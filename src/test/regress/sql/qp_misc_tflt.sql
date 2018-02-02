-- start_ignore
--
-- Greenplum Database database dump
--

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET default_with_oids = false;


--
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: gpadmin
--

CREATE LANGUAGE plpgsql;

SET search_path = public, pg_catalog;

SET default_tablespace = '';


--
-- Name: tflt; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace:
--

CREATE TABLE tflt (
    rnum integer NOT NULL,
    cflt double precision
) DISTRIBUTED BY (rnum);

--
-- Name: tversion; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace:
--

CREATE TABLE tversion (
    rnum integer NOT NULL,
    c1 integer,
    cver character(6),
    cnnull integer,
    ccnull character(1)
) DISTRIBUTED BY (rnum);

--
-- Name: vflt; Type: VIEW; Schema: public; Owner: gpadmin
--
CREATE VIEW vflt AS
    SELECT tflt.rnum, tflt.cflt FROM tflt;


--
-- Data for Name: tflt; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tflt (rnum, cflt) FROM stdin;
3	1
0	\N
1	-1
2	0
5	10
4	-0.10000000000000001
\.

--
-- Data for Name: tversion; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tversion (rnum, c1, cver, cnnull, ccnull) FROM stdin;
0	1	1.0   	\N	\N
\.

-- AbsCoreApproximateNumeric_p1
select 'AbsCoreApproximateNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1.000000000000000e+000 f2 from tversion union
select 2 f1, 0.000000000000000e+000 f2 from tversion union
select 3 f1, 1.000000000000000e+000 f2 from tversion union
select 4 f1, 1.000000000000000e-001 f2 from tversion union
select 5 f1, 1.000000000000000e+001 f2 from tversion union
select rnum, abs( vflt.cflt ) from vflt
) Q
group by
f1,f2
) Q ) P;
-- CaseNestedApproximateNumeric_p1
select 'CaseNestedApproximateNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'nested else' f2 from tversion union
select 3 f1, 'nested else' f2 from tversion union
select 4 f1, 'nested else' f2 from tversion union
select 5 f1, 'nested inner' f2 from tversion union
select vflt.rnum,case  when vflt.cflt > -1  then case  when vflt.cflt > 1 then  'nested inner' else 'nested else' end else 'else'  end from vflt
) Q
group by
f1,f2
) Q ) P;
-- CaseNestedApproximateNumeric_p2
select 'CaseNestedApproximateNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'nested else' f2 from tversion union
select 3 f1, 'nested else' f2 from tversion union
select 4 f1, 'nested else' f2 from tversion union
select 5 f1, 'nested inner' f2 from tversion union
select tflt.rnum,case  when tflt.cflt > -1  then case  when tflt.cflt > 1 then  'nested inner' else 'nested else' end else 'else'  end from tflt
) Q
group by
f1,f2
) Q ) P;
-- VarApproxNumeric_p1
select 'VarApproxNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 20.602 f1 from tversion union
select variance( vflt.cflt ) from vflt
) Q
group by
f1
) Q ) P;
-- VarApproxNumeric_p2
select 'VarApproxNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 20.602 f1 from tversion union
select variance( tflt.cflt ) from tflt
) Q
group by
f1
) Q ) P;
-- VarSampApproxNumeric_p1
select 'VarSampApproxNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 20.602 f1 from tversion union
select var_samp( vflt.cflt ) from vflt
) Q
group by
f1
) Q ) P;
-- VarSampApproxNumeric_p2
select 'VarSampApproxNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 20.602 f1 from tversion union
select var_samp( tflt.cflt ) from tflt
) Q
group by
f1
) Q ) P;
-- CaseSubqueryApproxmiateNumeric_p1
select 'CaseSubqueryApproxmiateNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'else' f2 from tversion union
select 5 f1, 'true' f2 from tversion union
select vflt.rnum,case  when vflt.cflt= (select max( vflt.cflt) from vflt)    then 'true' else 'else' 	end from vflt
) Q
group by
f1,f2
) Q ) P;
-- CaseSubqueryApproxmiateNumeric_p2
select 'CaseSubqueryApproxmiateNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'else' f2 from tversion union
select 5 f1, 'true' f2 from tversion union
select tflt.rnum,case  when tflt.cflt= (select max( tflt.cflt) from tflt)    then 'true' else 'else' 	end from tflt
) Q
group by
f1,f2
) Q ) P;
-- ApproximateNumericOpAdd_p1
select 'ApproximateNumericOpAdd_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1.000000000000000e+000 f2 from tversion union
select 2 f1, 2.000000000000000e+000 f2 from tversion union
select 3 f1, 3.000000000000000e+000 f2 from tversion union
select 4 f1, 1.900000000000000e+000 f2 from tversion union
select 5 f1, 1.200000000000000e+001 f2 from tversion union
select vflt.rnum,vflt.cflt + 2 from vflt
) Q
group by
f1,f2
) Q ) P;
-- ApproximateNumericOpAdd_p2
select 'ApproximateNumericOpAdd_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1.000000000000000e+000 f2 from tversion union
select 2 f1, 2.000000000000000e+000 f2 from tversion union
select 3 f1, 3.000000000000000e+000 f2 from tversion union
select 4 f1, 1.900000000000000e+000 f2 from tversion union
select 5 f1, 1.200000000000000e+001 f2 from tversion union
select tflt.rnum,tflt.cflt + 2 from tflt
) Q
group by
f1,f2
) Q ) P;
-- AbsCoreApproximateNumeric_p2
select 'AbsCoreApproximateNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1.000000000000000e+000 f2 from tversion union
select 2 f1, 0.000000000000000e+000 f2 from tversion union
select 3 f1, 1.000000000000000e+000 f2 from tversion union
select 4 f1, 1.000000000000000e-001 f2 from tversion union
select 5 f1, 1.000000000000000e+001 f2 from tversion union
select rnum, abs( tflt.cflt ) from tflt
) Q
group by
f1,f2
) Q ) P;
-- CastFloatToBigint_p1
select 'CastFloatToBigint_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, cast(vflt.cflt as bigint) from vflt
) Q
group by
f1,f2
) Q ) P;
-- CastFloatToBigint_p2
select 'CastFloatToBigint_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, cast(tflt.cflt as bigint) from tflt
) Q
group by
f1,f2
) Q ) P;
-- CastFloatToChar_p1
select 'CastFloatToChar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1E+0               ' f2 from tversion union
select 2 f1, '0E0                 ' f2 from tversion union
select 3 f1, '1E0                 ' f2 from tversion union
select 4 f1, '-1E-1               ' f2 from tversion union
select 5 f1, '1E1                 ' f2 from tversion union
select rnum, cast(vflt.cflt as char(20)) from vflt
) Q
group by
f1,f2
) Q ) P;
-- CastFloatToChar_p2
select 'CastFloatToChar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1E+0               ' f2 from tversion union
select 2 f1, '0E0                 ' f2 from tversion union
select 3 f1, '1E0                 ' f2 from tversion union
select 4 f1, '-1E-1               ' f2 from tversion union
select 5 f1, '1E1                 ' f2 from tversion union
select rnum, cast(tflt.cflt as char(20)) from tflt
) Q
group by
f1,f2
) Q ) P;
-- CastFloatToDouble_p1
select 'CastFloatToDouble_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1.0 f2 from tversion union
select 2 f1, 0.0 f2 from tversion union
select 3 f1, 1.0 f2 from tversion union
select 4 f1, -0.1 f2 from tversion union
select 5 f1, 10.0 f2 from tversion union
select rnum, cast(vflt.cflt as double precision) from vflt
) Q
group by
f1,f2
) Q ) P;
-- CastFloatToDouble_p2
select 'CastFloatToDouble_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1.0 f2 from tversion union
select 2 f1, 0.0 f2 from tversion union
select 3 f1, 1.0 f2 from tversion union
select 4 f1, -0.1 f2 from tversion union
select 5 f1, 10.0 f2 from tversion union
select rnum, cast(tflt.cflt as double precision) from tflt
) Q
group by
f1,f2
) Q ) P;
-- CastFloatToFloat_p1
select 'CastFloatToFloat_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1.0 f2 from tversion union
select 2 f1, 0.0 f2 from tversion union
select 3 f1, 1.0 f2 from tversion union
select 4 f1, -0.1 f2 from tversion union
select 5 f1, 10.0 f2 from tversion union
select rnum, cast(vflt.cflt as float) from vflt
) Q
group by
f1,f2
) Q ) P;
-- CastFloatToFloat_p2
select 'CastFloatToFloat_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1.0 f2 from tversion union
select 2 f1, 0.0 f2 from tversion union
select 3 f1, 1.0 f2 from tversion union
select 4 f1, -0.1 f2 from tversion union
select 5 f1, 10.0 f2 from tversion union
select rnum, cast(tflt.cflt as float) from tflt
) Q
group by
f1,f2
) Q ) P;
-- CastFloatToSmallint_p1
select 'CastFloatToSmallint_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, cast(vflt.cflt as smallint) from vflt
) Q
group by
f1,f2
) Q ) P;
-- CastFloatToSmallint_p2
select 'CastFloatToSmallint_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, cast(tflt.cflt as smallint) from tflt
) Q
group by
f1,f2
) Q ) P;
-- CastFloatToVarchar_p1
select 'CastFloatToVarchar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1E+0' f2 from tversion union
select 2 f1, '0E0' f2 from tversion union
select 3 f1, '1E0' f2 from tversion union
select 4 f1, '-1E-1' f2 from tversion union
select 5 f1, '1E1' f2 from tversion union
select rnum, cast(vflt.cflt as varchar(10)) from vflt
) Q
group by
f1,f2
) Q ) P;
-- CastFloatToVarchar_p2
select 'CastFloatToVarchar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1E+0' f2 from tversion union
select 2 f1, '0E0' f2 from tversion union
select 3 f1, '1E0' f2 from tversion union
select 4 f1, '-1E-1' f2 from tversion union
select 5 f1, '1E1' f2 from tversion union
select rnum, cast(tflt.cflt as varchar(10)) from tflt
) Q
group by
f1,f2
) Q ) P;
-- ApproximateNumericOpDiv_p1
select 'ApproximateNumericOpDiv_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -5.000000000000000e-001 f2 from tversion union
select 2 f1, 0.000000000000000e+000 f2 from tversion union
select 3 f1, 5.000000000000000e-001 f2 from tversion union
select 4 f1, -5.000000000000000e-002 f2 from tversion union
select 5 f1, 5.000000000000000e+000 f2 from tversion union
select vflt.rnum,vflt.cflt / 2 from vflt
) Q
group by
f1,f2
) Q ) P;
-- ApproximateNumericOpDiv_p2
select 'ApproximateNumericOpDiv_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -5.000000000000000e-001 f2 from tversion union
select 2 f1, 0.000000000000000e+000 f2 from tversion union
select 3 f1, 5.000000000000000e-001 f2 from tversion union
select 4 f1, -5.000000000000000e-002 f2 from tversion union
select 5 f1, 5.000000000000000e+000 f2 from tversion union
select tflt.rnum,tflt.cflt / 2 from tflt
) Q
group by
f1,f2
) Q ) P;
-- CeilCoreApproximateNumeric_p1
select 'CeilCoreApproximateNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, ceil( vflt.cflt ) from vflt
) Q
group by
f1,f2
) Q ) P;
-- CeilCoreApproximateNumeric_p2
select 'CeilCoreApproximateNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, ceil( tflt.cflt ) from tflt
) Q
group by
f1,f2
) Q ) P;
-- ApproximateNumericOpMul_p1
select 'ApproximateNumericOpMul_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -2.000000000000000e+000 f2 from tversion union
select 2 f1, 0.000000000000000e+000 f2 from tversion union
select 3 f1, 2.000000000000000e+000 f2 from tversion union
select 4 f1, -2.000000000000000e-001 f2 from tversion union
select 5 f1, 2.000000000000000e+001 f2 from tversion union
select vflt.rnum,vflt.cflt * 2 from vflt
) Q
group by
f1,f2
) Q ) P;
-- ApproximateNumericOpMul_p2
select 'ApproximateNumericOpMul_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -2.000000000000000e+000 f2 from tversion union
select 2 f1, 0.000000000000000e+000 f2 from tversion union
select 3 f1, 2.000000000000000e+000 f2 from tversion union
select 4 f1, -2.000000000000000e-001 f2 from tversion union
select 5 f1, 2.000000000000000e+001 f2 from tversion union
select tflt.rnum,tflt.cflt * 2 from tflt
) Q
group by
f1,f2
) Q ) P;
-- DistinctAggregateInCase_p1
select 'DistinctAggregateInCase_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'test1' f1 from tversion union
select case when min(distinct(vflt.cflt))=-1 then 'test1' else 'else' end from vflt
) Q
group by
f1
) Q ) P;
-- DistinctAggregateInCase_p2
select 'DistinctAggregateInCase_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'test1' f1 from tversion union
select case when min(distinct(tflt.cflt))=-1 then 'test1' else 'else' end from tflt
) Q
group by
f1
) Q ) P;
-- ApproximateNumericOpSub_p1
select 'ApproximateNumericOpSub_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -3.000000000000000e+000 f2 from tversion union
select 2 f1, -2.000000000000000e+000 f2 from tversion union
select 3 f1, -1.000000000000000e+000 f2 from tversion union
select 4 f1, -2.100000000000000e+000 f2 from tversion union
select 5 f1, 8.000000000000000e+000 f2 from tversion union
select vflt.rnum,vflt.cflt - 2 from vflt
) Q
group by
f1,f2
) Q ) P;
-- ApproximateNumericOpSub_p2
select 'ApproximateNumericOpSub_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -3.000000000000000e+000 f2 from tversion union
select 2 f1, -2.000000000000000e+000 f2 from tversion union
select 3 f1, -1.000000000000000e+000 f2 from tversion union
select 4 f1, -2.100000000000000e+000 f2 from tversion union
select 5 f1, 8.000000000000000e+000 f2 from tversion union
select tflt.rnum,tflt.cflt - 2 from tflt
) Q
group by
f1,f2
) Q ) P;
-- ExpCoreApproximateNumeric_p1
select 'ExpCoreApproximateNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, .367879441 f2 from tversion union
select 2 f1, 1 f2 from tversion union
select 3 f1, 2.71828183 f2 from tversion union
select 4 f1, .904837418 f2 from tversion union
select 5 f1, 22026.4658 f2 from tversion union
select vflt.rnum, exp( vflt.cflt ) from vflt
) Q
group by
f1,f2
) Q ) P;
-- ExpCoreApproximateNumeric_p2
select 'ExpCoreApproximateNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, .367879441 f2 from tversion union
select 2 f1, 1 f2 from tversion union
select 3 f1, 2.71828183 f2 from tversion union
select 4 f1, .904837418 f2 from tversion union
select 5 f1, 22026.4658 f2 from tversion union
select tflt.rnum, exp( tflt.cflt ) from tflt
) Q
group by
f1,f2
) Q ) P;
-- AvgApproxNumeric_p1
select 'AvgApproxNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1.98 f1 from tversion union
select avg(vflt.cflt) from vflt
) Q
group by
f1
) Q ) P;
-- AvgApproxNumeric_p2
select 'AvgApproxNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1.98 f1 from tversion union
select avg(tflt.cflt) from tflt
) Q
group by
f1
) Q ) P;
-- FloorCoreApproximateNumeric_p1
select 'FloorCoreApproximateNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, -1 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, floor( vflt.cflt ) from vflt
) Q
group by
f1,f2
) Q ) P;
-- FloorCoreApproximateNumeric_p2
select 'FloorCoreApproximateNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, -1 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, floor( tflt.cflt ) from tflt
) Q
group by
f1,f2
) Q ) P;
-- PowerCoreApproxNumeric_p1
select 'PowerCoreApproxNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, .01 f2 from tversion union
select 5 f1, 100 f2 from tversion union
select vflt.rnum, power( vflt.cflt,2 ) from vflt
) Q
group by
f1,f2
) Q ) P;
-- PowerCoreApproxNumeric_p2
select 'PowerCoreApproxNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, .01 f2 from tversion union
select 5 f1, 100 f2 from tversion union
select tflt.rnum, power( tflt.cflt,2 ) from tflt
) Q
group by
f1,f2
) Q ) P;
-- SelectCountApproxNumeric_p1
select 'SelectCountApproxNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5 f1 from tversion union
select count(vflt.cflt) from vflt
) Q
group by
f1
) Q ) P;
-- SelectCountApproxNumeric_p2
select 'SelectCountApproxNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5 f1 from tversion union
select count(tflt.cflt) from tflt
) Q
group by
f1
) Q ) P;
-- CaseBasicSearchApproximateNumeric_p1
select 'CaseBasicSearchApproximateNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'test1' f2 from tversion union
select 2 f1, 'other' f2 from tversion union
select 3 f1, 'other' f2 from tversion union
select 4 f1, 'other' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select vflt.rnum,case when vflt.cflt in ( -1,10,0.1 )  then 'test1' else 'other' end from vflt
) Q
group by
f1,f2
) Q ) P;
-- CaseBasicSearchApproximateNumeric_p2
select 'CaseBasicSearchApproximateNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'test1' f2 from tversion union
select 2 f1, 'other' f2 from tversion union
select 3 f1, 'other' f2 from tversion union
select 4 f1, 'other' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select tflt.rnum,case when tflt.cflt in ( -1,10,0.1 )  then 'test1' else 'other' end from tflt
) Q
group by
f1,f2
) Q ) P;
-- SelectMaxApproxNumeric_p1
select 'SelectMaxApproxNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10 f1 from tversion union
select max( vflt.cflt ) from vflt
) Q
group by
f1
) Q ) P;
-- SelectMaxApproxNumeric_p2
select 'SelectMaxApproxNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10 f1 from tversion union
select max( tflt.cflt ) from tflt
) Q
group by
f1
) Q ) P;
-- SelectMinApproxNumeric_p1
select 'SelectMinApproxNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select -1 f1 from tversion union
select min( vflt.cflt ) from vflt
) Q
group by
f1
) Q ) P;
-- SelectMinApproxNumeric_p2
select 'SelectMinApproxNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select -1 f1 from tversion union
select min( tflt.cflt ) from tflt
) Q
group by
f1
) Q ) P;
-- SelectStanDevPopApproxNumeric_p1
select 'SelectStanDevPopApproxNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.05975 f1 from tversion union
select stddev_pop( vflt.cflt ) from vflt
) Q
group by
f1
) Q ) P;
-- SelectStanDevPopApproxNumeric_p2
select 'SelectStanDevPopApproxNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.05975 f1 from tversion union
select stddev_pop( tflt.cflt ) from tflt
) Q
group by
f1
) Q ) P;
-- SelectSumApproxNumeric_p1
select 'SelectSumApproxNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 9.9 f1 from tversion union
select sum( vflt.cflt ) from vflt
) Q
group by
f1
) Q ) P;
-- SelectSumApproxNumeric_p2
select 'SelectSumApproxNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 9.9 f1 from tversion union
select sum( tflt.cflt ) from tflt
) Q
group by
f1
) Q ) P;
-- SelectVarPopApproxNumeric_p1
select 'SelectVarPopApproxNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 16.4816 f1 from tversion union
select var_pop( vflt.cflt ) from vflt
) Q
group by
f1
) Q ) P;
-- SelectVarPopApproxNumeric_p2
select 'SelectVarPopApproxNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 16.4816 f1 from tversion union
select var_pop( tflt.cflt ) from tflt
) Q
group by
f1
) Q ) P;
-- CaseComparisonsApproximateNumeric_p1
select 'CaseComparisonsApproximateNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'lt' f2 from tversion union
select 2 f1, 'in' f2 from tversion union
select 3 f1, '=' f2 from tversion union
select 4 f1, 'between' f2 from tversion union
select 5 f1, 'gt' f2 from tversion union
select vflt.rnum,case  when vflt.cflt =  1  then '=' when vflt.cflt >  9  then 'gt' when vflt.cflt < -0.2 then 'lt' when vflt.cflt in  (0,11)  then 'in' when vflt.cflt between -1 and 0  then 'between' else 'other' end from vflt
) Q
group by
f1,f2
) Q ) P;
-- CaseComparisonsApproximateNumeric_p2
select 'CaseComparisonsApproximateNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'lt' f2 from tversion union
select 2 f1, 'in' f2 from tversion union
select 3 f1, '=' f2 from tversion union
select 4 f1, 'between' f2 from tversion union
select 5 f1, 'gt' f2 from tversion union
select tflt.rnum,case  when tflt.cflt =  1  then '=' when tflt.cflt >  9  then 'gt' when tflt.cflt < -0.2 then 'lt' when tflt.cflt in  (0,11)  then 'in' when tflt.cflt between -1 and 0  then 'between' else 'other' end from tflt
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseApproximateNumericElseDefaultsNULL_p1
select 'SimpleCaseApproximateNumericElseDefaultsNULL_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, 'test2' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select vflt.rnum,case when vflt.cflt > 1 then 'test1' when vflt.cflt < 0 then 'test2' end from vflt
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseApproximateNumericElseDefaultsNULL_p2
select 'SimpleCaseApproximateNumericElseDefaultsNULL_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, 'test2' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select tflt.rnum,case when tflt.cflt > 1 then 'test1' when tflt.cflt < 0 then 'test2' end from tflt
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseApproximateNumericElseExplicitNULL_p1
select 'SimpleCaseApproximateNumericElseExplicitNULL_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, 'test2' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select vflt.rnum,case when vflt.cflt > 1 then 'test1' when vflt.cflt < 0 then 'test2' else null end from vflt
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseApproximateNumericElseExplicitNULL_p2
select 'SimpleCaseApproximateNumericElseExplicitNULL_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, 'test2' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select tflt.rnum,case when tflt.cflt > 1 then 'test1' when tflt.cflt < 0 then 'test2' else null end from tflt
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseApproximateNumeric_p1
select 'SimpleCaseApproximateNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'test2' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select vflt.rnum,case when vflt.cflt > 1 then 'test1' when vflt.cflt < 0 then 'test2' else 'else' end from vflt
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseApproximateNumeric_p2
select 'SimpleCaseApproximateNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'test2' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select tflt.rnum,case when tflt.cflt > 1 then 'test1' when tflt.cflt < 0 then 'test2' else 'else' end from tflt
) Q
group by
f1,f2
) Q ) P;
-- StanDevApproxNumeric_p1
select 'StanDevApproxNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.53894 f1 from tversion union
select stddev( vflt.cflt ) from vflt
) Q
group by
f1
) Q ) P;
-- StanDevApproxNumeric_p2
select 'StanDevApproxNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.53894 f1 from tversion union
select stddev( tflt.cflt ) from tflt
) Q
group by
f1
) Q ) P;
-- StanDevSampApproxNumeric_p1
select 'StanDevSampApproxNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.53894 f1 from tversion union
select stddev_samp( vflt.cflt ) from vflt
) Q
group by
f1
) Q ) P;
-- StanDevSampApproxNumeric_p2
select 'StanDevSampApproxNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.53894 f1 from tversion union
select stddev_samp( tflt.cflt ) from tflt
) Q
group by
f1
) Q ) P;

