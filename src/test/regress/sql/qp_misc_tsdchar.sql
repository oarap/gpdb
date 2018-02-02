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
-- Name: tsdchar; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace:
--

CREATE TABLE tsdchar (
    rnum integer NOT NULL,
    c1 character(27)
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
-- Data for Name: tsdchar; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tsdchar (rnum, c1) FROM stdin;
3	-1.0
0	-1
1	0
2	10
7	10.0E+0
4	0.0
5	10.0
6	-1.0E-1
11	12:00:00.00+05:00
8	2000-12-31
9	23:59:30.123
10	2000-12-31 12:15:30.123
15	-1
12	2000-12-31 12:00:00.0+05:00
13	-1
14	10
19	-1
16	10
17	-01-01
18	10-10
23	-1
20	10
21	-1
22	10
27	-1 1
24	10
25	-1.5
26	10.20
31	-1 01:01:01
28	10 10
29	-1 01:01
30	10 20:30
35	-01:01:01
32	10 20:30:40
33	-1:01
34	10:20
37	-01:01
36	10:20:30
38	10:20
\.


--
-- Data for Name: tversion; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tversion (rnum, c1, cver, cnnull, ccnull) FROM stdin;
0	1	1.0   	\N	\N
\.

-- CastCharsToBigint_p1
select 'CastCharsToBigint_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, -1 f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 2 f1, 10 f2 from tversion union
select rnum, cast(c1 as bigint) from tsdchar where rnum in (0,1,2)
) Q
group by
f1,f2
) Q ) P;
-- CastCharsToSmallint_p1
select 'CastCharsToSmallint_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, -1 f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 2 f1, 10 f2 from tversion union
select rnum, cast(c1 as smallint) from tsdchar where rnum in (0,1,2)
) Q
group by
f1,f2
) Q ) P;

