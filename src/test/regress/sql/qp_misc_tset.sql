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
-- Name: tset1; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace:
--

CREATE TABLE tset1 (
    rnum integer NOT NULL,
    c1 integer,
    c2 character(3)
) DISTRIBUTED BY (rnum);



--
-- Name: tset2; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace:
--

CREATE TABLE tset2 (
    rnum integer NOT NULL,
    c1 integer,
    c2 character(3)
) DISTRIBUTED BY (rnum);



--
-- Name: tset3; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace:
--

CREATE TABLE tset3 (
    rnum integer NOT NULL,
    c1 integer,
    c2 character(3)
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
-- Data for Name: tset1; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tset1 (rnum, c1, c2) FROM stdin;
3	20	BBB
0	10	AAA
1	10	AAA
2	10	AAA
7	60	\N
4	30	CCC
5	40	DDD
6	50	\N
11	\N	\N
8	\N	AAA
9	\N	AAA
10	\N	\N
\.


--
-- Data for Name: tset2; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tset2 (rnum, c1, c2) FROM stdin;
3	50	EEE
0	10	AAA
1	10	AAA
2	40	DDD
4	60	FFF
\.


--
-- Data for Name: tset3; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tset3 (rnum, c1, c2) FROM stdin;
0	10	AAA
\.


--
-- Data for Name: tversion; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tversion (rnum, c1, cver, cnnull, ccnull) FROM stdin;
0	1	1.0   	\N	\N
\.

-- SubqueryColumnAlias_p1
select 'SubqueryColumnAlias_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 'AAA' f3 from tversion union
select 1 f1, 10 f2, 'AAA' f3 from tversion union
select 2 f1, 10 f2, 'AAA' f3 from tversion union
select 5 f1, 40 f2, 'DDD' f3 from tversion union
select 6 f1, 50 f2, null f3 from tversion union
select 7 f1, 60 f2, null f3 from tversion union
select rnum, c1, c2 from tset1 as t1 where exists ( select * from tset2 where c1=t1.c1 )
) Q
group by
f1,f2,f3
) Q ) P;
-- SumDistinct_p1
select 'SumDistinct_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 210 f1 from tversion union
select sum( distinct c1 ) from tset1
) Q
group by
f1
) Q ) P;
-- UnionAll_p1
select 'UnionAll_p1' test_name_part, case when d = 1 then 1 else 0 end pass_ind from (
select count(distinct d) d from (
select t,f1,f2,c,count(*) d from (
select T, f1,f2,count(*) c  from (
select 'X' T, 10 f1, 'AAA' f2 from tversion union all
select 'X', 10 f1, 'AAA' f2 from tversion union all
select 'X', 10 f1, 'AAA' f2 from tversion union all
select 'X', 10 f1, 'AAA' f2 from tversion union all
select 'X', 10 f1, 'AAA' f2 from tversion union all
select 'X', 20 f1, 'BBB' f2 from tversion union all
select 'X', 30 f1, 'CCC' f2 from tversion union all
select 'X', 40 f1, 'DDD' f2 from tversion union all
select 'X', 40 f1, 'DDD' f2 from tversion union all
select 'X', 50 f1, 'EEE' f2 from tversion union all
select 'X', 50 f1, null f2 from tversion union all
select 'X', 60 f1, 'FFF' f2 from tversion union all
select  'X', 60 f1, null f2 from tversion union all
select 'X',  null f1, 'AAA' f2 from tversion union all
select 'X',  null f1, 'AAA' f2 from tversion union all
select  'X', null f1, null f2 from tversion union all
select 'X',  null f1, null f2 from tversion union all
select 'A' , c1, c2 from tset1 union all select 'A', c1, c2 from tset2
) Q
group by
T, f1,f2
) P
group by t,f1,f2,c
) O
) N;
-- Union_p1
select 'Union_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 10 f1, 'AAA' f2 from tversion union
select 20 f1, 'BBB' f2 from tversion union
select 30 f1, 'CCC' f2 from tversion union
select 40 f1, 'DDD' f2 from tversion union
select 50 f1, 'EEE' f2 from tversion union
select 50 f1, null f2 from tversion union
select 60 f1, 'FFF' f2 from tversion union
select 60 f1, null f2 from tversion union
select null f1, 'AAA' f2 from tversion union
select null f1, null f2 from tversion union
select c1, c2 from tset1 union select c1, c2 from tset2
) Q
group by
f1,f2
) Q ) P;
-- WithClauseDerivedTable_p1
-- test exepected to fail until GPDB supports function
-- GPDB Limitation syntax not supported WITH clause
select 'WithClauseDerivedTable_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 'AAA' f3 from tversion union
select 1 f1, 10 f2, 'AAA' f3 from tversion union
select 2 f1, 10 f2, 'AAA' f3 from tversion union
select 3 f1, 20 f2, 'BBB' f3 from tversion union
select 4 f1, 30 f2, 'CCC' f3 from tversion union
select 5 f1, 40 f2, 'DDD' f3 from tversion union
select 6 f1, 50 f2, null f3 from tversion union
select 7 f1, 60 f2, null f3 from tversion union
select 8 f1, null f2, 'AAA' f3 from tversion union
select 9 f1, null f2, 'AAA' f3 from tversion union
select 10 f1, null f2, null f3 from tversion union
select 11 f1, null f2, null f3 from tversion union
select * from ( with t_cte as ( select tset1.rnum, tset1.c1, tset1.c2 from tset1 ) select * from t_cte ) tx
) Q
group by
f1,f2,f3
) Q ) P;
-- DistinctCore_p1
select 'DistinctCore_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 10 f1, 'AAA' f2 from tversion union
select 20 f1, 'BBB' f2 from tversion union
select 30 f1, 'CCC' f2 from tversion union
select 40 f1, 'DDD' f2 from tversion union
select 50 f1, null f2 from tversion union
select 60 f1, null f2 from tversion union
select null f1, 'AAA' f2 from tversion union
select null f1, null f2 from tversion union
select distinct c1, c2 from tset1
) Q
group by
f1,f2
) Q ) P;
-- ExceptAll_p1
select 'ExceptAll_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 10 f1, 'AAA' f2 from tversion union
select 20 f1, 'BBB' f2 from tversion union
select 30 f1, 'CCC' f2 from tversion union
select 50 f1, null f2 from tversion union
select 60 f1, null f2 from tversion union
select null f1, 'AAA' f2 from tversion union
select null f1, 'AAA' f2 from tversion union
select null f1, null f2 from tversion union
select null f1, null f2 from tversion union
select c1, c2 from tset1 except all select c1, c2 from tset2
) Q
group by
f1,f2
) Q ) P;
-- Except_p1
select 'Except_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 20 f1, 'BBB' f2 from tversion union
select 30 f1, 'CCC' f2 from tversion union
select 50 f1, null f2 from tversion union
select 60 f1, null f2 from tversion union
select null f1, 'AAA' f2 from tversion union
select null f1, null f2 from tversion union
select c1, c2 from tset1 except select c1, c2 from tset2
) Q
group by
f1,f2
) Q ) P;
-- ExpressionUsingAggregate_p1
select 'ExpressionUsingAggregate_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 51 f1 from tversion union
select (1 + max(c1) - min(c1) ) from tset1
) Q
group by
f1
) Q ) P;
-- GroupByAlias_p1
select 'GroupByAlias_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 50 f1, 'AAA' f2 from tversion union
select 100 f1, 'BBB' f2 from tversion union
select 150 f1, 'CCC' f2 from tversion union
select 200 f1, 'DDD' f2 from tversion union
select 250 f1, null f2 from tversion union
select 300 f1, null f2 from tversion union
select null f1, 'AAA' f2 from tversion union
select null f1, null f2 from tversion union
select c1*5 as calc, c2 from tset1 group by calc, c2
) Q
group by
f1,f2
) Q ) P;
-- GroupByExpr_p1
select 'GroupByExpr_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 50 f1, 'AAA' f2 from tversion union
select 100 f1, 'BBB' f2 from tversion union
select 150 f1, 'CCC' f2 from tversion union
select 200 f1, 'DDD' f2 from tversion union
select 250 f1, null f2 from tversion union
select 300 f1, null f2 from tversion union
select null f1, 'AAA' f2 from tversion union
select null f1, null f2 from tversion union
select c1*5, c2 from tset1 group by c1*5, c2
) Q
group by
f1,f2
) Q ) P;
-- GroupByHaving_p1
select 'GroupByHaving_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 10 f1, 3 f2 from tversion union
select null f1, 4 f2 from tversion union
select c1, count(*) from tset1 group by c1 having count(*) > 2
) Q
group by
f1,f2
) Q ) P;
-- GroupByLiteral_p1
select 'GroupByLiteral_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10 f1 from tversion union
select 10 f1 from tversion union
select 10 f1 from tversion union
select 10 f1 from tversion union
select 10 f1 from tversion union
select 10 f1 from tversion union
select 10 f1 from tversion union
select 10 from tset1 group by tset1.c1
) Q
group by
f1
) Q ) P;
select 'GroupByMany_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 10 f1, 'AAA' f2 from tversion union
select 20 f1, 'BBB' f2 from tversion union
select 30 f1, 'CCC' f2 from tversion union
select 40 f1, 'DDD' f2 from tversion union
select 50 f1, null f2 from tversion union
select 60 f1, null f2 from tversion union
select null f1, 'AAA' f2 from tversion union
select null f1, null f2 from tversion union
select c1, c2 from tset1 group by c1, c2
) Q
group by
f1,f2
) Q ) P;
-- GroupByMultiply_p1
select 'GroupByMultiply_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 50 f1 from tversion union
select 100 f1 from tversion union
select 150 f1 from tversion union
select 200 f1 from tversion union
select 250 f1 from tversion union
select 300 f1 from tversion union
select null f1 from tversion union
select c1 * 5 from tset1 group by c1
) Q
group by
f1
) Q ) P;
-- GroupByOrdinal_p1
select 'GroupByOrdinal_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 50 f1, 'AAA' f2 from tversion union
select 100 f1, 'BBB' f2 from tversion union
select 150 f1, 'CCC' f2 from tversion union
select 200 f1, 'DDD' f2 from tversion union
select 250 f1, null f2 from tversion union
select 300 f1, null f2 from tversion union
select null f1, 'AAA' f2 from tversion union
select null f1, null f2 from tversion union
select c1*5, c2 from tset1 group by 1,2
) Q
group by
f1,f2
) Q ) P;
-- GroupBy_p1
select 'GroupBy_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'AAA' f1 from tversion union
select 'BBB' f1 from tversion union
select 'CCC' f1 from tversion union
select 'DDD' f1 from tversion union
select null f1 from tversion union
select c2 from tset1 group by c2
) Q
group by
f1
) Q ) P;
-- Having_p1
select 'Having_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 8 f1 from tversion union
select count(c1) from tset1 having count(*) > 2
) Q
group by
f1
) Q ) P;
-- IntersectAll_p1
select 'IntersectAll_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 10 f1, 'AAA' f2 from tversion union
select 10 f1, 'AAA' f2 from tversion union
select 40 f1, 'DDD' f2 from tversion union
select c1, c2 from tset1 intersect all select c1, c2 from tset2
) Q
group by
f1,f2
) Q ) P;
-- Intersect_p1
select 'Intersect_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 10 f1, 'AAA' f2 from tversion union
select 40 f1, 'DDD' f2 from tversion union
select c1, c2 from tset1 intersect select c1, c2 from tset2
) Q
group by
f1,f2
) Q ) P;
-- JoinCoreNatural_p1
select 'JoinCoreNatural_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 0 f2 from tversion union
select 1 f1, 1 f2 from tversion union
select tset1.rnum, tset2.rnum as rnumt2 from tset1 natural join tset2
) Q
group by
f1,f2
) Q ) P;
-- MultipleSumDistinct_p1
select 'MultipleSumDistinct_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 210 f1, 4 f2 from tversion union
select sum( distinct c1 ), count( distinct c2 ) from tset1
) Q
group by
f1,f2
) Q ) P;
-- OperatorAnd_p1
select 'OperatorAnd_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 10 f1, 'AAA' f2 from tversion union
select 10 f1, 'AAA' f2 from tversion union
select 10 f1, 'AAA' f2 from tversion union
select tset1.c1, tset1.c2  from tset1 where c1=10 and c2='AAA'
) Q
group by
f1,f2
) Q ) P;
-- OperatorOr_p1
select 'OperatorOr_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 30 f1, 'CCC' f2 from tversion union
select 40 f1, 'DDD' f2 from tversion union
select tset1.c1, tset1.c2  from tset1 where c1=30 or c2='DDD'
) Q
group by
f1,f2
) Q ) P;
-- OrderByOrdinal_p1
select 'OrderByOrdinal_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 'AAA' f3 from tversion union
select 1 f1, 10 f2, 'AAA' f3 from tversion union
select 2 f1, 10 f2, 'AAA' f3 from tversion union
select 3 f1, 20 f2, 'BBB' f3 from tversion union
select 4 f1, 30 f2, 'CCC' f3 from tversion union
select 5 f1, 40 f2, 'DDD' f3 from tversion union
select 6 f1, 50 f2, null f3 from tversion union
select 7 f1, 60 f2, null f3 from tversion union
select 8 f1, null f2, 'AAA' f3 from tversion union
select 9 f1, null f2, 'AAA' f3 from tversion union
select 10 f1, null f2, null f3 from tversion union
select 11 f1, null f2, null f3 from tversion union
select rnum, c1, c2 from tset1 order by 1,2
) Q
group by
f1,f2,f3
) Q ) P;
-- RowValueConstructor_p1
select 'RowValueConstructor_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 'AAA' f3 from tversion union
select 1 f1, 10 f2, 'AAA' f3 from tversion union
select 2 f1, 10 f2, 'AAA' f3 from tversion union
select 5 f1, 40 f2, 'DDD' f3 from tversion union
select * from tset1 where (c1,c2) in (select c1,c2 from tset2)
) Q
group by
f1,f2,f3
) Q ) P;
-- SetPrecedenceNoBrackets_p1
select 'SetPrecedenceNoBrackets_p1' test_name_part, case when d = 1 then 1 else 0 end pass_ind from (
select count(distinct d) d from (
select t,f1,c,count(*) d from (
select t, f1, count(*) c  from (
select 'X' T, 10 f1 from tversion union all
select 'X' T, 10 f1 from tversion union all
select 'X' T,40 f1 from tversion union all
select 'X' T,50 f1 from tversion union all
select 'X' T,60 f1 from tversion union all
select 'A', c1 from tset1 intersect select 'A', c1 from tset2 union all select 'A', c1 from tset3
) Q
group by
t, f1
) P
group by t, f1, c
) O
) N;
-- SetPrecedenceUnionFirst_p1
select 'SetPrecedenceUnionFirst_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10 f1 from tversion union
select 40 f1 from tversion union
select 50 f1 from tversion union
select 60 f1 from tversion union
select c1 from tset1 intersect (select c1 from tset2 union all select c1 from tset3)
) Q
group by
f1
) Q ) P;

