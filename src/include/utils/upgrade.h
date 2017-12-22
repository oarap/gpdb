#ifndef LEGACY_H
#define LEGACY_H
#include "utils/hyperloglog.h"

/* ---------------------- function declarations ------------------------ */
HLLCounter hll_upgrade(HLLCounter hloglog);

#endif
