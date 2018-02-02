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
-- Name: tdbl; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace:
--

CREATE TABLE tdbl (
    rnum integer NOT NULL,
    cdbl double precision
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
-- Name: vdbl; Type: VIEW; Schema: public; Owner: gpadmin
--

CREATE VIEW vdbl AS
    SELECT tdbl.rnum, tdbl.cdbl FROM tdbl;

--
-- Data for Name: tdbl; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tdbl (rnum, cdbl) FROM stdin;
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

-- CaseNestedApproximateNumeric_p3
select 'CaseNestedApproximateNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'nested else' f2 from tversion union
select 3 f1, 'nested else' f2 from tversion union
select 4 f1, 'nested else' f2 from tversion union
select 5 f1, 'nested inner' f2 from tversion union
select vdbl.rnum,case  when vdbl.cdbl > -1  then case  when vdbl.cdbl > 1 then  'nested inner' else 'nested else' end else 'else'  end from vdbl
) Q
group by
f1,f2
) Q ) P;
-- VarApproxNumeric_p3
select 'VarApproxNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 20.602 f1 from tversion union
select variance( vdbl.cdbl ) from vdbl
) Q
group by
f1
) Q ) P;
-- VarApproxNumeric_p4
select 'VarApproxNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 20.602 f1 from tversion union
select variance( tdbl.cdbl ) from tdbl
) Q
group by
f1
) Q ) P;
-- CaseNestedApproximateNumeric_p4
select 'CaseNestedApproximateNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'nested else' f2 from tversion union
select 3 f1, 'nested else' f2 from tversion union
select 4 f1, 'nested else' f2 from tversion union
select 5 f1, 'nested inner' f2 from tversion union
select tdbl.rnum,case  when tdbl.cdbl > -1  then case  when tdbl.cdbl > 1 then  'nested inner' else 'nested else' end else 'else'  end from tdbl
) Q
group by
f1,f2
) Q ) P;
-- VarSampApproxNumeric_p3
select 'VarSampApproxNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 20.602 f1 from tversion union
select var_samp( vdbl.cdbl ) from vdbl
) Q
group by
f1
) Q ) P;
-- VarSampApproxNumeric_p4
select 'VarSampApproxNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 20.602 f1 from tversion union
select var_samp( tdbl.cdbl ) from tdbl
) Q
group by
f1
) Q ) P;
-- CaseSubqueryApproxmiateNumeric_p3
select 'CaseSubqueryApproxmiateNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'else' f2 from tversion union
select 5 f1, 'true' f2 from tversion union
select vdbl.rnum,case  when vdbl.cdbl= (select max( vdbl.cdbl) from vdbl)    then 'true' else 'else' 	end from vdbl
) Q
group by
f1,f2
) Q ) P;
-- CaseSubqueryApproxmiateNumeric_p4
select 'CaseSubqueryApproxmiateNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'else' f2 from tversion union
select 5 f1, 'true' f2 from tversion union
select tdbl.rnum,case  when tdbl.cdbl= (select max( tdbl.cdbl) from tdbl)    then 'true' else 'else' 	end from tdbl
) Q
group by
f1,f2
) Q ) P;
-- CastDoubleToBigint_p1
select 'CastDoubleToBigint_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, cast(vdbl.cdbl as bigint) from vdbl
) Q
group by
f1,f2
) Q ) P;
-- CastDoubleToBigint_p2
select 'CastDoubleToBigint_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, cast(tdbl.cdbl as bigint) from tdbl
) Q
group by
f1,f2
) Q ) P;
-- CastDoubleToChar_p1
select 'CastDoubleToChar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1E+0               ' f2 from tversion union
select 2 f1, '0E0                 ' f2 from tversion union
select 3 f1, '1E0                 ' f2 from tversion union
select 4 f1, '-1E-1               ' f2 from tversion union
select 5 f1, '1E1                 ' f2 from tversion union
select rnum, cast(vdbl.cdbl as char(20)) from vdbl
) Q
group by
f1,f2
) Q ) P;
-- CastDoubleToChar_p2
select 'CastDoubleToChar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1E+0               ' f2 from tversion union
select 2 f1, '0E0                 ' f2 from tversion union
select 3 f1, '1E0                 ' f2 from tversion union
select 4 f1, '-1E-1               ' f2 from tversion union
select 5 f1, '1E1                 ' f2 from tversion union
select rnum, cast(tdbl.cdbl as char(20)) from tdbl
) Q
group by
f1,f2
) Q ) P;
-- CastDoubleToDouble_p1
select 'CastDoubleToDouble_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1.0 f2 from tversion union
select 2 f1, 0.0 f2 from tversion union
select 3 f1, 1.0 f2 from tversion union
select 4 f1, -0.1 f2 from tversion union
select 5 f1, 10.0 f2 from tversion union
select rnum, cast(vdbl.cdbl as double precision) from vdbl
) Q
group by
f1,f2
) Q ) P;
-- CastDoubleToDouble_p2
select 'CastDoubleToDouble_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1.0 f2 from tversion union
select 2 f1, 0.0 f2 from tversion union
select 3 f1, 1.0 f2 from tversion union
select 4 f1, -0.1 f2 from tversion union
select 5 f1, 10.0 f2 from tversion union
select rnum, cast(tdbl.cdbl as double precision) from tdbl
) Q
group by
f1,f2
) Q ) P;
-- CastDoubleToFloat_p1
select 'CastDoubleToFloat_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1.0 f2 from tversion union
select 2 f1, 0.0 f2 from tversion union
select 3 f1, 1.0 f2 from tversion union
select 4 f1, -0.1 f2 from tversion union
select 5 f1, 10.0 f2 from tversion union
select rnum, cast(vdbl.cdbl as float) from vdbl
) Q
group by
f1,f2
) Q ) P;
-- CastDoubleToFloat_p2
select 'CastDoubleToFloat_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1.0 f2 from tversion union
select 2 f1, 0.0 f2 from tversion union
select 3 f1, 1.0 f2 from tversion union
select 4 f1, -0.1 f2 from tversion union
select 5 f1, 10.0 f2 from tversion union
select rnum, cast(tdbl.cdbl as float) from tdbl
) Q
group by
f1,f2
) Q ) P;
-- CastDoubleToSmallint_p1
select 'CastDoubleToSmallint_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, cast(vdbl.cdbl as smallint) from vdbl
) Q
group by
f1,f2
) Q ) P;
-- CastDoubleToSmallint_p2
select 'CastDoubleToSmallint_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, cast(tdbl.cdbl as smallint) from tdbl
) Q
group by
f1,f2
) Q ) P;
-- CastDoubleToVarchar_p1
select 'CastDoubleToVarchar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1E+0' f2 from tversion union
select 2 f1, '0E0' f2 from tversion union
select 3 f1, '1E0' f2 from tversion union
select 4 f1, '-1E-1' f2 from tversion union
select 5 f1, '1E1' f2 from tversion union
select rnum, cast(vdbl.cdbl as varchar(20)) from vdbl
) Q
group by
f1,f2
) Q ) P;
-- CastDoubleToVarchar_p2
select 'CastDoubleToVarchar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1E+0' f2 from tversion union
select 2 f1, '0E0' f2 from tversion union
select 3 f1, '1E0' f2 from tversion union
select 4 f1, '-1E-1' f2 from tversion union
select 5 f1, '1E1' f2 from tversion union
select rnum, cast(tdbl.cdbl as varchar(20)) from tdbl
) Q
group by
f1,f2
) Q ) P;
-- ApproximateNumericOpAdd_p3
select 'ApproximateNumericOpAdd_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1.000000000000000e+000 f2 from tversion union
select 2 f1, 2.000000000000000e+000 f2 from tversion union
select 3 f1, 3.000000000000000e+000 f2 from tversion union
select 4 f1, 1.900000000000000e+000 f2 from tversion union
select 5 f1, 1.200000000000000e+001 f2 from tversion union
select vdbl.rnum,vdbl.cdbl + 2 from vdbl
) Q
group by
f1,f2
) Q ) P;
-- ApproximateNumericOpAdd_p4
select 'ApproximateNumericOpAdd_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1.000000000000000e+000 f2 from tversion union
select 2 f1, 2.000000000000000e+000 f2 from tversion union
select 3 f1, 3.000000000000000e+000 f2 from tversion union
select 4 f1, 1.900000000000000e+000 f2 from tversion union
select 5 f1, 1.200000000000000e+001 f2 from tversion union
select tdbl.rnum,tdbl.cdbl + 2 from tdbl
) Q
group by
f1,f2
) Q ) P;
-- ApproximateNumericOpDiv_p3
select 'ApproximateNumericOpDiv_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -5.000000000000000e-001 f2 from tversion union
select 2 f1, 0.000000000000000e+000 f2 from tversion union
select 3 f1, 5.000000000000000e-001 f2 from tversion union
select 4 f1, -5.000000000000000e-002 f2 from tversion union
select 5 f1, 5.000000000000000e+000 f2 from tversion union
select vdbl.rnum,vdbl.cdbl / 2 from vdbl
) Q
group by
f1,f2
) Q ) P;
-- ApproximateNumericOpDiv_p4
select 'ApproximateNumericOpDiv_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -5.000000000000000e-001 f2 from tversion union
select 2 f1, 0.000000000000000e+000 f2 from tversion union
select 3 f1, 5.000000000000000e-001 f2 from tversion union
select 4 f1, -5.000000000000000e-002 f2 from tversion union
select 5 f1, 5.000000000000000e+000 f2 from tversion union
select tdbl.rnum,tdbl.cdbl / 2 from tdbl
) Q
group by
f1,f2
) Q ) P;
-- CeilCoreApproximateNumeric_p4
select 'CeilCoreApproximateNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, ceil( tdbl.cdbl ) from tdbl
) Q
group by
f1,f2
) Q ) P;
-- CeilCoreApproximateNumeric_p3
select 'CeilCoreApproximateNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, ceil( vdbl.cdbl ) from vdbl
) Q
group by
f1,f2
) Q ) P;
-- AbsCoreApproximateNumeric_p3
select 'AbsCoreApproximateNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1.000000000000000e+000 f2 from tversion union
select 2 f1, 0.000000000000000e+000 f2 from tversion union
select 3 f1, 1.000000000000000e+000 f2 from tversion union
select 4 f1, 1.000000000000000e-001 f2 from tversion union
select 5 f1, 1.000000000000000e+001 f2 from tversion union
select rnum, abs( vdbl.cdbl ) from vdbl
) Q
group by
f1,f2
) Q ) P;
-- ApproximateNumericOpMul_p3
select 'ApproximateNumericOpMul_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -2.000000000000000e+000 f2 from tversion union
select 2 f1, 0.000000000000000e+000 f2 from tversion union
select 3 f1, 2.000000000000000e+000 f2 from tversion union
select 4 f1, -2.000000000000000e-001 f2 from tversion union
select 5 f1, 2.000000000000000e+001 f2 from tversion union
select vdbl.rnum,vdbl.cdbl * 2 from vdbl
) Q
group by
f1,f2
) Q ) P;
-- ApproximateNumericOpMul_p4
select 'ApproximateNumericOpMul_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -2.000000000000000e+000 f2 from tversion union
select 2 f1, 0.000000000000000e+000 f2 from tversion union
select 3 f1, 2.000000000000000e+000 f2 from tversion union
select 4 f1, -2.000000000000000e-001 f2 from tversion union
select 5 f1, 2.000000000000000e+001 f2 from tversion union
select tdbl.rnum,tdbl.cdbl * 2 from tdbl
) Q
group by
f1,f2
) Q ) P;
-- AbsCoreApproximateNumeric_p4
select 'AbsCoreApproximateNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1.000000000000000e+000 f2 from tversion union
select 2 f1, 0.000000000000000e+000 f2 from tversion union
select 3 f1, 1.000000000000000e+000 f2 from tversion union
select 4 f1, 1.000000000000000e-001 f2 from tversion union
select 5 f1, 1.000000000000000e+001 f2 from tversion union
select rnum, abs( tdbl.cdbl ) from tdbl
) Q
group by
f1,f2
) Q ) P;
-- DistinctAggregateInCase_p3
select 'DistinctAggregateInCase_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'test1' f1 from tversion union
select case when min(distinct(vdbl.cdbl))=-1 then 'test1' else 'else' end from vdbl
) Q
group by
f1
) Q ) P;
-- DistinctAggregateInCase_p4
select 'DistinctAggregateInCase_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'test1' f1 from tversion union
select case when min(distinct(tdbl.cdbl))=-1 then 'test1' else 'else' end from tdbl
) Q
group by
f1
) Q ) P;
-- ApproximateNumericOpSub_p3
select 'ApproximateNumericOpSub_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -3.000000000000000e+000 f2 from tversion union
select 2 f1, -2.000000000000000e+000 f2 from tversion union
select 3 f1, -1.000000000000000e+000 f2 from tversion union
select 4 f1, -2.100000000000000e+000 f2 from tversion union
select 5 f1, 8.000000000000000e+000 f2 from tversion union
select vdbl.rnum,vdbl.cdbl - 2 from vdbl
) Q
group by
f1,f2
) Q ) P;
-- ApproximateNumericOpSub_p4
select 'ApproximateNumericOpSub_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -3.000000000000000e+000 f2 from tversion union
select 2 f1, -2.000000000000000e+000 f2 from tversion union
select 3 f1, -1.000000000000000e+000 f2 from tversion union
select 4 f1, -2.100000000000000e+000 f2 from tversion union
select 5 f1, 8.000000000000000e+000 f2 from tversion union
select tdbl.rnum,tdbl.cdbl - 2 from tdbl
) Q
group by
f1,f2
) Q ) P;
-- ExpCoreApproximateNumeric_p3
select 'ExpCoreApproximateNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, .367879441 f2 from tversion union
select 2 f1, 1 f2 from tversion union
select 3 f1, 2.71828183 f2 from tversion union
select 4 f1, .904837418 f2 from tversion union
select 5 f1, 22026.4658 f2 from tversion union
select vdbl.rnum, exp( vdbl.cdbl ) from vdbl
) Q
group by
f1,f2
) Q ) P;
-- ExpCoreApproximateNumeric_p4
select 'ExpCoreApproximateNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, .367879441 f2 from tversion union
select 2 f1, 1 f2 from tversion union
select 3 f1, 2.71828183 f2 from tversion union
select 4 f1, .904837418 f2 from tversion union
select 5 f1, 22026.4658 f2 from tversion union
select tdbl.rnum, exp( tdbl.cdbl ) from tdbl
) Q
group by
f1,f2
) Q ) P;
-- FloorCoreApproximateNumeric_p3
select 'FloorCoreApproximateNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, -1 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, floor( vdbl.cdbl ) from vdbl
) Q
group by
f1,f2
) Q ) P;
-- FloorCoreApproximateNumeric_p4
select 'FloorCoreApproximateNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, -1 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, floor( tdbl.cdbl ) from tdbl
) Q
group by
f1,f2
) Q ) P;
-- AvgApproxNumeric_p3
select 'AvgApproxNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1.98 f1 from tversion union
select avg(vdbl.cdbl) from vdbl
) Q
group by
f1
) Q ) P;
-- AvgApproxNumeric_p4
select 'AvgApproxNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1.98 f1 from tversion union
select avg(tdbl.cdbl) from tdbl
) Q
group by
f1
) Q ) P;
-- PowerCoreApproxNumeric_p3
select 'PowerCoreApproxNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, .01 f2 from tversion union
select 5 f1, 100 f2 from tversion union
select vdbl.rnum, power( vdbl.cdbl,2 ) from vdbl
) Q
group by
f1,f2
) Q ) P;
-- PowerCoreApproxNumeric_p4
select 'PowerCoreApproxNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, .01 f2 from tversion union
select 5 f1, 100 f2 from tversion union
select tdbl.rnum, power( tdbl.cdbl,2 ) from tdbl
) Q
group by
f1,f2
) Q ) P;
-- SelectCountApproxNumeric_p3
select 'SelectCountApproxNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5 f1 from tversion union
select count(vdbl.cdbl) from vdbl
) Q
group by
f1
) Q ) P;
-- SelectCountApproxNumeric_p4
select 'SelectCountApproxNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5 f1 from tversion union
select count(tdbl.cdbl) from tdbl
) Q
group by
f1
) Q ) P;
-- SelectMaxApproxNumeric_p3
select 'SelectMaxApproxNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10 f1 from tversion union
select max( vdbl.cdbl ) from vdbl
) Q
group by
f1
) Q ) P;
-- CaseBasicSearchApproximateNumeric_p3
select 'CaseBasicSearchApproximateNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'test1' f2 from tversion union
select 2 f1, 'other' f2 from tversion union
select 3 f1, 'other' f2 from tversion union
select 4 f1, 'other' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select vdbl.rnum,case when vdbl.cdbl in ( -1,10,0.1 )  then 'test1' else 'other' end from vdbl
) Q
group by
f1,f2
) Q ) P;
-- SelectMaxApproxNumeric_p4
select 'SelectMaxApproxNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10 f1 from tversion union
select max( tdbl.cdbl ) from tdbl
) Q
group by
f1
) Q ) P;
-- CaseBasicSearchApproximateNumeric_p4
select 'CaseBasicSearchApproximateNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'test1' f2 from tversion union
select 2 f1, 'other' f2 from tversion union
select 3 f1, 'other' f2 from tversion union
select 4 f1, 'other' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select tdbl.rnum,case when tdbl.cdbl in ( -1,10,0.1 )  then 'test1' else 'other' end from tdbl
) Q
group by
f1,f2
) Q ) P;
-- SelectMinApproxNumeric_p3
select 'SelectMinApproxNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select -1 f1 from tversion union
select min( vdbl.cdbl ) from vdbl
) Q
group by
f1
) Q ) P;
-- SelectMinApproxNumeric_p4
select 'SelectMinApproxNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select -1 f1 from tversion union
select min( tdbl.cdbl ) from tdbl
) Q
group by
f1
) Q ) P;
-- SelectStanDevPopApproxNumeric_p3
select 'SelectStanDevPopApproxNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.05975 f1 from tversion union
select stddev_pop( vdbl.cdbl ) from vdbl
) Q
group by
f1
) Q ) P;
-- SelectStanDevPopApproxNumeric_p4
select 'SelectStanDevPopApproxNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.05975 f1 from tversion union
select stddev_pop( tdbl.cdbl ) from tdbl
) Q
group by
f1
) Q ) P;
-- SelectSumApproxNumeric_p3
select 'SelectSumApproxNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 9.9 f1 from tversion union
select sum( vdbl.cdbl ) from vdbl
) Q
group by
f1
) Q ) P;
-- SelectSumApproxNumeric_p4
select 'SelectSumApproxNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 9.9 f1 from tversion union
select sum( tdbl.cdbl ) from tdbl
) Q
group by
f1
) Q ) P;
-- SelectVarPopApproxNumeric_p3
select 'SelectVarPopApproxNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 16.4816 f1 from tversion union
select var_pop( vdbl.cdbl ) from vdbl
) Q
group by
f1
) Q ) P;
-- SelectVarPopApproxNumeric_p4
select 'SelectVarPopApproxNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 16.4816 f1 from tversion union
select var_pop( tdbl.cdbl ) from tdbl
) Q
group by
f1
) Q ) P;
-- SimpleCaseApproximateNumericElseDefaultsNULL_p3
select 'SimpleCaseApproximateNumericElseDefaultsNULL_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, 'test2' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select vdbl.rnum,case when vdbl.cdbl > 1 then 'test1' when vdbl.cdbl < 0 then 'test2' end from vdbl
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseApproximateNumericElseDefaultsNULL_p4
select 'SimpleCaseApproximateNumericElseDefaultsNULL_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, 'test2' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select tdbl.rnum,case when tdbl.cdbl > 1 then 'test1' when tdbl.cdbl < 0 then 'test2' end from tdbl
) Q
group by
f1,f2
) Q ) P;
-- CaseComparisonsApproximateNumeric_p3
select 'CaseComparisonsApproximateNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'lt' f2 from tversion union
select 2 f1, 'in' f2 from tversion union
select 3 f1, '=' f2 from tversion union
select 4 f1, 'between' f2 from tversion union
select 5 f1, 'gt' f2 from tversion union
select vdbl.rnum,case  when vdbl.cdbl =  1  then '=' when vdbl.cdbl >  9  then 'gt' when vdbl.cdbl < -0.2 then 'lt' when vdbl.cdbl in  (0,11)  then 'in' when vdbl.cdbl between -1 and 0  then 'between' else 'other' end from vdbl
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseApproximateNumericElseExplicitNULL_p3
select 'SimpleCaseApproximateNumericElseExplicitNULL_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, 'test2' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select vdbl.rnum,case when vdbl.cdbl > 1 then 'test1' when vdbl.cdbl < 0 then 'test2' else null end from vdbl
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseApproximateNumericElseExplicitNULL_p4
select 'SimpleCaseApproximateNumericElseExplicitNULL_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, 'test2' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select tdbl.rnum,case when tdbl.cdbl > 1 then 'test1' when tdbl.cdbl < 0 then 'test2' else null end from tdbl
) Q
group by
f1,f2
) Q ) P;
-- CaseComparisonsApproximateNumeric_p4
select 'CaseComparisonsApproximateNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'lt' f2 from tversion union
select 2 f1, 'in' f2 from tversion union
select 3 f1, '=' f2 from tversion union
select 4 f1, 'between' f2 from tversion union
select 5 f1, 'gt' f2 from tversion union
select tdbl.rnum,case  when tdbl.cdbl =  1  then '=' when tdbl.cdbl >  9  then 'gt' when tdbl.cdbl < -0.2 then 'lt' when tdbl.cdbl in  (0,11)  then 'in' when tdbl.cdbl between -1 and 0  then 'between' else 'other' end from tdbl
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseApproximateNumeric_p3
select 'SimpleCaseApproximateNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'test2' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select vdbl.rnum,case when vdbl.cdbl > 1 then 'test1' when vdbl.cdbl < 0 then 'test2' else 'else' end from vdbl
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseApproximateNumeric_p4
select 'SimpleCaseApproximateNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'test2' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select tdbl.rnum,case when tdbl.cdbl > 1 then 'test1' when tdbl.cdbl < 0 then 'test2' else 'else' end from tdbl
) Q
group by
f1,f2
) Q ) P;
-- StanDevApproxNumeric_p3
select 'StanDevApproxNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.53894 f1 from tversion union
select stddev( vdbl.cdbl ) from vdbl
) Q
group by
f1
) Q ) P;
-- StanDevApproxNumeric_p4
select 'StanDevApproxNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.53894 f1 from tversion union
select stddev( tdbl.cdbl ) from tdbl
) Q
group by
f1
) Q ) P;
-- StanDevSampApproxNumeric_p3
select 'StanDevSampApproxNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.53894 f1 from tversion union
select stddev_samp( vdbl.cdbl ) from vdbl
) Q
group by
f1
) Q ) P;
-- StanDevSampApproxNumeric_p4
select 'StanDevSampApproxNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.53894 f1 from tversion union
select stddev_samp( tdbl.cdbl ) from tdbl
) Q
group by
f1
) Q ) P;
