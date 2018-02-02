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
-- Name: tsint; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace:
--

CREATE TABLE tsint (
    rnum integer NOT NULL,
    csint smallint
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
-- Name: vsint; Type: VIEW; Schema: public; Owner: gpadmin
--
CREATE VIEW vsint AS
    SELECT tsint.rnum, tsint.csint FROM tsint;

--
-- Data for Name: tsint; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tsint (rnum, csint) FROM stdin;
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

-- CaseComparisonsInteger_p3
select 'CaseComparisonsInteger_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'lt' f2 from tversion union
select 2 f1, 'in' f2 from tversion union
select 3 f1, '=' f2 from tversion union
select 4 f1, 'gt' f2 from tversion union
select vsint.rnum,case  when vsint.csint =  1  then '=' when vsint.csint >  9  then 'gt' when vsint.csint < 0 then 'lt' when vsint.csint in  (0,11)  then 'in' when vsint.csint between 6 and 8  then 'between'  else 'other' end from vsint
) Q
group by
f1,f2
) Q ) P;
-- CaseComparisonsInteger_p4
select 'CaseComparisonsInteger_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'lt' f2 from tversion union
select 2 f1, 'in' f2 from tversion union
select 3 f1, '=' f2 from tversion union
select 4 f1, 'gt' f2 from tversion union
select tsint.rnum,case  when tsint.csint =  1  then '=' when tsint.csint >  9  then 'gt' when tsint.csint < 0 then 'lt' when tsint.csint in  (0,11)  then 'in' when tsint.csint between 6 and 8  then 'between'  else 'other' end from tsint
) Q
group by
f1,f2
) Q ) P;
-- VarInt_p3
select 'VarInt_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 25.66667 f1 from tversion union
select variance( vsint.csint ) from vsint
) Q
group by
f1
) Q ) P;
-- VarInt_p4
select 'VarInt_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 25.66667 f1 from tversion union
select variance( tsint.csint ) from tsint
) Q
group by
f1
) Q ) P;
-- VarSampInt_p3
select 'VarSampInt_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 25.66667 f1 from tversion union
select var_samp( vsint.csint ) from vsint
) Q
group by
f1
) Q ) P;
-- VarSampInt_p4
select 'VarSampInt_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 25.66667 f1 from tversion union
select var_samp( tsint.csint ) from tsint
) Q
group by
f1
) Q ) P;
-- CaseNestedInteger_p3
select 'CaseNestedInteger_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'nested else' f2 from tversion union
select 3 f1, 'nested else' f2 from tversion union
select 4 f1, 'nested inner' f2 from tversion union
select vsint.rnum,case  when vsint.csint > -1  then case  when vsint.csint > 1 then  'nested inner' else 'nested else' end else 'else'  end from vsint
) Q
group by
f1,f2
) Q ) P;
-- CaseNestedInteger_p4
select 'CaseNestedInteger_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'nested else' f2 from tversion union
select 3 f1, 'nested else' f2 from tversion union
select 4 f1, 'nested inner' f2 from tversion union
select tsint.rnum,case  when tsint.csint > -1  then case  when tsint.csint > 1 then  'nested inner' else 'nested else' end else 'else'  end from tsint
) Q
group by
f1,f2
) Q ) P;
-- AbsCoreInteger_p3
select 'AbsCoreInteger_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select vsint.rnum, abs( vsint.csint ) from vsint
) Q
group by
f1,f2
) Q ) P;
-- CaseSubQueryInteger_p3
select 'CaseSubQueryInteger_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'true' f2 from tversion union
select vsint.rnum,case  when vsint.csint= (select max( vsint.csint) from vsint)    then 'true' else 'else' 	end from vsint
) Q
group by
f1,f2
) Q ) P;
-- CaseSubQueryInteger_p4
select 'CaseSubQueryInteger_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'true' f2 from tversion union
select tsint.rnum,case  when tsint.csint= (select max( tsint.csint) from tsint)    then 'true' else 'else' 	end from tsint
) Q
group by
f1,f2
) Q ) P;
-- AbsCoreInteger_p4
select 'AbsCoreInteger_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select tsint.rnum, abs( tsint.csint ) from tsint
) Q
group by
f1,f2
) Q ) P;
-- CastSmallintToBigint_p1
select 'CastSmallintToBigint_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, cast(vsint.csint as bigint) from vsint
) Q
group by
f1,f2
) Q ) P;
-- CastSmallintToBigint_p2
select 'CastSmallintToBigint_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, cast(tsint.csint as bigint) from tsint
) Q
group by
f1,f2
) Q ) P;
-- CastSmallintToChar_p1
select 'CastSmallintToChar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1' f2 from tversion union
select 2 f1, '0 ' f2 from tversion union
select 3 f1, '1 ' f2 from tversion union
select 4 f1, '10' f2 from tversion union
select rnum, cast(vsint.csint as char(2)) from vsint
) Q
group by
f1,f2
) Q ) P;
-- CastSmallintToChar_p2
select 'CastSmallintToChar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1' f2 from tversion union
select 2 f1, '0 ' f2 from tversion union
select 3 f1, '1 ' f2 from tversion union
select 4 f1, '10' f2 from tversion union
select rnum, cast(tsint.csint as char(2)) from tsint
) Q
group by
f1,f2
) Q ) P;
-- CastSmallintToDouble_p1
select 'CastSmallintToDouble_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, cast(vsint.csint as double precision) from vsint
) Q
group by
f1,f2
) Q ) P;
-- CastSmallintToDouble_p2
select 'CastSmallintToDouble_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, cast(tsint.csint as double precision) from tsint
) Q
group by
f1,f2
) Q ) P;
-- CastSmallintToFloat_p1
select 'CastSmallintToFloat_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, cast(vsint.csint as float) from vsint
) Q
group by
f1,f2
) Q ) P;
-- CastSmallintToFloat_p2
select 'CastSmallintToFloat_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, cast(tsint.csint as float) from tsint
) Q
group by
f1,f2
) Q ) P;
-- CastSmallintToSmallint_p1
select 'CastSmallintToSmallint_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, cast(vsint.csint as smallint) from vsint
) Q
group by
f1,f2
) Q ) P;
-- CastSmallintToSmallint_p2
select 'CastSmallintToSmallint_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, cast(tsint.csint as smallint) from tsint
) Q
group by
f1,f2
) Q ) P;
-- CastSmallintToVarchar_p1
select 'CastSmallintToVarchar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1' f2 from tversion union
select 2 f1, '0' f2 from tversion union
select 3 f1, '1' f2 from tversion union
select 4 f1, '10' f2 from tversion union
select rnum, cast(vsint.csint as varchar(10)) from vsint
) Q
group by
f1,f2
) Q ) P;
-- CastSmallintToVarchar_p2
select 'CastSmallintToVarchar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1' f2 from tversion union
select 2 f1, '0' f2 from tversion union
select 3 f1, '1' f2 from tversion union
select 4 f1, '10' f2 from tversion union
select rnum, cast(tsint.csint as varchar(10)) from tsint
) Q
group by
f1,f2
) Q ) P;
-- CeilCoreIntegers_p3
select 'CeilCoreIntegers_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select vsint.rnum, ceil( vsint.csint ) from vsint
) Q
group by
f1,f2
) Q ) P;
-- CeilCoreIntegers_p4
select 'CeilCoreIntegers_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select tsint.rnum, ceil( tsint.csint ) from tsint
) Q
group by
f1,f2
) Q ) P;
-- DistinctAggregateInCase_p13
select 'DistinctAggregateInCase_p13' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'test1' f1 from tversion union
select case when min(distinct(vsint.csint))=-1 then 'test1' else 'else' end from vsint
) Q
group by
f1
) Q ) P;
-- DistinctAggregateInCase_p14
select 'DistinctAggregateInCase_p14' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'test1' f1 from tversion union
select case when min(distinct(tsint.csint))=-1 then 'test1' else 'else' end from tsint
) Q
group by
f1
) Q ) P;
-- ExpCoreIntegers_p3
select 'ExpCoreIntegers_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, .367879441 f2 from tversion union
select 2 f1, 1 f2 from tversion union
select 3 f1, 2.71828183 f2 from tversion union
select 4 f1, 22026.4658 f2 from tversion union
select vsint.rnum, exp( vsint.csint ) from vsint
) Q
group by
f1,f2
) Q ) P;
-- ExpCoreIntegers_p4
select 'ExpCoreIntegers_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, .367879441 f2 from tversion union
select 2 f1, 1 f2 from tversion union
select 3 f1, 2.71828183 f2 from tversion union
select 4 f1, 22026.4658 f2 from tversion union
select tsint.rnum, exp( tsint.csint ) from tsint
) Q
group by
f1,f2
) Q ) P;
-- FloorCoreIntegers_p3
select 'FloorCoreIntegers_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, floor( vsint.csint ) from vsint
) Q
group by
f1,f2
) Q ) P;
-- FloorCoreIntegers_p4
select 'FloorCoreIntegers_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, floor( tsint.csint ) from tsint
) Q
group by
f1,f2
) Q ) P;
-- IntegerOpAdd_p3
select 'IntegerOpAdd_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 2 f2 from tversion union
select 3 f1, 3 f2 from tversion union
select 4 f1, 12 f2 from tversion union
select vsint.rnum,vsint.csint + 2 from vsint
) Q
group by
f1,f2
) Q ) P;
-- IntegerOpAdd_p4
select 'IntegerOpAdd_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 2 f2 from tversion union
select 3 f1, 3 f2 from tversion union
select 4 f1, 12 f2 from tversion union
select tsint.rnum,tsint.csint + 2 from tsint
) Q
group by
f1,f2
) Q ) P;
-- IntegerOpDiv_p3
select 'IntegerOpDiv_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 0 f2 from tversion union
select 4 f1, 5 f2 from tversion union
select vsint.rnum,vsint.csint / 2 from vsint
) Q
group by
f1,f2
) Q ) P;
-- IntegerOpDiv_p4
select 'IntegerOpDiv_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 0 f2 from tversion union
select 4 f1, 5 f2 from tversion union
select tsint.rnum,tsint.csint / 2 from tsint
) Q
group by
f1,f2
) Q ) P;
-- IntegerOpMul_p3
select 'IntegerOpMul_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -2 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 2 f2 from tversion union
select 4 f1, 20 f2 from tversion union
select vsint.rnum,vsint.csint * 2 from vsint
) Q
group by
f1,f2
) Q ) P;
-- IntegerOpMul_p4
select 'IntegerOpMul_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -2 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 2 f2 from tversion union
select 4 f1, 20 f2 from tversion union
select tsint.rnum,tsint.csint * 2 from tsint
) Q
group by
f1,f2
) Q ) P;
-- IntegerOpSub_p3
select 'IntegerOpSub_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -3 f2 from tversion union
select 2 f1, -2 f2 from tversion union
select 3 f1, -1 f2 from tversion union
select 4 f1, 8 f2 from tversion union
select vsint.rnum,vsint.csint - 2 from vsint
) Q
group by
f1,f2
) Q ) P;
-- IntegerOpSub_p4
select 'IntegerOpSub_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -3 f2 from tversion union
select 2 f1, -2 f2 from tversion union
select 3 f1, -1 f2 from tversion union
select 4 f1, 8 f2 from tversion union
select tsint.rnum,tsint.csint - 2 from tsint
) Q
group by
f1,f2
) Q ) P;
-- AvgIntTruncates_p3
select 'AvgIntTruncates_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 2 f1 from tversion union
select avg(vsint.csint) from vsint
) Q
group by
f1
) Q ) P;
-- ModCore2Integers_p3
select 'ModCore2Integers_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 3 f1, 0 f2 from tversion union
select 4 f1, 3 f2 from tversion union
select vsint.rnum, mod( 3,vsint.csint ) from vsint where vsint.rnum <> 2
) Q
group by
f1,f2
) Q ) P;
-- ModCore2Integers_p4
select 'ModCore2Integers_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 3 f1, 0 f2 from tversion union
select 4 f1, 3 f2 from tversion union
select tsint.rnum, mod( 3,tsint.csint ) from tsint where tsint.rnum <> 2
) Q
group by
f1,f2
) Q ) P;
-- AvgIntTruncates_p4
select 'AvgIntTruncates_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 2 f1 from tversion union
select avg(tsint.csint) from tsint
) Q
group by
f1
) Q ) P;
-- ModCoreIntegers_p3
select 'ModCoreIntegers_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 1 f2 from tversion union
select rnum, mod( vsint.csint, 3 ) from vsint
) Q
group by
f1,f2
) Q ) P;
-- ModCoreIntegers_p4
select 'ModCoreIntegers_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 1 f2 from tversion union
select rnum, mod( tsint.csint, 3 ) from tsint
) Q
group by
f1,f2
) Q ) P;
-- AvgInt_p3
select 'AvgInt_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 2.500000000000000e+000 f1 from tversion union
select avg(vsint.csint) from vsint
) Q
group by
f1
) Q ) P;
-- AvgInt_p4
select 'AvgInt_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 2.500000000000000e+000 f1 from tversion union
select avg(tsint.csint) from tsint
) Q
group by
f1
) Q ) P;
-- PowerCoreIntegers_p3
select 'PowerCoreIntegers_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 100 f2 from tversion union
select vsint.rnum, power( vsint.csint,2 ) from vsint
) Q
group by
f1,f2
) Q ) P;
-- PowerCoreIntegers_p4
select 'PowerCoreIntegers_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 100 f2 from tversion union
select tsint.rnum, power( tsint.csint,2 ) from tsint
) Q
group by
f1,f2
) Q ) P;
-- SelectCountInt_p3
select 'SelectCountInt_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4 f1 from tversion union
select count(vsint.csint) from vsint
) Q
group by
f1
) Q ) P;
-- SelectCountInt_p4
select 'SelectCountInt_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4 f1 from tversion union
select count(tsint.csint) from tsint
) Q
group by
f1
) Q ) P;
-- SelectMaxInt_p3
select 'SelectMaxInt_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10 f1 from tversion union
select max( vsint.csint ) from vsint
) Q
group by
f1
) Q ) P;
-- SelectMaxInt_p4
select 'SelectMaxInt_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10 f1 from tversion union
select max( tsint.csint ) from tsint
) Q
group by
f1
) Q ) P;
-- SelectMinInt_p3
select 'SelectMinInt_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select -1 f1 from tversion union
select min( vsint.csint ) from vsint
) Q
group by
f1
) Q ) P;
-- SelectMinInt_p4
select 'SelectMinInt_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select -1 f1 from tversion union
select min( tsint.csint ) from tsint
) Q
group by
f1
) Q ) P;
-- SelectStanDevPopInt_p3
select 'SelectStanDevPopInt_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.38748 f1 from tversion union
select stddev_pop( vsint.csint ) from vsint
) Q
group by
f1
) Q ) P;
-- SelectStanDevPopInt_p4
select 'SelectStanDevPopInt_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.38748 f1 from tversion union
select stddev_pop( tsint.csint ) from tsint
) Q
group by
f1
) Q ) P;
-- SelectSumInt_p3
select 'SelectSumInt_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10 f1 from tversion union
select sum( vsint.csint ) from vsint
) Q
group by
f1
) Q ) P;
-- SelectSumInt_p4
select 'SelectSumInt_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10 f1 from tversion union
select sum( tsint.csint ) from tsint
) Q
group by
f1
) Q ) P;
-- CaseBasicSearchInteger_p3
select 'CaseBasicSearchInteger_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'test1' f2 from tversion union
select 2 f1, 'other' f2 from tversion union
select 3 f1, 'test1' f2 from tversion union
select 4 f1, 'test1' f2 from tversion union
select vsint.rnum,case when vsint.csint in ( -1,10,1 )  then 'test1' else 'other' end from vsint
) Q
group by
f1,f2
) Q ) P;
-- CaseBasicSearchInteger_p4
select 'CaseBasicSearchInteger_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'test1' f2 from tversion union
select 2 f1, 'other' f2 from tversion union
select 3 f1, 'test1' f2 from tversion union
select 4 f1, 'test1' f2 from tversion union
select tsint.rnum,case when tsint.csint in ( -1,10,1 )  then 'test1' else 'other' end from tsint
) Q
group by
f1,f2
) Q ) P;
-- SelectVarPopInt_p3
select 'SelectVarPopInt_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 19.25 f1 from tversion union
select var_pop( vsint.csint ) from vsint
) Q
group by
f1
) Q ) P;
-- SelectVarPopInt_p4
select 'SelectVarPopInt_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 19.25 f1 from tversion union
select var_pop( tsint.csint ) from tsint
) Q
group by
f1
) Q ) P;
-- SimpleCaseIntegerElseDefaultsNULL_p3
select 'SimpleCaseIntegerElseDefaultsNULL_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, 'test1' f2 from tversion union
select vsint.rnum,case when vsint.csint=10 then 'test1' when vsint.csint=-1 then 'test2' end from vsint
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseIntegerElseDefaultsNULL_p4
select 'SimpleCaseIntegerElseDefaultsNULL_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, 'test1' f2 from tversion union
select tsint.rnum,case when tsint.csint=10 then 'test1' when tsint.csint=-1 then 'test2' end from tsint
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseIntegerElseExplicitNULL_p3
select 'SimpleCaseIntegerElseExplicitNULL_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, 'test1' f2 from tversion union
select vsint.rnum,case when vsint.csint=10 then 'test1' when vsint.csint=-1 then 'test2' else null end from vsint
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseIntegerElseExplicitNULL_p4
select 'SimpleCaseIntegerElseExplicitNULL_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, 'test1' f2 from tversion union
select tsint.rnum,case when tsint.csint=10 then 'test1' when tsint.csint=-1 then 'test2' else null end from tsint
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseInteger_p3
select 'SimpleCaseInteger_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'test1' f2 from tversion union
select vsint.rnum,case when vsint.csint=10 then 'test1' when vsint.csint=-1 then 'test2' else 'else' end from vsint
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseInteger_p4
select 'SimpleCaseInteger_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'test1' f2 from tversion union
select tsint.rnum,case when tsint.csint=10 then 'test1' when tsint.csint=-1 then 'test2' else 'else' end from tsint
) Q
group by
f1,f2
) Q ) P;
-- StanDevInt_p3
select 'StanDevInt_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5.066228 f1 from tversion union
select stddev( vsint.csint ) from vsint
) Q
group by
f1
) Q ) P;
-- StanDevInt_p4
select 'StanDevInt_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5.066228 f1 from tversion union
select stddev( tsint.csint ) from tsint
) Q
group by
f1
) Q ) P;
-- StanDevSampInt_p3
select 'StanDevSampInt_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5.066228 f1 from tversion union
select stddev_samp( vsint.csint ) from vsint
) Q
group by
f1
) Q ) P;
-- StanDevSampInt_p4
select 'StanDevSampInt_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5.066228 f1 from tversion union
select stddev_samp( tsint.csint ) from tsint
) Q
group by
f1
) Q ) P;

