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
-- Name: tnum; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace:
--

CREATE TABLE tnum (
    rnum integer NOT NULL,
    cnum numeric(7,2)
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
-- Name: vnum; Type: VIEW; Schema: public; Owner: gpadmin
--
CREATE VIEW vnum AS
    SELECT tnum.rnum, tnum.cnum FROM tnum;

--
-- Data for Name: tnum; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tnum (rnum, cnum) FROM stdin;
3	1.00
0	\N
1	-1.00
2	0.00
5	10.00
4	0.10
\.

--
-- Data for Name: tversion; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tversion (rnum, c1, cver, cnnull, ccnull) FROM stdin;
0	1	1.0   	\N	\N
\.


-- AbsCoreExactNumeric_p4
select 'AbsCoreExactNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1.000000000000000e+000 f2 from tversion union
select 2 f1, 0.000000000000000e+000 f2 from tversion union
select 3 f1, 1.000000000000000e+000 f2 from tversion union
select 4 f1, 1.000000000000000e-001 f2 from tversion union
select 5 f1, 1.000000000000000e+001 f2 from tversion union
select rnum, abs( tnum.cnum ) from tnum
) Q
group by
f1,f2
) Q ) P;
-- VarExactNumeric_p3
select 'VarExactNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 20.402 f1 from tversion union
select variance( vnum.cnum ) from vnum
) Q
group by
f1
) Q ) P;
-- VarExactNumeric_p4
select 'VarExactNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 20.402 f1 from tversion union
select variance( tnum.cnum ) from tnum
) Q
group by
f1
) Q ) P;

-- VarSampExactNumeric_p3
select 'VarSampExactNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 20.402 f1 from tversion union
select var_samp( vnum.cnum ) from vnum
) Q
group by
f1
) Q ) P;
-- VarSampExactNumeric_p4
select 'VarSampExactNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 20.402 f1 from tversion union
select var_samp( tnum.cnum ) from tnum
) Q
group by
f1
) Q ) P;
-- CaseNestedExactNumeric_p3
select 'CaseNestedExactNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'nested else' f2 from tversion union
select 3 f1, 'nested else' f2 from tversion union
select 4 f1, 'nested else' f2 from tversion union
select 5 f1, 'nested inner' f2 from tversion union
select vnum.rnum,case  when vnum.cnum > -1  then case  when vnum.cnum > 1 then  'nested inner' else 'nested else' end else 'else'  end from vnum
) Q
group by
f1,f2
) Q ) P;
-- CaseNestedExactNumeric_p4
select 'CaseNestedExactNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'nested else' f2 from tversion union
select 3 f1, 'nested else' f2 from tversion union
select 4 f1, 'nested else' f2 from tversion union
select 5 f1, 'nested inner' f2 from tversion union
select tnum.rnum,case  when tnum.cnum > -1  then case  when tnum.cnum > 1 then  'nested inner' else 'nested else' end else 'else'  end from tnum
) Q
group by
f1,f2
) Q ) P;
-- CaseSubQueryExactNumeric_p3
select 'CaseSubQueryExactNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'else' f2 from tversion union
select 5 f1, 'true' f2 from tversion union
select vnum.rnum,case  when vnum.cnum= (select max( vnum.cnum) from vnum)    then 'true' else 'else' 	end from vnum
) Q
group by
f1,f2
) Q ) P;
-- CaseSubQueryExactNumeric_p4
select 'CaseSubQueryExactNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'else' f2 from tversion union
select 5 f1, 'true' f2 from tversion union
select tnum.rnum,case  when tnum.cnum= (select max( tnum.cnum) from tnum)    then 'true' else 'else' 	end from tnum
) Q
group by
f1,f2
) Q ) P;
-- CastNumericToBigint_p2
select 'CastNumericToBigint_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, cast(tnum.cnum as bigint) from tnum
) Q
group by
f1,f2
) Q ) P;
-- CastNumericToChar_p1
select 'CastNumericToChar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1.00' f2 from tversion union
select 2 f1, '0.00 ' f2 from tversion union
select 3 f1, '1.00 ' f2 from tversion union
select 4 f1, '0.10 ' f2 from tversion union
select 5 f1, '10.00' f2 from tversion union
select rnum, cast(vnum.cnum as char(5)) from vnum
) Q
group by
f1,f2
) Q ) P;
-- CastNumericToChar_p2
select 'CastNumericToChar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1.00' f2 from tversion union
select 2 f1, '0.00 ' f2 from tversion union
select 3 f1, '1.00 ' f2 from tversion union
select 4 f1, '0.10 ' f2 from tversion union
select 5 f1, '10.00' f2 from tversion union
select rnum, cast(tnum.cnum as char(5)) from tnum
) Q
group by
f1,f2
) Q ) P;
-- CastNumericToBigint_p1
select 'CastNumericToBigint_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, cast(vnum.cnum as bigint) from vnum
) Q
group by
f1,f2
) Q ) P;
-- CastNumericToDouble_p1
select 'CastNumericToDouble_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1.0 f2 from tversion union
select 2 f1, 0.0 f2 from tversion union
select 3 f1, 1.0 f2 from tversion union
select 4 f1, 0.1 f2 from tversion union
select 5 f1, 10.0 f2 from tversion union
select rnum, cast(vnum.cnum as double precision) from vnum
) Q
group by
f1,f2
) Q ) P;
-- CastNumericToDouble_p2
select 'CastNumericToDouble_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1.0 f2 from tversion union
select 2 f1, 0.0 f2 from tversion union
select 3 f1, 1.0 f2 from tversion union
select 4 f1, 0.1 f2 from tversion union
select 5 f1, 10.0 f2 from tversion union
select rnum, cast(tnum.cnum as double precision) from tnum
) Q
group by
f1,f2
) Q ) P;
-- CastNumericToFloat_p1
select 'CastNumericToFloat_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1.0 f2 from tversion union
select 2 f1, 0.0 f2 from tversion union
select 3 f1, 1.0 f2 from tversion union
select 4 f1, 0.1 f2 from tversion union
select 5 f1, 10.0 f2 from tversion union
select rnum, cast(vnum.cnum as float) from vnum
) Q
group by
f1,f2
) Q ) P;
-- CastNumericToFloat_p2
select 'CastNumericToFloat_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1.0 f2 from tversion union
select 2 f1, 0.0 f2 from tversion union
select 3 f1, 1.0 f2 from tversion union
select 4 f1, 0.1 f2 from tversion union
select 5 f1, 10.0 f2 from tversion union
select rnum, cast(tnum.cnum as float) from tnum
) Q
group by
f1,f2
) Q ) P;
-- CastNumericToInteger_p1
select 'CastNumericToInteger_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, cast(vnum.cnum as integer) from vnum
) Q
group by
f1,f2
) Q ) P;
-- CastNumericToInteger_p2
select 'CastNumericToInteger_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, cast(tnum.cnum as integer) from tnum
) Q
group by
f1,f2
) Q ) P;
-- CastNumericToSmallint_p1
select 'CastNumericToSmallint_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, cast(vnum.cnum as smallint) from vnum
) Q
group by
f1,f2
) Q ) P;
-- CastNumericToSmallint_p2
select 'CastNumericToSmallint_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, cast(tnum.cnum as smallint) from tnum
) Q
group by
f1,f2
) Q ) P;
-- CastNumericToVarchar_p1
select 'CastNumericToVarchar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1.00' f2 from tversion union
select 2 f1, '0.00' f2 from tversion union
select 3 f1, '1.00' f2 from tversion union
select 4 f1, '0.10' f2 from tversion union
select 5 f1, '10.00' f2 from tversion union
select rnum, cast(vnum.cnum as varchar(5)) from vnum
) Q
group by
f1,f2
) Q ) P;
-- CastNumericToVarchar_p2
select 'CastNumericToVarchar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1.00' f2 from tversion union
select 2 f1, '0.00' f2 from tversion union
select 3 f1, '1.00' f2 from tversion union
select 4 f1, '0.10' f2 from tversion union
select 5 f1, '10.00' f2 from tversion union
select rnum, cast(tnum.cnum as varchar(5)) from tnum
) Q
group by
f1,f2
) Q ) P;
-- CeilCoreExactNumeric_p3
select 'CeilCoreExactNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 1 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, ceil( vnum.cnum ) from vnum
) Q
group by
f1,f2
) Q ) P;
-- CeilCoreExactNumeric_p4
select 'CeilCoreExactNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 1 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, ceil( tnum.cnum ) from tnum
) Q
group by
f1,f2
) Q ) P;
-- DistinctAggregateInCase_p10
select 'DistinctAggregateInCase_p10' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'test1' f1 from tversion union
select case when min(distinct(tnum.cnum))=-1 then 'test1' else 'else' end from tnum
) Q
group by
f1
) Q ) P;
-- DistinctAggregateInCase_p9
select 'DistinctAggregateInCase_p9' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'test1' f1 from tversion union
select case when min(distinct(vnum.cnum))=-1 then 'test1' else 'else' end from vnum
) Q
group by
f1
) Q ) P;
-- ExactNumericOpAdd_p3
select 'ExactNumericOpAdd_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1,  000001.00 f2 from tversion union
select 2 f1,  000002.00 f2 from tversion union
select 3 f1,  000003.00 f2 from tversion union
select 4 f1,  000002.10 f2 from tversion union
select 5 f1,  000012.00 f2 from tversion union
select vnum.rnum,vnum.cnum + 2 from vnum
) Q
group by
f1,f2
) Q ) P;
-- ExactNumericOpAdd_p4
select 'ExactNumericOpAdd_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1,  000001.00 f2 from tversion union
select 2 f1,  000002.00 f2 from tversion union
select 3 f1,  000003.00 f2 from tversion union
select 4 f1,  000002.10 f2 from tversion union
select 5 f1,  000012.00 f2 from tversion union
select tnum.rnum,tnum.cnum + 2 from tnum
) Q
group by
f1,f2
) Q ) P;
-- ExactNumericOpDiv_p3
select 'ExactNumericOpDiv_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -00000.500000 f2 from tversion union
select 2 f1,  00000.000000 f2 from tversion union
select 3 f1,  00000.500000 f2 from tversion union
select 4 f1,  00000.050000 f2 from tversion union
select 5 f1,  00005.000000 f2 from tversion union
select vnum.rnum,vnum.cnum / 2 from vnum
) Q
group by
f1,f2
) Q ) P;
-- ExactNumericOpDiv_p4
select 'ExactNumericOpDiv_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -00000.500000 f2 from tversion union
select 2 f1,  00000.000000 f2 from tversion union
select 3 f1,  00000.500000 f2 from tversion union
select 4 f1,  00000.050000 f2 from tversion union
select 5 f1,  00005.000000 f2 from tversion union
select tnum.rnum,tnum.cnum / 2 from tnum
) Q
group by
f1,f2
) Q ) P;
-- ExactNumericOpMul_p3
select 'ExactNumericOpMul_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -0000002.00 f2 from tversion union
select 2 f1,  0000000.00 f2 from tversion union
select 3 f1,  0000002.00 f2 from tversion union
select 4 f1,  0000000.20 f2 from tversion union
select 5 f1,  0000020.00 f2 from tversion union
select vnum.rnum,vnum.cnum * 2 from vnum
) Q
group by
f1,f2
) Q ) P;
-- ExactNumericOpMul_p4
select 'ExactNumericOpMul_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -0000002.00 f2 from tversion union
select 2 f1,  0000000.00 f2 from tversion union
select 3 f1,  0000002.00 f2 from tversion union
select 4 f1,  0000000.20 f2 from tversion union
select 5 f1,  0000020.00 f2 from tversion union
select tnum.rnum,tnum.cnum * 2 from tnum
) Q
group by
f1,f2
) Q ) P;
-- ExactNumericOpSub_p3
select 'ExactNumericOpSub_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -000003.00 f2 from tversion union
select 2 f1, -000002.00 f2 from tversion union
select 3 f1, -000001.00 f2 from tversion union
select 4 f1, -000001.90 f2 from tversion union
select 5 f1,  000008.00 f2 from tversion union
select vnum.rnum,vnum.cnum - 2 from vnum
) Q
group by
f1,f2
) Q ) P;
-- ExactNumericOpSub_p4
select 'ExactNumericOpSub_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -000003.00 f2 from tversion union
select 2 f1, -000002.00 f2 from tversion union
select 3 f1, -000001.00 f2 from tversion union
select 4 f1, -000001.90 f2 from tversion union
select 5 f1,  000008.00 f2 from tversion union
select tnum.rnum,tnum.cnum - 2 from tnum
) Q
group by
f1,f2
) Q ) P;
-- ExpCoreExactNumeric_p3
select 'ExpCoreExactNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, .367879441 f2 from tversion union
select 2 f1, 1 f2 from tversion union
select 3 f1, 2.71828183 f2 from tversion union
select 4 f1, 1.10517092 f2 from tversion union
select 5 f1, 22026.4658 f2 from tversion union
select rnum, exp( vnum.cnum ) from vnum
) Q
group by
f1,f2
) Q ) P;
-- ExpCoreExactNumeric_p4
select 'ExpCoreExactNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, .367879441 f2 from tversion union
select 2 f1, 1 f2 from tversion union
select 3 f1, 2.71828183 f2 from tversion union
select 4 f1, 1.10517092 f2 from tversion union
select 5 f1, 22026.4658 f2 from tversion union
select rnum, exp( tnum.cnum ) from tnum
) Q
group by
f1,f2
) Q ) P;
-- FloorCoreExactNumeric_p3
select 'FloorCoreExactNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, floor( vnum.cnum ) from vnum
) Q
group by
f1,f2
) Q ) P;
-- FloorCoreExactNumeric_p4
select 'FloorCoreExactNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, floor( tnum.cnum ) from tnum
) Q
group by
f1,f2
) Q ) P;
-- AvgExactNumeric_p3
select 'AvgExactNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 2.02 f1 from tversion union
select avg(vnum.cnum) from vnum
) Q
group by
f1
) Q ) P;
-- AvgExactNumeric_p4
select 'AvgExactNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 2.02 f1 from tversion union
select avg(tnum.cnum) from tnum
) Q
group by
f1
) Q ) P;
-- ModCore2ExactNumeric_p3
select 'ModCore2ExactNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 3 f1, 0 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 3 f2 from tversion union
select vnum.rnum, mod( 3,vnum.cnum ) from vnum where vnum.rnum <> 2
) Q
group by
f1,f2
) Q ) P;
-- ModCore2ExactNumeric_p4
select 'ModCore2ExactNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 3 f1, 0 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 3 f2 from tversion union
select tnum.rnum, mod( 3,tnum.cnum ) from tnum where tnum.rnum <> 2
) Q
group by
f1,f2
) Q ) P;
-- ModCoreExactNumeric_p3
select 'ModCoreExactNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, .1 f2 from tversion union
select 5 f1, 1 f2 from tversion union
select rnum, mod( vnum.cnum, 3 ) from vnum
) Q
group by
f1,f2
) Q ) P;
-- ModCoreExactNumeric_p4
select 'ModCoreExactNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, .1 f2 from tversion union
select 5 f1, 1 f2 from tversion union
select rnum, mod( tnum.cnum, 3 ) from tnum
) Q
group by
f1,f2
) Q ) P;
-- PowerCoreExactNumeric_p3
select 'PowerCoreExactNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, .01 f2 from tversion union
select 5 f1, 100 f2 from tversion union
select vnum.rnum, power( vnum.cnum,2 ) from vnum
) Q
group by
f1,f2
) Q ) P;
-- PowerCoreExactNumeric_p4
select 'PowerCoreExactNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, .01 f2 from tversion union
select 5 f1, 100 f2 from tversion union
select tnum.rnum, power( tnum.cnum,2 ) from tnum
) Q
group by
f1,f2
) Q ) P;
-- SelectCountExactNumeric_p3
select 'SelectCountExactNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5 f1 from tversion union
select count(vnum.cnum) from vnum
) Q
group by
f1
) Q ) P;
-- SelectCountExactNumeric_p4
select 'SelectCountExactNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5 f1 from tversion union
select count(tnum.cnum) from tnum
) Q
group by
f1
) Q ) P;
-- SelectMaxExactNumeric_p3
select 'SelectMaxExactNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10 f1 from tversion union
select max( vnum.cnum ) from vnum
) Q
group by
f1
) Q ) P;
-- SelectMaxExactNumeric_p4
select 'SelectMaxExactNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10 f1 from tversion union
select max( tnum.cnum ) from tnum
) Q
group by
f1
) Q ) P;
-- SelectMinExactNumeric_p3
select 'SelectMinExactNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select -1 f1 from tversion union
select min( vnum.cnum ) from vnum
) Q
group by
f1
) Q ) P;
-- SelectMinExactNumeric_p4
select 'SelectMinExactNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select -1 f1 from tversion union
select min( tnum.cnum ) from tnum
) Q
group by
f1
) Q ) P;
-- SelectStanDevPopExactNumeric_p3
select 'SelectStanDevPopExactNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.04 f1 from tversion union
select stddev_pop( vnum.cnum ) from vnum
) Q
group by
f1
) Q ) P;
-- SelectStanDevPopExactNumeric_p4
select 'SelectStanDevPopExactNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.04 f1 from tversion union
select stddev_pop( tnum.cnum ) from tnum
) Q
group by
f1
) Q ) P;
-- CaseBasicSearchExactNumeric_p3
select 'CaseBasicSearchExactNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'test1' f2 from tversion union
select 2 f1, 'other' f2 from tversion union
select 3 f1, 'other' f2 from tversion union
select 4 f1, 'test1' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select vnum.rnum,case when vnum.cnum in ( -1,10,0.1 )  then 'test1' else 'other' end from vnum
) Q
group by
f1,f2
) Q ) P;
-- SelectSumExactNumeric_p3
select 'SelectSumExactNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10.1 f1 from tversion union
select sum( vnum.cnum ) from vnum
) Q
group by
f1
) Q ) P;
-- SelectSumExactNumeric_p4
select 'SelectSumExactNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10.1 f1 from tversion union
select sum( tnum.cnum ) from tnum
) Q
group by
f1
) Q ) P;
-- CaseBasicSearchExactNumeric_p4
select 'CaseBasicSearchExactNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'test1' f2 from tversion union
select 2 f1, 'other' f2 from tversion union
select 3 f1, 'other' f2 from tversion union
select 4 f1, 'test1' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select tnum.rnum,case when tnum.cnum in ( -1,10,0.1 )  then 'test1' else 'other' end from tnum
) Q
group by
f1,f2
) Q ) P;
-- SelectVarPopExactNumeric_p3
select 'SelectVarPopExactNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 16.3216 f1 from tversion union
select var_pop( vnum.cnum ) from vnum
) Q
group by
f1
) Q ) P;
-- SelectVarPopExactNumeric_p4
select 'SelectVarPopExactNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 16.3216 f1 from tversion union
select var_pop( tnum.cnum ) from tnum
) Q
group by
f1
) Q ) P;
-- AbsCoreExactNumeric_p3
select 'AbsCoreExactNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1.000000000000000e+000 f2 from tversion union
select 2 f1, 0.000000000000000e+000 f2 from tversion union
select 3 f1, 1.000000000000000e+000 f2 from tversion union
select 4 f1, 1.000000000000000e-001 f2 from tversion union
select 5 f1, 1.000000000000000e+001 f2 from tversion union
select rnum, abs( vnum.cnum ) from vnum
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseExactNumericElseDefaultsNULL_p3
select 'SimpleCaseExactNumericElseDefaultsNULL_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, null f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, null f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select vnum.rnum,case when vnum.cnum=10 then 'test1' when vnum.cnum=-0.1 then 'test2'  end from vnum
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseExactNumericElseDefaultsNULL_p4
select 'SimpleCaseExactNumericElseDefaultsNULL_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, null f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, null f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select tnum.rnum,case when tnum.cnum=10 then 'test1' when tnum.cnum=-0.1 then 'test2'  end from tnum
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseExactNumericElseExplicitNULL_p3
select 'SimpleCaseExactNumericElseExplicitNULL_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, null f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, null f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select vnum.rnum,case when vnum.cnum=10 then 'test1' when vnum.cnum=-0.1 then 'test2'  else null end from vnum
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseExactNumericElseExplicitNULL_p4
select 'SimpleCaseExactNumericElseExplicitNULL_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, null f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, null f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select tnum.rnum,case when tnum.cnum=10 then 'test1' when tnum.cnum=-0.1 then 'test2'  else null end from tnum
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseExactNumeric_p3
select 'SimpleCaseExactNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'else' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select vnum.rnum,case when vnum.cnum=10 then 'test1' when vnum.cnum=-0.1 then 'test2' else 'else' end from vnum
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseExactNumeric_p4
select 'SimpleCaseExactNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'else' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select tnum.rnum,case when tnum.cnum=10 then 'test1' when tnum.cnum=-0.1 then 'test2' else 'else' end from tnum
) Q
group by
f1,f2
) Q ) P;
-- StanDevExactNumeric_p3
select 'StanDevExactNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.516857 f1 from tversion union
select stddev( vnum.cnum ) from vnum
) Q
group by
f1
) Q ) P;
-- StanDevExactNumeric_p4
select 'StanDevExactNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.516857 f1 from tversion union
select stddev( tnum.cnum ) from tnum
) Q
group by
f1
) Q ) P;
-- CaseComparisonsExactNumeric_p3
select 'CaseComparisonsExactNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'lt' f2 from tversion union
select 2 f1, 'in' f2 from tversion union
select 3 f1, '=' f2 from tversion union
select 4 f1, 'between' f2 from tversion union
select 5 f1, 'gt' f2 from tversion union
select vnum.rnum,case  when vnum.cnum =  1  then '=' when vnum.cnum >  9  then 'gt' when vnum.cnum < -0.1 then 'lt' when vnum.cnum in  (0,11)  then 'in' when vnum.cnum between 0 and 1  then 'between' else 'other' end from vnum
) Q
group by
f1,f2
) Q ) P;
-- CaseComparisonsExactNumeric_p4
select 'CaseComparisonsExactNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'lt' f2 from tversion union
select 2 f1, 'in' f2 from tversion union
select 3 f1, '=' f2 from tversion union
select 4 f1, 'between' f2 from tversion union
select 5 f1, 'gt' f2 from tversion union
select tnum.rnum,case  when tnum.cnum =  1  then '=' when tnum.cnum >  9  then 'gt' when tnum.cnum < -0.1 then 'lt' when tnum.cnum in  (0,11)  then 'in' when tnum.cnum between 0 and 1  then 'between' else 'other' end from tnum
) Q
group by
f1,f2
) Q ) P;
-- StanDevSampExactNumeric_p3
select 'StanDevSampExactNumeric_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.516857 f1 from tversion union
select stddev_samp( vnum.cnum ) from vnum
) Q
group by
f1
) Q ) P;
-- StanDevSampExactNumeric_p4
select 'StanDevSampExactNumeric_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.516857 f1 from tversion union
select stddev_samp( tnum.cnum ) from tnum
) Q
group by
f1
) Q ) P;
