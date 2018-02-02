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
-- Name: tdt; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace:
--

CREATE TABLE tdt (
    rnum integer NOT NULL,
    cdt date
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
-- Name: vdt; Type: VIEW; Schema: public; Owner: gpadmin
--

CREATE VIEW vdt AS
    SELECT tdt.rnum, tdt.cdt FROM tdt;


--
-- Data for Name: tdt; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tdt (rnum, cdt) FROM stdin;
3	2000-12-31
0	\N
1	1996-01-01
2	2000-01-01
\.

--
-- Data for Name: tversion; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tversion (rnum, c1, cver, cnnull, ccnull) FROM stdin;
0	1	1.0   	\N	\N
\.

-- CastDateToChar_p1
select 'CastDateToChar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '1996-01-01' f2 from tversion union
select 2 f1, '2000-01-01' f2 from tversion union
select 3 f1, '2000-12-31' f2 from tversion union
select vdt.rnum, cast(vdt.cdt as char(10)) from vdt
) Q
group by
f1,f2
) Q ) P;
-- CastDateToChar_p2
select 'CastDateToChar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '1996-01-01' f2 from tversion union
select 2 f1, '2000-01-01' f2 from tversion union
select 3 f1, '2000-12-31' f2 from tversion union
select tdt.rnum, cast(tdt.cdt as char(10)) from tdt
) Q
group by
f1,f2
) Q ) P;
-- CastDateToDate_p2
select 'CastDateToDate_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, cast('1996-01-01' as date) f2 from tversion union
select 2 f1, cast('2000-01-01' as date) f2 from tversion union
select 3 f1, cast('2000-12-31' as date) f2 from tversion union
select tdt.rnum, cast(tdt.cdt as date) from tdt
) Q
group by
f1,f2
) Q ) P;
-- CastDateToVarchar_p1
select 'CastDateToVarchar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '1996-01-01' f2 from tversion union
select 2 f1, '2000-01-01' f2 from tversion union
select 3 f1, '2000-12-31' f2 from tversion union
select vdt.rnum, cast(vdt.cdt as varchar(10)) from vdt
) Q
group by
f1,f2
) Q ) P;
-- CastDateToVarchar_p2
select 'CastDateToVarchar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '1996-01-01' f2 from tversion union
select 2 f1, '2000-01-01' f2 from tversion union
select 3 f1, '2000-12-31' f2 from tversion union
select tdt.rnum, cast(tdt.cdt as varchar(10)) from tdt
) Q
group by
f1,f2
) Q ) P;
-- CastDateToDate_p1
select 'CastDateToDate_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, cast('1996-01-01' as date) f2 from tversion union
select 2 f1, cast('2000-01-01' as date) f2 from tversion union
select 3 f1, cast('2000-12-31' as date) f2 from tversion union
select vdt.rnum, cast(vdt.cdt as date) from vdt
) Q
group by
f1,f2
) Q ) P;
-- ExtractCoreDayFromDate_p1
select 'ExtractCoreDayFromDate_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 01 f2 from tversion union
select 2 f1, 01 f2 from tversion union
select 3 f1, 31 f2 from tversion union
select vdt.rnum, extract( day from vdt.cdt ) from vdt
) Q
group by
f1,f2
) Q ) P;
-- ExtractCoreDayFromDate_p2
select 'ExtractCoreDayFromDate_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 01 f2 from tversion union
select 2 f1, 01 f2 from tversion union
select 3 f1, 31 f2 from tversion union
select tdt.rnum, extract( day from tdt.cdt ) from tdt
) Q
group by
f1,f2
) Q ) P;
-- ExtractCoreMonthFromDate_p1
select 'ExtractCoreMonthFromDate_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 01 f2 from tversion union
select 2 f1, 01 f2 from tversion union
select 3 f1, 12 f2 from tversion union
select vdt.rnum, extract( month from vdt.cdt ) from vdt
) Q
group by
f1,f2
) Q ) P;
-- ExtractCoreMonthFromDate_p2
select 'ExtractCoreMonthFromDate_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 01 f2 from tversion union
select 2 f1, 01 f2 from tversion union
select 3 f1, 12 f2 from tversion union
select tdt.rnum, extract( month from tdt.cdt ) from tdt
) Q
group by
f1,f2
) Q ) P;
-- ExtractCoreYearFromDate_p1
select 'ExtractCoreYearFromDate_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1996 f2 from tversion union
select 2 f1, 2000 f2 from tversion union
select 3 f1, 2000 f2 from tversion union
select vdt.rnum, extract( year from vdt.cdt ) from vdt
) Q
group by
f1,f2
) Q ) P;
-- ExtractCoreYearFromDate_p2
select 'ExtractCoreYearFromDate_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1996 f2 from tversion union
select 2 f1, 2000 f2 from tversion union
select 3 f1, 2000 f2 from tversion union
select tdt.rnum, extract( year from tdt.cdt ) from tdt
) Q
group by
f1,f2
) Q ) P;
-- SelectCountDate_p1
select 'SelectCountDate_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 3 f1 from tversion union
select count(vdt.cdt) from vdt
) Q
group by
f1
) Q ) P;
-- SelectCountDate_p2
select 'SelectCountDate_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 3 f1 from tversion union
select count(tdt.cdt) from tdt
) Q
group by
f1
) Q ) P;
