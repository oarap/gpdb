/* File contains functions that interact directly with the postgres api */
#include <stdio.h>
#include <math.h>
#include <string.h>
#include <sys/time.h>

#include "postgres.h"
#include "fmgr.h"
#include "utils/builtins.h"
#include "utils/bytea.h"
#include "utils/lsyscache.h"
#include "lib/stringinfo.h"
#include "libpq/pqformat.h"

#include "hyperloglog.h"
#include "upgrade.h"
#include "encoding.h"
#include "utils/hyperloglog_counter.h"


/* ---------------------- function definitions --------------------------- */

HLLCounter
hyperloglog_add_item(HLLCounter hllcounter, Datum element, int16 typlen, bool typbyval, char typalign)
{

    HLLCounter hyperloglog;

    /* requires the estimator to be already created */
    if (hllcounter == NULL)
        elog(ERROR, "hyperloglog counter must not be NULL");


	/* estimator (we know it's not a NULL value) */
	hyperloglog = (HLLCounter) hllcounter;

	/* TODO The requests for type info shouldn't be a problem (thanks to
	 * lsyscache), but if it turns out to have a noticeable impact it's
	 * possible to cache that between the calls (in the estimator).
	 *
	 * I have noticed no measurable effect from either option. */

	/* decompress if needed */
	if(hyperloglog->b < 0){
		hyperloglog = hll_decompress(hyperloglog);
	}

	/* it this a varlena type, passed by reference or by value ? */
	if (typlen == -1) {
		/* varlena */
		hyperloglog = hll_add_element(hyperloglog, VARDATA_ANY(element), VARSIZE_ANY_EXHDR(element));
	} else if (typbyval) {
		/* fixed-length, passed by value */
		hyperloglog = hll_add_element(hyperloglog, (char*)&element, typlen);
	} else {
		/* fixed-length, passed by reference */
		hyperloglog = hll_add_element(hyperloglog, (char*)element, typlen);
	}
	
	return hyperloglog;
}

Datum
hyperloglog_add_item_agg(PG_FUNCTION_ARGS)
{

    HLLCounter hyperloglog;
    double ndistinct;
    float errorRate; /* required error rate */

    /* info for anyelement */
    Oid         element_type = get_fn_expr_argtype(fcinfo->flinfo, 1);
    Datum       element = PG_GETARG_DATUM(1);
    int16       typlen;
    bool        typbyval;
    char        typalign;

    /* Create a new estimator (with requested error rate and ndistinct) or
     * reuse the existing one.  Return null if both counter and element args
     * are null. This prevents excess empty counter creation */
    if (PG_ARGISNULL(0) && PG_ARGISNULL(1)){
        PG_RETURN_NULL();
    } else if (PG_ARGISNULL(0) && !PG_ARGISNULL(1)) {

        errorRate = PG_GETARG_FLOAT4(2);
        ndistinct = PG_GETARG_FLOAT8(3);

        /* error rate between 0 and 1 (not 0) */
        if ((errorRate <= 0) || (errorRate > 1))
            elog(ERROR, "error rate has to be between 0 and 1");

    hyperloglog = hll_create(ndistinct, errorRate, PACKED);

    } else { /* existing estimator */
        hyperloglog = (HLLCounter) PG_GETARG_BYTEA_P(0);
    }

    /* add the item to the estimator (skip NULLs) */
    if (! PG_ARGISNULL(1)) {

        /* TODO The requests for type info shouldn't be a problem (thanks to
         * lsyscache), but if it turns out to have a noticeable impact it's
         * possible to cache that between the calls (in the estimator).
         *
         * I have noticed no measurable effect from either option. */
        
        /* get type information for the second parameter (anyelement item) */
        get_typlenbyvalalign(element_type, &typlen, &typbyval, &typalign);

        /* decompress if needed */
        if(hyperloglog->b < 0){
            hyperloglog = hll_decompress(hyperloglog);
        }    

        /* it this a varlena type, passed by reference or by value ? */
        if (typlen == -1) {
            /* varlena */
            hyperloglog = hll_add_element(hyperloglog, VARDATA_ANY(element), VARSIZE_ANY_EXHDR(element));
        } else if (typbyval) {
            /* fixed-length, passed by value */
            hyperloglog = hll_add_element(hyperloglog, (char*)&element, typlen);
        } else {
            /* fixed-length, passed by reference */
            hyperloglog = hll_add_element(hyperloglog, (char*)element, typlen);
        }
    }

    /* return the updated bytea */
    PG_RETURN_BYTEA_P(hyperloglog);

}


Datum
hyperloglog_add_item_agg_pack(PG_FUNCTION_ARGS)
{

    HLLCounter hyperloglog;
    double ndistinct;
    float errorRate; /* required error rate */

    /* info for anyelement */
    Oid         element_type = get_fn_expr_argtype(fcinfo->flinfo, 1);
    Datum       element = PG_GETARG_DATUM(1);
    int16       typlen;
    bool        typbyval;
    char        typalign;

    /* Create a new estimator (with requested error rate and ndistinct) or
 *      * reuse the existing one.  Return null if both counter and element args
 *           * are null. This prevents excess empty counter creation */
    if (PG_ARGISNULL(0) && PG_ARGISNULL(1)){
        PG_RETURN_NULL();
    } else if (PG_ARGISNULL(0) && !PG_ARGISNULL(1)) {

        errorRate = PG_GETARG_FLOAT4(2);
            ndistinct = PG_GETARG_FLOAT8(3);

        /* error rate between 0 and 1 (not 0) */
        if ((errorRate <= 0) || (errorRate > 1))
            elog(ERROR, "error rate has to be between 0 and 1");

        if (!PG_ARGISNULL(4) && ('u' == VARDATA_ANY(PG_GETARG_TEXT_P(4))[0] || 'U'  == VARDATA_ANY(PG_GETARG_TEXT_P(4))[0] )){
            hyperloglog = hll_create(ndistinct, errorRate, PACKED_UNPACKED);
        } else if (!PG_ARGISNULL(4) && ('p' == VARDATA_ANY(PG_GETARG_TEXT_P(4))[0] || 'P'  == VARDATA_ANY(PG_GETARG_TEXT_P(4))[0] ) ) {
            hyperloglog = hll_create(ndistinct, errorRate, PACKED);
        } else {
            elog(ERROR,"ERROR: Improper format specification! Must be U or P");
            PG_RETURN_NULL();
        }

    } else { /* existing estimator */
        hyperloglog = (HLLCounter) PG_GETARG_BYTEA_P(0);
    }

    /* add the item to the estimator (skip NULLs) */
    if (! PG_ARGISNULL(1)) {

        /* TODO The requests for type info shouldn't be a problem (thanks to
 *                  * lsyscache), but if it turns out to have a noticeable impact it's
 *                                   * possible to cache that between the calls (in the estimator).
 *                                                    *
 *                                                                     * I have noticed no measurable effect from either option. */

        /* get type information for the second parameter (anyelement item) */
        get_typlenbyvalalign(element_type, &typlen, &typbyval, &typalign);

                /* decompress if needed */
        if(hyperloglog->b < 0){
            hyperloglog = hll_decompress(hyperloglog);
        }

        /* it this a varlena type, passed by reference or by value ? */
        if (typlen == -1) {
            /* varlena */
            hyperloglog = hll_add_element(hyperloglog, VARDATA_ANY(element), VARSIZE_ANY_EXHDR(element));
        } else if (typbyval) {
            /* fixed-length, passed by value */
            hyperloglog = hll_add_element(hyperloglog, (char*)&element, typlen);
        } else {
            /* fixed-length, passed by reference */
            hyperloglog = hll_add_element(hyperloglog, (char*)element, typlen);
        }
    }

    /* return the updated bytea */
    PG_RETURN_BYTEA_P(hyperloglog);

}


Datum
hyperloglog_add_item_agg_error(PG_FUNCTION_ARGS)
{

    HLLCounter hyperloglog;
    float errorRate; /* required error rate */

    /* info for anyelement */
    Oid         element_type = get_fn_expr_argtype(fcinfo->flinfo, 1);
    Datum       element = PG_GETARG_DATUM(1);
    int16       typlen;
    bool        typbyval;
    char        typalign;

    /* Create a new estimator (with requested error rate) or reuse the
     * existing one. Return null if both counter and element args are null.
     * This prevents excess empty counter creation */
    if (PG_ARGISNULL(0) && PG_ARGISNULL(1)){
        PG_RETURN_NULL();
    } else if (PG_ARGISNULL(0)) {

        errorRate = PG_GETARG_FLOAT4(2);

        /* error rate between 0 and 1 (not 0) */
        if ((errorRate <= 0) || (errorRate > 1))
            elog(ERROR, "error rate has to be between 0 and 1");

    hyperloglog = hll_create(DEFAULT_NDISTINCT, errorRate, PACKED);


    } else { /* existing estimator */
        hyperloglog = (HLLCounter) PG_GETARG_BYTEA_P(0);
    }

    /* add the item to the estimator (skip NULLs) */
    if (! PG_ARGISNULL(1)) {

        /* TODO The requests for type info shouldn't be a problem (thanks to
         * lsyscache), but if it turns out to have a noticeable impact it's
         * possible to cache that between the calls (in the estimator).
         *
         * I have noticed no measurable effect from either option. */
        
        /* get type information for the second parameter (anyelement item) */
        get_typlenbyvalalign(element_type, &typlen, &typbyval, &typalign);

        /* decompress if needed */
        if(hyperloglog->b < 0){
            hyperloglog = hll_decompress(hyperloglog);
        }    

        /* it this a varlena type, passed by reference or by value ? */
        if (typlen == -1) {
            /* varlena */
            hyperloglog = hll_add_element(hyperloglog, VARDATA_ANY(element), VARSIZE_ANY_EXHDR(element));
        } else if (typbyval) {
            /* fixed-length, passed by value */
            hyperloglog = hll_add_element(hyperloglog, (char*)&element, typlen);
        } else {
            /* fixed-length, passed by reference */
            hyperloglog = hll_add_element(hyperloglog, (char*)element, typlen);
        }
    }

    /* return the updated bytea */
    PG_RETURN_BYTEA_P(hyperloglog);

}

Datum
hyperloglog_add_item_agg_error_pack(PG_FUNCTION_ARGS)
{

    HLLCounter hyperloglog;
    float errorRate; /* required error rate */

    /* info for anyelement */
    Oid         element_type = get_fn_expr_argtype(fcinfo->flinfo, 1);
    Datum       element = PG_GETARG_DATUM(1);
    int16       typlen;
    bool        typbyval;
    char        typalign;

    /* Create a new estimator (with requested error rate) or reuse the
 *      * existing one. Return null if both counter and element args are null.
 *           * This prevents excess empty counter creation */
    if (PG_ARGISNULL(0) && PG_ARGISNULL(1)){
        PG_RETURN_NULL();
    } else if (PG_ARGISNULL(0)) {

        errorRate = PG_GETARG_FLOAT4(2);

        /* error rate between 0 and 1 (not 0) */
        if ((errorRate <= 0) || (errorRate > 1))
            elog(ERROR, "error rate has to be between 0 and 1");

        if (!PG_ARGISNULL(3) && ('u' == VARDATA_ANY(PG_GETARG_TEXT_P(3))[0] || 'U'  == VARDATA_ANY(PG_GETARG_TEXT_P(3))[0] )){
            hyperloglog = hll_create(DEFAULT_NDISTINCT, errorRate, PACKED_UNPACKED);
        } else if (!PG_ARGISNULL(3) && ('p' == VARDATA_ANY(PG_GETARG_TEXT_P(3))[0] || 'P'  == VARDATA_ANY(PG_GETARG_TEXT_P(3))[0] ) ) {
            hyperloglog = hll_create(DEFAULT_NDISTINCT, errorRate, PACKED);
        } else {
            elog(ERROR,"ERROR: Improper format specification! Must be U or P");
            PG_RETURN_NULL();
        }

    } else { /* existing estimator */
        hyperloglog = (HLLCounter) PG_GETARG_BYTEA_P(0);
    }

    /* add the item to the estimator (skip NULLs) */
    if (! PG_ARGISNULL(1)) {

        /* TODO The requests for type info shouldn't be a problem (thanks to
 *                  * lsyscache), but if it turns out to have a noticeable impact it's
 *                                   * possible to cache that between the calls (in the estimator).
 *                                                    *
 *                                                                     * I have noticed no measurable effect from either option. */

        /* get type information for the second parameter (anyelement item) */
        get_typlenbyvalalign(element_type, &typlen, &typbyval, &typalign);

                /* decompress if needed */
        if(hyperloglog->b < 0){
            hyperloglog = hll_decompress(hyperloglog);
        }

        /* it this a varlena type, passed by reference or by value ? */
        if (typlen == -1) {
            /* varlena */
            hyperloglog = hll_add_element(hyperloglog, VARDATA_ANY(element), VARSIZE_ANY_EXHDR(element));
        } else if (typbyval) {
            /* fixed-length, passed by value */
            hyperloglog = hll_add_element(hyperloglog, (char*)&element, typlen);
        } else {
            /* fixed-length, passed by reference */
            hyperloglog = hll_add_element(hyperloglog, (char*)element, typlen);
        }
    }

    /* return the updated bytea */
    PG_RETURN_BYTEA_P(hyperloglog);

}



Datum
hyperloglog_add_item_agg_default(PG_FUNCTION_ARGS)
{

    HLLCounter hyperloglog;

    /* info for anyelement */
    Oid         element_type = get_fn_expr_argtype(fcinfo->flinfo, 1);
    Datum       element = PG_GETARG_DATUM(1);
    int16       typlen;
    bool        typbyval;
    char        typalign;
    
    /* Create a new estimator (with default error rate and ndistinct) or reuse
     * the existing one. Return null if both counter and element args are null.
     * This prevents excess empty counter creation */
    if (PG_ARGISNULL(0) && PG_ARGISNULL(1)){
        PG_RETURN_NULL();
    } else if (PG_ARGISNULL(0)) {
    hyperloglog = hll_create(DEFAULT_NDISTINCT, DEFAULT_ERROR, PACKED);
    } else {
        hyperloglog = (HLLCounter) PG_GETARG_BYTEA_P(0);
    }

    /* add the item to the estimator (skip NULLs) */
    if (! PG_ARGISNULL(1)) {

        /* TODO The requests for type info shouldn't be a problem (thanks to
         * lsyscache), but if it turns out to have a noticeable impact it's
         * possible to cache that between the calls (in the estimator).
         *
         * I have noticed no measurable effect from either option. */

        /* get type information for the second parameter (anyelement item) */
        get_typlenbyvalalign(element_type, &typlen, &typbyval, &typalign);

        /* decompress if needed */
        if(hyperloglog->b < 0){
            hyperloglog = hll_decompress(hyperloglog);
        }    

        /* it this a varlena type, passed by reference or by value ? */
        if (typlen == -1) {
            /* varlena */
            /* leaving idnetifier of VARLENA */
            hyperloglog = hll_add_element(hyperloglog, VARDATA_ANY(element), VARSIZE_ANY_EXHDR(element));
        } else if (typbyval) {
            /* fixed-length, passed by value */
            hyperloglog = hll_add_element(hyperloglog, (char*)&element, typlen);
        } else {
            /* fixed-length, passed by reference */
            hyperloglog = hll_add_element(hyperloglog, (char*)element, typlen);
        }

    }

    /* return the updated bytea */
    PG_RETURN_BYTEA_P(hyperloglog);

}

Datum
hyperloglog_add_item_agg_default_pack(PG_FUNCTION_ARGS)
{

    HLLCounter hyperloglog;

    /* info for anyelement */
    Oid         element_type = get_fn_expr_argtype(fcinfo->flinfo, 1);
    Datum       element = PG_GETARG_DATUM(1);
    int16       typlen;
    bool        typbyval;
    char        typalign;

    /* Create a new estimator (with default error rate and ndistinct) or reuse
 *      * the existing one. Return null if both counter and element args are null.
 *               * This prevents excess empty counter creation */
    if (PG_ARGISNULL(0) && PG_ARGISNULL(1)){
        PG_RETURN_NULL();
    } else if (PG_ARGISNULL(0)) {
        if (!PG_ARGISNULL(2) && ('u' == VARDATA_ANY(PG_GETARG_TEXT_P(2))[0] || 'U'  == VARDATA_ANY(PG_GETARG_TEXT_P(2))[0] )){
            hyperloglog = hll_create(DEFAULT_NDISTINCT, DEFAULT_ERROR, PACKED_UNPACKED);
        } else if (!PG_ARGISNULL(2) && ('p' == VARDATA_ANY(PG_GETARG_TEXT_P(2))[0] || 'P'  == VARDATA_ANY(PG_GETARG_TEXT_P(2))[0] ) ) {
            hyperloglog = hll_create(DEFAULT_NDISTINCT, DEFAULT_ERROR, PACKED);
        } else {
        elog(ERROR,"ERROR: Improper format specification! Must be U or P");
        PG_RETURN_NULL();
    }
    } else {
        hyperloglog = (HLLCounter) PG_GETARG_BYTEA_P(0);
    }

    /* add the item to the estimator (skip NULLs) */
    if (! PG_ARGISNULL(1)) {

        /* TODO The requests for type info shouldn't be a problem (thanks to
 *                  * lsyscache), but if it turns out to have a noticeable impact it's
 *                                   * possible to cache that between the calls (in the estimator).
 *                                                    *
 *                                                                     * I have noticed no measurable effect from either option. */

        /* get type information for the second parameter (anyelement item) */
        get_typlenbyvalalign(element_type, &typlen, &typbyval, &typalign);

                /* decompress if needed */
        if(hyperloglog->b < 0){
            hyperloglog = hll_decompress(hyperloglog);
        }

        /* it this a varlena type, passed by reference or by value ? */
        if (typlen == -1) {
            /* varlena */
            /* leaving idnetifier of VARLENA */
            hyperloglog = hll_add_element(hyperloglog, VARDATA_ANY(element), VARSIZE_ANY_EXHDR(element));
        } else if (typbyval) {
            /* fixed-length, passed by value */
            hyperloglog = hll_add_element(hyperloglog, (char*)&element, typlen);
        } else {
            /* fixed-length, passed by reference */
            hyperloglog = hll_add_element(hyperloglog, (char*)element, typlen);
        }

    }

    /* return the updated bytea */
    PG_RETURN_BYTEA_P(hyperloglog);

}



Datum
hyperloglog_merge(PG_FUNCTION_ARGS)
{

    HLLCounter counter1;
    HLLCounter counter2;

    if (PG_ARGISNULL(0) && PG_ARGISNULL(1)){
        /* if both counters are null return null */
        PG_RETURN_NULL();

    } else if (PG_ARGISNULL(0)) {
        /* if first counter is null just copy the second estimator into the
         * first one */
        counter1 = (HLLCounter) PG_GETARG_BYTEA_P(1);

    } else if (PG_ARGISNULL(1)) {
        /* if second counter is null just return the the first estimator */
        counter1 = (HLLCounter) PG_GETARG_BYTEA_P(0);

    } else {

        /* ok, we already have the estimator - merge the second one into it */
        counter1 = (HLLCounter) PG_GETARG_BYTEA_P_COPY(0);
        counter2 = (HLLCounter) PG_GETARG_BYTEA_P_COPY(1);

        /* unpack if needed */
    counter1 = hll_unpack(counter1);
    counter2 = hll_unpack(counter2);

        /* perform the merge */
        counter1 = hll_merge(counter1, counter2);

    }

    /* return the updated bytea */
    PG_RETURN_BYTEA_P(counter1);


}

Datum
hyperloglog_merge_unsafe(PG_FUNCTION_ARGS)
{

    HLLCounter counter1;
    HLLCounter counter2;

    if (PG_ARGISNULL(0) && PG_ARGISNULL(1)){
        /* if both counters are null return null */
        PG_RETURN_NULL();

    }
    else if (PG_ARGISNULL(0)) {
        /* if first counter is null just copy the second estimator into the
        * first one */
        counter1 = (HLLCounter) PG_GETARG_BYTEA_P(1);

    }
    else if (PG_ARGISNULL(1)) {
        /* if second counter is null just return the the first estimator */
        counter1 = (HLLCounter) PG_GETARG_BYTEA_P(0);

    }
    else {

        /* ok, we already have the estimator - merge the second one into it */
        counter1 = (HLLCounter) PG_GETARG_BYTEA_P(0);
        counter2 = (HLLCounter) PG_GETARG_BYTEA_P(1);

        /* unpack if needed */
        counter1 = hll_unpack(counter1);
        counter2 = hll_unpack(counter2);

        /* perform the merge */
        counter1 = hll_merge(counter1, counter2);

    }

    /* return the updated bytea */
    PG_RETURN_BYTEA_P(counter1);


}

double
hyperloglog_get_estimate(HLLCounter hllcounter)
{

    double estimate;
    HLLCounter hyperloglog = hllcounter;
    
    /* unpack if needed */
    hyperloglog = hll_unpack(hyperloglog);

    estimate = hll_estimate(hyperloglog);

    /* return the updated bytea */
    return estimate;

}

Datum
hyperloglog_init_default(PG_FUNCTION_ARGS)
{
      HLLCounter hyperloglog;

      hyperloglog = hll_create(DEFAULT_NDISTINCT, DEFAULT_ERROR,PACKED);

      PG_RETURN_BYTEA_P(hyperloglog);
}

Datum
hyperloglog_init_error(PG_FUNCTION_ARGS)
{
      HLLCounter hyperloglog;

      float errorRate; /* required error rate */

      errorRate = PG_GETARG_FLOAT4(0);

      /* error rate between 0 and 1 (not 0) */
      if ((errorRate <= 0) || (errorRate > 1)) {
          elog(ERROR, "error rate has to be between 0 and 1");
      }

      hyperloglog = hll_create(DEFAULT_NDISTINCT, errorRate, PACKED);

      PG_RETURN_BYTEA_P(hyperloglog);
}

Datum
hyperloglog_init(PG_FUNCTION_ARGS)
{
      HLLCounter hyperloglog;

      double ndistinct; 
      float errorRate; /* required error rate */

      ndistinct = PG_GETARG_FLOAT8(1);
      errorRate = PG_GETARG_FLOAT4(0);

      /* error rate between 0 and 1 (not 0) */
      if ((errorRate <= 0) || (errorRate > 1)) {
          elog(ERROR, "error rate has to be between 0 and 1");
      }

      hyperloglog = hll_create(ndistinct, errorRate, PACKED);

      PG_RETURN_BYTEA_P(hyperloglog);
}

Datum
hyperloglog_size_default(PG_FUNCTION_ARGS)
{
      PG_RETURN_INT32(hll_get_size(DEFAULT_NDISTINCT, DEFAULT_ERROR));
}

Datum
hyperloglog_size_error(PG_FUNCTION_ARGS)
{
      float errorRate; /* required error rate */

      errorRate = PG_GETARG_FLOAT4(0);

      /* error rate between 0 and 1 (not 0) */
      if ((errorRate <= 0) || (errorRate > 1)) {
          elog(ERROR, "error rate has to be between 0 and 1");
      }

      PG_RETURN_INT32(hll_get_size(DEFAULT_NDISTINCT, errorRate));
}

Datum
hyperloglog_size(PG_FUNCTION_ARGS)
{
      double ndistinct; 
      float errorRate; /* required error rate */

      ndistinct = PG_GETARG_FLOAT8(1);
      errorRate = PG_GETARG_FLOAT4(0);

      /* error rate between 0 and 1 (not 0) */
      if ((errorRate <= 0) || (errorRate > 1)) {
          elog(ERROR, "error rate has to be between 0 and 1");
      }

      PG_RETURN_INT32(hll_get_size(ndistinct, errorRate));
}

int
hyperloglog_length(HLLCounter hllcounter)
{
    PG_RETURN_INT32(VARSIZE_ANY(hllcounter));
}

Datum
hyperloglog_reset(PG_FUNCTION_ARGS)
{
    hll_reset_internal(((HLLCounter) PG_GETARG_BYTEA_P(0)));
    PG_RETURN_VOID();
}

Datum
hyperloglog_out(PG_FUNCTION_ARGS)
{
    int16   datalen, resultlen, res;
    char     *result;
    bytea    *data = PG_GETARG_BYTEA_P(0);

    datalen = VARSIZE_ANY_EXHDR(data);
    resultlen = b64_enc_len(VARDATA_ANY(data), datalen);
    result = palloc(resultlen + 1);
    res = hll_b64_encode(VARDATA_ANY(data),datalen, result);
    
    /* Make this FATAL 'cause we've trodden on memory ... */
    if (res > resultlen)
        elog(FATAL, "overflow - encode estimate too small");

    result[res] = '\0';

    PG_RETURN_CSTRING(result);
}

Datum
hyperloglog_in(PG_FUNCTION_ARGS)
{
    bytea      *result;
    char       *data = PG_GETARG_CSTRING(0);
    int16      datalen, resultlen, res;

    datalen = strlen(data);
    resultlen = b64_dec_len(data,datalen);
    result = palloc(VARHDRSZ + resultlen);
    res = hll_b64_decode(data, datalen, VARDATA(result));

    /* Make this FATAL 'cause we've trodden on memory ... */
    if (res > resultlen)
        elog(FATAL, "overflow - decode estimate too small");

    SET_VARSIZE(result, VARHDRSZ + res);

    PG_RETURN_BYTEA_P(result);
    
}

/*
 *        bytearecv            - converts external binary format to bytea
 */
Datum
hyperloglog_recv(PG_FUNCTION_ARGS)
{
    Datum dd = DirectFunctionCall1(bytearecv, PG_GETARG_DATUM(0));
    return dd;
}

/*
 *        byteasend            - converts bytea to binary format
 *
 * This is a special case: just copy the input...
 */
Datum
hyperloglog_send(PG_FUNCTION_ARGS)
{
    Datum dd = PG_GETARG_DATUM(0);
    bytea* bp = DatumGetByteaP(dd);
    StringInfoData buf;
    pq_begintypsend(&buf);
    pq_sendbytes(&buf, VARDATA_ANY(bp), VARSIZE_ANY_EXHDR(bp));
    PG_RETURN_BYTEA_P(pq_endtypsend(&buf));
}

Datum
hyperloglog_comp(PG_FUNCTION_ARGS)
{
    HLLCounter hyperloglog;

    if (PG_ARGISNULL(0) ){
        PG_RETURN_NULL();
    }

    hyperloglog =  (HLLCounter) PG_GETARG_BYTEA_P_COPY(0);

    hyperloglog = hll_compress(hyperloglog);

    PG_RETURN_BYTEA_P(hyperloglog);
}

Datum
hyperloglog_decomp(PG_FUNCTION_ARGS)
{
    HLLCounter hyperloglog;

    if (PG_ARGISNULL(0) ){
        PG_RETURN_NULL();
    }

    hyperloglog =  (HLLCounter) PG_GETARG_BYTEA_P_COPY(0);
    if (hyperloglog-> b < 0 && hyperloglog->format == PACKED ) {
        hyperloglog = hll_decompress(hyperloglog);
    }

    PG_RETURN_BYTEA_P(hyperloglog);
}


Datum
hyperloglog_update(PG_FUNCTION_ARGS)
{
    HLLCounter hyperloglog;

    if (PG_ARGISNULL(0) ){
        PG_RETURN_NULL();
    }

    hyperloglog = (HLLCounter)PG_GETARG_BYTEA_P_COPY(0);

    hyperloglog = hll_upgrade(hyperloglog);

    PG_RETURN_BYTEA_P(hyperloglog);
}


Datum
hyperloglog_info(PG_FUNCTION_ARGS)
{
    HLLCounter hyperloglog;
    char out[500], comp[4], enc[7], format[9];
    int corrected_b;

    if (PG_ARGISNULL(0) ){
        PG_RETURN_NULL();
    }

    hyperloglog =  (HLLCounter)PG_GETARG_BYTEA_P(0);
    
    if (hyperloglog->b < 0){
        snprintf(comp,4,"yes");
    } else {
        snprintf(comp,4,"no");
    }

    if (-1*hyperloglog->b > MAX_INDEX_BITS){
        corrected_b = -1*hyperloglog->b - MAX_INDEX_BITS;
    } else if (hyperloglog->b < 0){
        corrected_b = -1*hyperloglog->b;
    } else {
        corrected_b = hyperloglog->b;
    }

    if (hyperloglog->idx == -1){
        snprintf(enc,7,"dense");
    } else {
        snprintf(enc,7,"sparse");
    }
    
    if (hyperloglog->format == PACKED){
        snprintf(format, 9, "packed");
    } else if (hyperloglog->format == UNPACKED) {
        snprintf(format, 9, "unpacked");
    }

    snprintf(out, 500, "Counter Summary\nstruct version: %d\nsize on disk (bytes): %ld\nbits per bin: %d\nindex bits: %d\nnumber of bins: %d\ncompressed?: %s\nencoding: %s\nformat: %s\n--------------------------", hyperloglog->version, VARSIZE_ANY(hyperloglog), hyperloglog->binbits, corrected_b, (int)pow(2, corrected_b), comp, enc, format);

    PG_RETURN_TEXT_P(cstring_to_text(out));
}

Datum
hyperloglog_info_noargs(PG_FUNCTION_ARGS)
{
    char out[500];

    snprintf(out,500,"Current struct version %d\nDefault error rate %f\nDefault ndistinct %llu",STRUCT_VERSION,DEFAULT_ERROR,DEFAULT_NDISTINCT);

    PG_RETURN_TEXT_P(cstring_to_text(out));
}

    
/* set operations */
Datum
hyperloglog_equal(PG_FUNCTION_ARGS)
{

    HLLCounter counter1;
    HLLCounter counter2;

    if (PG_ARGISNULL(0) || PG_ARGISNULL(1)) {
        PG_RETURN_NULL();
    } else {
    counter1 = (HLLCounter) PG_GETARG_BYTEA_P_COPY(0);
    counter2 = (HLLCounter) PG_GETARG_BYTEA_P_COPY(1);

    /* unpack if needed */
    counter1 = hll_unpack(counter1);
        counter2 = hll_unpack(counter2);


        PG_RETURN_BOOL(hll_is_equal(counter1, counter2));
    }

}

Datum
hyperloglog_not_equal(PG_FUNCTION_ARGS)
{

    HLLCounter counter1;
    HLLCounter counter2;

    if (PG_ARGISNULL(0) || PG_ARGISNULL(1)) {
        PG_RETURN_NULL();
    } else {
    counter1 = (HLLCounter) PG_GETARG_BYTEA_P_COPY(0);
    counter2 = (HLLCounter) PG_GETARG_BYTEA_P_COPY(1);

    /* unpack if needed */
    counter1 = hll_unpack(counter1);
    counter2 = hll_unpack(counter2);


        PG_RETURN_BOOL(!hll_is_equal(counter1, counter2));
    }

}

Datum
hyperloglog_union(PG_FUNCTION_ARGS)
{

    HLLCounter counter1;
    HLLCounter counter2;

    if (PG_ARGISNULL(0) && PG_ARGISNULL(1)) {
        PG_RETURN_NULL();
    } else if (PG_ARGISNULL(0)) {
    counter2 = (HLLCounter) PG_GETARG_BYTEA_P_COPY(1);

    /* unpack if needed */
    counter2 = hll_unpack(counter2);

    
        PG_RETURN_FLOAT8(hll_estimate(counter2));
    } else if (PG_ARGISNULL(1)) {
    counter1 = (HLLCounter) PG_GETARG_BYTEA_P_COPY(0);

    /* unpack if needed */
    counter1 = hll_unpack(counter1);

        PG_RETURN_FLOAT8(hll_estimate(counter1));
    } else {
    counter1 = (HLLCounter) PG_GETARG_BYTEA_P_COPY(0);
    counter2 = (HLLCounter) PG_GETARG_BYTEA_P_COPY(1);

    /* unpack if needed */
    counter1 = hll_unpack(counter1);
    counter2 = hll_unpack(counter2);


        PG_RETURN_FLOAT8(hll_estimate(hll_merge(counter1, counter2)));
    }

}

Datum
hyperloglog_intersection(PG_FUNCTION_ARGS)
{

    HLLCounter counter1;
    HLLCounter counter2;
    double A, B , AUB;

    if (PG_ARGISNULL(0) || PG_ARGISNULL(1)) {
        PG_RETURN_NULL();
    } else {
    counter1 = (HLLCounter) PG_GETARG_BYTEA_P_COPY(0);
    counter2 = (HLLCounter) PG_GETARG_BYTEA_P_COPY(1);

        /* unpack if needed */
    counter1 = hll_unpack(counter1);
    counter2 = hll_unpack(counter2);

        A = hll_estimate(counter1);
        B = hll_estimate(counter2);
        AUB = hll_estimate(hll_merge(counter1, counter2));
        PG_RETURN_FLOAT8(A + B - AUB);
    }

}

Datum
hyperloglog_compliment(PG_FUNCTION_ARGS)
{

    HLLCounter counter1;
    HLLCounter counter2;
    double B, AUB;

    if (PG_ARGISNULL(0) && PG_ARGISNULL(1)) {
        PG_RETURN_NULL();
    } else if (PG_ARGISNULL(0)) {
    counter2 = (HLLCounter) PG_GETARG_BYTEA_P_COPY(1);

        /* unpack if needed */
    counter2 = hll_unpack(counter2);
    
        PG_RETURN_FLOAT8(hll_estimate(counter2));
    } else if (PG_ARGISNULL(1)) {
    counter1 = (HLLCounter) PG_GETARG_BYTEA_P_COPY(0);

    /* unpack if needed */
    counter1 = hll_unpack(counter1);

        PG_RETURN_FLOAT8(hll_estimate(counter1));
    } else {
    counter1 = (HLLCounter) PG_GETARG_BYTEA_P_COPY(0);
    counter2 = (HLLCounter) PG_GETARG_BYTEA_P_COPY(1);

    /* unpack if needed */
    counter1 = hll_unpack(counter1);
    counter2 = hll_unpack(counter2);

        B = hll_estimate(counter2);
        AUB = hll_estimate(hll_merge(counter1, counter2));
        PG_RETURN_FLOAT8(AUB - B);
    }

}

Datum
hyperloglog_symmetric_diff(PG_FUNCTION_ARGS)
{

    HLLCounter counter1;
    HLLCounter counter2;
    double A, B , AUB;

    if (PG_ARGISNULL(0) && PG_ARGISNULL(1)) {
        PG_RETURN_NULL();
    } else if (PG_ARGISNULL(0)) {
    counter2 = (HLLCounter) PG_GETARG_BYTEA_P_COPY(1);

    /* unpack if needed */
    counter2 = hll_unpack(counter2);
    
        PG_RETURN_FLOAT8(hll_estimate(counter2));
    } else if (PG_ARGISNULL(1)) {
    counter1 = (HLLCounter) PG_GETARG_BYTEA_P_COPY(0);

    /* unpack if needed */
    counter1 = hll_unpack(counter1);

        PG_RETURN_FLOAT8(hll_estimate(counter1));
    } else {
    counter1 = (HLLCounter) PG_GETARG_BYTEA_P_COPY(0);
    counter2 = (HLLCounter) PG_GETARG_BYTEA_P_COPY(1);

    /* unpack if needed */
    counter1 = hll_unpack(counter1);
    counter2 = hll_unpack(counter2);


        A = hll_estimate(counter1);
        B = hll_estimate(counter2);
        AUB = hll_estimate(hll_merge(counter1, counter2));
        PG_RETURN_FLOAT8(2*AUB - A - B);
    }

}

