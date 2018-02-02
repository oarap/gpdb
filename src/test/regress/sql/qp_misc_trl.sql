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
-- Name: trl; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace:
--

CREATE TABLE trl (
    rnum integer NOT NULL,
    crl real
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
-- Name: vrl; Type: VIEW; Schema: public; Owner: gpadmin
--
CREATE VIEW vrl AS
    SELECT trl.rnum, trl.crl FROM trl;

--
-- Data for Name: trl; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY trl (rnum, crl) FROM stdin;
3	1
0	\N
1	-1
2	0
5	10
4	-0.1
\.


--
-- Data for Name: tversion; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tversion (rnum, c1, cver, cnnull, ccnull) FROM stdin;
0	1	1.0   	\N	\N
\.

-- VarApproxNumeric_p5
select 'VarApproxNumeric_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 20.602 f1 from tversion union
select variance( vrl.crl ) from vrl
) Q
group by
f1
) Q ) P;
-- VarApproxNumeric_p6
select 'VarApproxNumeric_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 20.602 f1 from tversion union
select variance( trl.crl ) from trl
) Q
group by
f1
) Q ) P;
-- CaseNestedApproximateNumeric_p5
select 'CaseNestedApproximateNumeric_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'nested else' f2 from tversion union
select 3 f1, 'nested else' f2 from tversion union
select 4 f1, 'nested else' f2 from tversion union
select 5 f1, 'nested inner' f2 from tversion union
select vrl.rnum,case  when vrl.crl > -1  then case  when vrl.crl > 1 then  'nested inner' else 'nested else' end else 'else'  end from vrl
) Q
group by
f1,f2
) Q ) P;
-- VarSampApproxNumeric_p5
select 'VarSampApproxNumeric_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 20.602 f1 from tversion union
select var_samp( vrl.crl ) from vrl
) Q
group by
f1
) Q ) P;
-- VarSampApproxNumeric_p6
select 'VarSampApproxNumeric_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 20.602 f1 from tversion union
select var_samp( trl.crl ) from trl
) Q
group by
f1
) Q ) P;
-- CaseNestedApproximateNumeric_p6
select 'CaseNestedApproximateNumeric_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'nested else' f2 from tversion union
select 3 f1, 'nested else' f2 from tversion union
select 4 f1, 'nested else' f2 from tversion union
select 5 f1, 'nested inner' f2 from tversion union
select trl.rnum,case  when trl.crl > -1  then case  when trl.crl > 1 then  'nested inner' else 'nested else' end else 'else'  end from trl
) Q
group by
f1,f2
) Q ) P;
-- CaseSubqueryApproxmiateNumeric_p5
select 'CaseSubqueryApproxmiateNumeric_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'else' f2 from tversion union
select 5 f1, 'true' f2 from tversion union
select vrl.rnum,case  when vrl.crl= (select max( vrl.crl) from vrl)    then 'true' else 'else' 	end from vrl
) Q
group by
f1,f2
) Q ) P;
-- CaseSubqueryApproxmiateNumeric_p6
select 'CaseSubqueryApproxmiateNumeric_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'else' f2 from tversion union
select 5 f1, 'true' f2 from tversion union
select trl.rnum,case  when trl.crl= (select max( trl.crl) from trl)    then 'true' else 'else' 	end from trl
) Q
group by
f1,f2
) Q ) P;
-- ApproximateNumericOpAdd_p5
select 'ApproximateNumericOpAdd_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1.000000000000000e+000 f2 from tversion union
select 2 f1, 2.000000000000000e+000 f2 from tversion union
select 3 f1, 3.000000000000000e+000 f2 from tversion union
select 4 f1, 1.900000000000000e+000 f2 from tversion union
select 5 f1, 1.200000000000000e+001 f2 from tversion union
select vrl.rnum,vrl.crl + 2 from vrl
) Q
group by
f1,f2
) Q ) P;
-- ApproximateNumericOpAdd_p6
select 'ApproximateNumericOpAdd_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1.000000000000000e+000 f2 from tversion union
select 2 f1, 2.000000000000000e+000 f2 from tversion union
select 3 f1, 3.000000000000000e+000 f2 from tversion union
select 4 f1, 1.900000000000000e+000 f2 from tversion union
select 5 f1, 1.200000000000000e+001 f2 from tversion union
select trl.rnum,trl.crl + 2 from trl
) Q
group by
f1,f2
) Q ) P;
-- CastRealToBigint_p1
select 'CastRealToBigint_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, cast(vrl.crl as bigint) from vrl
) Q
group by
f1,f2
) Q ) P;
-- CastRealToBigint_p2
select 'CastRealToBigint_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, cast(trl.crl as bigint) from trl
) Q
group by
f1,f2
) Q ) P;
-- CastRealToChar_p1
select 'CastRealToChar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1        ' f2 from tversion union
select 2 f1, '0         ' f2 from tversion union
select 3 f1, '1         ' f2 from tversion union
select 4 f1, '-0.1      ' f2 from tversion union
select 5 f1, '10        ' f2 from tversion union
select rnum, cast(vrl.crl as char(10)) from vrl
) Q
group by
f1,f2
) Q ) P;
-- CastRealToChar_p2
select 'CastRealToChar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1        ' f2 from tversion union
select 2 f1, '0         ' f2 from tversion union
select 3 f1, '1         ' f2 from tversion union
select 4 f1, '-0.1      ' f2 from tversion union
select 5 f1, '10        ' f2 from tversion union
select rnum, cast(trl.crl as char(10)) from trl
) Q
group by
f1,f2
) Q ) P;
-- CastRealToDouble_p1
select 'CastRealToDouble_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1.0 f2 from tversion union
select 2 f1, 0.0 f2 from tversion union
select 3 f1, 1.0 f2 from tversion union
select 4 f1, -0.1 f2 from tversion union
select 5 f1, 10.0 f2 from tversion union
select rnum, cast(vrl.crl as double precision) from vrl
) Q
group by
f1,f2
) Q ) P;
-- CastRealToDouble_p2
select 'CastRealToDouble_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1.0 f2 from tversion union
select 2 f1, 0.0 f2 from tversion union
select 3 f1, 1.0 f2 from tversion union
select 4 f1, -0.1 f2 from tversion union
select 5 f1, 10.0 f2 from tversion union
select rnum, cast(trl.crl as double precision) from trl
) Q
group by
f1,f2
) Q ) P;
-- CastRealToSmallint_p1
select 'CastRealToSmallint_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, cast(vrl.crl as smallint) from vrl
) Q
group by
f1,f2
) Q ) P;
-- CastRealToSmallint_p2
select 'CastRealToSmallint_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, cast(trl.crl as smallint) from trl
) Q
group by
f1,f2
) Q ) P;
-- CastRealToVarchar_p1
select 'CastRealToVarchar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1' f2 from tversion union
select 2 f1, '0' f2 from tversion union
select 3 f1, '1' f2 from tversion union
select 4 f1, '-0.1' f2 from tversion union
select 5 f1, '10' f2 from tversion union
select rnum, cast(vrl.crl as varchar(10)) from vrl
) Q
group by
f1,f2
) Q ) P;
-- CastRealToVarchar_p2
select 'CastRealToVarchar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1' f2 from tversion union
select 2 f1, '0' f2 from tversion union
select 3 f1, '1' f2 from tversion union
select 4 f1, '-0.1' f2 from tversion union
select 5 f1, '10' f2 from tversion union
select rnum, cast(trl.crl as varchar(10)) from trl
) Q
group by
f1,f2
) Q ) P;
-- ApproximateNumericOpDiv_p5
select 'ApproximateNumericOpDiv_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -5.000000000000000e-001 f2 from tversion union
select 2 f1, 0.000000000000000e+000 f2 from tversion union
select 3 f1, 5.000000000000000e-001 f2 from tversion union
select 4 f1, -5.000000000000000e-002 f2 from tversion union
select 5 f1, 5.000000000000000e+000 f2 from tversion union
select vrl.rnum,vrl.crl / 2 from vrl
) Q
group by
f1,f2
) Q ) P;
-- ApproximateNumericOpDiv_p6
select 'ApproximateNumericOpDiv_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -5.000000000000000e-001 f2 from tversion union
select 2 f1, 0.000000000000000e+000 f2 from tversion union
select 3 f1, 5.000000000000000e-001 f2 from tversion union
select 4 f1, -5.000000000000000e-002 f2 from tversion union
select 5 f1, 5.000000000000000e+000 f2 from tversion union
select trl.rnum,trl.crl / 2 from trl
) Q
group by
f1,f2
) Q ) P;
-- CeilCoreApproximateNumeric_p5
select 'CeilCoreApproximateNumeric_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, ceil( vrl.crl ) from vrl
) Q
group by
f1,f2
) Q ) P;
-- CeilCoreApproximateNumeric_p6
select 'CeilCoreApproximateNumeric_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, ceil( trl.crl ) from trl
) Q
group by
f1,f2
) Q ) P;
-- ApproximateNumericOpMul_p5
select 'ApproximateNumericOpMul_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -2.000000000000000e+000 f2 from tversion union
select 2 f1, 0.000000000000000e+000 f2 from tversion union
select 3 f1, 2.000000000000000e+000 f2 from tversion union
select 4 f1, -2.000000000000000e-001 f2 from tversion union
select 5 f1, 2.000000000000000e+001 f2 from tversion union
select vrl.rnum,vrl.crl * 2 from vrl
) Q
group by
f1,f2
) Q ) P;
-- ApproximateNumericOpMul_p6
select 'ApproximateNumericOpMul_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -2.000000000000000e+000 f2 from tversion union
select 2 f1, 0.000000000000000e+000 f2 from tversion union
select 3 f1, 2.000000000000000e+000 f2 from tversion union
select 4 f1, -2.000000000000000e-001 f2 from tversion union
select 5 f1, 2.000000000000000e+001 f2 from tversion union
select trl.rnum,trl.crl * 2 from trl
) Q
group by
f1,f2
) Q ) P;
-- DistinctAggregateInCase_p5
select 'DistinctAggregateInCase_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'test1' f1 from tversion union
select case when min(distinct(vrl.crl))=-1 then 'test1' else 'else' end from vrl
) Q
group by
f1
) Q ) P;
-- DistinctAggregateInCase_p6
select 'DistinctAggregateInCase_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'test1' f1 from tversion union
select case when min(distinct(trl.crl))=-1 then 'test1' else 'else' end from trl
) Q
group by
f1
) Q ) P;
-- ExpCoreApproximateNumeric_p5
select 'ExpCoreApproximateNumeric_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, .367879441 f2 from tversion union
select 2 f1, 1 f2 from tversion union
select 3 f1, 2.71828183 f2 from tversion union
select 4 f1, .904837418 f2 from tversion union
select 5 f1, 22026.4658 f2 from tversion union
select vrl.rnum, exp( vrl.crl ) from vrl
) Q
group by
f1,f2
) Q ) P;
-- ExpCoreApproximateNumeric_p6
select 'ExpCoreApproximateNumeric_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, .367879441 f2 from tversion union
select 2 f1, 1 f2 from tversion union
select 3 f1, 2.71828183 f2 from tversion union
select 4 f1, .904837418 f2 from tversion union
select 5 f1, 22026.4658 f2 from tversion union
select trl.rnum, exp( trl.crl ) from trl
) Q
group by
f1,f2
) Q ) P;
-- ApproximateNumericOpSub_p5
select 'ApproximateNumericOpSub_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -3.000000000000000e+000 f2 from tversion union
select 2 f1, -2.000000000000000e+000 f2 from tversion union
select 3 f1, -1.000000000000000e+000 f2 from tversion union
select 4 f1, -2.100000000000000e+000 f2 from tversion union
select 5 f1, 8.000000000000000e+000 f2 from tversion union
select vrl.rnum,vrl.crl - 2 from vrl
) Q
group by
f1,f2
) Q ) P;
-- ApproximateNumericOpSub_p6
select 'ApproximateNumericOpSub_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -3.000000000000000e+000 f2 from tversion union
select 2 f1, -2.000000000000000e+000 f2 from tversion union
select 3 f1, -1.000000000000000e+000 f2 from tversion union
select 4 f1, -2.100000000000000e+000 f2 from tversion union
select 5 f1, 8.000000000000000e+000 f2 from tversion union
select trl.rnum,trl.crl - 2 from trl
) Q
group by
f1,f2
) Q ) P;
-- FloorCoreApproximateNumeric_p5
select 'FloorCoreApproximateNumeric_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, -1 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, floor( vrl.crl ) from vrl
) Q
group by
f1,f2
) Q ) P;
-- FloorCoreApproximateNumeric_p6
select 'FloorCoreApproximateNumeric_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, -1 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, floor( trl.crl ) from trl
) Q
group by
f1,f2
) Q ) P;
-- AbsCoreApproximateNumeric_p5
select 'AbsCoreApproximateNumeric_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1.000000000000000e+000 f2 from tversion union
select 2 f1, 0.000000000000000e+000 f2 from tversion union
select 3 f1, 1.000000000000000e+000 f2 from tversion union
select 4 f1, 1.000000000000000e-001 f2 from tversion union
select 5 f1, 1.000000000000000e+001 f2 from tversion union
select rnum, abs( vrl.crl ) from vrl
) Q
group by
f1,f2
) Q ) P;
-- AvgApproxNumeric_p5
select 'AvgApproxNumeric_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1.98 f1 from tversion union
select avg(vrl.crl) from vrl
) Q
group by
f1
) Q ) P;
-- AvgApproxNumeric_p6
select 'AvgApproxNumeric_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1.98 f1 from tversion union
select avg(trl.crl) from trl
) Q
group by
f1
) Q ) P;
-- AbsCoreApproximateNumeric_p6
select 'AbsCoreApproximateNumeric_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1.000000000000000e+000 f2 from tversion union
select 2 f1, 0.000000000000000e+000 f2 from tversion union
select 3 f1, 1.000000000000000e+000 f2 from tversion union
select 4 f1, 1.000000000000000e-001 f2 from tversion union
select 5 f1, 1.000000000000000e+001 f2 from tversion union
select rnum, abs( trl.crl ) from trl
) Q
group by
f1,f2
) Q ) P;
-- PowerCoreApproxNumeric_p5
select 'PowerCoreApproxNumeric_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, .01 f2 from tversion union
select 5 f1, 100 f2 from tversion union
select vrl.rnum, power( vrl.crl,2 ) from vrl
) Q
group by
f1,f2
) Q ) P;
-- PowerCoreApproxNumeric_p6
select 'PowerCoreApproxNumeric_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, .01 f2 from tversion union
select 5 f1, 100 f2 from tversion union
select trl.rnum, power( trl.crl,2 ) from trl
) Q
group by
f1,f2
) Q ) P;
-- SelectCountApproxNumeric_p5
select 'SelectCountApproxNumeric_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5 f1 from tversion union
select count(vrl.crl) from vrl
) Q
group by
f1
) Q ) P;
-- SelectCountApproxNumeric_p6
select 'SelectCountApproxNumeric_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5 f1 from tversion union
select count(trl.crl) from trl
) Q
group by
f1
) Q ) P;
-- SelectMaxApproxNumeric_p5
select 'SelectMaxApproxNumeric_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10 f1 from tversion union
select max( vrl.crl ) from vrl
) Q
group by
f1
) Q ) P;
-- SelectMaxApproxNumeric_p6
select 'SelectMaxApproxNumeric_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10 f1 from tversion union
select max( trl.crl ) from trl
) Q
group by
f1
) Q ) P;
-- CaseBasicSearchApproximateNumeric_p5
select 'CaseBasicSearchApproximateNumeric_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'test1' f2 from tversion union
select 2 f1, 'other' f2 from tversion union
select 3 f1, 'other' f2 from tversion union
select 4 f1, 'other' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select vrl.rnum,case when vrl.crl in ( -1,10,0.1 )  then 'test1' else 'other' end from vrl
) Q
group by
f1,f2
) Q ) P;
-- SelectMinApproxNumeric_p5
select 'SelectMinApproxNumeric_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select -1 f1 from tversion union
select min( vrl.crl ) from vrl
) Q
group by
f1
) Q ) P;
-- SelectMinApproxNumeric_p6
select 'SelectMinApproxNumeric_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select -1 f1 from tversion union
select min( trl.crl ) from trl
) Q
group by
f1
) Q ) P;
-- CaseBasicSearchApproximateNumeric_p6
select 'CaseBasicSearchApproximateNumeric_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'test1' f2 from tversion union
select 2 f1, 'other' f2 from tversion union
select 3 f1, 'other' f2 from tversion union
select 4 f1, 'other' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select trl.rnum,case when trl.crl in ( -1,10,0.1 )  then 'test1' else 'other' end from trl
) Q
group by
f1,f2
) Q ) P;
-- SelectStanDevPopApproxNumeric_p5
select 'SelectStanDevPopApproxNumeric_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.05975 f1 from tversion union
select stddev_pop( vrl.crl ) from vrl
) Q
group by
f1
) Q ) P;
-- SelectStanDevPopApproxNumeric_p6
select 'SelectStanDevPopApproxNumeric_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.05975 f1 from tversion union
select stddev_pop( trl.crl ) from trl
) Q
group by
f1
) Q ) P;
-- SelectSumApproxNumeric_p5
select 'SelectSumApproxNumeric_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 9.9 f1 from tversion union
select sum( vrl.crl ) from vrl
) Q
group by
f1
) Q ) P;
-- SelectSumApproxNumeric_p6
select 'SelectSumApproxNumeric_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 9.9 f1 from tversion union
select sum( trl.crl ) from trl
) Q
group by
f1
) Q ) P;
-- SelectVarPopApproxNumeric_p5
select 'SelectVarPopApproxNumeric_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 16.4816 f1 from tversion union
select var_pop( vrl.crl ) from vrl
) Q
group by
f1
) Q ) P;
-- SelectVarPopApproxNumeric_p6
select 'SelectVarPopApproxNumeric_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 16.4816 f1 from tversion union
select var_pop( trl.crl ) from trl
) Q
group by
f1
) Q ) P;
-- SimpleCaseApproximateNumericElseDefaultsNULL_p5
select 'SimpleCaseApproximateNumericElseDefaultsNULL_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, 'test2' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select vrl.rnum,case when vrl.crl > 1 then 'test1' when vrl.crl < 0 then 'test2' end from vrl
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseApproximateNumericElseDefaultsNULL_p6
select 'SimpleCaseApproximateNumericElseDefaultsNULL_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, 'test2' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select trl.rnum,case when trl.crl > 1 then 'test1' when trl.crl < 0 then 'test2' end from trl
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseApproximateNumericElseExplicitNULL_p5
select 'SimpleCaseApproximateNumericElseExplicitNULL_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, 'test2' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select vrl.rnum,case when vrl.crl > 1 then 'test1' when vrl.crl < 0 then 'test2' else null end from vrl
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseApproximateNumericElseExplicitNULL_p6
select 'SimpleCaseApproximateNumericElseExplicitNULL_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, 'test2' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select trl.rnum,case when trl.crl > 1 then 'test1' when trl.crl < 0 then 'test2' else null end from trl
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseApproximateNumeric_p5
select 'SimpleCaseApproximateNumeric_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'test2' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select vrl.rnum,case when vrl.crl > 1 then 'test1' when vrl.crl < 0 then 'test2' else 'else' end from vrl
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseApproximateNumeric_p6
select 'SimpleCaseApproximateNumeric_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'test2' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select trl.rnum,case when trl.crl > 1 then 'test1' when trl.crl < 0 then 'test2' else 'else' end from trl
) Q
group by
f1,f2
) Q ) P;
-- CaseComparisonsApproximateNumeric_p5
select 'CaseComparisonsApproximateNumeric_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'lt' f2 from tversion union
select 2 f1, 'in' f2 from tversion union
select 3 f1, '=' f2 from tversion union
select 4 f1, 'between' f2 from tversion union
select 5 f1, 'gt' f2 from tversion union
select vrl.rnum,case  when vrl.crl =  1  then '=' when vrl.crl >  9  then 'gt' when vrl.crl < -0.2 then 'lt' when vrl.crl in  (0,11)  then 'in' when vrl.crl between -1 and 0  then 'between' else 'other' end from vrl
) Q
group by
f1,f2
) Q ) P;
-- CaseComparisonsApproximateNumeric_p6
select 'CaseComparisonsApproximateNumeric_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'lt' f2 from tversion union
select 2 f1, 'in' f2 from tversion union
select 3 f1, '=' f2 from tversion union
select 4 f1, 'between' f2 from tversion union
select 5 f1, 'gt' f2 from tversion union
select trl.rnum,case  when trl.crl =  1  then '=' when trl.crl >  9  then 'gt' when trl.crl < -0.2 then 'lt' when trl.crl in  (0,11)  then 'in' when trl.crl between -1 and 0  then 'between' else 'other' end from trl
) Q
group by
f1,f2
) Q ) P;
-- StanDevApproxNumeric_p5
select 'StanDevApproxNumeric_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.53894 f1 from tversion union
select stddev( vrl.crl ) from vrl
) Q
group by
f1
) Q ) P;
-- StanDevApproxNumeric_p6
select 'StanDevApproxNumeric_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.53894 f1 from tversion union
select stddev( trl.crl ) from trl
) Q
group by
f1
) Q ) P;
-- StanDevSampApproxNumeric_p5
select 'StanDevSampApproxNumeric_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.53894 f1 from tversion union
select stddev_samp( vrl.crl ) from vrl
) Q
group by
f1
) Q ) P;
-- StanDevSampApproxNumeric_p6
select 'StanDevSampApproxNumeric_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.53894 f1 from tversion union
select stddev_samp( trl.crl ) from trl
) Q
group by
f1
) Q ) P;
