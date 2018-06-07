/*-------------------------------------------------------------------------
 *
 * analyzeutils.c
 *
 *	  Provides utils functions for analyze.c
 *
 * Copyright (c) 2015, Pivotal Inc.
 *
 *-------------------------------------------------------------------------
 */
#include "postgres.h"
#include "access/heapam.h"
#include "access/hash.h"
#include "catalog/pg_statistic.h"
#include "utils/array.h"
#include "utils/lsyscache.h"
#include "utils/datum.h"
#include "utils/dynahash.h"
#include "utils/hsearch.h"
#include "cdb/cdbhash.h"
#include "cdb/cdbheap.h"
#include "cdb/cdbpartition.h"
#include "parser/parse_oper.h"
#include "access/heapam.h"
#include "access/transam.h"
#include "access/tuptoaster.h"
#include "access/xact.h"
#include "catalog/heap.h"
#include "catalog/index.h"
#include "catalog/indexing.h"
#include "catalog/namespace.h"
#include "catalog/pg_namespace.h"
#include "cdb/cdbpartition.h"
#include "cdb/cdbtm.h"
#include "cdb/cdbvars.h"
#include "commands/dbcommands.h"
#include "commands/vacuum.h"
#include "executor/executor.h"
#include "executor/spi.h"
#include "miscadmin.h"
#include "nodes/nodeFuncs.h"
#include "parser/parse_oper.h"
#include "parser/parse_relation.h"
#include "pgstat.h"
#include "postmaster/autovacuum.h"
#include "storage/bufmgr.h"
#include "storage/proc.h"
#include "storage/procarray.h"
#include "utils/acl.h"
#include "utils/builtins.h"
#include "utils/datum.h"
#include "utils/guc.h"
#include "utils/lsyscache.h"
#include "utils/memutils.h"
#include "utils/pg_rusage.h"
#include "utils/syscache.h"
#include "utils/tuplesort.h"
#include "utils/tqual.h"

#include "commands/analyzeutils.h"

typedef struct TypInfo
{
	Oid typOid;
	bool typbyval;
	int16 typlen;
	Oid ltFuncOp; /* oid of 'less than' operator function id of this type */
	Oid eqFuncOp; /* oid of equality operator function id of this type */
} TypInfo;

/* Functions and structures used for aggregating leaf partition stats */
typedef struct MCVFreqPair
{
	Datum mcv;
	float4 count;
	TypInfo *typinfo; /* type information of datum type */
} MCVFreqPair;

typedef struct MCVFreqEntry
{
	MCVFreqPair *entry;
} MCVFreqEntry;

typedef struct PartDatum
{
	int partId; /* id of the partition histogram where the datum is from */
	Datum datum;
} PartDatum;

static Datum* buildMCVArrayForStatsEntry(MCVFreqPair** mcvpairArray, int *nEntries, float4 ndistinct, float4 samplerows);
static float4* buildFreqArrayForStatsEntry(MCVFreqPair** mcvpairArray, int nEntries, float4 reltuples);
static int datumHashTableMatch(const void*keyPtr1, const void *keyPtr2, Size keysize);
static uint32 datumHashTableHash(const void *keyPtr, Size keysize);
static void calculateHashWithHashAny(void *clientData, void *buf, size_t len);
static HTAB* createDatumHashTable(unsigned int nEntries);
static MCVFreqPair* MCVFreqPairCopy(MCVFreqPair* mfp);
static bool containsDatum(HTAB *datumHash, MCVFreqPair *mfp);
static void addAllMCVsToHashTable
	(
	HTAB *datumHash,
	HeapTuple heaptupleStats,
	float4 partReltuples,
	TypInfo *typInfo
	);
static void addMCVToHashTable(HTAB* datumHash, MCVFreqPair *mfp);
static int mcvpair_cmp(const void *a, const void *b);

static void initTypInfo(TypInfo *typInfo, Oid typOid);
static int getNextPartDatum(CdbHeap *hp);
static int DatumHeapComparator(void *lhs, void *rhs, void *context);
static void advanceCursor(int pid, int *cursors, AttStatsSlot **histSlots);
static Datum getMinBound(AttStatsSlot **histSlots, int *cursors, int nParts, Oid ltFuncOid);
static Datum getMaxBound(AttStatsSlot **histSlots, int nParts, Oid ltFuncOid);
static void getHistogramHeapTuple(AttStatsSlot **histSlots,
		HeapTuple *heaptupleStats,
		float4 *partsReltuples,
		float4 *sumReltuples,
		int *numNotNullParts,
		int nParts);
static void initDatumHeap(CdbHeap *hp, AttStatsSlot **histSlots, int *cursors, int nParts);
static void getLeafReltuplesRelpages(Oid singleOid, float4 *relTuples, float4 *relPages);

/* A few variables that don't seem worth passing around as parameters */
static int	elevel = -1;

float4
get_rel_reltuples(Oid relid)
{
	float4 relTuples = 0.0;

	StringInfoData	sqlstmt;
	int			ret;
	Datum		arrayDatum;
	bool		isNull;
	Datum	   *values = NULL;
	int			valuesLength;

	initStringInfo(&sqlstmt);

	if (GpPolicyFetch(CurrentMemoryContext, relid)->ptype == POLICYTYPE_ENTRY)
	{
		appendStringInfo(&sqlstmt, "select pg_catalog.sum(pg_catalog.gp_statistics_estimate_reltuples_relpages_oid(c.oid))::pg_catalog.float4[] "
						 "from pg_catalog.pg_class c where c.oid=%d", relid);
	}
	else
	{
		appendStringInfo(&sqlstmt, "select pg_catalog.sum(pg_catalog.gp_statistics_estimate_reltuples_relpages_oid(c.oid))::pg_catalog.float4[] "
						 "from pg_catalog.gp_dist_random('pg_catalog.pg_class') c where c.oid=%d", relid);
	}

	if (SPI_OK_CONNECT != SPI_connect())
		ereport(ERROR, (errcode(ERRCODE_INTERNAL_ERROR),
						errmsg("Unable to connect to execute internal query.")));

	elog(elevel, "Executing SQL: %s", sqlstmt.data);

	/* Do the query. */
	ret = SPI_execute(sqlstmt.data, true, 0);
	Assert(ret > 0);
	Assert(SPI_tuptable != NULL);
	Assert(SPI_processed == 1);

	arrayDatum = heap_getattr(SPI_tuptable->vals[0], 1, SPI_tuptable->tupdesc, &isNull);
	if (isNull)
		elog(ERROR, "could not get estimated number of tuples and pages for relation %u", relid);

	deconstruct_array(DatumGetArrayTypeP(arrayDatum),
					  FLOAT4OID,
					  sizeof(float4),
					  true,
					  'i',
					  &values, NULL, &valuesLength);
	Assert(valuesLength == 2);

	relTuples += DatumGetFloat4(values[0]);

	SPI_finish();

	return relTuples;
}

/*
 * Given column stats of an attribute, build an MCVFreqPair and add it to the hash table.
 * If the MCV to be added already exist in the hash table, we increment its count value.
 * Input:
 * 	- datumHash: hash table
 * 	- partOid: Oid of current partition
 * 	- typInfo: type information
 * Output:
 *  - partReltuples: the number of tuples in this partition
 */
static void
addAllMCVsToHashTable
	(
	HTAB *datumHash,
	HeapTuple heaptupleStats,
	float4 partReltuples,
	TypInfo *typInfo
	)
{
	AttStatsSlot mcvSlot;
	get_attstatsslot(&mcvSlot, heaptupleStats, STATISTIC_KIND_MCV, InvalidOid, ATTSTATSSLOT_VALUES | ATTSTATSSLOT_NUMBERS);

	Assert(mcvSlot.nvalues == mcvSlot.nnumbers);
	for (int i = 0; i < mcvSlot.nvalues; i++)
	{
		Datum mcv = mcvSlot.values[i];
		float4 count = partReltuples * mcvSlot.numbers[i];
		MCVFreqPair *mfp = (MCVFreqPair *) palloc(sizeof(MCVFreqPair));
		mfp->mcv = mcv;
		mfp->count = count;
		mfp->typinfo = typInfo;
		addMCVToHashTable(datumHash, mfp);
		pfree(mfp);
	}
	free_attstatsslot(&mcvSlot);
}


/*
 * Main function for aggregating leaf partition MCV/Freq to compute
 * root or interior partition MCV/Freq
 * Input:
 * 	- relationOid: Oid of root or interior partition
 * 	- attnum: column number
 * 	- nEntries: target number of MCVs/Freqs to be collected, the real number of
 * 	MCVs/Freqs returned may be less
 * Output:
 * 	- result: two dimensional arrays of MCVs and Freqs
 */
int
aggregate_leaf_partition_MCVs
	(
	Oid relationOid,
	AttrNumber attnum,
	HeapTuple *heaptupleStats,
	float4 *relTuples,
	unsigned int nEntries,
	double ndistinct,
	void **result
	)
{
	List *lRelOids = rel_get_leaf_children_relids(relationOid); /* list of OIDs of leaf partitions */
	Oid typoid = get_atttype(relationOid, attnum);
	TypInfo *typInfo = (TypInfo*) palloc(sizeof(TypInfo));
	initTypInfo(typInfo, typoid);

	HTAB* datumHash = createDatumHashTable(nEntries);
	float4 sumReltuples = 0;

	int numPartitions = list_length(lRelOids);
	for (int i=0; i < numPartitions; i++)
	{
		if (!HeapTupleIsValid(heaptupleStats[i]))
		{
			continue;
		}

		addAllMCVsToHashTable(datumHash, heaptupleStats[i], relTuples[i],typInfo);
		sumReltuples += relTuples[i];
	}

	if (0 == hash_get_num_entries(datumHash))
	{
		/* in the unlikely event of an emtpy hash table, return early */
		*result = NULL;
		result++;
		*result = NULL;
		hash_destroy(datumHash);
		return 0;
	}

	int i = 0;
	HASH_SEQ_STATUS hash_seq;
	MCVFreqEntry *mcvfreq;
	MCVFreqPair **mcvpairArray = palloc(hash_get_num_entries(datumHash) * sizeof(MCVFreqPair*));

	/* put MCVFreqPairs in an array in order to sort */
	hash_seq_init(&hash_seq, datumHash);
	while ((mcvfreq = hash_seq_search(&hash_seq)) != NULL)
	{
		mcvpairArray[i++] = mcvfreq->entry;
	}
	qsort(mcvpairArray, i, sizeof(MCVFreqPair *), mcvpair_cmp);

	/* prepare returning MCV and Freq arrays */
	int nFinalEntries = Min(i, nEntries);
	*result = (void *)buildMCVArrayForStatsEntry(mcvpairArray, &nFinalEntries, ndistinct, sumReltuples);
	if(*result == NULL)
		return 0;
	result++; /* now switch to frequency array (result[1]) */
	*result = (void *)buildFreqArrayForStatsEntry(mcvpairArray, nFinalEntries, sumReltuples);

	hash_destroy(datumHash);
	pfree(typInfo);
	pfree(mcvpairArray);

	return nFinalEntries;
}

/*
 * Return an array of MCVs from the resultant MCVFreqPair array
 * Input:
 * 	- mcvpairArray: contains MCVs and corresponding counts in desc order
 * 	- nEntries: number of MCVs to be returned
 * 	- typoid: type oid of the MCV datum
 */
static Datum *
buildMCVArrayForStatsEntry
	(
	MCVFreqPair** mcvpairArray,
	int *nEntries,
	float4 ndistinct,
	float4 samplerows
	)
{
	Assert(mcvpairArray);
	Assert(*nEntries > 0);

	Datum *out = palloc(sizeof(Datum)*(*nEntries));
	double mincount = -1.0;

	if (*nEntries == (int)ndistinct &&
		ndistinct > 0 &&
		*nEntries <= default_statistics_target)
	{
		/* Track list includes all values seen, and all will fit */
	}
	else
	{
		double		avgcount,
				maxmincount;

		/* estimate # of occurrences in sample of a typical value */
		avgcount = (double) samplerows / ndistinct;
		/* set minimum threshold count to store a value */
		mincount = avgcount * 1.25;
		if (mincount < 2)
			mincount = 2;
		/* don't let threshold exceed 1/K, however */
		maxmincount = (double) samplerows / (double) default_statistics_target;
		if (mincount > maxmincount)
			mincount = maxmincount;

	}
	for (int i = 0; i < *nEntries; i++)
	{
		if ((mcvpairArray[i])->count < mincount)
		{
			if (i == 0)
			{
				pfree(out);
				return NULL;
			} else
			{
				*nEntries = i;
				break;
			}
		}
		Datum mcv = (mcvpairArray[i])->mcv;
		out[i] = mcv;
	}

	return out;
}

/*
 * Return an array of frequencies from the resultant MCVFreqPair array
 * Input:
 * 	- mcvpairArray: contains MCVs and corresponding counts in desc order
 * 	- nEntries: number of frequencies to be returned
 * 	- reltuples: number of tuples of the root or interior partition (all leaf partitions combined)
 */
static float4 *
buildFreqArrayForStatsEntry
	(
	MCVFreqPair** mcvpairArray,
	int nEntries,
	float4 reltuples
	)
{
	Assert(mcvpairArray);
	Assert(nEntries > 0);
	Assert(reltuples > 0); /* otherwise ANALYZE will not collect stats */

	float4 *out = (float *)palloc(sizeof(float4)*nEntries);
	for (int i = 0; i < nEntries; i++)
	{
		float4 freq = mcvpairArray[i]->count / reltuples;
		out[i] = freq;
	}

	return out;
}

/*
 * Comparison function to sort an array of MCVFreqPairs in desc order
 */
static int
mcvpair_cmp(const void *a, const void *b)
{
	Assert(a);
	Assert(b);

	MCVFreqPair *mfp1 = *(MCVFreqPair **)a;
	MCVFreqPair *mfp2 = *(MCVFreqPair **)b;
	if (mfp1->count > mfp2->count)
		return -1;
	if (mfp1->count < mfp2->count)
		return 1;
	else
		return 0;
}

/**
 * Add an MCVFreqPair to the hash table, if the same datum already exists
 * in the hash table, update its count
 * Input:
 * 	datumHash - hash table
 * 	mfp - MCVFreqPair to be added
 * 	typbyval - whether the datum inside is passed by value
 * 	typlen - pg_type.typlen of the datum type
 */
static void
addMCVToHashTable(HTAB* datumHash, MCVFreqPair *mfp)
{
	Assert(datumHash);
	Assert(mfp);

	MCVFreqEntry *mcvfreq;
	bool found = false; /* required by hash_search */

	if (!containsDatum(datumHash, mfp))
	{
		/* create a deep copy of MCVFreqPair and put it in the hash table */
		MCVFreqPair *key = MCVFreqPairCopy(mfp);
		mcvfreq = hash_search(datumHash, &key, HASH_ENTER, &found);
		if (mcvfreq == NULL)
		{
			ereport(ERROR, (errcode(ERRCODE_OUT_OF_MEMORY), errmsg("out of memory")));
		}
		mcvfreq->entry = key;
	}

	else
	{
		mcvfreq = hash_search(datumHash, &mfp, HASH_FIND, &found);
		Assert(mcvfreq);
		mcvfreq->entry->count += mfp->count;
	}

	return;
}

/**
 * Copy function for MCVFreqPair
 * Input:
 * 	mfp - input MCVFreqPair
 * 	typbyval - whether the datum inside is passed by value
 * 	typlen - pg_type.typlen of the datum type
 * Output:
 * 	result - a deep copy of input MCVFreqPair
 */
static MCVFreqPair *
MCVFreqPairCopy(MCVFreqPair* mfp)
{
	MCVFreqPair *result = (MCVFreqPair*) palloc(sizeof(MCVFreqPair));
	result->count = mfp->count;
	result->typinfo = mfp->typinfo;
	result->mcv = datumCopy(mfp->mcv, mfp->typinfo->typbyval, mfp->typinfo->typlen);

	return result;
}

/**
 * Test whether an MCVFreqPair is in the hash table
 * Input:
 * 	datumHash - hash table
 * 	mfp - pointer to an MCVFreqPair
 * Output:
 * 	found - whether the MCVFreqPair is found
 */
static bool
containsDatum(HTAB *datumHash, MCVFreqPair *mfp)
{
	bool found = false;
	if (datumHash != NULL)
		hash_search(datumHash, &mfp, HASH_FIND, &found);

	return found;
}

/**
 * Create a hash table with both hash key and hash entry as a pointer
 * to a MCVFreqPair struct
 * Input:
 * 	nEntries - estimated number of elements in the hash table, the size
 * 	of the hash table can grow dynamically
 * Output:
 * 	a pointer to the created hash table
 */
static HTAB*
createDatumHashTable(unsigned int nEntries)
{
	HASHCTL	hash_ctl;
	MemSet(&hash_ctl, 0, sizeof(hash_ctl));

	hash_ctl.keysize = sizeof(MCVFreqPair*);
	hash_ctl.entrysize = sizeof(MCVFreqEntry);
	hash_ctl.hash = datumHashTableHash;
	hash_ctl.match = datumHashTableMatch;

	return hash_create("DatumHashTable", nEntries, &hash_ctl, HASH_ELEM | HASH_FUNCTION | HASH_COMPARE);
}

/**
 * A generic hash function
 * Input:
 * 	buf - pointer to hash key
 * 	len - number of bytes to be hashed
 * Output:
 * 	clientData - hash value as an unsigned integer
 */
static void
calculateHashWithHashAny(void *clientData, void *buf, size_t len)
{
	uint32 *result = (uint32*) clientData;
	*result = hash_any((unsigned char *)buf, len );
}

/**
 * Hash function for MCVFreqPair struct pointer.
 * Input:
 * 	keyPtr - pointer to hash key
 * 	keysize - not used, hash function must have this signature
 * Output:
 * 	result - hash value as an unsigned integer
 */
static uint32
datumHashTableHash(const void *keyPtr, Size keysize)
{
	uint32 result = 0;
	MCVFreqPair *mfp = *((MCVFreqPair **)keyPtr);

	hashDatum(mfp->mcv, mfp->typinfo->typOid, calculateHashWithHashAny, &result);

	return result;
}

/**
 * Match function for MCVFreqPair struct pointer.
 * Input:
 * 	keyPtr1, keyPtr2 - pointers to two hash keys
 * 	keysize - not used, hash function must have this signature
 * Output:
 * 	0 if two hash keys match, 1 otherwise
 */
static int
datumHashTableMatch(const void *keyPtr1, const void *keyPtr2, Size keysize)
{
	Assert(keyPtr1);
	Assert(keyPtr2);

	MCVFreqPair *left = *((MCVFreqPair **)keyPtr1);
	MCVFreqPair *right = *((MCVFreqPair **)keyPtr2);

	Assert(left->typinfo->typOid == right->typinfo->typOid);

	return datumCompare(left->mcv, right->mcv, left->typinfo->eqFuncOp) ? 0 : 1;
}





/*
 * Initialize type information
 * Input:
 * 	typOid - Oid of the type
 * Output:
 *  members of typInfo are initialized
 */
static void
initTypInfo(TypInfo *typInfo, Oid typOid)
{
	typInfo->typOid = typOid;
	get_typlenbyval(typOid, &typInfo->typlen, &typInfo->typbyval);
	get_sort_group_operators(typOid, true, true, false, &typInfo->ltFuncOp, &typInfo->eqFuncOp, NULL);
	typInfo->eqFuncOp = get_opcode(typInfo->eqFuncOp);
	typInfo->ltFuncOp = get_opcode(typInfo->ltFuncOp);
}

/*
 * Get the part id of the next PartDatum, which contains the minimum datum value, from the heap
 * Input:
 * 	hp - min heap containing PartDatum
 * Output:
 *  part id of the datum having minimum value in the heap. Return -1 if heap is empty.
 */
static int
getNextPartDatum(CdbHeap *hp)
{
	if (CdbHeap_Count(hp) > 0)
	{
		PartDatum* minElement = CdbHeap_Min(PartDatum, hp);
		return minElement->partId;
	}
	return -1;
}



/*
 * Comparator function of heap element PartDatum
 * Input:
 * 	lhs, rhs - pointers to heap elements
 * 	context - pointer to comparison context
 * Output:
 *  -1 if lhs < rhs
 *  0 if lhs == rhs
 *  1 if lhs > rhs
 */
static int
DatumHeapComparator(void *lhs, void *rhs, void *context)
{
	Datum d1 = ((PartDatum *)lhs)->datum;
	Datum d2 = ((PartDatum *)rhs)->datum;
	TypInfo *typInfo = (TypInfo *) context;

	if (datumCompare(d1, d2, typInfo->ltFuncOp))
	{
		return -1;
	}

	if (datumCompare(d1, d2, typInfo->eqFuncOp))
	{
		return 0;
	}

	return 1;
}

/* Advance the cursor of a partition by 1, set to -1 if the end is reached
 * Input:
 * 	pid - partition id
 * 	cursors - cursor vector
 * 	nBounds - array of the number of bounds
 * */
static void
advanceCursor(int pid, int *cursors, AttStatsSlot **histSlots)
{
	cursors[pid]++;
	if (cursors[pid] >= histSlots[pid]->nvalues)
	{
		cursors[pid] = -1;
	}
}

/*
 * Get the minimum bound of all partition bounds. Only need to iterate over
 * the first bound of each partition since the bounds in a histogram are ordered.
 */
static Datum
getMinBound(AttStatsSlot **histSlots, int *cursors, int nParts, Oid ltFuncOid)
{
	Assert(histSlots);
	Assert(histSlots[0]);
	Assert(cursors);
	Assert(nParts > 0);

	Datum minDatum = histSlots[0]->values[0];
	for (int pid = 0; pid < nParts; pid++)
	{
		if (datumCompare(histSlots[pid]->values[0], minDatum, ltFuncOid))
		{
			minDatum = histSlots[pid]->values[0];
		}
		advanceCursor(pid, cursors, histSlots);
	}

	return minDatum;
}

/*
 * Get the maximum bound of all partition bounds. Only need to iterate over
 * the last bound of each partition since the bounds in a histogram are ordered.
 */
static Datum
getMaxBound(AttStatsSlot **histSlots, int nParts, Oid ltFuncOid)
{
	Assert(histSlots);
	Assert(histSlots[0]);
	Assert(nParts > 0);

	Datum maxDatum = histSlots[0]->values[histSlots[0]->nvalues-1];
	for (int pid = 0; pid < nParts; pid++)
	{
		if (datumCompare(maxDatum, histSlots[pid]->values[histSlots[pid]->nvalues-1], ltFuncOid))
		{
			maxDatum = histSlots[pid]->values[histSlots[pid]->nvalues-1];
		}
	}

	return maxDatum;
}

/*
 * Preparing the output array of histogram bounds, removing any duplicates
 * Input:
 * 	ldatum - list of pointers to the aggregated bounds, may contain duplicates
 * 	typInfo - type information
 * Output:
 *  an array containing the aggregated histogram bounds
 */
static Datum *
buildHistogramEntryForStats
	(
	List *ldatum,
	TypInfo* typInfo,
	int *num_hist
	)
{

	Assert(ldatum);
	Assert(typInfo);

	Datum *histArray = (Datum *)palloc(sizeof(Datum)*list_length(ldatum));
	
	ListCell *lc = NULL;
	Datum *prevDatum = (Datum *) linitial(ldatum);
	int idx = 0;
	*num_hist = 0;

	foreach_with_count (lc, ldatum, idx)
	{
		Datum *pdatum = (Datum *) lfirst(lc);

		/* remove duplicate datum in the list, starting from the second datum */
		if (datumCompare(*pdatum, *prevDatum, typInfo->eqFuncOp) && idx > 0)
		{
			continue;
		}

		histArray[*num_hist] = *pdatum;
		*num_hist = *num_hist+1;
		*prevDatum = *pdatum;
	}

	return histArray;
}


/*
 * Obtain all histogram bounds from every partition and store them in a 2D array (histData)
 * Input:
 * 	lRelOids - list of part Oids
 * 	typInfo - type info
 * 	attnum - attribute number
 * Output:
 * 	histData - 2D array of all histogram bounds from every partition
 * 	nBounds - array of the number of histogram bounds (from each partition)
 * 	partsReltuples - array of the number of tuples (from each partition)
 * 	sumReltuples - sum of number of tuples in all partitions
 */
static void
getHistogramHeapTuple
	(
	AttStatsSlot **histSlots,
	HeapTuple *heaptupleStats,
	float4 *partsReltuples,
	float4 *sumReltuples,
	int *numNotNullParts,
	int nParts
	)
{
	int pid = 0;

	for (int i = 0; i < nParts; i++)
	{
		*sumReltuples += partsReltuples[i];
		if (!HeapTupleIsValid(heaptupleStats[i]))
		{
			continue;
		}
		histSlots[pid] = (AttStatsSlot *)palloc(sizeof(AttStatsSlot));
		get_attstatsslot(histSlots[pid], heaptupleStats[i], STATISTIC_KIND_HISTOGRAM, InvalidOid, ATTSTATSSLOT_VALUES);

		if (histSlots[pid]->nvalues > 0)
		{
			pid++;
		}
	}
	*numNotNullParts = pid;
}
/*
 * Initialize heap by inserting the second histogram bound from each partition histogram.
 * Input:
 * 	hp - heap
 * 	histData - all histogram bounds from each part
 * 	cursors - cursor vector
 * 	nParts - number of partitions
 */
static void
initDatumHeap(CdbHeap *hp, AttStatsSlot **histSlots, int *cursors, int nParts)
{
	for (int pid = 0; pid < nParts; pid++)
	{
		if (cursors[pid] > 0) /* do nothing if part histogram only has one element */
		{
			PartDatum pd;
			pd.partId = pid;
			pd.datum = histSlots[pid]->values[cursors[pid]];
			CdbHeap_Insert(hp, &pd);
		}
	}
}

/*
 * Comparison function for two datums
 * Input:
 * 	d1, d2 - datums
 * 	opFuncOid - oid of the function for comparison operator of this datum type
 */
bool
datumCompare(Datum d1, Datum d2, Oid opFuncOid)
{
	FmgrInfo	ltproc;
	fmgr_info(opFuncOid, &ltproc);
	return DatumGetBool(FunctionCall2(&ltproc, d1, d2));
}

/*
 * Main function for aggregating leaf partition histogram to compute
 * root or interior partition histogram
 * Input:
 * 	- relationOid: Oid of root or interior partition
 * 	- attnum: column number
 * 	- nEntries: target number of histogram bounds to be collected, the real number of
 * 	histogram bounds returned may be less
 * Output:
 * 	- result: an array of aggregated histogram bounds
 * Algorithm:
 *
 * 	We use the following example to explain how the aggregating algorithm works.

	Suppose a parent table 'lineitem' has 3 partitions 'lineitem_prt_1', 'lineitem_prt_2',
	'lineitem_prt_3'. The histograms of the column of interest of the parts are:

	hist(prt_1): {0,19,38,59}
	hist(prt_2): {2,18,40,62}
	hist(prt_3): {1,22,39,61}

	Note the histograms are equi-depth, which implies each bucket should contain the same number of tuples.

	The number of tuples in each part is:

	nTuples(prt_1) = 300
	nTuples(prt_2) = 270
	nTuples(prt_3) = 330

	Some notation:

	hist(agg): the aggregated histogram
	hist(parts): the histograms of the partitions, i.e., {hist(prt_1), hist(prt_2), hist(prt_3)}
	nEntries: the target number of histogram buckets in hist(agg). Usually this is the same as in the partitions. In this example, nEntries = 3.
	nParts: the number of partitions. nParts = 3 in this example.

	Since we know the target number of tuples in each bucket of hist(agg), the basic idea is to fill the buckets of hist(agg) using the buckets in hist(parts). And once a bucket in hist(agg) is filled up, we look at which bucket from hist(parts) is the current bucket, and use its bound as the bucket bound in hist(agg).
	Continue with our example we have,

	bucketSize(prt_1) = 300/3 = 100
	bucketSize(prt_2) = 270/3 = 90
	bucketSize(prt_3) = 330/3 = 110
	bucketSize(agg) = (300+270+330)/3 = 300

	Now, to begin with, we find the minimum of the first boundary point across hist(parts) and use it as the first boundary of hist(agg), i.e.,
	hist(agg) = {min({0,2,1})} = {0}

	We need to maintain a priority queue in order to decide on the next bucket from hist(parts) to work with.
	Each element in the queue is a (Datum, partID) pair, where Datum is a boundary from hist(parts) and partID is the ID of the part the Datum comes from.
	Each time we dequeue(), we get the minimum datum in the queue as the next datum we will work on.
	The priority queue contains up to nParts entries. In our example, we first enqueue
	the second boundary across hist(parts), i.e., 19, 18, 22, along with their part ID.

	Continue with filling the bucket of hist(agg), we dequeue '18' from the queue and fill in
	the first bucket (having 90 tuples). Since bucketSize(agg) = 300, we need more buckets
	from hist(parts) to fill it. At the same time, we dequeue 18 and enqueue the next bound (which is 40).
	The first bucket of hist(agg) will be filled up by '22' (90+100+110 >= 300), at this time we put '22' as the next boundary value in hist(agg), i.e.
	hist(agg) = {0,22}

	Continue with the iteration, we will finally fill all the buckets
	hist(agg) = {0,22,40,62}
 *
 */
int
aggregate_leaf_partition_histograms
	(
	Oid relationOid,
	AttrNumber attnum,
	HeapTuple *heaptupleStats,
	float4 *relTuples,
	unsigned int nEntries,
	void **result
	)
{
	List *lRelOids = rel_get_leaf_children_relids(relationOid);
	int nParts = list_length(lRelOids);
	Assert(nParts > 0);

	/* get type information */
	TypInfo typInfo;
	Oid typOid = get_atttype(relationOid, attnum);
	initTypInfo(&typInfo, typOid);

	AttStatsSlot **histSlots = (AttStatsSlot **) palloc(nParts * sizeof(AttStatsSlot *));
	float4 sumReltuples = 0;
	memset(histSlots, 0, nParts * sizeof(AttStatsSlot *));

	int numNotNullParts = 0;
	/* populate histData, nBounds, partsReltuples and sumReltuples */
	getHistogramHeapTuple(histSlots, heaptupleStats, relTuples, &sumReltuples, &numNotNullParts, nParts);

	if (0 == numNotNullParts)
	{
		/* if all the parts histograms are empty, we return nothing */
		result = NULL;
		return 0;
	}

	/* reset nParts to the number of non-null parts */
	nParts = numNotNullParts;

	/* now define the state variables needed for the aggregation loop */
	float4 bucketSize = sumReltuples / (nEntries + 1); /* target bucket size in the aggregated histogram */
	float4 nTuplesToFill = bucketSize; /* remaining number of tuples to fill in the current bucket
									 of the aggregated histogram, reset to bucketSize when a new
									 bucket is added */
	int cursors[nParts]; /* the index of current bucket for each histogram, set to -1
								  after the histogram has been traversed */
	float4 eachBucket[nParts]; /* the number of data points in each bucket for each histogram */
	float4 remainingSize[nParts]; /* remaining number of tuples in the current bucket of a part */
	memset(cursors, 0, nParts * sizeof(int));
	memset(eachBucket, 0, nParts * sizeof(float4));
	memset(remainingSize, 0, nParts * sizeof(float4));

	/* initialize eachBucket[] and remainingSize[] */
	for (int i = 0; i < nParts; i++)
	{
		if (1 < histSlots[i]->nvalues)
		{
			eachBucket[i] = relTuples[i] / (histSlots[i]->nvalues - 1);
			remainingSize[i] = eachBucket[i];
		}
	}

	int pid = 0; /* part id */
	/* we maintain a priority queue (min heap) of PartDatum */
	CdbHeap *dhp = CdbHeap_Create(DatumHeapComparator,
								&typInfo,
								nParts /* nSlotMax */,
								sizeof(PartDatum),
								NULL /* slotArray */);

	List *ldatum = NIL; /* list of pointers to the selected bounds */
	/* the first bound in the aggregated histogram will be the minimum of the first bounds of all parts */
	Datum minBound = getMinBound(histSlots, cursors, nParts, typInfo.ltFuncOp);
	ldatum = lappend(ldatum, &minBound);

	/* continue filling the aggregated histogram, starting from the second bound */
	initDatumHeap(dhp, histSlots, cursors, nParts);

	/* loop continues when DatumHeap is not empty yet and the number of histogram boundaries
	 * has not reached nEntries */
	while (((pid = getNextPartDatum(dhp)) >= 0) && list_length(ldatum) < nEntries)
	{
		if (remainingSize[pid] < nTuplesToFill)
		{
			nTuplesToFill -= remainingSize[pid];
			advanceCursor(pid, cursors, histSlots);
			remainingSize[pid] = eachBucket[pid];
			CdbHeap_DeleteMin(dhp);
			if (cursors[pid] > 0)
			{
				PartDatum pd;
				pd.partId = pid;
				pd.datum = histSlots[pid]->values[cursors[pid]];
				CdbHeap_Insert(dhp, &pd);
			}
		}
		else
		{
			ldatum = lappend(ldatum, &histSlots[pid]->values[cursors[pid]]);
			remainingSize[pid] -= nTuplesToFill;
			nTuplesToFill = bucketSize;
		}
	}

	/* adding the max boundary across all histograms to the aggregated histogram */
	Datum maxBound = getMaxBound(histSlots, nParts, typInfo.ltFuncOp);
	ldatum = lappend(ldatum, &maxBound);

	/* now ldatum contains the resulting boundaries */
	int num_hist;
	Datum *out = buildHistogramEntryForStats(ldatum, &typInfo, &num_hist);

	/* clean up */
	CdbHeap_Destroy(dhp);

	*result = out;

	return num_hist;
}

/*
 *	needs_sample() -- checks if the analyze requires sampling the actual data
 */
bool
needs_sample(VacAttrStats **vacattrstats, int attr_cnt)
{
	Assert(vacattrstats != NULL);
	int i;
	for (i = 0; i < attr_cnt; i++)
	{
		Assert(vacattrstats[i] != NULL);
		if(!vacattrstats[i]->merge_stats)
			return true;
	}
	return false;
}

/*
 *	leaf_parts_analyzed() -- checks if all the leaf partitions analyzed
 *
 *	We use this to determine if all the leaf partitions are analyzed and
 *	the statistics are in place to be able to merge and generate meaningful
 *	statistics for the root partition. If one partition is analyzed but the
 *	other is not, root statistics will be bogus if we continue merging.
 */
bool
leaf_parts_analyzed(VacAttrStats *stats)
{
	PartitionNode *pn = get_parts(stats->attr->attrelid, 0 /*level*/ ,
								  0 /*parent*/, false /* inctemplate */, true /*includesubparts*/);
	Assert(pn);

	List *oid_list = all_leaf_partition_relids(pn); /* all leaves */
	int numPartitions = list_length(oid_list);
	bool all_parts_empty = true;
	int i;
	for (i = 0; i < numPartitions; i++)
	{
		Oid partRelid = list_nth_oid(oid_list,i);
		float4 relTuples = get_rel_reltuples(partRelid);
		if (relTuples == 0.0)
			continue;
		HeapTuple heaptupleStats = get_att_stats(list_nth_oid(oid_list, i), stats->attr->attnum);
		all_parts_empty = false;

		// if there is no colstats
		if (!HeapTupleIsValid(heaptupleStats))
		{
			return false;
		}
		heap_freetuple(heaptupleStats);
	}
	if(all_parts_empty)
		return false;

	return true;
}

/**
 * This method estimates reltuples/relpages for a relation. To do this, it employs
 * the built-in function 'gp_statistics_estimate_reltuples_relpages'. If the table to be
 * analyzed is a system table, then it calculates statistics only using the master.
 * Input:
 * 	relationOid - relation's Oid
 * Output:
 * 	relTuples - estimated number of tuples
 * 	relPages  - estimated number of pages
 */
static void
getLeafReltuplesRelpages(Oid singleOid, float4 *relTuples, float4 *relPages)
{
	*relPages = 0.0;
	*relTuples = 0.0;

	StringInfoData	sqlstmt;
	int			ret;
	Datum		arrayDatum;
	bool		isNull;
	Datum	   *values = NULL;
	int			valuesLength;
	
	initStringInfo(&sqlstmt);
	
	if (GpPolicyFetch(CurrentMemoryContext, singleOid)->ptype == POLICYTYPE_ENTRY)
	{
		appendStringInfo(&sqlstmt, "select pg_catalog.sum(pg_catalog.gp_statistics_estimate_reltuples_relpages_oid(c.oid))::pg_catalog.float4[] "
						 "from pg_catalog.pg_class c where c.oid=%d", singleOid);
	}
	else
	{
		appendStringInfo(&sqlstmt, "select pg_catalog.sum(pg_catalog.gp_statistics_estimate_reltuples_relpages_oid(c.oid))::pg_catalog.float4[] "
						 "from pg_catalog.gp_dist_random('pg_catalog.pg_class') c where c.oid=%d", singleOid);
	}
	
	if (SPI_OK_CONNECT != SPI_connect())
		ereport(ERROR, (errcode(ERRCODE_INTERNAL_ERROR),
						errmsg("Unable to connect to execute internal query.")));
	
	elog(elevel, "Executing SQL: %s", sqlstmt.data);
	
	/* Do the query. */
	ret = SPI_execute(sqlstmt.data, true, 0);
	Assert(ret > 0);
	Assert(SPI_tuptable != NULL);
	Assert(SPI_processed == 1);
	
	arrayDatum = heap_getattr(SPI_tuptable->vals[0], 1, SPI_tuptable->tupdesc, &isNull);
	if (isNull)
		elog(ERROR, "could not get estimated number of tuples and pages for relation %u", singleOid);
	
	deconstruct_array(DatumGetArrayTypeP(arrayDatum),
					  FLOAT4OID,
					  sizeof(float4),
					  true,
					  'i',
					  &values, NULL, &valuesLength);
	Assert(valuesLength == 2);
	
	*relTuples += DatumGetFloat4(values[0]);
	*relPages += DatumGetFloat4(values[1]);
	
	SPI_finish();
	
	return;
}

bool
table_analyzed_and_not_changed(Relation onerel)
{
	float4		relTuples = 0;
	float4		relPages = 0;

	Oid relid = RelationGetRelid(onerel);
	HLLCounter  hllcounter;

	if (rel_part_status(relid) != PART_STATUS_LEAF)
		return false;

	getLeafReltuplesRelpages(relid, &relTuples, &relPages);

	if (relTuples == 0 || relPages == 0)
		return false;

	int nAttr = RelationGetNumberOfAttributes(onerel);
	int i;
	for (i = 1; i <= nAttr; i++)
	{
		HeapTuple heaptupleStats = get_att_stats(relid, i);

		// if there is no colstats
		if (!HeapTupleIsValid(heaptupleStats))
		{
			continue;
		}

		AttStatsSlot hllSlot;
		if (!get_attstatsslot(&hllSlot, heaptupleStats, STATISTIC_KIND_HLL, InvalidOid, ATTSTATSSLOT_VALUES))
			continue;
		hllcounter = (HLLCounter) DatumGetByteaP(hllSlot.values[0]);
		heap_freetuple(heaptupleStats);

		if (hllcounter == NULL)
			continue;

		float4 relTuplesSaved = hllcounter->relTuples;
		float4 relPagesSaved = hllcounter->relPages;
		free_attstatsslot(&hllSlot);
		// Unlike ProcessQuery, DoCopyInternal, and friends, we don't have the
		// luxury of knowing "how many tuples have I just processed", so we use
		// the heuristic of "does this table look similar to when I last saw it?"
		float4 estTupPerPage = relTuples / relPages;
		if (fabs(relTuples - relTuplesSaved) <= (float) gp_autostats_on_change_threshold &&
			fabs(relPages - relPagesSaved) <= (float) gp_autostats_on_change_threshold / estTupPerPage)
			return true;
		else
			return false;
	}
	return false;
}
