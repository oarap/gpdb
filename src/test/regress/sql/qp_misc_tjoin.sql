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
-- Name: tjoin1; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace:
--

CREATE TABLE tjoin1 (
    rnum integer NOT NULL,
    c1 integer,
    c2 integer
) DISTRIBUTED BY (rnum);


--
-- Name: tjoin2; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace:
--

CREATE TABLE tjoin2 (
    rnum integer NOT NULL,
    c1 integer,
    c2 character(2)
) DISTRIBUTED BY (rnum);


--
-- Name: tjoin3; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace:
--

CREATE TABLE tjoin3 (
    rnum integer NOT NULL,
    c1 integer,
    c2 character(2)
) DISTRIBUTED BY (rnum);



--
-- Name: tjoin4; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace:
--

CREATE TABLE tjoin4 (
    rnum integer NOT NULL,
    c1 integer,
    c2 character(2)
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
-- Data for Name: tjoin1; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tjoin1 (rnum, c1, c2) FROM stdin;
1	20	25
0	10	15
2	\N	50
\.


--
-- Data for Name: tjoin2; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tjoin2 (rnum, c1, c2) FROM stdin;
3	10	FF
0	10	BB
1	15	DD
2	\N	EE
\.

--
-- Data for Name: tjoin3; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tjoin3 (rnum, c1, c2) FROM stdin;
1	15	YY
0	10	XX
\.


--
-- Data for Name: tjoin4; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tjoin4 (rnum, c1, c2) FROM stdin;
0	20	ZZ
\.

--
-- Data for Name: tversion; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tversion (rnum, c1, cver, cnnull, ccnull) FROM stdin;
0	1	1.0   	\N	\N
\.

-- StringPredicateLike_p2
select 'StringPredicateLike_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 10 f1, 'BB' f2 from tversion union
select tjoin2.c1, tjoin2.c2 from tjoin2 where tjoin2.c2 like '%B%'
) Q
group by
f1,f2
) Q ) P;
-- StringPredicateLike_p3
select 'StringPredicateLike_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 10 f1, 'BB' f2 from tversion union
select tjoin2.c1, tjoin2.c2 from tjoin2 where tjoin2.c2 like '_B'
) Q
group by
f1,f2
) Q ) P;
-- StringPredicateLike_p4
select 'StringPredicateLike_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 10 f1, 'BB' f2 from tversion union
select tjoin2.c1, tjoin2.c2 from tjoin2 where tjoin2.c2 like 'BB%'
) Q
group by
f1,f2
) Q ) P;
-- StringPredicateNotBetween_p1
select 'StringPredicateNotBetween_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 1 f1, 15 f2, 'DD' f3 from tversion union
select 2 f1, null f2, 'EE' f3 from tversion union
select 3 f1, 10 f2, 'FF' f3 from tversion union
select rnum,tjoin2.c1, tjoin2.c2 from tjoin2 where not tjoin2.c2 between 'AA' and 'CC'
) Q
group by
f1,f2,f3
) Q ) P;
-- StringPredicateNotIn_p1
select 'StringPredicateNotIn_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 1 f1, 15 f2, 'DD' f3 from tversion union
select 3 f1, 10 f2, 'FF' f3 from tversion union
select rnum,tjoin2.c1, tjoin2.c2 from tjoin2 where not tjoin2.c2 in ('ZZ','BB','EE')
) Q
group by
f1,f2,f3
) Q ) P;
-- StringPredicateNotLike_p1
select 'StringPredicateNotLike_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 1 f1, 15 f2, 'DD' f3 from tversion union
select 2 f1, null f2, 'EE' f3 from tversion union
select 3 f1, 10 f2, 'FF' f3 from tversion union
select rnum,tjoin2.c1, tjoin2.c2 from tjoin2 where tjoin2.c2 not like 'B%'
) Q
group by
f1,f2,f3
) Q ) P;
-- SubqueryCorrelated_p1
select 'SubqueryCorrelated_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 10 f1, 15 f2 from tversion union
select tjoin1.c1, tjoin1.c2 from tjoin1 where tjoin1.c1 = any (select tjoin2.c1 from tjoin2 where tjoin2.c1 = tjoin1.c1)
) Q
group by
f1,f2
) Q ) P;
-- SubqueryDerivedAliasOrderBy_p1
select 'SubqueryDerivedAliasOrderBy_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 15 f3 from tversion union
select 1 f1, 20 f2, 25 f3 from tversion union
select 2 f1, null f2, 50 f3 from tversion union
select tx.rnum, tx.c1, tx.c2 from (select rnum, c1, c2 from tjoin1 order by c1) tx
) Q
group by
f1,f2,f3
) Q ) P;
-- SubqueryDerivedAssignNames_p1
select 'SubqueryDerivedAssignNames_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 15 f3 from tversion union
select 1 f1, 20 f2, 25 f3 from tversion union
select 2 f1, null f2, 50 f3 from tversion union
select tx.rnumx, tx.c1x, tx.c2x from (select rnum, c1, c2 from tjoin1) tx (rnumx, c1x, c2x)
) Q
group by
f1,f2,f3
) Q ) P;
-- SubqueryDerivedMany_p1
select 'SubqueryDerivedMany_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4, count(*) c  from (
select 0 f1, 10 f2, 15 f3, 'BB' f4 from tversion union
select 0 f1, 10 f2, 15 f3, 'DD' f4 from tversion union
select 0 f1, 10 f2, 15 f3, 'EE' f4 from tversion union
select 0 f1, 10 f2, 15 f3, 'FF' f4 from tversion union
select 1 f1, 20 f2, 25 f3, 'BB' f4 from tversion union
select 1 f1, 20 f2, 25 f3, 'DD' f4 from tversion union
select 1 f1, 20 f2, 25 f3, 'EE' f4 from tversion union
select 1 f1, 20 f2, 25 f3, 'FF' f4 from tversion union
select 2 f1, null f2, 50 f3, 'BB' f4 from tversion union
select 2 f1, null f2, 50 f3, 'DD' f4 from tversion union
select 2 f1, null f2, 50 f3, 'EE' f4 from tversion union
select 2 f1, null f2, 50 f3, 'FF' f4 from tversion union
select tx.rnum, tx.c1, tx.c2, ty.c2 from (select tjoin1.rnum, tjoin1.c1, tjoin1.c2 from tjoin1) tx, (select tjoin2.c2 from tjoin2) ty
) Q
group by
f1,f2,f3,f4
) Q ) P;
-- SubqueryDerived_p1
select 'SubqueryDerived_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 15 f3 from tversion union
select 1 f1, 20 f2, 25 f3 from tversion union
select 2 f1, null f2, 50 f3 from tversion union
select tx.rnum, tx.c1, tx.c2 from (select rnum, c1, c2 from tjoin1) tx
) Q
group by
f1,f2,f3
) Q ) P;
-- SubqueryInAggregate_p1
select 'SubqueryInAggregate_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 1 f3 from tversion union
select 1 f1, 20 f2, 1 f3 from tversion union
select 2 f1, null f2, 1 f3 from tversion union
select rnum, c1, sum( (select 1 from tversion) ) from tjoin1 group by rnum, c1
) Q
group by
f1,f2,f3
) Q ) P;
-- SubqueryInCase_p1
-- test expected to fail until function supported in GPDB
-- GPDB Limitation ERROR:  Greenplum Database does not yet support that query.  DETAIL:  The query contains a multi-row subquery.
select 'SubqueryInCase_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 'no' f3 from tversion union
select 1 f1, 20 f2, 'no' f3 from tversion union
select 2 f1, null f2, 'no' f3 from tversion union
select tjoin1.rnum, tjoin1.c1, case when 10 in ( select 1 from tversion ) then 'yes' else 'no' end from tjoin1
) Q
group by
f1,f2,f3
) Q ) P;
-- SubqueryInGroupBy_p1
select 'SubqueryInGroupBy_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 3 f1, 4 f2 from tversion union
select (select count(*) from tjoin1),count(*) from tjoin2 group by ( select count(*) from tjoin1 )
) Q
group by
f1,f2
) Q ) P;
-- SubqueryInHaving_p1
select 'SubqueryInHaving_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 3 f1 from tversion union
select count(*) from tjoin1 having count(*) > ( select count(*) from tversion )
) Q
group by
f1
) Q ) P;
-- SubqueryPredicateExists_p1
select 'SubqueryPredicateExists_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 'BB' f3 from tversion union
select 1 f1, 15 f2, 'DD' f3 from tversion union
select 2 f1, null f2, 'EE' f3 from tversion union
select 3 f1, 10 f2, 'FF' f3 from tversion union
select rnum, c1, c2 from tjoin2 where exists ( select c1 from tjoin1)
) Q
group by
f1,f2,f3
) Q ) P;
-- SubqueryPredicateIn_p1
select 'SubqueryPredicateIn_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 'BB' f3 from tversion union
select 1 f1, 15 f2, 'DD' f3 from tversion union
select 2 f1, null f2, 'EE' f3 from tversion union
select 3 f1, 10 f2, 'FF' f3 from tversion union
select rnum, c1, c2 from tjoin2 where 50 in ( select c2 from tjoin1 where c2=50)
) Q
group by
f1,f2,f3
) Q ) P;
-- SubqueryPredicateNotExists_p1
select 'SubqueryPredicateNotExists_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 'BB' f3 from tversion union
select 1 f1, 15 f2, 'DD' f3 from tversion union
select 2 f1, null f2, 'EE' f3 from tversion union
select 3 f1, 10 f2, 'FF' f3 from tversion union
select rnum, c1, c2 from tjoin2 where not exists ( select c1 from tjoin1 where c2=500)
) Q
group by
f1,f2,f3
) Q ) P;
-- SubqueryPredicateNotIn_p1
-- test expected to fail until function supported in GPDB
-- GPDB Limitation ERROR:  Greenplum Database does not yet support that query.  DETAIL:  The query contains a multi-row subquery.
select 'SubqueryPredicateNotIn_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 'BB' f3 from tversion union
select 1 f1, 15 f2, 'DD' f3 from tversion union
select 2 f1, null f2, 'EE' f3 from tversion union
select 3 f1, 10 f2, 'FF' f3 from tversion union
select rnum, c1, c2 from tjoin2 where 50 not in ( select c2 from tjoin1 where c2=25)
) Q
group by
f1,f2,f3
) Q ) P;
-- SubqueryQuantifiedPredicateAnyFromC1_p1
select 'SubqueryQuantifiedPredicateAnyFromC1_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 'BB' f3 from tversion union
select 1 f1, 15 f2, 'DD' f3 from tversion union
select 2 f1, null f2, 'EE' f3 from tversion union
select 3 f1, 10 f2, 'FF' f3 from tversion union
select rnum, c1, c2 from tjoin2 where 20 > any ( select c1 from tjoin1)
) Q
group by
f1,f2,f3
) Q ) P;
-- SubqueryQuantifiedPredicateAnyFromC2_p1
select 'SubqueryQuantifiedPredicateAnyFromC2_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 'BB' f3 from tversion union
select 1 f1, 15 f2, 'DD' f3 from tversion union
select 2 f1, null f2, 'EE' f3 from tversion union
select 3 f1, 10 f2, 'FF' f3 from tversion union
select rnum, c1, c2 from tjoin2 where 20 > any ( select c2 from tjoin1)
) Q
group by
f1,f2,f3
) Q ) P;
-- SubqueryQuantifiedPredicateEmpty_p1
-- test expected to fail until GPDB support this function
-- GPDB Limitation ERROR:  Greenplum Database does not yet support this query.  DETAIL:  The query contains a multi-row subquery.
select 'SubqueryQuantifiedPredicateEmpty_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 'BB' f3 from tversion union
select 1 f1, 15 f2, 'DD' f3 from tversion union
select 2 f1, null f2, 'EE' f3 from tversion union
select 3 f1, 10 f2, 'FF' f3 from tversion union
select rnum, c1, c2 from tjoin2 where 20 > all ( select c1 from tjoin1 where c1 = 100)
) Q
group by
f1,f2,f3
) Q ) P;
-- SubqueryQuantifiedPredicateLarge_p1
-- test expected to fail until GPDB supports this function
-- GPDB Limitation ERROR:  Greenplum Database does not yet support that query.  DETAIL:  The query contains a multi-row subquery.
select 'SubqueryQuantifiedPredicateLarge_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 'BB' f3 from tversion union
select 1 f1, 15 f2, 'DD' f3 from tversion union
select 2 f1, null f2, 'EE' f3 from tversion union
select 3 f1, 10 f2, 'FF' f3 from tversion union
select rnum, c1, c2 from tjoin2 where 75 > all ( select c2 from tjoin1)
) Q
group by
f1,f2,f3
) Q ) P;
-- SubstringValueExpr_p1
select 'SubstringValueExpr_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 10 f1, 'BB' f2 from tversion union
select tjoin2.c1, tjoin2.c2 from tjoin2 where substring(tjoin2.c2 from 1 for 1) = 'B'
) Q
group by
f1,f2
) Q ) P;
-- JoinCoreLikePredicate_gp_p1
select 'JoinCoreLikePredicate_gp_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where not exists (select tjoin1.rnum, tjoin1.c1, tjoin1.c2, tjoin2.c2 as c2j2 from tjoin1 inner join tjoin2 on ( tjoin1.c1 = tjoin2.c1 and tjoin2.c2 like 'A%' ))
) Q
group by
f1
) Q ) P;
-- JoinCoreNestedInner_gp_p1
select 'JoinCoreNestedInner_gp_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where not exists (select tjoin1.c1, tjoin2.c2, tjoin3.c2 as c2j3 from (( tjoin1 inner join tjoin2 on tjoin1.c1=tjoin2.c1 ) inner join tjoin3 on tjoin3.c1=tjoin1.c1) inner join tjoin4 on tjoin4.c1=tjoin3.c1)
) Q
group by
f1
) Q ) P;
-- StringPredicateLikeEscape_gp_p1
select 'StringPredicateLikeEscape_gp_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 10 f1, 'BB' f2 from tversion union
select tjoin2.c1, tjoin2.c2 from tjoin2 where ('%%' || tjoin2.c2) like '!%%B' escape '!'
) Q
group by
f1,f2
) Q ) P;
-- StringPredicateLikeUnderscore_gp_p1
select 'StringPredicateLikeUnderscore_gp_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 10 f1, 'BB' f2 from tversion union
select tjoin2.c1, tjoin2.c2 from tjoin2 where ('__' || tjoin2.c2) like '!__BB' escape '!'
) Q
group by
f1,f2
) Q ) P;
-- SubqueryNotIn_gp_p1
select 'SubqueryNotIn_gp_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where not exists (select tjoin1.rnum, tjoin1.c1 from tjoin1 where tjoin1.c1 not in (select tjoin2.c1 from tjoin2))
) Q
group by
f1
) Q ) P;
-- SubqueryOnCondition_gp_p1
select 'SubqueryOnCondition_gp_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where not exists (select tjoin1.c1, tjoin2.c2 from tjoin1 inner join tjoin2 on ( tjoin1.c1 = tjoin2.c1 and tjoin1.c2 < ( select count(*) from tversion)))
) Q
group by
f1
) Q ) P;
-- SubqueryPredicateWhereIn_gp_p1
select 'SubqueryPredicateWhereIn_gp_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where not exists (select rnum, c1, c2 from tjoin2 where 50 in ( select c1 from tjoin1))
) Q
group by
f1
) Q ) P;
-- SubqueryQuantifiedPredicateNull_gp_p1
-- test expected to fail until GPDB support function
-- GPDB Limitation ERROR:  Greenplum Database does not yet support this query.  DETAIL:  The query contains a multi-row subquery.
select 'SubqueryQuantifiedPredicateNull_gp_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where not exists (select rnum, c1, c2 from tjoin2 where 20 > all ( select c1 from tjoin1))
) Q
group by
f1
) Q ) P;
-- SubqueryQuantifiedPredicateSmall_gp_p1
-- test expected to fail until GPDB supports function
-- GPDB Limitation ERROR:  Greenplum Database does not yet support this query.  DETAIL:  The query contains a multi-row subquery.
select 'SubqueryQuantifiedPredicateSmall_gp_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where not exists (select rnum, c1, c2 from tjoin2 where 20 > all ( select c2 from tjoin1))
) Q
group by
f1
) Q ) P;
-- ExpressionInIn_p1
select 'ExpressionInIn_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 10 f1, 'BB' f2 from tversion union
select tjoin2.c1, tjoin2.c2 from tjoin2 where tjoin2.rnum in (1 - 1)
) Q
group by
f1,f2
) Q ) P;
-- IsNullPredicate_p1
select 'IsNullPredicate_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select null f1, 'EE' f2 from tversion union
select c1, c2 from tjoin2 where c1 is null
) Q
group by
f1,f2
) Q ) P;
-- JoinCoreCrossProduct_p1
select 'JoinCoreCrossProduct_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 0 f2, 10 f3, 10 f4, 'BB' f5 from tversion union
select 0 f1, 1 f2, 10 f3, 15 f4, 'DD' f5 from tversion union
select 0 f1, 2 f2, 10 f3, null f4, 'EE' f5 from tversion union
select 0 f1, 3 f2, 10 f3, 10 f4, 'FF' f5 from tversion union
select 1 f1, 0 f2, 20 f3, 10 f4, 'BB' f5 from tversion union
select 1 f1, 1 f2, 20 f3, 15 f4, 'DD' f5 from tversion union
select 1 f1, 2 f2, 20 f3, null f4, 'EE' f5 from tversion union
select 1 f1, 3 f2, 20 f3, 10 f4, 'FF' f5 from tversion union
select 2 f1, 0 f2, null f3, 10 f4, 'BB' f5 from tversion union
select 2 f1, 1 f2, null f3, 15 f4, 'DD' f5 from tversion union
select 2 f1, 2 f2, null f3, null f4, 'EE' f5 from tversion union
select 2 f1, 3 f2, null f3, 10 f4, 'FF' f5 from tversion union
select tjoin1.rnum, tjoin2.rnum, tjoin1.c1, tjoin2.c1 as c1j2, tjoin2.c2 from tjoin1, tjoin2
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- JoinCoreCross_p1
select 'JoinCoreCross_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 10 f3 from tversion union
select 3 f1, 10 f2, 10 f3 from tversion union
select tjoin2.rnum, tjoin1.c1, tjoin2.c1 as c1j2 from tjoin1 cross join tjoin2 where tjoin1.c1=tjoin2.c1
) Q
group by
f1,f2,f3
) Q ) P;
-- JoinCoreEqualWithAnd_p1
select 'JoinCoreEqualWithAnd_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 10 f1, 'BB' f2 from tversion union
select tjoin1.c1, tjoin2.c2 from tjoin1 inner join tjoin2 on ( tjoin1.c1 = tjoin2.c1 and tjoin2.c2='BB' )
) Q
group by
f1,f2
) Q ) P;
-- JoinCoreImplicit_p1
select 'JoinCoreImplicit_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4, count(*) c  from (
select 0 f1, 10 f2, 10 f3, 'BB' f4 from tversion union
select 3 f1, 10 f2, 10 f3, 'FF' f4 from tversion union
select tjoin2.rnum, tjoin1.c1, tjoin2.c1 as c1j2, tjoin2.c2 from tjoin1, tjoin2 where tjoin1.c1=tjoin2.c1
) Q
group by
f1,f2,f3,f4
) Q ) P;
-- JoinCoreIsNullPredicate_p1
select 'JoinCoreIsNullPredicate_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4, count(*) c  from (
select 0 f1, 10 f2, 15 f3, null f4 from tversion union
select 1 f1, 20 f2, 25 f3, null f4 from tversion union
select 2 f1, null f2, 50 f3, null f4 from tversion union
select tjoin1.rnum, tjoin1.c1, tjoin1.c2, tjoin2.c2  as c2j2 from tjoin1 left outer join tjoin2 on ( tjoin1.c1 = tjoin2.c1 and tjoin1.c2 is null )
) Q
group by
f1,f2,f3,f4
) Q ) P;
-- JoinCoreLeftNestedInnerTableRestrict_p1
select 'JoinCoreLeftNestedInnerTableRestrict_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 0 f2, 0 f3 from tversion union
select 0 f1, 3 f2, 0 f3 from tversion union
select 1 f1, null f2, null f3 from tversion union
select 2 f1, null f2, null f3 from tversion union
select tjoin1.rnum, tjoin2.rnum as rnumt2, tjoin3.rnum as rnumt3 from  (tjoin1 left outer join tjoin2 on tjoin1.c1=tjoin2.c1) left outer join tjoin3 on tjoin2.c1=tjoin3.c1
) Q
group by
f1,f2,f3
) Q ) P;
-- JoinCoreLeftNestedOptionalTableRestrict_p1
select 'JoinCoreLeftNestedOptionalTableRestrict_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4, count(*) c  from (
select 10 f1, 15 f2, 'BB' f3, 'XX' f4 from tversion union
select 10 f1, 15 f2, 'FF' f3, 'XX' f4 from tversion union
select 20 f1, 25 f2, null f3, null f4 from tversion union
select null f1, 50 f2, null f3, null f4 from tversion union
select tjoin1.c1, tjoin1.c2, tjoin2.c2 as c2j2, tjoin3.c2 as c2j3 from  tjoin1 left outer join (tjoin2 left outer join tjoin3 on tjoin2.c1=tjoin3.c1) on tjoin1.c1=tjoin3.c1
) Q
group by
f1,f2,f3,f4
) Q ) P;
-- JoinCoreNestedInnerOuter_p1
select 'JoinCoreNestedInnerOuter_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5,f6, count(*) c  from (
select 0 f1, 10 f2, 15 f3, 'BB' f4, 'XX' f5, null f6 from tversion union
select 3 f1, 10 f2, 15 f3, 'FF' f4, 'XX' f5, null f6 from tversion union
select tjoin2.rnum, tjoin1.c1, tjoin1.c2, tjoin2.c2 as c2j2, tjoin3.c2 as c2j3,tjoin4.c2 as c2j4 from (tjoin1 inner join (tjoin2 left outer join tjoin3 on tjoin2.c1=tjoin3.c1) on (tjoin1.c1=tjoin2.c1)) left outer join tjoin4 on (tjoin1.c1=tjoin4.c1)
) Q
group by
f1,f2,f3,f4,f5,f6
) Q ) P;
-- JoinCoreNestedOuterInnerTableRestrict_p1
select 'JoinCoreNestedOuterInnerTableRestrict_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 0 f2, 0 f3 from tversion union
select 0 f1, 3 f2, 0 f3 from tversion union
select null f1, 1 f2, null f3 from tversion union
select null f1, 2 f2, null f3 from tversion union
select tjoin1.rnum, tjoin2.rnum as rnumt2, tjoin3.rnum as rnumt3 from  (tjoin1 right outer join tjoin2 on tjoin1.c1=tjoin2.c1) left outer join tjoin3 on tjoin1.c1=tjoin3.c1
) Q
group by
f1,f2,f3
) Q ) P;
-- JoinCoreNestedOuterOptionalTableRestrict_p1
select 'JoinCoreNestedOuterOptionalTableRestrict_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4, count(*) c  from (
select 10 f1, 15 f2, 'BB' f3, 'XX' f4 from tversion union
select 10 f1, 15 f2, 'FF' f3, 'XX' f4 from tversion union
select null f1, null f2, null f3, 'YY' f4 from tversion union
select tjoin1.c1, tjoin1.c2, tjoin2.c2 as c2j2, tjoin3.c2 as c2j3 from  (tjoin1 left outer join tjoin2 on tjoin1.c1=tjoin2.c1) right outer join tjoin3 on tjoin2.c1=tjoin3.c1
) Q
group by
f1,f2,f3,f4
) Q ) P;
-- JoinCoreNestedOuter_p1
select 'JoinCoreNestedOuter_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5,f6, count(*) c  from (
select 0 f1, 10 f2, 15 f3, 'BB' f4, 'XX' f5, null f6 from tversion union
select 1 f1, null f2, null f3, 'DD' f4, 'YY' f5, null f6 from tversion union
select 2 f1, null f2, null f3, 'EE' f4, null f5, null f6 from tversion union
select 3 f1, 10 f2, 15 f3, 'FF' f4, 'XX' f5, null f6 from tversion union
select tjoin2.rnum, tjoin1.c1, tjoin1.c2, tjoin2.c2 as c2j2, tjoin3.c2 as c2j3,tjoin4.c2 as c2j4 from  (tjoin1 right outer join (tjoin2 left outer join tjoin3 on tjoin2.c1=tjoin3.c1) on (tjoin1.c1=tjoin2.c1)) left outer join tjoin4 on (tjoin1.c1=tjoin4.c1)
) Q
group by
f1,f2,f3,f4,f5,f6
) Q ) P;
-- JoinCoreNoExpressionInOnCondition_p1
select 'JoinCoreNoExpressionInOnCondition_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 10 f2, 15 f3, 10 f4, 'XX' f5 from tversion union
select 0 f1, 10 f2, 15 f3, 15 f4, 'YY' f5 from tversion union
select tjoin1.rnum, tjoin1.c1,tjoin1.c2,tjoin3.c1, tjoin3.c2 from tjoin1 inner join tjoin3 on tjoin1.c1 = 9 + 1
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- JoinCoreNonEquiJoin_p1
select 'JoinCoreNonEquiJoin_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 0 f2, 0 f3 from tversion union
select 1 f1, 1 f2, 1 f3 from tversion union
select 2 f1, 2 f2, null f3 from tversion union
select 3 f1, 3 f2, 0 f3 from tversion union
select tjoin2.rnum, tjoin2.rnum as rnumt2, tjoin3.rnum as rnumt3  from tjoin2 left outer join tjoin3 on tjoin2.c2 <> tjoin3.c2 and tjoin2.c1=tjoin3.c1
) Q
group by
f1,f2,f3
) Q ) P;
-- JoinCoreNonEquiJoin_p2
select 'JoinCoreNonEquiJoin_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 0 f2, 0 f3 from tversion union
select 1 f1, 1 f2, 1 f3 from tversion union
select 2 f1, 2 f2, null f3 from tversion union
select 3 f1, 3 f2, 0 f3 from tversion union
select tjoin2.rnum, tjoin2.rnum as rnumt2, tjoin3.rnum as rnumt3  from tjoin2 left outer join tjoin3 on tjoin2.c2 <> tjoin3.c2 and tjoin2.c1=tjoin3.c1
) Q
group by
f1,f2,f3
) Q ) P;
-- JoinCoreNonJoinNonEquiJoin_p1
select 'JoinCoreNonJoinNonEquiJoin_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 'BB' f3 from tversion union
select 0 f1, 10 f2, 'DD' f3 from tversion union
select 0 f1, 10 f2, 'EE' f3 from tversion union
select 0 f1, 10 f2, 'FF' f3 from tversion union
select 1 f1, 20 f2, null f3 from tversion union
select 2 f1, null f2, null f3 from tversion union
select tjoin1.rnum, tjoin1.c1,tjoin2.c2 from tjoin1 left outer join tjoin2 on tjoin1.c1 < 20
) Q
group by
f1,f2,f3
) Q ) P;
-- JoinCoreNotPredicate_p1
select 'JoinCoreNotPredicate_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4, count(*) c  from (
select 0 f1, 10 f2, 15 f3, 'BB' f4 from tversion union
select 3 f1, 10 f2, 15 f3, 'FF' f4 from tversion union
select tjoin2.rnum, tjoin1.c1, tjoin1.c2, tjoin2.c2 as c2j2 from tjoin1 inner join tjoin2 on ( tjoin1.c1 = tjoin2.c1 and not tjoin2.c2 = 'AA' )
) Q
group by
f1,f2,f3,f4
) Q ) P;
-- JoinCoreNwayJoinedTable_p1
select 'JoinCoreNwayJoinedTable_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4, count(*) c  from (
select 0 f1, 10 f2, 'BB' f3, 'XX' f4 from tversion union
select 1 f1, null f2, 'DD' f3, null f4 from tversion union
select 2 f1, null f2, 'EE' f3, null f4 from tversion union
select 3 f1, 10 f2, 'FF' f3, 'XX' f4 from tversion union
select tjoin2.rnum, tjoin1.c1, tjoin2.c2 as c2j2, tjoin3.c2 as c2j3 from tjoin1 right outer join  tjoin2 on tjoin1.c1 = tjoin2.c1 left outer join tjoin3 on tjoin1.c1 = tjoin3.c1
) Q
group by
f1,f2,f3,f4
) Q ) P;
-- JoinCoreOnConditionAbsFunction_p1
select 'JoinCoreOnConditionAbsFunction_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 'BB' f3 from tversion union
select 0 f1, 10 f2, 'FF' f3 from tversion union
select 1 f1, 20 f2, null f3 from tversion union
select 2 f1, null f2, null f3 from tversion union
select tjoin1.rnum, tjoin1.c1,tjoin2.c2 from tjoin1 left outer join tjoin2 on abs(tjoin1.c1)=tjoin2.c1
) Q
group by
f1,f2,f3
) Q ) P;
-- JoinCoreOnConditionSetFunction_p1
select 'JoinCoreOnConditionSetFunction_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 10 f1, null f2 from tversion union
select 20 f1, null f2 from tversion union
select null f1, null f2 from tversion union
select tjoin1.c1,tjoin2.c2 from tjoin1 left outer join tjoin2 on tjoin1.c1=tjoin2.c1 and tjoin1.c1 >= ((select sum(c1) from tjoin1)/2)
) Q
group by
f1,f2
) Q ) P;
-- JoinCoreOnConditionSubstringFunction_p1
select 'JoinCoreOnConditionSubstringFunction_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 'BB' f3 from tversion union
select 1 f1, 20 f2, null f3 from tversion union
select 2 f1, null f2, null f3 from tversion union
select tjoin1.rnum, tjoin1.c1,tjoin2.c2 from tjoin1 left outer join tjoin2 on tjoin1.c1=tjoin2.c1 and substring(tjoin2.c2 from 1 for 2)='BB'
) Q
group by
f1,f2,f3
) Q ) P;
-- JoinCoreOnConditionTrimFunction_p1
select 'JoinCoreOnConditionTrimFunction_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 'BB' f3 from tversion union
select 1 f1, 20 f2, null f3 from tversion union
select 2 f1, null f2, null f3 from tversion union
select tjoin1.rnum, tjoin1.c1,tjoin2.c2 from tjoin1 left outer join tjoin2 on tjoin1.c1=tjoin2.c1 and trim(tjoin2.c2)='BB'
) Q
group by
f1,f2,f3
) Q ) P;
-- JoinCoreOnConditionUpperFunction_p1
select 'JoinCoreOnConditionUpperFunction_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 'BB' f3 from tversion union
select 1 f1, 20 f2, null f3 from tversion union
select 2 f1, null f2, null f3 from tversion union
select tjoin1.rnum, tjoin1.c1,tjoin2.c2 from tjoin1 left outer join tjoin2 on tjoin1.c1=tjoin2.c1 and upper(tjoin2.c2)='BB'
) Q
group by
f1,f2,f3
) Q ) P;
-- JoinCoreOptionalTableFilter_p1
select 'JoinCoreOptionalTableFilter_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 10 f1, 'FF' f2 from tversion union
select tjoin1.c1, tjoin2.c2 from tjoin1 left outer join tjoin2 on tjoin1.c1 = tjoin2.c1 where tjoin2.c2 > 'C'
) Q
group by
f1,f2
) Q ) P;
-- JoinCoreOptionalTableJoinFilter_p1
select 'JoinCoreOptionalTableJoinFilter_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 'FF' f3 from tversion union
select 1 f1, 20 f2, null f3 from tversion union
select 2 f1, null f2, null f3 from tversion union
select tjoin1.rnum, tjoin1.c1, tjoin2.c2 from tjoin1 left outer join tjoin2 on ( tjoin1.c1 = tjoin2.c1 and tjoin2.c2 > 'C' )
) Q
group by
f1,f2,f3
) Q ) P;
-- JoinCoreOptionalTableJoinRestrict_p1
select 'JoinCoreOptionalTableJoinRestrict_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5,f6,f7,f8,f9, count(*) c  from (
select 0 f1, 10 f2, 15 f3, 0 f4, 10 f5, 'BB' f6, 0 f7, 10 f8, 'XX' f9 from tversion union
select 0 f1, 10 f2, 15 f3, 3 f4, 10 f5, 'FF' f6, 0 f7, 10 f8, 'XX' f9 from tversion union
select tjoin1.rnum as tj1rnum, tjoin1.c1 as tj1c1, tjoin1.c2 as tj1c2, tjoin2.rnum as tj2rnum, tjoin2.c1 as tj2c1, tjoin2.c2 as tj2c2, tjoin3.rnum as tj3rnum, tjoin3.c1 as tj3c1, tjoin3.c2 as tj3c2 from  (tjoin1 left outer join tjoin2 on tjoin1.c1=tjoin2.c1)  , tjoin3 where tjoin2.c1=tjoin3.c1
) Q
group by
f1,f2,f3,f4,f5,f6,f7,f8,f9
) Q ) P;
-- JoinCoreOrPredicate_p1
select 'JoinCoreOrPredicate_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 10 f1, 15 f2, 'BB' f3 from tversion union
select 10 f1, 15 f2, 'DD' f3 from tversion union
select 10 f1, 15 f2, 'EE' f3 from tversion union
select 10 f1, 15 f2, 'FF' f3 from tversion union
select 20 f1, 25 f2, 'BB' f3 from tversion union
select 20 f1, 25 f2, 'DD' f3 from tversion union
select 20 f1, 25 f2, 'EE' f3 from tversion union
select 20 f1, 25 f2, 'FF' f3 from tversion union
select tjoin1.c1, tjoin1.c2, tjoin2.c2 as c2j2 from tjoin1 inner join tjoin2 on ( tjoin1.c1 = 10 or tjoin1.c1=20 )
) Q
group by
f1,f2,f3
) Q ) P;
-- JoinCoreOrPredicate_p2
select 'JoinCoreOrPredicate_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 10 f1, 15 f2, 'BB' f3 from tversion union
select 10 f1, 15 f2, 'DD' f3 from tversion union
select 10 f1, 15 f2, 'EE' f3 from tversion union
select 10 f1, 15 f2, 'FF' f3 from tversion union
select 20 f1, 25 f2, 'BB' f3 from tversion union
select 20 f1, 25 f2, 'DD' f3 from tversion union
select 20 f1, 25 f2, 'EE' f3 from tversion union
select 20 f1, 25 f2, 'FF' f3 from tversion union
select tjoin1.c1, tjoin1.c2, tjoin2.c2 as c2j2 from tjoin1 inner join tjoin2 on ( tjoin1.c1 = 10 or tjoin1.c1=20 )
) Q
group by
f1,f2,f3
) Q ) P;
-- JoinCorePreservedTableFilter_p1
select 'JoinCorePreservedTableFilter_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4, count(*) c  from (
select 1 f1, 20 f2, 25 f3, null f4 from tversion union
select 2 f1, null f2, 50 f3, null f4 from tversion union
select tjoin1.rnum, tjoin1.c1, tjoin1.c2, tjoin2.c2 as c2j2 from tjoin1 left outer join tjoin2 on tjoin1.c1 = tjoin2.c1 where tjoin1.c2 > 15
) Q
group by
f1,f2,f3,f4
) Q ) P;
-- JoinCorePreservedTableJoinFilter_p1
select 'JoinCorePreservedTableJoinFilter_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4, count(*) c  from (
select 0 f1, 10 f2, 15 f3, null f4 from tversion union
select 1 f1, 20 f2, 25 f3, null f4 from tversion union
select 2 f1, null f2, 50 f3, null f4 from tversion union
select tjoin1.rnum, tjoin1.c1, tjoin1.c2, tjoin2.c2 as c2j2 from tjoin1 left outer join tjoin2 on ( tjoin1.c1 = tjoin2.c1 and tjoin1.c2 > 15 )
) Q
group by
f1,f2,f3,f4
) Q ) P;
-- JoinCoreRightNestedInnerTableRestrict_p1
select 'JoinCoreRightNestedInnerTableRestrict_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 0 f2, 0 f3 from tversion union
select 0 f1, 3 f2, 0 f3 from tversion union
select null f1, 1 f2, 1 f3 from tversion union
select tjoin1.rnum, tjoin2.rnum as rnumt2, tjoin3.rnum as rnumt3 from  (tjoin1 right outer join tjoin2 on tjoin1.c1=tjoin2.c1) right outer join tjoin3 on tjoin2.c1=tjoin3.c1
) Q
group by
f1,f2,f3
) Q ) P;
-- JoinCoreRightNestedOptionalTableRestrict_p1
select 'JoinCoreRightNestedOptionalTableRestrict_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4, count(*) c  from (
select 10 f1, 15 f2, 'BB' f3, 'XX' f4 from tversion union
select 10 f1, 15 f2, 'FF' f3, 'XX' f4 from tversion union
select null f1, null f2, null f3, 'YY' f4 from tversion union
select tjoin1.c1, tjoin1.c2, tjoin2.c2 as c2j2, tjoin3.c2 as c2j3 from  (tjoin1 right outer join tjoin2 on tjoin1.c1=tjoin2.c1) right outer join tjoin3 on tjoin1.c1=tjoin3.c1
) Q
group by
f1,f2,f3,f4
) Q ) P;
-- JoinCoreSelf_p1
select 'JoinCoreSelf_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 10 f3 from tversion union
select 1 f1, 20 f2, 20 f3 from tversion union
select tjoin1.rnum, tjoin1.c1, tjoin1a.c1 from tjoin1, tjoin1 tjoin1a where tjoin1.c1=tjoin1a.c1
) Q
group by
f1,f2,f3
) Q ) P;
-- JoinCoreSimpleAndJoinedTable_p1
select 'JoinCoreSimpleAndJoinedTable_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4, count(*) c  from (
select 0 f1, 10 f2, 15 f3, 'BB' f4 from tversion union
select 3 f1, 10 f2, 15 f3, 'FF' f4 from tversion union
select tjoin2.rnum, tjoin1.c1, tjoin1.c2, tjoin2.c2 as c2j2 from tjoin1 left outer join tjoin2 on ( tjoin1.c1 = tjoin2.c1 ), tjoin3 where tjoin3.c1 = tjoin1.c1
) Q
group by
f1,f2,f3,f4
) Q ) P;
-- JoinCoreTwoSidedJoinRestrictionFilter_p1
select 'JoinCoreTwoSidedJoinRestrictionFilter_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 0 f2, 0 f3 from tversion union
select 0 f1, 3 f2, 0 f3 from tversion union
select tjoin1.rnum, tjoin2.rnum as rnumt2, tjoin3.rnum as rnumt3 from  (tjoin1 left outer join tjoin2 on tjoin1.c1=tjoin2.c1) left outer join tjoin3 on tjoin1.c1=tjoin3.c1 where tjoin2.c1=tjoin3.c1
) Q
group by
f1,f2,f3
) Q ) P;
-- JoinCoreTwoSidedJoinRestrict_p1
select 'JoinCoreTwoSidedJoinRestrict_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5,f6,f7,f8,f9, count(*) c  from (
select 0 f1, 10 f2, 15 f3, 0 f4, 10 f5, 'BB' f6, 0 f7, 10 f8, 'XX' f9 from tversion union
select 0 f1, 10 f2, 15 f3, 3 f4, 10 f5, 'FF' f6, 0 f7, 10 f8, 'XX' f9 from tversion union
select 1 f1, 20 f2, 25 f3, null f4, null f5, null f6, null f7, null f8, null f9 from tversion union
select 2 f1, null f2, 50 f3, null f4, null f5, null f6, null f7, null f8, null f9 from tversion union
select tjoin1.rnum as tj1rnum, tjoin1.c1 as tj1c1, tjoin1.c2 as tj1c2, tjoin2.rnum as tj2rnum, tjoin2.c1 as tj2c1, tjoin2.c2 as tj2c2, tjoin3.rnum as tj3rnum, tjoin3.c1 as tj3c1, tjoin3.c2 as tj3c2 from (tjoin1 left outer join tjoin2 on tjoin1.c1=tjoin2.c1) left outer join tjoin3 on tjoin2.c1=tjoin3.c1
) Q
group by
f1,f2,f3,f4,f5,f6,f7,f8,f9
) Q ) P;
-- JoinCoreUsing_p1
select 'JoinCoreUsing_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 10 f3 from tversion union
select 3 f1, 10 f2, 10 f3 from tversion union
select tjoin2.rnum, tjoin1.c1, tjoin2.c1 as c1j2 from tjoin1 join tjoin2 using ( c1 )
) Q
group by
f1,f2,f3
) Q ) P;
-- LikeValueExpr_p1
select 'LikeValueExpr_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 10 f1, 'BB' f2 from tversion union
select tjoin2.c1, tjoin2.c2 from tjoin2 where tjoin2.c2 like upper('BB')
) Q
group by
f1,f2
) Q ) P;
-- RowSubquery_p1
select 'RowSubquery_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 15 f3 from tversion union
select rnum, c1, c2 from tjoin1 where (c1,'BB') in (select c1, c2 from tjoin2 where c2='BB')
) Q
group by
f1,f2,f3
) Q ) P;
-- ScalarSubqueryInProjList_p1
select 'ScalarSubqueryInProjList_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4, count(*) c  from (
select 0 f1, 10 f2, 15 f3, 15 f4 from tversion union
select 1 f1, 20 f2, 25 f3, 15 f4 from tversion union
select 2 f1, null f2, 50 f3, 15 f4 from tversion union
select tjoin1.rnum, tjoin1.c1, tjoin1.c2, (select max(tjoin2.c1) from tjoin2) csub from tjoin1
) Q
group by
f1,f2,f3,f4
) Q ) P;
-- ScalarSubquery_p1
select 'ScalarSubquery_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 15 f3 from tversion union
select rnum, c1, c2 from tjoin1 where c1 = ( select min(c1) from tjoin1)
) Q
group by
f1,f2,f3
) Q ) P;
-- StringComparisonEq_p1
select 'StringComparisonEq_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 10 f1, 'BB' f2 from tversion union
select tjoin2.c1, tjoin2.c2 from tjoin2 where tjoin2.c2='BB'
) Q
group by
f1,f2
) Q ) P;
-- StringComparisonGtEq_p1
select 'StringComparisonGtEq_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 1 f1, 15 f2, 'DD' f3 from tversion union
select 2 f1, null f2, 'EE' f3 from tversion union
select 3 f1, 10 f2, 'FF' f3 from tversion union
select rnum,tjoin2.c1, tjoin2.c2 from tjoin2 where tjoin2.c2 >= 'DD'
) Q
group by
f1,f2,f3
) Q ) P;
-- StringComparisonGt_p1
select 'StringComparisonGt_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 2 f1, null f2, 'EE' f3 from tversion union
select 3 f1, 10 f2, 'FF' f3 from tversion union
select rnum,tjoin2.c1, tjoin2.c2 from tjoin2 where tjoin2.c2 > 'DD'
) Q
group by
f1,f2,f3
) Q ) P;
-- StringComparisonLtEq_p1
select 'StringComparisonLtEq_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 'BB' f3 from tversion union
select 1 f1, 15 f2, 'DD' f3 from tversion union
select 2 f1, null f2, 'EE' f3 from tversion union
select rnum,tjoin2.c1, tjoin2.c2 from tjoin2 where tjoin2.c2 <= 'EE'
) Q
group by
f1,f2,f3
) Q ) P;
-- StringComparisonLt_p1
select 'StringComparisonLt_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 'BB' f3 from tversion union
select 1 f1, 15 f2, 'DD' f3 from tversion union
select rnum,tjoin2.c1, tjoin2.c2 from tjoin2 where tjoin2.c2 < 'EE'
) Q
group by
f1,f2,f3
) Q ) P;
-- StringComparisonNtEq_p1
select 'StringComparisonNtEq_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 1 f1, 15 f2, 'DD' f3 from tversion union
select 2 f1, null f2, 'EE' f3 from tversion union
select 3 f1, 10 f2, 'FF' f3 from tversion union
select rnum,tjoin2.c1, tjoin2.c2 from tjoin2 where tjoin2.c2 <> 'BB'
) Q
group by
f1,f2,f3
) Q ) P;
-- StringComparisonNtEq_p2
select 'StringComparisonNtEq_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 1 f1, 15 f2, 'DD' f3 from tversion union
select 2 f1, null f2, 'EE' f3 from tversion union
select 3 f1, 10 f2, 'FF' f3 from tversion union
select rnum,tjoin2.c1, tjoin2.c2 from tjoin2 where tjoin2.c2 <> 'BB'
) Q
group by
f1,f2,f3
) Q ) P;
-- StringPredicateBetween_p1
select 'StringPredicateBetween_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 10 f1, 'BB' f2 from tversion union
select tjoin2.c1, tjoin2.c2 from tjoin2 where tjoin2.c2 between 'AA' and 'CC'
) Q
group by
f1,f2
) Q ) P;
-- StringPredicateIn_p1
select 'StringPredicateIn_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, 10 f2, 'BB' f3 from tversion union
select 2 f1, null f2, 'EE' f3 from tversion union
select rnum,tjoin2.c1, tjoin2.c2 from tjoin2 where tjoin2.c2 in ('ZZ','BB','EE')
) Q
group by
f1,f2,f3
) Q ) P;
-- StringPredicateLike_p1
select 'StringPredicateLike_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 10 f1, 'BB' f2 from tversion union
select tjoin2.c1, tjoin2.c2 from tjoin2 where tjoin2.c2 like 'B%'
) Q
group by
f1,f2
) Q ) P;
