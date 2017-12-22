#ifndef HYPERLOGLOG_COUNTER_H
#define HYPERLOGLOG_COUNTER_H

#include "postgres.h"
#include "fmgr.h"
#include "utils/builtins.h"
#include "utils/bytea.h"
#include "utils/lsyscache.h"
#include "lib/stringinfo.h"
#include "libpq/pqformat.h"

#include "utils/hyperloglog.h"
#include "utils/upgrade.h"
#include "utils/encoding.h"

/* shoot for 2^64 distinct items and 0.8125% error rate by default */
#define DEFAULT_NDISTINCT   1ULL << 63 
#define DEFAULT_ERROR       0.008125


/* ------------- function declarations for local functions --------------- */
extern HLLCounter hyperloglog_add_item(HLLCounter hllcounter, Datum element, int16 typelen, bool typbyval, char typalign);
extern Datum hyperloglog_add_item_agg(PG_FUNCTION_ARGS);
extern Datum hyperloglog_add_item_agg_pack(PG_FUNCTION_ARGS);
extern Datum hyperloglog_add_item_agg_error(PG_FUNCTION_ARGS);
extern Datum hyperloglog_add_item_agg_error_pack(PG_FUNCTION_ARGS);
extern Datum hyperloglog_add_item_agg_default(PG_FUNCTION_ARGS);
extern Datum hyperloglog_add_item_agg_default_pack(PG_FUNCTION_ARGS);
extern double hyperloglog_get_estimate(HLLCounter hllcounter);
extern Datum hyperloglog_merge(PG_FUNCTION_ARGS);
extern Datum hyperloglog_merge_unsafe(PG_FUNCTION_ARGS);
extern Datum hyperloglog_size_default(PG_FUNCTION_ARGS);
extern Datum hyperloglog_size_error(PG_FUNCTION_ARGS);
extern Datum hyperloglog_size(PG_FUNCTION_ARGS);
extern Datum hyperloglog_init_default(PG_FUNCTION_ARGS);
extern Datum hyperloglog_init_error(PG_FUNCTION_ARGS);
extern Datum hyperloglog_init(PG_FUNCTION_ARGS);
extern Datum hyperloglog_reset(PG_FUNCTION_ARGS);
extern int hyperloglog_length(HLLCounter hllcounter);
extern Datum hyperloglog_in(PG_FUNCTION_ARGS);
extern Datum hyperloglog_out(PG_FUNCTION_ARGS);
extern Datum hyperloglog_recv(PG_FUNCTION_ARGS);
extern Datum hyperloglog_send(PG_FUNCTION_ARGS);
extern Datum hyperloglog_comp(PG_FUNCTION_ARGS);
extern Datum hyperloglog_decomp(PG_FUNCTION_ARGS);
extern Datum hyperloglog_update(PG_FUNCTION_ARGS);
extern Datum hyperloglog_info(PG_FUNCTION_ARGS);
extern Datum hyperloglog_info_noargs(PG_FUNCTION_ARGS);
extern Datum hyperloglog_equal(PG_FUNCTION_ARGS);
extern Datum hyperloglog_not_equal(PG_FUNCTION_ARGS);
extern Datum hyperloglog_union(PG_FUNCTION_ARGS);
extern Datum hyperloglog_intersection(PG_FUNCTION_ARGS);
extern Datum hyperloglog_compliment(PG_FUNCTION_ARGS);
extern Datum hyperloglog_symmetric_diff(PG_FUNCTION_ARGS);

#endif
