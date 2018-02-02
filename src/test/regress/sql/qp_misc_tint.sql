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
-- Name: tint; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace:
--

CREATE TABLE tint (
    rnum integer NOT NULL,
    cint integer
) DISTRIBUTED BY (rnum);

--
-- Data for Name: tint; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

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
-- Name: vint; Type: VIEW; Schema: public; Owner: gpadmin
--
CREATE VIEW vint AS
    SELECT tint.rnum, tint.cint FROM tint;


COPY tint (rnum, cint) FROM stdin;
3	1
0	\N
1	-1
2	0
4	10
\.

--
-- Data for Name: tversion; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tversion (rnum, c1, cver, cnnull, ccnull) FROM stdin;
0	1	1.0   	\N	\N
\.
-- CaseComparisonsInteger_p2
select 'CaseComparisonsInteger_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'lt' f2 from tversion union
select 2 f1, 'in' f2 from tversion union
select 3 f1, '=' f2 from tversion union
select 4 f1, 'gt' f2 from tversion union
select tint.rnum,case  when tint.cint =  1  then '=' when tint.cint >  9  then 'gt' when tint.cint < 0 then 'lt' when tint.cint in  (0,11)  then 'in' when tint.cint between 6 and 8  then 'between'  else 'other' end from tint
) Q
group by
f1,f2
) Q ) P;
-- VarInt_p1
select 'VarInt_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 25.66667 f1 from tversion union
select variance( vint.cint ) from vint
) Q
group by
f1
) Q ) P;
-- VarInt_p2
select 'VarInt_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 25.66667 f1 from tversion union
select variance( tint.cint ) from tint
) Q
group by
f1
) Q ) P;
-- VarSampInt_p1
select 'VarSampInt_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 25.66667 f1 from tversion union
select var_samp( vint.cint ) from vint
) Q
group by
f1
) Q ) P;
-- VarSampInt_p2
select 'VarSampInt_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 25.66667 f1 from tversion union
select var_samp( tint.cint ) from tint
) Q
group by
f1
) Q ) P;
-- AbsCoreInteger_p1
select 'AbsCoreInteger_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select vint.rnum, abs( vint.cint ) from vint
) Q
group by
f1,f2
) Q ) P;
-- CaseNestedInteger_p1
select 'CaseNestedInteger_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'nested else' f2 from tversion union
select 3 f1, 'nested else' f2 from tversion union
select 4 f1, 'nested inner' f2 from tversion union
select vint.rnum,case  when vint.cint > -1  then case  when vint.cint > 1 then  'nested inner' else 'nested else' end else 'else'  end from vint
) Q
group by
f1,f2
) Q ) P;
-- CaseNestedInteger_p2
select 'CaseNestedInteger_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'nested else' f2 from tversion union
select 3 f1, 'nested else' f2 from tversion union
select 4 f1, 'nested inner' f2 from tversion union
select tint.rnum,case  when tint.cint > -1  then case  when tint.cint > 1 then  'nested inner' else 'nested else' end else 'else'  end from tint
) Q
group by
f1,f2
) Q ) P;
-- AbsCoreInteger_p2
select 'AbsCoreInteger_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select tint.rnum, abs( tint.cint ) from tint
) Q
group by
f1,f2
) Q ) P;
-- CaseSubQueryInteger_p1
select 'CaseSubQueryInteger_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'true' f2 from tversion union
select vint.rnum,case  when vint.cint= (select max( vint.cint) from vint)    then 'true' else 'else' 	end from vint
) Q
group by
f1,f2
) Q ) P;
-- CaseSubQueryInteger_p2
select 'CaseSubQueryInteger_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'true' f2 from tversion union
select tint.rnum,case  when tint.cint= (select max( tint.cint) from tint)    then 'true' else 'else' 	end from tint
) Q
group by
f1,f2
) Q ) P;
-- CastIntegerToBigint_p1
select 'CastIntegerToBigint_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, cast(vint.cint as bigint) from vint
) Q
group by
f1,f2
) Q ) P;
-- CastIntegerToBigint_p2
select 'CastIntegerToBigint_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, cast(tint.cint as bigint) from tint
) Q
group by
f1,f2
) Q ) P;
-- CastIntegerToChar_p1
select 'CastIntegerToChar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1   ' f2 from tversion union
select 2 f1, '0    ' f2 from tversion union
select 3 f1, '1    ' f2 from tversion union
select 4 f1, '10   ' f2 from tversion union
select rnum, cast(vint.cint as char(5)) from vint
) Q
group by
f1,f2
) Q ) P;
-- CastIntegerToChar_p2
select 'CastIntegerToChar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1   ' f2 from tversion union
select 2 f1, '0    ' f2 from tversion union
select 3 f1, '1    ' f2 from tversion union
select 4 f1, '10   ' f2 from tversion union
select rnum, cast(tint.cint as char(5)) from tint
) Q
group by
f1,f2
) Q ) P;
-- CastIntegerToDouble_p1
select 'CastIntegerToDouble_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, cast(vint.cint as double precision) from vint
) Q
group by
f1,f2
) Q ) P;
-- CastIntegerToDouble_p2
select 'CastIntegerToDouble_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, cast(tint.cint as double precision) from tint
) Q
group by
f1,f2
) Q ) P;
-- CastIntegerToFloat_p1
select 'CastIntegerToFloat_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, cast(vint.cint as float) from vint
) Q
group by
f1,f2
) Q ) P;
-- CastIntegerToFloat_p2
select 'CastIntegerToFloat_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, cast(tint.cint as float) from tint
) Q
group by
f1,f2
) Q ) P;
-- CastIntegerToInteger_p1
select 'CastIntegerToInteger_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, cast(vint.cint as integer) from vint
) Q
group by
f1,f2
) Q ) P;
-- CastIntegerToInteger_p2
select 'CastIntegerToInteger_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, cast(tint.cint as integer) from tint
) Q
group by
f1,f2
) Q ) P;
-- CastIntegerToSmallint_p1
select 'CastIntegerToSmallint_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, cast(vint.cint as smallint) from vint
) Q
group by
f1,f2
) Q ) P;
-- CastIntegerToSmallint_p2
select 'CastIntegerToSmallint_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, cast(tint.cint as smallint) from tint
) Q
group by
f1,f2
) Q ) P;
-- CastIntegerToVarchar_p1
select 'CastIntegerToVarchar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1' f2 from tversion union
select 2 f1, '0' f2 from tversion union
select 3 f1, '1' f2 from tversion union
select 4 f1, '10' f2 from tversion union
select rnum, cast(vint.cint as varchar(5)) from vint
) Q
group by
f1,f2
) Q ) P;
-- CastIntegerToVarchar_p2
select 'CastIntegerToVarchar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1' f2 from tversion union
select 2 f1, '0' f2 from tversion union
select 3 f1, '1' f2 from tversion union
select 4 f1, '10' f2 from tversion union
select rnum, cast(tint.cint as varchar(5)) from tint
) Q
group by
f1,f2
) Q ) P;
-- CeilCoreIntegers_p1
select 'CeilCoreIntegers_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select vint.rnum, ceil( vint.cint ) from vint
) Q
group by
f1,f2
) Q ) P;
-- CeilCoreIntegers_p2
select 'CeilCoreIntegers_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select tint.rnum, ceil( tint.cint ) from tint
) Q
group by
f1,f2
) Q ) P;
-- DistinctAggregateInCase_p11
select 'DistinctAggregateInCase_p11' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'test1' f1 from tversion union
select case when min(distinct(vint.cint))=-1 then 'test1' else 'else' end from vint
) Q
group by
f1
) Q ) P;
-- DistinctAggregateInCase_p12
select 'DistinctAggregateInCase_p12' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'test1' f1 from tversion union
select case when min(distinct(tint.cint))=-1 then 'test1' else 'else' end from tint
) Q
group by
f1
) Q ) P;
-- ExpCoreIntegers_p1
select 'ExpCoreIntegers_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, .367879441 f2 from tversion union
select 2 f1, 1 f2 from tversion union
select 3 f1, 2.71828183 f2 from tversion union
select 4 f1, 22026.4658 f2 from tversion union
select vint.rnum, exp( vint.cint ) from vint
) Q
group by
f1,f2
) Q ) P;
-- ExpCoreIntegers_p2
select 'ExpCoreIntegers_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, .367879441 f2 from tversion union
select 2 f1, 1 f2 from tversion union
select 3 f1, 2.71828183 f2 from tversion union
select 4 f1, 22026.4658 f2 from tversion union
select tint.rnum, exp( tint.cint ) from tint
) Q
group by
f1,f2
) Q ) P;
-- FloorCoreIntegers_p1
select 'FloorCoreIntegers_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, floor( vint.cint ) from vint
) Q
group by
f1,f2
) Q ) P;
-- FloorCoreIntegers_p2
select 'FloorCoreIntegers_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, floor( tint.cint ) from tint
) Q
group by
f1,f2
) Q ) P;
-- IntegerOpAdd_p1
select 'IntegerOpAdd_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 2 f2 from tversion union
select 3 f1, 3 f2 from tversion union
select 4 f1, 12 f2 from tversion union
select vint.rnum,vint.cint + 2 from vint
) Q
group by
f1,f2
) Q ) P;
-- IntegerOpAdd_p2
select 'IntegerOpAdd_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 2 f2 from tversion union
select 3 f1, 3 f2 from tversion union
select 4 f1, 12 f2 from tversion union
select tint.rnum,tint.cint + 2 from tint
) Q
group by
f1,f2
) Q ) P;
-- IntegerOpDiv_p1
select 'IntegerOpDiv_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 0 f2 from tversion union
select 4 f1, 5 f2 from tversion union
select vint.rnum,vint.cint / 2 from vint
) Q
group by
f1,f2
) Q ) P;
-- IntegerOpDiv_p2
select 'IntegerOpDiv_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 0 f2 from tversion union
select 4 f1, 5 f2 from tversion union
select tint.rnum,tint.cint / 2 from tint
) Q
group by
f1,f2
) Q ) P;
-- IntegerOpMul_p1
select 'IntegerOpMul_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -2 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 2 f2 from tversion union
select 4 f1, 20 f2 from tversion union
select vint.rnum,vint.cint * 2 from vint
) Q
group by
f1,f2
) Q ) P;
-- IntegerOpMul_p2
select 'IntegerOpMul_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -2 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 2 f2 from tversion union
select 4 f1, 20 f2 from tversion union
select tint.rnum,tint.cint * 2 from tint
) Q
group by
f1,f2
) Q ) P;
-- IntegerOpSub_p1
select 'IntegerOpSub_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -3 f2 from tversion union
select 2 f1, -2 f2 from tversion union
select 3 f1, -1 f2 from tversion union
select 4 f1, 8 f2 from tversion union
select vint.rnum,vint.cint - 2 from vint
) Q
group by
f1,f2
) Q ) P;
-- IntegerOpSub_p2
select 'IntegerOpSub_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -3 f2 from tversion union
select 2 f1, -2 f2 from tversion union
select 3 f1, -1 f2 from tversion union
select 4 f1, 8 f2 from tversion union
select tint.rnum,tint.cint - 2 from tint
) Q
group by
f1,f2
) Q ) P;
-- AvgIntTruncates_p1
select 'AvgIntTruncates_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 2 f1 from tversion union
select avg(vint.cint) from vint
) Q
group by
f1
) Q ) P;
-- AvgIntTruncates_p2
select 'AvgIntTruncates_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 2 f1 from tversion union
select avg(tint.cint) from tint
) Q
group by
f1
) Q ) P;
-- ModCore2Integers_p1
select 'ModCore2Integers_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 3 f1, 0 f2 from tversion union
select 4 f1, 3 f2 from tversion union
select vint.rnum, mod( 3,vint.cint ) from vint where vint.rnum <> 2
) Q
group by
f1,f2
) Q ) P;
-- ModCore2Integers_p2
select 'ModCore2Integers_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 3 f1, 0 f2 from tversion union
select 4 f1, 3 f2 from tversion union
select tint.rnum, mod( 3,tint.cint ) from tint where tint.rnum <> 2
) Q
group by
f1,f2
) Q ) P;
-- ModCoreIntegers_p1
select 'ModCoreIntegers_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 1 f2 from tversion union
select rnum, mod( vint.cint, 3 ) from vint
) Q
group by
f1,f2
) Q ) P;
-- ModCoreIntegers_p2
select 'ModCoreIntegers_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 1 f2 from tversion union
select rnum, mod( tint.cint, 3 ) from tint
) Q
group by
f1,f2
) Q ) P;
-- AvgInt_p1
select 'AvgInt_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 2.500000000000000e+000 f1 from tversion union
select avg(vint.cint) from vint
) Q
group by
f1
) Q ) P;
-- AvgInt_p2
select 'AvgInt_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 2.500000000000000e+000 f1 from tversion union
select avg(tint.cint) from tint
) Q
group by
f1
) Q ) P;
-- PowerCoreIntegers_p1
select 'PowerCoreIntegers_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 100 f2 from tversion union
select vint.rnum, power( vint.cint,2 ) from vint
) Q
group by
f1,f2
) Q ) P;
-- PowerCoreIntegers_p2
select 'PowerCoreIntegers_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 100 f2 from tversion union
select tint.rnum, power( tint.cint,2 ) from tint
) Q
group by
f1,f2
) Q ) P;
-- SelectCountInt_p1
select 'SelectCountInt_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4 f1 from tversion union
select count(vint.cint) from vint
) Q
group by
f1
) Q ) P;
-- SelectCountInt_p2
select 'SelectCountInt_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4 f1 from tversion union
select count(tint.cint) from tint
) Q
group by
f1
) Q ) P;
-- SelectMaxInt_p1
select 'SelectMaxInt_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10 f1 from tversion union
select max( vint.cint ) from vint
) Q
group by
f1
) Q ) P;
-- SelectMaxInt_p2
select 'SelectMaxInt_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10 f1 from tversion union
select max( tint.cint ) from tint
) Q
group by
f1
) Q ) P;
-- SelectMinInt_p1
select 'SelectMinInt_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select -1 f1 from tversion union
select min( vint.cint ) from vint
) Q
group by
f1
) Q ) P;
-- SelectMinInt_p2
select 'SelectMinInt_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select -1 f1 from tversion union
select min( tint.cint ) from tint
) Q
group by
f1
) Q ) P;
-- SelectStanDevPopInt_p1
select 'SelectStanDevPopInt_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.38748 f1 from tversion union
select stddev_pop( vint.cint ) from vint
) Q
group by
f1
) Q ) P;
-- SelectStanDevPopInt_p2
select 'SelectStanDevPopInt_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.38748 f1 from tversion union
select stddev_pop( tint.cint ) from tint
) Q
group by
f1
) Q ) P;
-- SelectSumInt_p1
select 'SelectSumInt_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10 f1 from tversion union
select sum( vint.cint ) from vint
) Q
group by
f1
) Q ) P;
-- SelectSumInt_p2
select 'SelectSumInt_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10 f1 from tversion union
select sum( tint.cint ) from tint
) Q
group by
f1
) Q ) P;
-- CaseBasicSearchInteger_p1
select 'CaseBasicSearchInteger_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'test1' f2 from tversion union
select 2 f1, 'other' f2 from tversion union
select 3 f1, 'test1' f2 from tversion union
select 4 f1, 'test1' f2 from tversion union
select vint.rnum,case when vint.cint in ( -1,10,1 )  then 'test1' else 'other' end from vint
) Q
group by
f1,f2
) Q ) P;
-- CaseBasicSearchInteger_p2
select 'CaseBasicSearchInteger_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'test1' f2 from tversion union
select 2 f1, 'other' f2 from tversion union
select 3 f1, 'test1' f2 from tversion union
select 4 f1, 'test1' f2 from tversion union
select tint.rnum,case when tint.cint in ( -1,10,1 )  then 'test1' else 'other' end from tint
) Q
group by
f1,f2
) Q ) P;
-- SelectVarPopInt_p1
select 'SelectVarPopInt_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 19.25 f1 from tversion union
select var_pop( vint.cint ) from vint
) Q
group by
f1
) Q ) P;
-- SelectVarPopInt_p2
select 'SelectVarPopInt_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 19.25 f1 from tversion union
select var_pop( tint.cint ) from tint
) Q
group by
f1
) Q ) P;
-- SimpleCaseIntegerElseDefaultsNULL_p1
select 'SimpleCaseIntegerElseDefaultsNULL_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, 'test1' f2 from tversion union
select vint.rnum,case when vint.cint=10 then 'test1' when vint.cint=-1 then 'test2' end from vint
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseIntegerElseDefaultsNULL_p2
select 'SimpleCaseIntegerElseDefaultsNULL_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, 'test1' f2 from tversion union
select tint.rnum,case when tint.cint=10 then 'test1' when tint.cint=-1 then 'test2' end from tint
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseIntegerElseExplicitNULL_p1
select 'SimpleCaseIntegerElseExplicitNULL_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, 'test1' f2 from tversion union
select vint.rnum,case when vint.cint=10 then 'test1' when vint.cint=-1 then 'test2' else null end from vint
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseIntegerElseExplicitNULL_p2
select 'SimpleCaseIntegerElseExplicitNULL_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, 'test1' f2 from tversion union
select tint.rnum,case when tint.cint=10 then 'test1' when tint.cint=-1 then 'test2' else null end from tint
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseInteger_p1
select 'SimpleCaseInteger_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'test1' f2 from tversion union
select vint.rnum,case when vint.cint=10 then 'test1' when vint.cint=-1 then 'test2' else 'else' end from vint
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseInteger_p2
select 'SimpleCaseInteger_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'test1' f2 from tversion union
select tint.rnum,case when tint.cint=10 then 'test1' when tint.cint=-1 then 'test2' else 'else' end from tint
) Q
group by
f1,f2
) Q ) P;
-- StanDevInt_p1
select 'StanDevInt_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5.066228 f1 from tversion union
select stddev( vint.cint ) from vint
) Q
group by
f1
) Q ) P;
-- StanDevInt_p2
select 'StanDevInt_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5.066228 f1 from tversion union
select stddev( tint.cint ) from tint
) Q
group by
f1
) Q ) P;
-- StanDevSampInt_p1
select 'StanDevSampInt_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5.066228 f1 from tversion union
select stddev_samp( vint.cint ) from vint
) Q
group by
f1
) Q ) P;
-- StanDevSampInt_p2
select 'StanDevSampInt_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5.066228 f1 from tversion union
select stddev_samp( tint.cint ) from tint
) Q
group by
f1
) Q ) P;
-- CaseComparisonsInteger_p1
select 'CaseComparisonsInteger_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'lt' f2 from tversion union
select 2 f1, 'in' f2 from tversion union
select 3 f1, '=' f2 from tversion union
select 4 f1, 'gt' f2 from tversion union
select vint.rnum,case  when vint.cint =  1  then '=' when vint.cint >  9  then 'gt' when vint.cint < 0 then 'lt' when vint.cint in  (0,11)  then 'in' when vint.cint between 6 and 8  then 'between'  else 'other' end from vint
) Q
group by
f1,f2
) Q ) P;
