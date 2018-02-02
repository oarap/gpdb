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
-- Name: tolap; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace:
--

CREATE TABLE tolap (
    rnum integer NOT NULL,
    c1 character(3),
    c2 character(2),
    c3 integer,
    c4 integer
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
-- Data for Name: tolap; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tolap (rnum, c1, c2, c3, c4) FROM stdin;
3	BBB	BB	20	5
0	AAA	AA	10	3
1	AAA	AA	15	2
2	AAA	AB	25	1
7	\N	\N	\N	\N
4	CCC	CC	30	2
5	DDD	DD	40	1
6	\N	\N	50	6
\.


--
-- Data for Name: tversion; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tversion (rnum, c1, cver, cnnull, ccnull) FROM stdin;
0	1	1.0   	\N	\N
\.

-- OlapCoreAvgMultiplePartitions_p1
select 'OlapCoreAvgMultiplePartitions_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5,f6,f7, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4,  00000000000000000000000000000027.142857 f5,  00000000000000000000000000000016.666667 f6,  00000000000000000000000000000012.500000 f7 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4,  00000000000000000000000000000027.142857 f5,  00000000000000000000000000000016.666667 f6,  00000000000000000000000000000012.500000 f7 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4,  00000000000000000000000000000027.142857 f5,  00000000000000000000000000000016.666667 f6,  00000000000000000000000000000025.000000 f7 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4,  00000000000000000000000000000027.142857 f5,  00000000000000000000000000000020.000000 f6,  00000000000000000000000000000020.000000 f7 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4,  00000000000000000000000000000027.142857 f5,  00000000000000000000000000000030.000000 f6,  00000000000000000000000000000030.000000 f7 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4,  00000000000000000000000000000027.142857 f5,  00000000000000000000000000000040.000000 f6,  00000000000000000000000000000040.000000 f7 from tversion union
select 6 f1, null f2, null f3, 50 f4,  00000000000000000000000000000027.142857 f5,  00000000000000000000000000000050.000000 f6,  00000000000000000000000000000050.000000 f7 from tversion union
select 7 f1, null f2, null f3, null f4,  00000000000000000000000000000027.142857 f5,  00000000000000000000000000000050.000000 f6,  00000000000000000000000000000050.000000 f7 from tversion union
select rnum, c1, c2, c3, avg(c3) over (), avg( c3 ) over(partition by c1), avg( c3 ) over(partition by c1,c2) from tolap
) Q
group by
f1,f2,f3,f4,f5,f6,f7
) Q ) P;
-- OlapCoreAvgNoWindowFrame_p1
select 'OlapCoreAvgNoWindowFrame_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 1.666666666666667e+001 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 1.666666666666667e+001 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 1.666666666666667e+001 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 2.000000000000000e+001 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 3.000000000000000e+001 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 4.000000000000000e+001 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 5.000000000000000e+001 f5 from tversion union
select 7 f1, null f2, null f3, null f4, 5.000000000000000e+001 f5 from tversion union
select rnum, c1, c2, c3, avg( c3 ) over(partition by c1) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreAvgRowsBetween_p1
-- test expected to fail until GPDB supports function
-- GPDB Limitation: ERROR: window specifications with a framing clause must have an ORDER BY clause
select 'OlapCoreAvgRowsBetween_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 1.666666666666667e+001 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 1.666666666666667e+001 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 1.666666666666667e+001 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 2.000000000000000e+001 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 3.000000000000000e+001 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 4.000000000000000e+001 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 5.000000000000000e+001 f5 from tversion union
select 7 f1, null f2, null f3, null f4, 5.000000000000000e+001 f5 from tversion union
select rnum, c1, c2, c3, avg( c3 ) over(partition by c1 rows between unbounded preceding and unbounded following) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreCountMultiplePartitions_p1
select 'OlapCoreCountMultiplePartitions_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5,f6,f7, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 7 f5, 3 f6, 2 f7 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 7 f5, 3 f6, 2 f7 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 7 f5, 3 f6, 1 f7 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 7 f5, 1 f6, 1 f7 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 7 f5, 1 f6, 1 f7 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 7 f5, 1 f6, 1 f7 from tversion union
select 6 f1, null f2, null f3, 50 f4, 7 f5, 1 f6, 1 f7 from tversion union
select 7 f1, null f2, null f3, null f4, 7 f5, 1 f6, 1 f7 from tversion union
select rnum, c1, c2, c3, count(c3) over (), count( c3 ) over(partition by c1), count( c3 ) over(partition by c1,c2) from tolap
) Q
group by
f1,f2,f3,f4,f5,f6,f7
) Q ) P;
-- OlapCoreCountNoWindowFrame_p1
select 'OlapCoreCountNoWindowFrame_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 3 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 3 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 3 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 1 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 1 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 1 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 1 f5 from tversion union
select 7 f1, null f2, null f3, null f4, 1 f5 from tversion union
select rnum, c1, c2, c3, count( c3 ) over(partition by c1) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreCountRowsBetween_p2
select 'OlapCoreCountRowsBetween_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 3 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 3 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 3 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 1 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 1 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 1 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 1 f5 from tversion union
select 7 f1, null f2, null f3, null f4, 1 f5 from tversion union
select rnum, c1, c2, c3, count( c3 ) over(partition by c1 rows between unbounded preceding and unbounded following) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreCountStar_p1
select 'OlapCoreCountStar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 3 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 3 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 3 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 1 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 1 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 1 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 2 f5 from tversion union
select 7 f1, null f2, null f3, null f4, 2 f5 from tversion union
select rnum, c1, c2, c3, count(*) over(partition by c1) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreCumedistNullOrdering_p1
-- test expected to fail until GPDB supports function
-- GPDB Limitation syntax not supported; NULLS LAST
select 'OlapCoreCumedistNullOrdering_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 1.000000000000000e+000 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 6.666666666666670e-001 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 3.333333333333330e-001 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 1.000000000000000e+000 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 1.000000000000000e+000 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 1.000000000000000e+000 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 5.000000000000000e-001 f5 from tversion union
select 7 f1, null f2, null f3, null f4, 1.000000000000000e+000 f5 from tversion union
select rnum, c1, c2, c3, cume_dist() over(partition by c1 order by c3 desc nulls last) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreCumedist_p1
select 'OlapCoreCumedist_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 1.000000000000000e+000 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 6.666666666666670e-001 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 3.333333333333330e-001 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 1.000000000000000e+000 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 1.000000000000000e+000 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 1.000000000000000e+000 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 5.000000000000000e-001 f5 from tversion union
select 7 f1, null f2, null f3, null f4, 1.000000000000000e+000 f5 from tversion union
select rnum, c1, c2, c3, cume_dist() over(partition by c1 order by c3 desc) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreDenseRankNullOrdering_p1
-- test expected to fail until GPDB supports function
-- GPDB Limitation syntax not supported; NULLS LAST
select 'OlapCoreDenseRankNullOrdering_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 3 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 2 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 1 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 1 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 1 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 1 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 1 f5 from tversion union
select 7 f1, null f2, null f3, null f4, 2 f5 from tversion union
select rnum, c1, c2, c3, dense_rank() over(partition by c1 order by c3 desc nulls last) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreDenseRank_p1
select 'OlapCoreDenseRank_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 3 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 2 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 1 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 1 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 1 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 1 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 2 f5 from tversion union
select 7 f1, null f2, null f3, null f4, 1 f5 from tversion union
select rnum, c1, c2, c3, dense_rank() over(partition by c1 order by c3 desc ) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreFirstValueNullOrdering_p1
-- test expected to fail until GPDB supports function
-- GPDB Limitation syntax not supported; NULLS LAST
select 'OlapCoreFirstValueNullOrdering_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 10 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 10 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 10 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 20 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 30 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 40 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 50 f5 from tversion union
select 7 f1, null f2, null f3, null f4, 50 f5 from tversion union
select rnum, c1, c2, c3, first_value( c3 ) over(partition by c1 order by c3 asc nulls last) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreFirstValueRowsBetween_p1
select 'OlapCoreFirstValueRowsBetween_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 10 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 10 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 10 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 20 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 30 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 40 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 50 f5 from tversion union
select 7 f1, null f2, null f3, null f4, 50 f5 from tversion union
select rnum, c1, c2, c3, first_value( c3 ) over(partition by c1 order by c3 rows between unbounded preceding and unbounded following) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreLastValueNoWindowFrame_p1
select 'OlapCoreLastValueNoWindowFrame_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 25 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 25 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 25 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 20 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 30 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 40 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, null f5 from tversion union
select 7 f1, null f2, null f3, null f4, null f5 from tversion union
select rnum, c1, c2, c3, last_value( c3 ) over( partition by c1 order by c3 ) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreLastValueNullOrdering_p1
-- test expected to fail until GPDB support function
-- GPDB Limitation syntax not supported; NULLS LAST
select 'OlapCoreLastValueNullOrdering_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 25 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 25 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 25 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 20 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 30 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 40 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, null f5 from tversion union
select 7 f1, null f2, null f3, null f4, null f5 from tversion union
select rnum, c1, c2, c3, last_value( c3 ) over(partition by c1 order by c3 asc nulls last) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreLastValueRowsBetween_p1
select 'OlapCoreLastValueRowsBetween_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 25 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 25 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 25 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 20 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 30 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 40 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, null f5 from tversion union
select 7 f1, null f2, null f3, null f4, null f5 from tversion union
select rnum, c1, c2, c3, last_value( c3 ) over(partition by c1 order by c3 rows between unbounded preceding and unbounded following) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreMax_p1
select 'OlapCoreMax_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 25 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 25 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 25 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 20 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 30 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 40 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 50 f5 from tversion union
select 7 f1, null f2, null f3, null f4, 50 f5 from tversion union
select rnum, c1, c2, c3, max( c3 ) over(partition by c1) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreMin_p1
select 'OlapCoreMin_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 10 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 10 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 10 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 20 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 30 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 40 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 50 f5 from tversion union
select 7 f1, null f2, null f3, null f4, 50 f5 from tversion union
select rnum, c1, c2, c3, min( c3 ) over(partition by c1) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreNtile_p1
select 'OlapCoreNtile_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select  00000000000000000000000000000000000000 f1, 'AAA' f2, 'AA' f3,  00000000000000000000000000000000000010 f4, 1.000000000000000e+000 f5 from tversion union
select  00000000000000000000000000000000000001 f1, 'AAA' f2, 'AA' f3,  00000000000000000000000000000000000015 f4, 1.000000000000000e+000 f5 from tversion union
select  00000000000000000000000000000000000002 f1, 'AAA' f2, 'AB' f3,  00000000000000000000000000000000000025 f4, 2.000000000000000e+000 f5 from tversion union
select  00000000000000000000000000000000000003 f1, 'BBB' f2, 'BB' f3,  00000000000000000000000000000000000020 f4, 2.000000000000000e+000 f5 from tversion union
select  00000000000000000000000000000000000004 f1, 'CCC' f2, 'CC' f3,  00000000000000000000000000000000000030 f4, 3.000000000000000e+000 f5 from tversion union
select  00000000000000000000000000000000000005 f1, 'DDD' f2, 'DD' f3,  00000000000000000000000000000000000040 f4, 3.000000000000000e+000 f5 from tversion union
select  00000000000000000000000000000000000006 f1, null f2, null f3,  00000000000000000000000000000000000050 f4, 4.000000000000000e+000 f5 from tversion union
select  00000000000000000000000000000000000007 f1, null f2, null f3, null f4, 4.000000000000000e+000 f5 from tversion union
select rnum, c1, c2, c3, ntile(4) over(order by c3) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreNullOrder_p1
-- test expected to fail until GPDB supports function
-- GPDB Limitation syntax not supported; NULLS FIRST
select 'OlapCoreNullOrder_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 50 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 50 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 50 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 20 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 30 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 40 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 50 f5 from tversion union
select 7 f1, null f2, null f3, null f4, 50 f5 from tversion union
select rnum, c1, c2, c3, sum( c3 ) over(partition by c1 order by c1 asc nulls first) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCorePercentRankNullOrdering_p1
-- test expected to fail until GPDB supports function
-- GPDB Limitation syntax not supported; NULLS LAST
select 'OlapCorePercentRankNullOrdering_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 1.000000000000000e+000 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 5.000000000000000e-001 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 0.000000000000000e+000 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 0.000000000000000e+000 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 0.000000000000000e+000 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 0.000000000000000e+000 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 0.000000000000000e+000 f5 from tversion union
select 7 f1, null f2, null f3, null f4, 1.000000000000000e+000 f5 from tversion union
select rnum, c1, c2, c3, percent_rank() over(partition by c1 order by c3 desc nulls last) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCorePercentRank_p1
select 'OlapCorePercentRank_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 1.000000000000000e+000 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 5.000000000000000e-001 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 0.000000000000000e+000 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 0.000000000000000e+000 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 0.000000000000000e+000 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 0.000000000000000e+000 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 0.000000000000000e+000 f5 from tversion union
select 7 f1, null f2, null f3, null f4, 1.000000000000000e+000 f5 from tversion union
select rnum, c1, c2, c3, percent_rank() over(partition by c1 order by c3 desc) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreRankMultiplePartitions_p1
select 'OlapCoreRankMultiplePartitions_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5,f6,f7, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 8 f5, 3 f6, 2 f7 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 7 f5, 2 f6, 1 f7 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 5 f5, 1 f6, 1 f7 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 6 f5, 1 f6, 1 f7 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 4 f5, 1 f6, 1 f7 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 3 f5, 1 f6, 1 f7 from tversion union
select 6 f1, null f2, null f3, 50 f4, 2 f5, 2 f6, 2 f7 from tversion union
select 7 f1, null f2, null f3, null f4, 1 f5, 1 f6, 1 f7 from tversion union
select rnum, c1, c2, c3, rank() over(order by c3 desc),rank() over(partition by c1 order by c3 desc),rank() over(partition by c1,c2 order by c3 desc) from tolap
) Q
group by
f1,f2,f3,f4,f5,f6,f7
) Q ) P;
-- OlapCoreRankNoWindowFrame_p1
select 'OlapCoreRankNoWindowFrame_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 2 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 1 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 1 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 1 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 1 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 1 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 2 f5 from tversion union
select 7 f1, null f2, null f3, null f4, 1 f5 from tversion union
select rnum, c1, c2, c3, rank() over(partition by c1,c2 order by c3 desc) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreRankNullOrdering_p1
-- test expected to fail until GPDB supports function
-- GPDB Limitation syntax not supported; NULLS LAST
select 'OlapCoreRankNullOrdering_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 2 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 1 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 1 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 1 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 1 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 1 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 1 f5 from tversion union
select 7 f1, null f2, null f3, null f4, 2 f5 from tversion union
select rnum, c1, c2, c3, rank() over(partition by c1,c2 order by c3 desc nulls last) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreRankOrderby100_p1
select 'OlapCoreRankOrderby100_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 1 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 1 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 1 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 1 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 1 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 1 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 1 f5 from tversion union
select 7 f1, null f2, null f3, null f4, 1 f5 from tversion union
select rnum, c1, c2, c3, rank( ) over(partition by c1 order by 100) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreRowNumberNullOrdering_p1
-- test expected to fail until GPDB supports function
-- GPDB Limitation: syntax not supported; NULLS LAST
select 'OlapCoreRowNumberNullOrdering_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 2 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 1 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 1 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 1 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 1 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 1 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 1 f5 from tversion union
select 7 f1, null f2, null f3, null f4, 2 f5 from tversion union
select rnum, c1, c2, c3, row_number() over(partition by c1,c2 order by c3 desc nulls last) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreRowNumber_p1
select 'OlapCoreRowNumber_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 2 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 1 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 1 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 1 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 1 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 1 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 2 f5 from tversion union
select 7 f1, null f2, null f3, null f4, 1 f5 from tversion union
select rnum, c1, c2, c3, row_number() over(partition by c1,c2 order by c3 desc) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreRunningSum_p1
select 'OlapCoreRunningSum_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4, count(*) c  from (
select 'AAA' f1, 'AA' f2,  00000000000000000000000000000000000025 f3,  00000000000000000000000000000000000025 f4 from tversion union
select 'AAA' f1, 'AB' f2,  00000000000000000000000000000000000025 f3,  00000000000000000000000000000000000050 f4 from tversion union
select 'BBB' f1, 'BB' f2,  00000000000000000000000000000000000020 f3,  00000000000000000000000000000000000020 f4 from tversion union
select 'CCC' f1, 'CC' f2,  00000000000000000000000000000000000030 f3,  00000000000000000000000000000000000030 f4 from tversion union
select 'DDD' f1, 'DD' f2,  00000000000000000000000000000000000040 f3,  00000000000000000000000000000000000040 f4 from tversion union
select null f1, null f2,  00000000000000000000000000000000000050 f3,  00000000000000000000000000000000000050 f4 from tversion union
select c1, c2, sum (c3), sum(sum(c3)) over(partition by c1 order by c1,c2 rows unbounded preceding) from tolap group by c1,c2
) Q
group by
f1,f2,f3,f4
) Q ) P;
-- OlapCoreStddevPop_p1
select 'OlapCoreStddevPop_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 6.236095644623235e+000 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 6.236095644623235e+000 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 6.236095644623235e+000 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 0.000000000000000e+000 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 0.000000000000000e+000 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 0.000000000000000e+000 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 0.000000000000000e+000 f5 from tversion union
select 7 f1, null f2, null f3, null f4, 0.000000000000000e+000 f5 from tversion union
select rnum, c1, c2, c3, stddev_pop( c3 ) over(partition by c1) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreStddevSamp_p1
select 'OlapCoreStddevSamp_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 7.637626158259730e+000 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 7.637626158259730e+000 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 7.637626158259730e+000 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, null f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, null f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, null f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, null f5 from tversion union
select 7 f1, null f2, null f3, null f4, null f5 from tversion union
select rnum, c1, c2, c3, stddev_samp( c3 ) over(partition by c1) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreStddev_p1
select 'OlapCoreStddev_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 7.637626158259730e+000 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 7.637626158259730e+000 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 7.637626158259730e+000 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, null f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, null f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, null f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, null f5 from tversion union
select 7 f1, null f2, null f3, null f4, null f5 from tversion union
select rnum, c1, c2, c3, stddev( c3 ) over(partition by c1) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreSumMultiplePartitions_p1
select 'OlapCoreSumMultiplePartitions_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5,f6,f7, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4,  00000000000000000000000000000000000190 f5,  00000000000000000000000000000000000050 f6,  00000000000000000000000000000000000025 f7 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4,  00000000000000000000000000000000000190 f5,  00000000000000000000000000000000000050 f6,  00000000000000000000000000000000000025 f7 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4,  00000000000000000000000000000000000190 f5,  00000000000000000000000000000000000050 f6,  00000000000000000000000000000000000025 f7 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4,  00000000000000000000000000000000000190 f5,  00000000000000000000000000000000000020 f6,  00000000000000000000000000000000000020 f7 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4,  00000000000000000000000000000000000190 f5,  00000000000000000000000000000000000030 f6,  00000000000000000000000000000000000030 f7 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4,  00000000000000000000000000000000000190 f5,  00000000000000000000000000000000000040 f6,  00000000000000000000000000000000000040 f7 from tversion union
select 6 f1, null f2, null f3, 50 f4,  00000000000000000000000000000000000190 f5,  00000000000000000000000000000000000050 f6,  00000000000000000000000000000000000050 f7 from tversion union
select 7 f1, null f2, null f3, null f4,  00000000000000000000000000000000000190 f5,  00000000000000000000000000000000000050 f6,  00000000000000000000000000000000000050 f7 from tversion union
select rnum, c1, c2, c3, sum(c3) over (), sum( c3 ) over(partition by c1), sum( c3 ) over(partition by c1,c2) from tolap
) Q
group by
f1,f2,f3,f4,f5,f6,f7
) Q ) P;
-- OlapCoreSumNullOrdering_p1
-- test expected to fail until GPDB supports function
-- GPDB Limitation syntax not supported; NULLS LAST
select 'OlapCoreSumNullOrdering_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 50 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 50 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 50 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 20 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 30 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 40 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 50 f5 from tversion union
select 7 f1, null f2, null f3, null f4, 50 f5 from tversion union
select rnum, c1, c2, c3, sum( c3 ) over(partition by c1 order by c1 asc nulls last) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreSumOfGroupedSums_p1
select 'OlapCoreSumOfGroupedSums_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4, count(*) c  from (
select 'AAA' f1, 'AA' f2,  00000000000000000000000000000000000025 f3,  00000000000000000000000000000000000050 f4 from tversion union
select 'AAA' f1, 'AB' f2,  00000000000000000000000000000000000025 f3,  00000000000000000000000000000000000050 f4 from tversion union
select 'BBB' f1, 'BB' f2,  00000000000000000000000000000000000020 f3,  00000000000000000000000000000000000020 f4 from tversion union
select 'CCC' f1, 'CC' f2,  00000000000000000000000000000000000030 f3,  00000000000000000000000000000000000030 f4 from tversion union
select 'DDD' f1, 'DD' f2,  00000000000000000000000000000000000040 f3,  00000000000000000000000000000000000040 f4 from tversion union
select null f1, null f2,  00000000000000000000000000000000000050 f3,  00000000000000000000000000000000000050 f4 from tversion union
select c1, c2, sum ( c3 ), sum(sum(c3)) over(partition by c1) from tolap group by c1,c2
) Q
group by
f1,f2,f3,f4
) Q ) P;
-- OlapCoreSumOrderby100_p1
select 'OlapCoreSumOrderby100_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 50 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 50 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 50 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 20 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 30 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 40 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 50 f5 from tversion union
select 7 f1, null f2, null f3, null f4, 50 f5 from tversion union
select rnum, c1, c2, c3, sum( c3 ) over(partition by c1 order by 100) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreSum_p1
select 'OlapCoreSum_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 50 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 50 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 50 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 20 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 30 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 40 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 50 f5 from tversion union
select 7 f1, null f2, null f3, null f4, 50 f5 from tversion union
select rnum, c1, c2, c3, sum( c3 ) over(partition by c1) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreVariance_p1
select 'OlapCoreVariance_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 5.833333333333331e+001 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 5.833333333333331e+001 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 5.833333333333331e+001 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, null f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, null f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, null f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, null f5 from tversion union
select 7 f1, null f2, null f3, null f4, null f5 from tversion union
select rnum, c1, c2, c3, variance( c3 ) over(partition by c1) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreVarPop_p1
select 'OlapCoreVarPop_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 3.888888888888889e+001 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 3.888888888888889e+001 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 3.888888888888889e+001 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 0.000000000000000e+000 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 0.000000000000000e+000 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 0.000000000000000e+000 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 0.000000000000000e+000 f5 from tversion union
select 7 f1, null f2, null f3, null f4, 0.000000000000000e+000 f5 from tversion union
select rnum, c1, c2, c3, var_pop( c3 ) over(partition by c1) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreVarSamp_p1
select 'OlapCoreVarSamp_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 5.833333333333331e+001 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 5.833333333333331e+001 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 5.833333333333331e+001 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, null f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, null f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, null f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, null f5 from tversion union
select 7 f1, null f2, null f3, null f4, null f5 from tversion union
select rnum, c1, c2, c3, var_samp( c3 ) over(partition by c1) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreWindowFrameMultiplePartitions_p1
select 'OlapCoreWindowFrameMultiplePartitions_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5,f6, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 50 f4, 25 f5, 190 f6 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 50 f4, 25 f5, 190 f6 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 50 f4, 25 f5, 190 f6 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 20 f5, 190 f6 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 30 f5, 190 f6 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 40 f5, 190 f6 from tversion union
select 6 f1, null f2, null f3, 50 f4, 50 f5, 190 f6 from tversion union
select 7 f1, null f2, null f3, 50 f4, 50 f5, 190 f6 from tversion union
select rnum, c1, c2, sum(c3) over (partition by c1), sum(c3) over (partition by c2), sum(c3) over () from tolap
) Q
group by
f1,f2,f3,f4,f5,f6
) Q ) P;
-- OlapCoreWindowFrameRowsBetweenPrecedingFollowing_p1
select 'OlapCoreWindowFrameRowsBetweenPrecedingFollowing_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 25 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 45 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 75 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 60 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 95 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 120 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 90 f5 from tversion union
select 7 f1, null f2, null f3, null f4, 50 f5 from tversion union
select rnum, c1, c2, c3, sum(c3) over ( order by c3 rows between 1 preceding and 1 following ) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreWindowFrameRowsBetweenPrecedingPreceding_p1
select 'OlapCoreWindowFrameRowsBetweenPrecedingPreceding_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, null f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 10 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 20 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 15 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 25 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 30 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 40 f5 from tversion union
select 7 f1, null f2, null f3, null f4, 50 f5 from tversion union
select rnum, c1, c2, c3, sum(c3) over ( order by c3 rows between 1 preceding and 1 preceding ) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreWindowFrameRowsBetweenUnboundedFollowing_p1
select 'OlapCoreWindowFrameRowsBetweenUnboundedFollowing_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 190 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 180 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 145 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 165 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 120 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 90 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 50 f5 from tversion union
select 7 f1, null f2, null f3, null f4, null f5 from tversion union
select rnum, c1, c2, c3, sum(c3) over ( order by c3 rows between current row and unbounded following ) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreWindowFrameRowsBetweenUnboundedPreceding_p1
select 'OlapCoreWindowFrameRowsBetweenUnboundedPreceding_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 10 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 25 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 70 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 45 f5 from tversion union
select 3 f1, 'CCC' f2, 'CC' f3, 30 f4, 100 f5 from tversion union
select 4 f1, 'DDD' f2, 'DD' f3, 40 f4, 140 f5 from tversion union
select 5 f1, null f2, null f3, 50 f4, 190 f5 from tversion union
select 6 f1, null f2, null f3, null f4, 190 f5 from tversion union
select rnum, c1, c2, c3, sum(c3) over ( order by c3 rows between unbounded preceding and current row ) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreWindowFrameRowsPreceding_p1
select 'OlapCoreWindowFrameRowsPreceding_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 10 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 15 f4, 25 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 25 f4, 60 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 45 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 75 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 95 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 120 f5 from tversion union
select 7 f1, null f2, null f3, null f4, 90 f5 from tversion union
select rnum, c1, c2, c3, sum(c3) over ( order by c3 rows 2 preceding ) from tolap
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- OlapCoreWindowFrameWindowDefinition_p1
-- test expected to fail until GPDB supports function
-- GPDB Limitation: syntax not supported
select 'OlapCoreWindowFrameWindowDefinition_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 'AAA' f2, 'AA' f3, 10 f4, 10 f5 from tversion union
select 1 f1, 'AAA' f2, 'AA' f3, 25 f4, 15 f5 from tversion union
select 2 f1, 'AAA' f2, 'AB' f3, 50 f4, 25 f5 from tversion union
select 3 f1, 'BBB' f2, 'BB' f3, 20 f4, 20 f5 from tversion union
select 4 f1, 'CCC' f2, 'CC' f3, 30 f4, 30 f5 from tversion union
select 5 f1, 'DDD' f2, 'DD' f3, 40 f4, 40 f5 from tversion union
select 6 f1, null f2, null f3, 50 f4, 50 f5 from tversion union
select 7 f1, null f2, null f3, 50 f4, null f5 from tversion union
select rnum, c1, c2, sum(c3) over w1, sum (c3) over w2 from tolap  window w1 as (partition by c1 order by c3), w2 as ( w1 rows between unbounded preceding and current row)
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;

