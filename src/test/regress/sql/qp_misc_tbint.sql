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
-- Name: tbint; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace:
--

CREATE TABLE tbint (
    rnum integer NOT NULL,
    cbint bigint
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
-- Name: vbint; Type: VIEW; Schema: public; Owner: gpadmin
--

CREATE VIEW vbint AS
    SELECT tbint.rnum, tbint.cbint FROM tbint;

--
-- Data for Name: tbint; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tbint (rnum, cbint) FROM stdin;
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

-- CaseComparisonsInteger_p5
select 'CaseComparisonsInteger_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'lt' f2 from tversion union
select 2 f1, 'in' f2 from tversion union
select 3 f1, '=' f2 from tversion union
select 4 f1, 'gt' f2 from tversion union
select vbint.rnum,case  when vbint.cbint =  1  then '=' when vbint.cbint >  9  then 'gt' when vbint.cbint < 0 then 'lt' when vbint.cbint in  (0,11)  then 'in' when vbint.cbint between 6 and 8  then 'between'  else 'other' end from vbint
) Q
group by
f1,f2
) Q ) P;
-- CaseComparisonsInteger_p6
select 'CaseComparisonsInteger_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'lt' f2 from tversion union
select 2 f1, 'in' f2 from tversion union
select 3 f1, '=' f2 from tversion union
select 4 f1, 'gt' f2 from tversion union
select tbint.rnum,case  when tbint.cbint =  1  then '=' when tbint.cbint >  9  then 'gt' when tbint.cbint < 0 then 'lt' when tbint.cbint in  (0,11)  then 'in' when tbint.cbint between 6 and 8  then 'between'  else 'other' end from tbint
) Q
group by
f1,f2
) Q ) P;
-- VarInt_p5
select 'VarInt_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 25.66667 f1 from tversion union
select variance( vbint.cbint ) from vbint
) Q
group by
f1
) Q ) P;
-- VarInt_p6
select 'VarInt_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 25.66667 f1 from tversion union
select variance( tbint.cbint ) from tbint
) Q
group by
f1
) Q ) P;
-- VarSampInt_p5
select 'VarSampInt_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 25.66667 f1 from tversion union
select var_samp( vbint.cbint ) from vbint
) Q
group by
f1
) Q ) P;

-- VarSampInt_p6
select 'VarSampInt_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 25.66667 f1 from tversion union
select var_samp( tbint.cbint ) from tbint
) Q
group by
f1
) Q ) P;
-- CaseNestedInteger_p5
select 'CaseNestedInteger_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'nested else' f2 from tversion union
select 3 f1, 'nested else' f2 from tversion union
select 4 f1, 'nested inner' f2 from tversion union
select vbint.rnum,case  when vbint.cbint > -1  then case  when vbint.cbint > 1 then  'nested inner' else 'nested else' end else 'else'  end from vbint
) Q
group by
f1,f2
) Q ) P;
-- CaseNestedInteger_p6
select 'CaseNestedInteger_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'nested else' f2 from tversion union
select 3 f1, 'nested else' f2 from tversion union
select 4 f1, 'nested inner' f2 from tversion union
select tbint.rnum,case  when tbint.cbint > -1  then case  when tbint.cbint > 1 then  'nested inner' else 'nested else' end else 'else'  end from tbint
) Q
group by
f1,f2
) Q ) P;
-- CaseSubQueryInteger_p5
select 'CaseSubQueryInteger_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'true' f2 from tversion union
select vbint.rnum,case  when vbint.cbint= (select max( vbint.cbint) from vbint)    then 'true' else 'else' 	end from vbint
) Q
group by
f1,f2
) Q ) P;
-- CaseSubQueryInteger_p6
select 'CaseSubQueryInteger_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'true' f2 from tversion union
select tbint.rnum,case  when tbint.cbint= (select max( tbint.cbint) from tbint)    then 'true' else 'else' 	end from tbint
) Q
group by
f1,f2
) Q ) P;
-- CastBigintToBigint_p1
select 'CastBigintToBigint_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, cast(vbint.cbint as bigint) from vbint
) Q
group by
f1,f2
) Q ) P;
-- CastBigintToBigint_p2
select 'CastBigintToBigint_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, cast(tbint.cbint as bigint) from tbint
) Q
group by
f1,f2
) Q ) P;
-- CastBigintToChar_p1
select 'CastBigintToChar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1' f2 from tversion union
select 2 f1, '0 ' f2 from tversion union
select 3 f1, '1 ' f2 from tversion union
select 4 f1, '10' f2 from tversion union
select rnum, cast(vbint.cbint as char(2)) from vbint
) Q
group by
f1,f2
) Q ) P;
-- CastBigintToChar_p2
select 'CastBigintToChar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1' f2 from tversion union
select 2 f1, '0 ' f2 from tversion union
select 3 f1, '1 ' f2 from tversion union
select 4 f1, '10' f2 from tversion union
select rnum, cast(tbint.cbint as char(2)) from tbint
) Q
group by
f1,f2
) Q ) P;
-- CastBigintToDecimal_p1
select 'CastBigintToDecimal_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, cast(vbint.cbint as decimal(10,0)) from vbint
) Q
group by
f1,f2
) Q ) P;
-- CastBigintToDecimal_p2
select 'CastBigintToDecimal_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, cast(tbint.cbint as decimal(10,0)) from tbint
) Q
group by
f1,f2
) Q ) P;
-- CastBigintToDouble_p1
select 'CastBigintToDouble_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, cast(vbint.cbint as double precision) from vbint
) Q
group by
f1,f2
) Q ) P;
-- CastBigintToDouble_p2
select 'CastBigintToDouble_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, cast(tbint.cbint as double precision) from tbint
) Q
group by
f1,f2
) Q ) P;
-- CastBigintToFloat_p1
select 'CastBigintToFloat_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, cast(vbint.cbint as float) from vbint
) Q
group by
f1,f2
) Q ) P;
-- CastBigintToFloat_p2
select 'CastBigintToFloat_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, cast(tbint.cbint as float) from tbint
) Q
group by
f1,f2
) Q ) P;
-- CastBigintToInteger_p1
select 'CastBigintToInteger_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, cast(vbint.cbint as integer) from vbint
) Q
group by
f1,f2
) Q ) P;
-- CastBigintToInteger_p2
select 'CastBigintToInteger_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, cast(tbint.cbint as integer) from tbint
) Q
group by
f1,f2
) Q ) P;
-- CastBigintToSmallint_p1
select 'CastBigintToSmallint_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, cast(vbint.cbint as smallint) from vbint
) Q
group by
f1,f2
) Q ) P;
-- AbsCoreInteger_p5
select 'AbsCoreInteger_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select vbint.rnum, abs( vbint.cbint ) from vbint
) Q
group by
f1,f2
) Q ) P;
-- CastBigintToSmallint_p2
select 'CastBigintToSmallint_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, cast(tbint.cbint as smallint) from tbint
) Q
group by
f1,f2
) Q ) P;
-- CastBigintToVarchar_p1
select 'CastBigintToVarchar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1' f2 from tversion union
select 2 f1, '0' f2 from tversion union
select 3 f1, '1' f2 from tversion union
select 4 f1, '10' f2 from tversion union
select rnum, cast(vbint.cbint as varchar(2)) from vbint
) Q
group by
f1,f2
) Q ) P;
-- CastBigintToVarchar_p2
select 'CastBigintToVarchar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1' f2 from tversion union
select 2 f1, '0' f2 from tversion union
select 3 f1, '1' f2 from tversion union
select 4 f1, '10' f2 from tversion union
select rnum, cast(tbint.cbint as varchar(2)) from tbint
) Q
group by
f1,f2
) Q ) P;
-- AbsCoreInteger_p6
select 'AbsCoreInteger_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select tbint.rnum, abs( tbint.cbint ) from tbint
) Q
group by
f1,f2
) Q ) P;
-- CeilCoreIntegers_p5
select 'CeilCoreIntegers_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select vbint.rnum, ceil( vbint.cbint ) from vbint
) Q
group by
f1,f2
) Q ) P;
-- CeilCoreIntegers_p6
select 'CeilCoreIntegers_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select tbint.rnum, ceil( tbint.cbint ) from tbint
) Q
group by
f1,f2
) Q ) P;
-- DistinctAggregateInCase_p15
select 'DistinctAggregateInCase_p15' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'test1' f1 from tversion union
select case when min(distinct(vbint.cbint))=-1 then 'test1' else 'else' end from vbint
) Q
group by
f1
) Q ) P;
-- DistinctAggregateInCase_p16
select 'DistinctAggregateInCase_p16' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'test1' f1 from tversion union
select case when min(distinct(tbint.cbint))=-1 then 'test1' else 'else' end from tbint
) Q
group by
f1
) Q ) P;
-- ExpCoreIntegers_p5
select 'ExpCoreIntegers_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, .367879441 f2 from tversion union
select 2 f1, 1 f2 from tversion union
select 3 f1, 2.71828183 f2 from tversion union
select 4 f1, 22026.4658 f2 from tversion union
select vbint.rnum, exp( vbint.cbint ) from vbint
) Q
group by
f1,f2
) Q ) P;
-- ExpCoreIntegers_p6
select 'ExpCoreIntegers_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, .367879441 f2 from tversion union
select 2 f1, 1 f2 from tversion union
select 3 f1, 2.71828183 f2 from tversion union
select 4 f1, 22026.4658 f2 from tversion union
select tbint.rnum, exp( tbint.cbint ) from tbint
) Q
group by
f1,f2
) Q ) P;
-- FloorCoreIntegers_p5
select 'FloorCoreIntegers_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, floor( vbint.cbint ) from vbint
) Q
group by
f1,f2
) Q ) P;
-- FloorCoreIntegers_p6
select 'FloorCoreIntegers_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 10 f2 from tversion union
select rnum, floor( tbint.cbint ) from tbint
) Q
group by
f1,f2
) Q ) P;
-- IntegerOpAdd_p5
select 'IntegerOpAdd_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 2 f2 from tversion union
select 3 f1, 3 f2 from tversion union
select 4 f1, 12 f2 from tversion union
select vbint.rnum,vbint.cbint + 2 from vbint
) Q
group by
f1,f2
) Q ) P;
-- IntegerOpAdd_p6
select 'IntegerOpAdd_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 2 f2 from tversion union
select 3 f1, 3 f2 from tversion union
select 4 f1, 12 f2 from tversion union
select tbint.rnum,tbint.cbint + 2 from tbint
) Q
group by
f1,f2
) Q ) P;
-- IntegerOpDiv_p5
select 'IntegerOpDiv_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 0 f2 from tversion union
select 4 f1, 5 f2 from tversion union
select vbint.rnum,vbint.cbint / 2 from vbint
) Q
group by
f1,f2
) Q ) P;
-- IntegerOpDiv_p6
select 'IntegerOpDiv_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 0 f2 from tversion union
select 4 f1, 5 f2 from tversion union
select tbint.rnum,tbint.cbint / 2 from tbint
) Q
group by
f1,f2
) Q ) P;
-- IntegerOpMul_p5
select 'IntegerOpMul_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -2 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 2 f2 from tversion union
select 4 f1, 20 f2 from tversion union
select vbint.rnum,vbint.cbint * 2 from vbint
) Q
group by
f1,f2
) Q ) P;
-- IntegerOpMul_p6
select 'IntegerOpMul_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -2 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 2 f2 from tversion union
select 4 f1, 20 f2 from tversion union
select tbint.rnum,tbint.cbint * 2 from tbint
) Q
group by
f1,f2
) Q ) P;
-- IntegerOpSub_p5
select 'IntegerOpSub_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -3 f2 from tversion union
select 2 f1, -2 f2 from tversion union
select 3 f1, -1 f2 from tversion union
select 4 f1, 8 f2 from tversion union
select vbint.rnum,vbint.cbint - 2 from vbint
) Q
group by
f1,f2
) Q ) P;
-- IntegerOpSub_p6
select 'IntegerOpSub_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -3 f2 from tversion union
select 2 f1, -2 f2 from tversion union
select 3 f1, -1 f2 from tversion union
select 4 f1, 8 f2 from tversion union
select tbint.rnum,tbint.cbint - 2 from tbint
) Q
group by
f1,f2
) Q ) P;
-- ModCore2Integers_p5
select 'ModCore2Integers_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 3 f1, 0 f2 from tversion union
select 4 f1, 3 f2 from tversion union
select vbint.rnum, mod( 3,vbint.cbint ) from vbint where vbint.rnum <> 2
) Q
group by
f1,f2
) Q ) P;
-- ModCore2Integers_p6
select 'ModCore2Integers_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 3 f1, 0 f2 from tversion union
select 4 f1, 3 f2 from tversion union
select tbint.rnum, mod( 3,tbint.cbint ) from tbint where tbint.rnum <> 2
) Q
group by
f1,f2
) Q ) P;
-- ModCoreIntegers_p5
select 'ModCoreIntegers_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 1 f2 from tversion union
select rnum, mod( vbint.cbint, 3 ) from vbint
) Q
group by
f1,f2
) Q ) P;
-- ModCoreIntegers_p6
select 'ModCoreIntegers_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 1 f2 from tversion union
select rnum, mod( tbint.cbint, 3 ) from tbint
) Q
group by
f1,f2
) Q ) P;
-- AvgIntTruncates_p5
select 'AvgIntTruncates_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 2 f1 from tversion union
select avg(vbint.cbint) from vbint
) Q
group by
f1
) Q ) P;
-- AvgIntTruncates_p6
select 'AvgIntTruncates_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 2 f1 from tversion union
select avg(tbint.cbint) from tbint
) Q
group by
f1
) Q ) P;
-- AvgInt_p5
select 'AvgInt_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 2.500000000000000e+000 f1 from tversion union
select avg(vbint.cbint) from vbint
) Q
group by
f1
) Q ) P;
-- AvgInt_p6
select 'AvgInt_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 2.500000000000000e+000 f1 from tversion union
select avg(tbint.cbint) from tbint
) Q
group by
f1
) Q ) P;
-- PowerCoreIntegers_p5
select 'PowerCoreIntegers_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 100 f2 from tversion union
select vbint.rnum, power( vbint.cbint,2 ) from vbint
) Q
group by
f1,f2
) Q ) P;
-- PowerCoreIntegers_p6
select 'PowerCoreIntegers_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 100 f2 from tversion union
select tbint.rnum, power( tbint.cbint,2 ) from tbint
) Q
group by
f1,f2
) Q ) P;
-- SelectCountInt_p5
select 'SelectCountInt_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4 f1 from tversion union
select count(vbint.cbint) from vbint
) Q
group by
f1
) Q ) P;
-- SelectCountInt_p6
select 'SelectCountInt_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4 f1 from tversion union
select count(tbint.cbint) from tbint
) Q
group by
f1
) Q ) P;
-- SelectMaxInt_p5
select 'SelectMaxInt_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10 f1 from tversion union
select max( vbint.cbint ) from vbint
) Q
group by
f1
) Q ) P;
-- SelectMaxInt_p6
select 'SelectMaxInt_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10 f1 from tversion union
select max( tbint.cbint ) from tbint
) Q
group by
f1
) Q ) P;
-- SelectMinInt_p5
select 'SelectMinInt_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select -1 f1 from tversion union
select min( vbint.cbint ) from vbint
) Q
group by
f1
) Q ) P;
-- SelectMinInt_p6
select 'SelectMinInt_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select -1 f1 from tversion union
select min( tbint.cbint ) from tbint
) Q
group by
f1
) Q ) P;
-- SelectStanDevPopInt_p5
select 'SelectStanDevPopInt_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.38748 f1 from tversion union
select stddev_pop( vbint.cbint ) from vbint
) Q
group by
f1
) Q ) P;
-- SelectStanDevPopInt_p6
select 'SelectStanDevPopInt_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.38748 f1 from tversion union
select stddev_pop( tbint.cbint ) from tbint
) Q
group by
f1
) Q ) P;
-- SelectSumInt_p5
select 'SelectSumInt_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10 f1 from tversion union
select sum( vbint.cbint ) from vbint
) Q
group by
f1
) Q ) P;
-- SelectSumInt_p6
select 'SelectSumInt_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10 f1 from tversion union
select sum( tbint.cbint ) from tbint
) Q
group by
f1
) Q ) P;
-- CaseBasicSearchInteger_p5
select 'CaseBasicSearchInteger_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'test1' f2 from tversion union
select 2 f1, 'other' f2 from tversion union
select 3 f1, 'test1' f2 from tversion union
select 4 f1, 'test1' f2 from tversion union
select vbint.rnum,case when vbint.cbint in ( -1,10,1 )  then 'test1' else 'other' end from vbint
) Q
group by
f1,f2
) Q ) P;
-- CaseBasicSearchInteger_p6
select 'CaseBasicSearchInteger_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'test1' f2 from tversion union
select 2 f1, 'other' f2 from tversion union
select 3 f1, 'test1' f2 from tversion union
select 4 f1, 'test1' f2 from tversion union
select tbint.rnum,case when tbint.cbint in ( -1,10,1 )  then 'test1' else 'other' end from tbint
) Q
group by
f1,f2
) Q ) P;
-- SelectVarPopInt_p5
select 'SelectVarPopInt_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 19.25 f1 from tversion union
select var_pop( vbint.cbint ) from vbint
) Q
group by
f1
) Q ) P;
-- SelectVarPopInt_p6
select 'SelectVarPopInt_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 19.25 f1 from tversion union
select var_pop( tbint.cbint ) from tbint
) Q
group by
f1
) Q ) P;
-- SimpleCaseIntegerElseDefaultsNULL_p5
select 'SimpleCaseIntegerElseDefaultsNULL_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, 'test1' f2 from tversion union
select vbint.rnum,case when vbint.cbint=10 then 'test1' when vbint.cbint=-1 then 'test2' end from vbint
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseIntegerElseDefaultsNULL_p6
select 'SimpleCaseIntegerElseDefaultsNULL_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, 'test1' f2 from tversion union
select tbint.rnum,case when tbint.cbint=10 then 'test1' when tbint.cbint=-1 then 'test2' end from tbint
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseIntegerElseExplicitNULL_p5
select 'SimpleCaseIntegerElseExplicitNULL_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, 'test1' f2 from tversion union
select vbint.rnum,case when vbint.cbint=10 then 'test1' when vbint.cbint=-1 then 'test2' else null end from vbint
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseIntegerElseExplicitNULL_p6
select 'SimpleCaseIntegerElseExplicitNULL_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, 'test1' f2 from tversion union
select tbint.rnum,case when tbint.cbint=10 then 'test1' when tbint.cbint=-1 then 'test2' else null end from tbint
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseInteger_p5
select 'SimpleCaseInteger_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'test1' f2 from tversion union
select vbint.rnum,case when vbint.cbint=10 then 'test1' when vbint.cbint=-1 then 'test2' else 'else' end from vbint
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseInteger_p6
select 'SimpleCaseInteger_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'test2' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'test1' f2 from tversion union
select tbint.rnum,case when tbint.cbint=10 then 'test1' when tbint.cbint=-1 then 'test2' else 'else' end from tbint
) Q
group by
f1,f2
) Q ) P;
-- StanDevInt_p5
select 'StanDevInt_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5.066228 f1 from tversion union
select stddev( vbint.cbint ) from vbint
) Q
group by
f1
) Q ) P;
-- StanDevInt_p6
select 'StanDevInt_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5.066228 f1 from tversion union
select stddev( tbint.cbint ) from tbint
) Q
group by
f1
) Q ) P;
-- StanDevSampInt_p5
select 'StanDevSampInt_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5.066228 f1 from tversion union
select stddev_samp( vbint.cbint ) from vbint
) Q
group by
f1
) Q ) P;
-- StanDevSampInt_p6
select 'StanDevSampInt_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5.066228 f1 from tversion union
select stddev_samp( tbint.cbint ) from tbint
) Q
group by
f1
) Q ) P;
