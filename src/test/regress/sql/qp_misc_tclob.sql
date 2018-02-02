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
-- Name: tclob; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace:
--

CREATE TABLE tclob (
    rnum integer NOT NULL,
    cclob text
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
-- Name: vclob; Type: VIEW; Schema: public; Owner: gpadmin
--

CREATE VIEW vclob AS
    SELECT tclob.rnum, tclob.cclob FROM tclob;


--
-- Data for Name: tclob; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tclob (rnum, cclob) FROM stdin;
3	BB
0	\N
1
2
5	FF
4	EE
\.

--
-- Data for Name: tversion; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tversion (rnum, c1, cver, cnnull, ccnull) FROM stdin;
0	1	1.0   	\N	\N
\.


--
-- Name: clobpk; Type: CONSTRAINT; Schema: public; Owner: gpadmin; Tablespace:
--

ALTER TABLE ONLY tclob
    ADD CONSTRAINT clobpk PRIMARY KEY (rnum);
-- SubstringCoreBlob_p1
select 'SubstringCoreBlob_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, '' f2 from tversion union
select 3 f1, 'B' f2 from tversion union
select 4 f1, 'E' f2 from tversion union
select 5 f1, 'F' f2 from tversion union
select rnum, substring( tclob.cclob from 2 for 1)  from tclob
) Q
group by
f1,f2
) Q ) P;
-- CountClob_p1
select 'CountClob_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5 f1 from tversion union
select count(vclob.cclob) from vclob
) Q
group by
f1
) Q ) P;
-- CountClob_p2
select 'CountClob_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5 f1 from tversion union
select count(tclob.cclob) from tclob
) Q
group by
f1
) Q ) P;
