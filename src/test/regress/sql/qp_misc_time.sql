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
-- Name: ttm; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace:
--

CREATE TABLE ttm (
    rnum integer NOT NULL,
    ctm time(3) without time zone
) DISTRIBUTED BY (rnum);



--
-- Name: tts; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace:
--

CREATE TABLE tts (
    rnum integer NOT NULL,
    cts timestamp(3) without time zone
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
-- Name: vtm; Type: VIEW; Schema: public; Owner: gpadmin
--
CREATE VIEW vtm AS
    SELECT ttm.rnum, ttm.ctm FROM ttm;
--
-- Name: vts; Type: VIEW; Schema: public; Owner: gpadmin
--
CREATE VIEW vts AS
    SELECT tts.rnum, tts.cts FROM tts;


--
-- Data for Name: ttm; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY ttm (rnum, ctm) FROM stdin;
3	23:59:30.123
0	\N
1	00:00:00
2	12:00:00
\.


--
-- Data for Name: tts; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tts (rnum, cts) FROM stdin;
3	1996-01-01 23:59:30.123
0	\N
1	1996-01-01 00:00:00
2	1996-01-01 12:00:00
7	2000-12-31 00:00:00
4	2000-01-01 00:00:00
5	2000-01-01 12:00:00
6	2000-01-01 23:59:30.123
9	2000-12-31 12:15:30.123
8	2000-12-31 12:00:00
\.

--
-- Data for Name: tversion; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tversion (rnum, c1, cver, cnnull, ccnull) FROM stdin;
0	1	1.0   	\N	\N
\.



--
-- Greenplum Database database dump complete
--

-- end_ignore

-- END OF SETUP


-- SubstringCoreNegativeStart_p1
select 'SubstringCoreNegativeStart_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select '12' f1 from tversion union
select substring( '1234567890' from -2 for 5)  from tversion
) Q
group by
f1
) Q ) P;
-- SubstringCoreNullParameters_p1
select 'SubstringCoreNullParameters_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select null f1 from tversion union
select substring( '1234567890' from cnnull for 1)  from tversion
) Q
group by
f1
) Q ) P;
-- SubstringCoreNullParameters_p2
select 'SubstringCoreNullParameters_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select null f1 from tversion union
select substring( '1234567890' from 1 for cnnull)  from tversion
) Q
group by
f1
) Q ) P;
-- TableConstructor_p1
select 'TableConstructor_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 10 f1, 'BB' f2 from tversion union
select t1.c1, t1.c2 from (values (10,'BB')) t1(c1,c2)
) Q
group by
f1,f2
) Q ) P;
-- TrimBothCoreNullParameters_p1
select 'TrimBothCoreNullParameters_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select null f1 from tversion union
select trim(both ccnull from '++1234567890++' )  from tversion
) Q
group by
f1
) Q ) P;
-- TrimBothCoreNullParameters_p2
select 'TrimBothCoreNullParameters_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select null f1 from tversion union
select trim(both '+' from ccnull )  from tversion
) Q
group by
f1
) Q ) P;
-- TrimBothException_p1
select 'TrimBothException_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'error' f1 from tversion union
select trim(both '++' from '++1234567890++' )  from tversion
) Q
group by
f1
) Q ) P;
-- TrimBothSpacesCore_p1
select 'TrimBothSpacesCore_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select '1234567890' f1 from tversion union
select trim(both from '  1234567890  ' )  from tversion
) Q
group by
f1
) Q ) P;
-- TrimLeadingSpacesCore_p1
select 'TrimLeadingSpacesCore_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select '1234567890  ' f1 from tversion union
select trim(leading from '  1234567890  ' )  from tversion
) Q
group by
f1
) Q ) P;
-- TrimTrailingSpacesCore_p1
select 'TrimTrailingSpacesCore_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select '  1234567890' f1 from tversion union
select trim(trailing from '  1234567890  ' )  from tversion
) Q
group by
f1
) Q ) P;
-- UpperCoreSpecial_p1
select 'UpperCoreSpecial_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'ß' f1 from tversion union
select upper( 'ß' ) from tversion
) Q
group by
f1
) Q ) P;
-- NumericComparisonEqual_gp_p1
select 'NumericComparisonEqual_gp_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where not exists (select 1 from tversion where 7 = 210.3 union select 1 from tversion where 7 = cnnull)
) Q
group by
f1
) Q ) P;
-- SelectWhere_gp_p1
select 'SelectWhere_gp_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 0, 1 f1 from tversion union
select rnum, c1  from tversion where rnum=0
) Q
group by
f1
) Q ) P;
-- SimpleSelect_gp_p1
select 'SimpleSelect_gp_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select c1  from tversion
) Q
group by
f1
) Q ) P;
-- SubstringCoreLiteral_gp_p1
select 'SubstringCoreLiteral_gp_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, NULL f2 from tversion union
select 0 f1, 'B' f2 from tversion union
select rnum, substring( '' from 2 for 1)  from tversion
) Q
group by
f1,f2
) Q ) P;
-- SubstringCoreLiteral_gp_p2
select 'SubstringCoreLiteral_gp_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, NULL f2 from tversion union
select 0 f1, 'B' f2 from tversion union
select rnum, substring( ' ' from 2 for 1)  from tversion
) Q
group by
f1,f2
) Q ) P;
-- SubstringCoreLiteral_gp_p3
select 'SubstringCoreLiteral_gp_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, NULL f2 from tversion union
select 0 f1, 'B' f2 from tversion union
select rnum, substring( 'BB' from 2 for 1)  from tversion
) Q
group by
f1,f2
) Q ) P;
-- TrimCoreLiteral_gp_p1
select 'TrimCoreLiteral_gp_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 2 f1 from tversion union
select  length(trim( 'BB ' ))  from tversion
) Q
group by
f1
) Q ) P;
-- TrimCoreLiteral_gp_p2
select 'TrimCoreLiteral_gp_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 2 f1 from tversion union
select  length(trim( 'EE  ' ))  from tversion
) Q
group by
f1
) Q ) P;
-- TrimCoreLiteral_gp_p3
select 'TrimCoreLiteral_gp_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 2 f1 from tversion union
select  length(trim( '  FF      ' ))  from tversion
) Q
group by
f1
) Q ) P;
-- CastCharsToDate_p1
select 'CastCharsToDate_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select cast('2000-01-01' as date) f1 from tversion union
select cast('2000-01-01' as date) from tversion
) Q
group by
f1
) Q ) P;
-- CastCharsToDouble_p1
select 'CastCharsToDouble_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10.3 f1 from tversion union
select cast('10.3' as double precision) from tversion
) Q
group by
f1
) Q ) P;
-- CastCharsToFloat_p1
select 'CastCharsToFloat_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10.3 f1 from tversion union
select cast('10.3' as float) from tversion
) Q
group by
f1
) Q ) P;
-- CastCharsToInteger_p1
select 'CastCharsToInteger_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10 f1 from tversion union
select cast('10' as integer) from tversion
) Q
group by
f1
) Q ) P;
-- CastCharsToTimestamp_p1
select 'CastCharsToTimestamp_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select cast('2000-01-01 12:30:40' as timestamp) f1 from tversion union
select cast('2000-01-01 12:30:40' as timestamp) from tversion
) Q
group by
f1
) Q ) P;
-- AggregateInExpression_p1
select 'AggregateInExpression_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10 f1 from tversion union
select 10 * count( 1 ) from tversion
) Q
group by
f1
) Q ) P;
-- CastNvarcharToBigint_p1
select 'CastNvarcharToBigint_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select cast(n'1' as bigint) from tversion
) Q
group by
f1
) Q ) P;
-- CastNvarcharToDouble_p1
select 'CastNvarcharToDouble_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1.000000000000000e+000 f1 from tversion union
select cast(n'1.0' as double precision) from tversion
) Q
group by
f1
) Q ) P;
-- CastNvarcharToInteger_p1
select 'CastNvarcharToInteger_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select cast(n'1' as integer) from tversion
) Q
group by
f1
) Q ) P;
-- CastNvarcharToSmallint_p1
select 'CastNvarcharToSmallint_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select cast(n'1' as smallint) from tversion
) Q
group by
f1
) Q ) P;
-- CastTimestampToChar_p1
select 'CastTimestampToChar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '1996-01-01 00:00:00.000       ' f2 from tversion union
select 2 f1, '1996-01-01 12:00:00.000       ' f2 from tversion union
select 3 f1, '1996-01-01 23:59:30.123       ' f2 from tversion union
select 4 f1, '2000-01-01 00:00:00.000       ' f2 from tversion union
select 5 f1, '2000-01-01 12:00:00.000       ' f2 from tversion union
select 6 f1, '2000-01-01 23:59:30.123       ' f2 from tversion union
select 7 f1, '2000-12-31 00:00:00.000       ' f2 from tversion union
select 8 f1, '2000-12-31 12:00:00.000       ' f2 from tversion union
select 9 f1, '2000-12-31 12:15:30.123       ' f2 from tversion union
select vts.rnum, cast(vts.cts as char(30)) from vts
) Q
group by
f1,f2
) Q ) P;
-- CastTimestampToChar_p2
select 'CastTimestampToChar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '1996-01-01 00:00:00.000       ' f2 from tversion union
select 2 f1, '1996-01-01 12:00:00.000       ' f2 from tversion union
select 3 f1, '1996-01-01 23:59:30.123       ' f2 from tversion union
select 4 f1, '2000-01-01 00:00:00.000       ' f2 from tversion union
select 5 f1, '2000-01-01 12:00:00.000       ' f2 from tversion union
select 6 f1, '2000-01-01 23:59:30.123       ' f2 from tversion union
select 7 f1, '2000-12-31 00:00:00.000       ' f2 from tversion union
select 8 f1, '2000-12-31 12:00:00.000       ' f2 from tversion union
select 9 f1, '2000-12-31 12:15:30.123       ' f2 from tversion union
select tts.rnum, cast(tts.cts as char(30)) from tts
) Q
group by
f1,f2
) Q ) P;
-- CastTimestampToDate_p1
select 'CastTimestampToDate_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, cast('1996-01-01' as date) f2 from tversion union
select 2 f1, cast('1996-01-01' as date) f2 from tversion union
select 3 f1, cast('1996-01-01' as date) f2 from tversion union
select 4 f1, cast('2000-01-01' as date) f2 from tversion union
select 5 f1, cast('2000-01-01' as date) f2 from tversion union
select 6 f1, cast('2000-01-01' as date) f2 from tversion union
select 7 f1, cast('2000-12-31' as date) f2 from tversion union
select 8 f1, cast('2000-12-31' as date) f2 from tversion union
select 9 f1, cast('2000-12-31' as date) f2 from tversion union
select vts.rnum, cast(vts.cts as date) from vts
) Q
group by
f1,f2
) Q ) P;
-- CastTimestampToDate_p2
select 'CastTimestampToDate_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, cast('1996-01-01' as date) f2 from tversion union
select 2 f1, cast('1996-01-01' as date) f2 from tversion union
select 3 f1, cast('1996-01-01' as date) f2 from tversion union
select 4 f1, cast('2000-01-01' as date) f2 from tversion union
select 5 f1, cast('2000-01-01' as date) f2 from tversion union
select 6 f1, cast('2000-01-01' as date) f2 from tversion union
select 7 f1, cast('2000-12-31' as date) f2 from tversion union
select 8 f1, cast('2000-12-31' as date) f2 from tversion union
select 9 f1, cast('2000-12-31' as date) f2 from tversion union
select tts.rnum, cast(tts.cts as date) from tts
) Q
group by
f1,f2
) Q ) P;
-- CastTimestampToVarchar_p1
select 'CastTimestampToVarchar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '1996-01-01 00:00:00.000' f2 from tversion union
select 2 f1, '1996-01-01 12:00:00.000' f2 from tversion union
select 3 f1, '1996-01-01 23:59:30.123' f2 from tversion union
select 4 f1, '2000-01-01 00:00:00.000' f2 from tversion union
select 5 f1, '2000-01-01 12:00:00.000' f2 from tversion union
select 6 f1, '2000-01-01 23:59:30.123' f2 from tversion union
select 7 f1, '2000-12-31 00:00:00.000' f2 from tversion union
select 8 f1, '2000-12-31 12:00:00.000000000' f2 from tversion union
select 9 f1, '2000-12-31 12:15:30.123000000' f2 from tversion union
select vts.rnum,cast(vts.cts as varchar(100)) from vts
) Q
group by
f1,f2
) Q ) P;
-- CastTimestampToVarchar_p2
select 'CastTimestampToVarchar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '1996-01-01 00:00:00.000' f2 from tversion union
select 2 f1, '1996-01-01 12:00:00.000' f2 from tversion union
select 3 f1, '1996-01-01 23:59:30.123' f2 from tversion union
select 4 f1, '2000-01-01 00:00:00.000' f2 from tversion union
select 5 f1, '2000-01-01 12:00:00.000' f2 from tversion union
select 6 f1, '2000-01-01 23:59:30.123' f2 from tversion union
select 7 f1, '2000-12-31 00:00:00.000' f2 from tversion union
select 8 f1, '2000-12-31 12:00:00.000000000' f2 from tversion union
select 9 f1, '2000-12-31 12:15:30.123000000' f2 from tversion union
select tts.rnum,cast(tts.cts as varchar(100)) from tts
) Q
group by
f1,f2
) Q ) P;
-- CastTimeToChar_p1
select 'CastTimeToChar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '00:00:00.000        ' f2 from tversion union
select 2 f1, '12:00:00.000        ' f2 from tversion union
select 3 f1, '23:59:30.123        ' f2 from tversion union
select vtm.rnum, cast(vtm.ctm as char(20)) from vtm
) Q
group by
f1,f2
) Q ) P;
-- CastTimeToChar_p2
select 'CastTimeToChar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '00:00:00.000        ' f2 from tversion union
select 2 f1, '12:00:00.000        ' f2 from tversion union
select 3 f1, '23:59:30.123        ' f2 from tversion union
select ttm.rnum, cast(ttm.ctm as char(20)) from ttm
) Q
group by
f1,f2
) Q ) P;
-- CastTimeToVarchar_p1
select 'CastTimeToVarchar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '00:00:00.000' f2 from tversion union
select 2 f1, '12:00:00.000' f2 from tversion union
select 3 f1, '23:59:30.123' f2 from tversion union
select vtm.rnum,cast(vtm.ctm as varchar(100)) from vtm
) Q
group by
f1,f2
) Q ) P;
-- CastTimeToVarchar_p2
select 'CastTimeToVarchar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '00:00:00.000' f2 from tversion union
select 2 f1, '12:00:00.000' f2 from tversion union
select 3 f1, '23:59:30.123' f2 from tversion union
select ttm.rnum,cast(ttm.ctm as varchar(100)) from ttm
) Q
group by
f1,f2
) Q ) P;
-- CastVarcharToBigint_p1
select 'CastVarcharToBigint_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select cast('1' as bigint) from tversion
) Q
group by
f1
) Q ) P;
-- CastVarcharToDate_p1
select 'CastVarcharToDate_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select cast('2000-01-01' as date) f1 from tversion union
select cast('2000-01-01' as date) from tversion
) Q
group by
f1
) Q ) P;
-- CastVarcharToDate_p2
select 'CastVarcharToDate_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select cast('2000-01-01' as date) f1 from tversion union
select cast('2000-01-01' as date) from tversion
) Q
group by
f1
) Q ) P;
-- CastVarcharToDate_p3
select 'CastVarcharToDate_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select cast('2000-01-01' as date) f1 from tversion union
select cast('2000-01-01' as date) from tversion
) Q
group by
f1
) Q ) P;
-- CastVarcharToDate_p4
select 'CastVarcharToDate_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select cast('2000-01-01' as date) f1 from tversion union
select cast('2000-01-01' as date) from tversion
) Q
group by
f1
) Q ) P;
-- CastVarcharToDate_p5
select 'CastVarcharToDate_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select cast('2000-01-01' as date) f1 from tversion union
select cast('2000-01-01' as date) from tversion
) Q
group by
f1
) Q ) P;
-- CastVarcharToDouble_p1
select 'CastVarcharToDouble_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1.000000000000000e+000 f1 from tversion union
select cast('1.0' as double precision) from tversion
) Q
group by
f1
) Q ) P;
-- CastVarcharToFloat_p1
select 'CastVarcharToFloat_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1.000000000000000e+000 f1 from tversion union
select cast('1.0' as float) from tversion
) Q
group by
f1
) Q ) P;
-- CastVarcharToFloat_p2
select 'CastVarcharToFloat_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1.000000000000000e+000 f1 from tversion union
select cast('1.0' as float) from tversion
) Q
group by
f1
) Q ) P;
-- CastVarcharToInteger_p1
select 'CastVarcharToInteger_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select cast('1' as integer) from tversion
) Q
group by
f1
) Q ) P;
-- CastVarcharToSmallint_p1
select 'CastVarcharToSmallint_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select cast('1' as smallint) from tversion
) Q
group by
f1
) Q ) P;
-- CastVarcharToTimestamp_p1
select 'CastVarcharToTimestamp_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select cast('2000-01-01 12:00:00.000000000' as timestamp) f1 from tversion union
select cast('2000-01-01 12:00:00' as timestamp) from tversion
) Q
group by
f1
) Q ) P;
-- ApproximateNumericOpMulNULL_p1
select 'ApproximateNumericOpMulNULL_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select null f1 from tversion union
select -1.0e+0 * cnnull from tversion
) Q
group by
f1
) Q ) P;
-- CharacterLiteral_p1
select 'CharacterLiteral_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'BB' f1 from tversion union
select 'BB' from tversion
) Q
group by
f1
) Q ) P;
-- CharacterLiteral_p2
select 'CharacterLiteral_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'BB' f1 from tversion union
select 'BB' from tversion
) Q
group by
f1
) Q ) P;
-- ApproximateNumericOpMulNULL_p2
select 'ApproximateNumericOpMulNULL_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select null f1 from tversion union
select 0.0e+0 * cnnull from tversion
) Q
group by
f1
) Q ) P;
-- CoalesceCoreNullParameters_p1
select 'CoalesceCoreNullParameters_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select null f1 from tversion union
select coalesce( ccnull, ccnull, ccnull ) from tversion
) Q
group by
f1
) Q ) P;
-- CoalesceCore_p1
select 'CoalesceCore_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'A' f1 from tversion union
select coalesce( ccnull, 'A', 'B' ) from tversion
) Q
group by
f1
) Q ) P;
-- Comments1_p1
select 'Comments1_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select /* hello */ 1 from tversion
) Q
group by
f1
) Q ) P;
-- ApproximateNumericOpMulNULL_p3
select 'ApproximateNumericOpMulNULL_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select null f1 from tversion union
select 1.0e+0 * cnnull from tversion
) Q
group by
f1
) Q ) P;
-- ApproximateNumericOpMulNULL_p4
select 'ApproximateNumericOpMulNULL_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select null f1 from tversion union
select -1.0e-1 * cnnull from tversion
) Q
group by
f1
) Q ) P;
-- CountCharLiteral_p1
select 'CountCharLiteral_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count('') from tversion
) Q
group by
f1
) Q ) P;
-- CountCharLiteral_p10
select 'CountCharLiteral_p10' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count('FF') from tversion
) Q
group by
f1
) Q ) P;
-- CountCharLiteral_p2
select 'CountCharLiteral_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(' ') from tversion
) Q
group by
f1
) Q ) P;
-- CountCharLiteral_p3
select 'CountCharLiteral_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count('BB') from tversion
) Q
group by
f1
) Q ) P;
-- CountCharLiteral_p4
select 'CountCharLiteral_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count('EE') from tversion
) Q
group by
f1
) Q ) P;
-- CountCharLiteral_p5
select 'CountCharLiteral_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count('FF') from tversion
) Q
group by
f1
) Q ) P;
-- CountCharLiteral_p6
select 'CountCharLiteral_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count('') from tversion
) Q
group by
f1
) Q ) P;
-- ApproximateNumericOpMulNULL_p5
select 'ApproximateNumericOpMulNULL_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select null f1 from tversion union
select 10.0e+0 * cnnull from tversion
) Q
group by
f1
) Q ) P;
-- CountCharLiteral_p7
select 'CountCharLiteral_p7' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(' ') from tversion
) Q
group by
f1
) Q ) P;
-- CountCharLiteral_p8
select 'CountCharLiteral_p8' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count('BB') from tversion
) Q
group by
f1
) Q ) P;
-- CountCharLiteral_p9
select 'CountCharLiteral_p9' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count('EE') from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p1
select 'CountNumericLiteral_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(-1.0e+0) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p10
select 'CountNumericLiteral_p10' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(10.0e+0) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p11
select 'CountNumericLiteral_p11' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(-1.0e+0) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p12
select 'CountNumericLiteral_p12' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(0.0e+0) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p13
select 'CountNumericLiteral_p13' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(1.0e+0) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p14
select 'CountNumericLiteral_p14' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(-1.0e-1) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p15
select 'CountNumericLiteral_p15' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(10.0e+0) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p16
select 'CountNumericLiteral_p16' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(-1.0) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p17
select 'CountNumericLiteral_p17' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(0.0) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p18
select 'CountNumericLiteral_p18' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(1.0) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p19
select 'CountNumericLiteral_p19' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(0.1) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p2
select 'CountNumericLiteral_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(0.0e+0) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p20
select 'CountNumericLiteral_p20' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(10.0) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p21
select 'CountNumericLiteral_p21' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(-1.0) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p22
select 'CountNumericLiteral_p22' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(0.0) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p23
select 'CountNumericLiteral_p23' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(1.0) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p24
select 'CountNumericLiteral_p24' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(0.1) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p25
select 'CountNumericLiteral_p25' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(10.0) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p26
select 'CountNumericLiteral_p26' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(-1) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p27
select 'CountNumericLiteral_p27' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(0) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p28
select 'CountNumericLiteral_p28' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(1) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p29
select 'CountNumericLiteral_p29' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(10) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p3
select 'CountNumericLiteral_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(1.0e+0) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p30
select 'CountNumericLiteral_p30' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(-1) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p31
select 'CountNumericLiteral_p31' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(0) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p32
select 'CountNumericLiteral_p32' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(1) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p33
select 'CountNumericLiteral_p33' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(10) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p34
select 'CountNumericLiteral_p34' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(-1) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p35
select 'CountNumericLiteral_p35' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(0) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p36
select 'CountNumericLiteral_p36' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(1) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p37
select 'CountNumericLiteral_p37' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(10) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p4
select 'CountNumericLiteral_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(-1.0e-1) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p5
select 'CountNumericLiteral_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(10.0e+0) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p6
select 'CountNumericLiteral_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(-1.0e+0) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p7
select 'CountNumericLiteral_p7' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(0.0e+0) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p8
select 'CountNumericLiteral_p8' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(1.0e+0) from tversion
) Q
group by
f1
) Q ) P;
-- CountNumericLiteral_p9
select 'CountNumericLiteral_p9' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(-1.0e-1) from tversion
) Q
group by
f1
) Q ) P;
-- CountTemporalLiteral_p1
select 'CountTemporalLiteral_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(date '1996-01-01') from tversion
) Q
group by
f1
) Q ) P;
-- CountTemporalLiteral_p10
select 'CountTemporalLiteral_p10' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(timestamp '2000-12-31 00:00:00') from tversion
) Q
group by
f1
) Q ) P;
-- CountTemporalLiteral_p11
select 'CountTemporalLiteral_p11' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(timestamp '2000-12-31 12:00:00') from tversion
) Q
group by
f1
) Q ) P;
-- CountTemporalLiteral_p12
select 'CountTemporalLiteral_p12' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(timestamp '2000-12-31 23:59:30.123') from tversion
) Q
group by
f1
) Q ) P;
-- CountTemporalLiteral_p2
select 'CountTemporalLiteral_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(date '2000-01-01') from tversion
) Q
group by
f1
) Q ) P;
-- CountTemporalLiteral_p3
select 'CountTemporalLiteral_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(date '2000-12-31') from tversion
) Q
group by
f1
) Q ) P;
-- CountTemporalLiteral_p4
select 'CountTemporalLiteral_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(time '00:00:00.000') from tversion
) Q
group by
f1
) Q ) P;
-- CountTemporalLiteral_p5
select 'CountTemporalLiteral_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(time '12:00:00.000') from tversion
) Q
group by
f1
) Q ) P;
-- CountTemporalLiteral_p6
select 'CountTemporalLiteral_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(time '23:59:30.123') from tversion
) Q
group by
f1
) Q ) P;
-- CountTemporalLiteral_p7
select 'CountTemporalLiteral_p7' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(timestamp '2000-01-01 00:00:00.0') from tversion
) Q
group by
f1
) Q ) P;
-- CountTemporalLiteral_p8
select 'CountTemporalLiteral_p8' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(timestamp '2000-01-01 12:00:00') from tversion
) Q
group by
f1
) Q ) P;
-- CountTemporalLiteral_p9
select 'CountTemporalLiteral_p9' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(timestamp '2000-01-01 23:59:30.123') from tversion
) Q
group by
f1
) Q ) P;
-- CountValueExpression_p1
select 'CountValueExpression_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count( 1 * 10 ) from tversion
) Q
group by
f1
) Q ) P;
-- DateLiteral_p1
select 'DateLiteral_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select '1996-01-01' f1 from tversion union
select date '1996-01-01' from tversion
) Q
group by
f1
) Q ) P;
-- ExactNumericOpMulNULL_p1
select 'ExactNumericOpMulNULL_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select null f1 from tversion union
select -1.0 * cnnull from tversion
) Q
group by
f1
) Q ) P;
-- ExactNumericOpMulNULL_p2
select 'ExactNumericOpMulNULL_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select null f1 from tversion union
select 0.0 * cnnull from tversion
) Q
group by
f1
) Q ) P;
-- ExactNumericOpMulNULL_p3
select 'ExactNumericOpMulNULL_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select null f1 from tversion union
select 1.0 * cnnull from tversion
) Q
group by
f1
) Q ) P;
-- ExactNumericOpMulNULL_p4
select 'ExactNumericOpMulNULL_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select null f1 from tversion union
select 0.1 * cnnull from tversion
) Q
group by
f1
) Q ) P;
-- ExactNumericOpMulNULL_p5
select 'ExactNumericOpMulNULL_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select null f1 from tversion union
select 10.0 * cnnull from tversion
) Q
group by
f1
) Q ) P;
-- ExtractCoreDayFromTimestamp_p1
select 'ExtractCoreDayFromTimestamp_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 01 f2 from tversion union
select 2 f1, 01 f2 from tversion union
select 3 f1, 01 f2 from tversion union
select 4 f1, 01 f2 from tversion union
select 5 f1, 01 f2 from tversion union
select 6 f1, 01 f2 from tversion union
select 7 f1, 31 f2 from tversion union
select 8 f1, 31 f2 from tversion union
select 9 f1, 31 f2 from tversion union
select vts.rnum, extract( day from vts.cts ) from vts
) Q
group by
f1,f2
) Q ) P;
-- ExtractCoreDayFromTimestamp_p2
select 'ExtractCoreDayFromTimestamp_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 01 f2 from tversion union
select 2 f1, 01 f2 from tversion union
select 3 f1, 01 f2 from tversion union
select 4 f1, 01 f2 from tversion union
select 5 f1, 01 f2 from tversion union
select 6 f1, 01 f2 from tversion union
select 7 f1, 31 f2 from tversion union
select 8 f1, 31 f2 from tversion union
select 9 f1, 31 f2 from tversion union
select tts.rnum, extract( day from tts.cts ) from tts
) Q
group by
f1,f2
) Q ) P;
-- ExtractCoreHourFromTimestamp_p1
select 'ExtractCoreHourFromTimestamp_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 2 f1, 12 f2 from tversion union
select 3 f1, 23 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 12 f2 from tversion union
select 6 f1, 23 f2 from tversion union
select 7 f1, 0 f2 from tversion union
select 8 f1, 12 f2 from tversion union
select 9 f1, 12 f2 from tversion union
select vts.rnum, extract( hour from vts.cts ) from vts
) Q
group by
f1,f2
) Q ) P;
-- ExtractCoreHourFromTimestamp_p2
select 'ExtractCoreHourFromTimestamp_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 2 f1, 12 f2 from tversion union
select 3 f1, 23 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 12 f2 from tversion union
select 6 f1, 23 f2 from tversion union
select 7 f1, 0 f2 from tversion union
select 8 f1, 12 f2 from tversion union
select 9 f1, 12 f2 from tversion union
select tts.rnum, extract( hour from tts.cts ) from tts
) Q
group by
f1,f2
) Q ) P;
-- ExtractCoreHourFromTime_p1
select 'ExtractCoreHourFromTime_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 2 f1, 12 f2 from tversion union
select 3 f1, 23 f2 from tversion union
select vtm.rnum, extract( hour from vtm.ctm ) from vtm
) Q
group by
f1,f2
) Q ) P;
-- ExtractCoreHourFromTime_p2
select 'ExtractCoreHourFromTime_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 2 f1, 12 f2 from tversion union
select 3 f1, 23 f2 from tversion union
select ttm.rnum, extract( hour from ttm.ctm ) from ttm
) Q
group by
f1,f2
) Q ) P;
-- ExtractCoreMinuteFromTimestamp_p1
select 'ExtractCoreMinuteFromTimestamp_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 59 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 0 f2 from tversion union
select 6 f1, 59 f2 from tversion union
select 7 f1, 0 f2 from tversion union
select 8 f1, 0 f2 from tversion union
select 9 f1, 15 f2 from tversion union
select vts.rnum, extract( minute from vts.cts ) from vts
) Q
group by
f1,f2
) Q ) P;
-- ExtractCoreMinuteFromTimestamp_p2
select 'ExtractCoreMinuteFromTimestamp_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 59 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 0 f2 from tversion union
select 6 f1, 59 f2 from tversion union
select 7 f1, 0 f2 from tversion union
select 8 f1, 0 f2 from tversion union
select 9 f1, 15 f2 from tversion union
select tts.rnum, extract( minute from tts.cts ) from tts
) Q
group by
f1,f2
) Q ) P;
-- ExtractCoreMinuteFromTime_p1
select 'ExtractCoreMinuteFromTime_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 59 f2 from tversion union
select vtm.rnum, extract( minute from vtm.ctm ) from vtm
) Q
group by
f1,f2
) Q ) P;
-- ExtractCoreMinuteFromTime_p2
select 'ExtractCoreMinuteFromTime_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 59 f2 from tversion union
select ttm.rnum, extract( minute from ttm.ctm ) from ttm
) Q
group by
f1,f2
) Q ) P;
-- ExtractCoreMonthFromTimestamp_p1
select 'ExtractCoreMonthFromTimestamp_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 01 f2 from tversion union
select 2 f1, 01 f2 from tversion union
select 3 f1, 01 f2 from tversion union
select 4 f1, 01 f2 from tversion union
select 5 f1, 01 f2 from tversion union
select 6 f1, 01 f2 from tversion union
select 7 f1, 12 f2 from tversion union
select 8 f1, 12 f2 from tversion union
select 9 f1, 12 f2 from tversion union
select vts.rnum, extract( month from vts.cts ) from vts
) Q
group by
f1,f2
) Q ) P;
-- ExtractCoreMonthFromTimestamp_p2
select 'ExtractCoreMonthFromTimestamp_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 01 f2 from tversion union
select 2 f1, 01 f2 from tversion union
select 3 f1, 01 f2 from tversion union
select 4 f1, 01 f2 from tversion union
select 5 f1, 01 f2 from tversion union
select 6 f1, 01 f2 from tversion union
select 7 f1, 12 f2 from tversion union
select 8 f1, 12 f2 from tversion union
select 9 f1, 12 f2 from tversion union
select tts.rnum, extract( month from tts.cts ) from tts
) Q
group by
f1,f2
) Q ) P;
-- ExtractCoreSecondFromTimestamp_p1
select 'ExtractCoreSecondFromTimestamp_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1,  0000.000000 f2 from tversion union
select 2 f1,  0000.000000 f2 from tversion union
select 3 f1,  0030.123000 f2 from tversion union
select 4 f1,  0000.000000 f2 from tversion union
select 5 f1,  0000.000000 f2 from tversion union
select 6 f1,  0030.123000 f2 from tversion union
select 7 f1,  0000.000000 f2 from tversion union
select 8 f1,  0000.000000 f2 from tversion union
select 9 f1,  0030.123000 f2 from tversion union
select vts.rnum, extract( second from vts.cts ) from vts
) Q
group by
f1,f2
) Q ) P;
-- ExtractCoreSecondFromTimestamp_p2
select 'ExtractCoreSecondFromTimestamp_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1,  0000.000000 f2 from tversion union
select 2 f1,  0000.000000 f2 from tversion union
select 3 f1,  0030.123000 f2 from tversion union
select 4 f1,  0000.000000 f2 from tversion union
select 5 f1,  0000.000000 f2 from tversion union
select 6 f1,  0030.123000 f2 from tversion union
select 7 f1,  0000.000000 f2 from tversion union
select 8 f1,  0000.000000 f2 from tversion union
select 9 f1,  0030.123000 f2 from tversion union
select tts.rnum, extract( second from tts.cts ) from tts
) Q
group by
f1,f2
) Q ) P;
-- ExtractCoreSecondFromTime_p1
select 'ExtractCoreSecondFromTime_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 30.123 f2 from tversion union
select vtm.rnum, extract( second from vtm.ctm ) from vtm
) Q
group by
f1,f2
) Q ) P;
-- ExtractCoreSecondFromTime_p2
select 'ExtractCoreSecondFromTime_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 30.123 f2 from tversion union
select ttm.rnum, extract( second from ttm.ctm ) from ttm
) Q
group by
f1,f2
) Q ) P;
-- ExtractCoreYearFromTimestamp_p1
select 'ExtractCoreYearFromTimestamp_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1996 f2 from tversion union
select 2 f1, 1996 f2 from tversion union
select 3 f1, 1996 f2 from tversion union
select 4 f1, 2000 f2 from tversion union
select 5 f1, 2000 f2 from tversion union
select 6 f1, 2000 f2 from tversion union
select 7 f1, 2000 f2 from tversion union
select 8 f1, 2000 f2 from tversion union
select 9 f1, 2000 f2 from tversion union
select vts.rnum, extract( year from vts.cts ) from vts
) Q
group by
f1,f2
) Q ) P;
-- ExtractCoreYearFromTimestamp_p2
select 'ExtractCoreYearFromTimestamp_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1996 f2 from tversion union
select 2 f1, 1996 f2 from tversion union
select 3 f1, 1996 f2 from tversion union
select 4 f1, 2000 f2 from tversion union
select 5 f1, 2000 f2 from tversion union
select 6 f1, 2000 f2 from tversion union
select 7 f1, 2000 f2 from tversion union
select 8 f1, 2000 f2 from tversion union
select 9 f1, 2000 f2 from tversion union
select tts.rnum, extract( year from tts.cts ) from tts
) Q
group by
f1,f2
) Q ) P;
-- IntegerOpMulNULL_p1
select 'IntegerOpMulNULL_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select null f1 from tversion union
select -1.0e+0 * cnnull from tversion
) Q
group by
f1
) Q ) P;
-- IntegerOpMulNULL_p2
select 'IntegerOpMulNULL_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select null f1 from tversion union
select 0.0e+0 * cnnull from tversion
) Q
group by
f1
) Q ) P;
-- IntegerOpMulNULL_p3
select 'IntegerOpMulNULL_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select null f1 from tversion union
select 1.0e+0 * cnnull from tversion
) Q
group by
f1
) Q ) P;
-- IntegerOpMulNULL_p4
select 'IntegerOpMulNULL_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select null f1 from tversion union
select -1.0e-1 * cnnull from tversion
) Q
group by
f1
) Q ) P;
-- IntegerOpMulNULL_p5
select 'IntegerOpMulNULL_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select null f1 from tversion union
select 10.0e+0 * cnnull from tversion
) Q
group by
f1
) Q ) P;
-- IsNullValueExpr_p1
select 'IsNullValueExpr_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select c1 from tversion where 1 * cnnull is null
) Q
group by
f1
) Q ) P;
-- LnCoreNull_p1
select 'LnCoreNull_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select null f1 from tversion union
select ln( null ) from tversion
) Q
group by
f1
) Q ) P;
-- LnCore_p1
select 'LnCore_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 2.302585092994050e+000 f1 from tversion union
select ln( 10 ) from tversion
) Q
group by
f1
) Q ) P;
-- LnCore_p2
select 'LnCore_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 2.302585092994050e+000 f1 from tversion union
select ln( 10.0e+0 ) from tversion
) Q
group by
f1
) Q ) P;
-- LnCore_p3
select 'LnCore_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 2.302585092994050e+000 f1 from tversion union
select ln( 10.0 ) from tversion
) Q
group by
f1
) Q ) P;
-- LowerCoreSpecial_p1
select 'LowerCoreSpecial_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'ß' f1 from tversion union
select lower( 'ß' ) from tversion
) Q
group by
f1
) Q ) P;
-- MaxLiteralTemp_p1
select 'MaxLiteralTemp_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select '2000-01-01' f1 from tversion union
select max( '2000-01-01' ) from tversion
) Q
group by
f1
) Q ) P;
-- MinLiteralTemp_p1
select 'MinLiteralTemp_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select '2000-01-01' f1 from tversion union
select min( '2000-01-01' ) from tversion
) Q
group by
f1
) Q ) P;
-- ModBoundaryTinyNumber_p1
select 'ModBoundaryTinyNumber_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 0 f1 from tversion union
select mod( 35, 0.000000000001 ) from tversion
) Q
group by
f1
) Q ) P;
-- Negate_p1
select 'Negate_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select -4 f1 from tversion union
select -(2 * 2) from tversion
) Q
group by
f1
) Q ) P;
-- NullifCoreReturnsNull_p1
select 'NullifCoreReturnsNull_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select null f1 from tversion union
select nullif(cnnull, cnnull) from tversion
) Q
group by
f1
) Q ) P;
-- NullifCoreReturnsNull_p2
select 'NullifCoreReturnsNull_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select null f1 from tversion union
select nullif(1,1) from tversion
) Q
group by
f1
) Q ) P;
-- NullifCoreReturnsNull_p3
select 'NullifCoreReturnsNull_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select null f1 from tversion union
select nullif(cnnull, 1) from tversion
) Q
group by
f1
) Q ) P;
-- NullifCoreReturnsOne_p1
select 'NullifCoreReturnsOne_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select nullif(1,2) from tversion
) Q
group by
f1
) Q ) P;
-- NumericComparisonGreaterThanOrEqual_p1
select 'NumericComparisonGreaterThanOrEqual_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where 210.3 >= 7
) Q
group by
f1
) Q ) P;
-- NumericComparisonGreaterThan_p1
select 'NumericComparisonGreaterThan_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where 210.3 > 7
) Q
group by
f1
) Q ) P;
-- NumericComparisonLessThanOrEqual_p1
select 'NumericComparisonLessThanOrEqual_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where 7 <= 210.3
) Q
group by
f1
) Q ) P;
-- NumericComparisonLessThan_p1
select 'NumericComparisonLessThan_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where 7 < 210.3
) Q
group by
f1
) Q ) P;
-- NumericComparisonNotEqual_p1
select 'NumericComparisonNotEqual_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where 7 <> 210.3
) Q
group by
f1
) Q ) P;
-- NumericLiteral_p1
select 'NumericLiteral_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select +1.000000000000000e+000 f1 from tversion union
select 1.0 from tversion
) Q
group by
f1
) Q ) P;
-- PowerBoundary_p1
select 'PowerBoundary_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select power( 0,0 ) from tversion
) Q
group by
f1
) Q ) P;
-- BooleanComparisonOperatorAnd_p1
select 'BooleanComparisonOperatorAnd_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where (1 < 2) and (3 < 4)
) Q
group by
f1
) Q ) P;
-- PowerCoreNegativeBaseOddExp_p1
select 'PowerCoreNegativeBaseOddExp_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select -64 f1 from tversion union
select power( -4,3 ) from tversion
) Q
group by
f1
) Q ) P;
-- BooleanComparisonOperatorNotOperatorAnd_p1
select 'BooleanComparisonOperatorNotOperatorAnd_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where not (2 < 1) and (3 < 4)
) Q
group by
f1
) Q ) P;
-- BooleanComparisonOperatorNotOperatorOr_p1
select 'BooleanComparisonOperatorNotOperatorOr_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where not (2 < 1) or (3 < 4)
) Q
group by
f1
) Q ) P;
-- BooleanComparisonOperatorOr_p1
select 'BooleanComparisonOperatorOr_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where (1 < 2) or (4 < 3)
) Q
group by
f1
) Q ) P;
-- SelectCountNullNumeric_p1
select 'SelectCountNullNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 0 f1 from tversion union
select count(cnnull) from tversion
) Q
group by
f1
) Q ) P;
-- SelectCountNullNumeric_p2
select 'SelectCountNullNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 0 f1 from tversion union
select count(cnnull) from tversion
) Q
group by
f1
) Q ) P;
-- SelectCountNull_p1
select 'SelectCountNull_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 0 f1 from tversion union
select count(ccnull) from tversion
) Q
group by
f1
) Q ) P;
-- SelectCountStar_p1
select 'SelectCountStar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select count(*) from tversion
) Q
group by
f1
) Q ) P;
-- SelectCountTimestamp_p1
select 'SelectCountTimestamp_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 9 f1 from tversion union
select count(vts.cts) from vts
) Q
group by
f1
) Q ) P;
-- SelectCountTimestamp_p2
select 'SelectCountTimestamp_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 9 f1 from tversion union
select count(tts.cts) from tts
) Q
group by
f1
) Q ) P;
-- SelectCountTime_p1
select 'SelectCountTime_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 3 f1 from tversion union
select count(vtm.ctm) from vtm
) Q
group by
f1
) Q ) P;
-- SelectCountTime_p2
select 'SelectCountTime_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 3 f1 from tversion union
select count(ttm.ctm) from ttm
) Q
group by
f1
) Q ) P;
-- SelectDateComparisonEqualTo_p1
select 'SelectDateComparisonEqualTo_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where date '2001-01-01' = date '2001-01-01'
) Q
group by
f1
) Q ) P;
-- SelectDateComparisonGreaterThanOrEqualTo_p1
select 'SelectDateComparisonGreaterThanOrEqualTo_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where date '2001-01-01' >= date '2000-01-01'
) Q
group by
f1
) Q ) P;
-- SelectDateComparisonGreaterThan_p1
select 'SelectDateComparisonGreaterThan_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where date '2001-01-01' > date '2000-01-01'
) Q
group by
f1
) Q ) P;
-- SelectDateComparisonLessThanOrEqualTo_p1
select 'SelectDateComparisonLessThanOrEqualTo_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where date '2000-01-01' <= date '2001-01-01'
) Q
group by
f1
) Q ) P;
-- SelectDateComparisonLessThan_p1
select 'SelectDateComparisonLessThan_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where date '2000-01-01' < date '2001-01-01'
) Q
group by
f1
) Q ) P;
-- SelectDateComparisonNotEqualTo_p1
select 'SelectDateComparisonNotEqualTo_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where date '2001-01-01' <> date '2000-01-01'
) Q
group by
f1
) Q ) P;
-- SelectMaxLit_p1
select 'SelectMaxLit_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'A' f1 from tversion union
select max( 'A' ) from tversion
) Q
group by
f1
) Q ) P;
-- SelectMaxNullNumeric_p1
select 'SelectMaxNullNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select null f1 from tversion union
select max( cnnull ) from tversion
) Q
group by
f1
) Q ) P;
-- SelectMaxNull_p1
select 'SelectMaxNull_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select null f1 from tversion union
select max( ccnull ) from tversion
) Q
group by
f1
) Q ) P;
-- SelectMinLit_p1
select 'SelectMinLit_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'A' f1 from tversion union
select min( 'A' ) from tversion
) Q
group by
f1
) Q ) P;
-- SelectMinNullNumeric_p1
select 'SelectMinNullNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select null f1 from tversion union
select min( cnnull ) from tversion
) Q
group by
f1
) Q ) P;
-- SelectMinNull_p1
select 'SelectMinNull_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select null f1 from tversion union
select min( ccnull ) from tversion
) Q
group by
f1
) Q ) P;
-- SelectStar_p1
select 'SelectStar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3,f4,f5, count(*) c  from (
select 0 f1, 1 f2, '1.0   ' f3, null f4, null f5 from tversion union
select * from tversion
) Q
group by
f1,f2,f3,f4,f5
) Q ) P;
-- SelectTimeComparisonEqualTo_p1
select 'SelectTimeComparisonEqualTo_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where time '10:20:30' = time '10:20:30'
) Q
group by
f1
) Q ) P;
-- SelectTimeComparisonGreaterThanOrEqualTo_p1
select 'SelectTimeComparisonGreaterThanOrEqualTo_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where time '23:59:40' >= time '00:00:00.000'
) Q
group by
f1
) Q ) P;
-- SelectTimeComparisonGreaterThanOrEqualTo_p2
select 'SelectTimeComparisonGreaterThanOrEqualTo_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where time '23:59:40' >= time '12:00:00.000'
) Q
group by
f1
) Q ) P;
-- SelectTimeComparisonGreaterThanOrEqualTo_p3
select 'SelectTimeComparisonGreaterThanOrEqualTo_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where time '23:59:40' >= time '23:59:30.123'
) Q
group by
f1
) Q ) P;
-- SelectTimeComparisonGreaterThan_p1
select 'SelectTimeComparisonGreaterThan_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where time '23:59:40' > time '00:00:00.000'
) Q
group by
f1
) Q ) P;
-- SelectTimeComparisonGreaterThan_p2
select 'SelectTimeComparisonGreaterThan_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where time '23:59:40' > time '12:00:00.000'
) Q
group by
f1
) Q ) P;
-- SelectTimeComparisonGreaterThan_p3
select 'SelectTimeComparisonGreaterThan_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where time '23:59:40' > time '23:59:30.123'
) Q
group by
f1
) Q ) P;
-- SelectTimeComparisonLessThanOrEqualTo_p1
select 'SelectTimeComparisonLessThanOrEqualTo_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where time '00:00:00' <= time '00:00:00.000'
) Q
group by
f1
) Q ) P;
-- SelectTimeComparisonLessThanOrEqualTo_p2
select 'SelectTimeComparisonLessThanOrEqualTo_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where time '00:00:00' <= time '12:00:00.000'
) Q
group by
f1
) Q ) P;
-- SelectTimeComparisonLessThanOrEqualTo_p3
select 'SelectTimeComparisonLessThanOrEqualTo_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where time '00:00:00' <= time '23:59:30.123'
) Q
group by
f1
) Q ) P;
-- SelectTimeComparisonLessThan_p1
select 'SelectTimeComparisonLessThan_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where time '00:00:00.000' < time '23:59:40'
) Q
group by
f1
) Q ) P;
-- SelectTimeComparisonLessThan_p2
select 'SelectTimeComparisonLessThan_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where time '12:00:00.000' < time '23:59:40'
) Q
group by
f1
) Q ) P;
-- SelectTimeComparisonLessThan_p3
select 'SelectTimeComparisonLessThan_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where time '23:59:30.123' < time '23:59:40'
) Q
group by
f1
) Q ) P;
-- SelectTimeComparisonNotEqualTo_p1
select 'SelectTimeComparisonNotEqualTo_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where time '22:20:30' <> time '00:00:00.000'
) Q
group by
f1
) Q ) P;
-- SelectTimeComparisonNotEqualTo_p2
select 'SelectTimeComparisonNotEqualTo_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where time '22:20:30' <> time '12:00:00.000'
) Q
group by
f1
) Q ) P;
-- SelectTimeComparisonNotEqualTo_p3
select 'SelectTimeComparisonNotEqualTo_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where time '22:20:30' <> time '23:59:30.123'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonEqualTo_p1
select 'SelectTimestampComparisonEqualTo_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '2000-01-01 00:00:00.0' = timestamp '2000-01-01 00:00:00.0'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonEqualTo_p2
select 'SelectTimestampComparisonEqualTo_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '2000-01-01 12:00:00' = timestamp '2000-01-01 12:00:00'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonEqualTo_p3
select 'SelectTimestampComparisonEqualTo_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '2000-01-01 23:59:30.123' = timestamp '2000-01-01 23:59:30.123'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonEqualTo_p4
select 'SelectTimestampComparisonEqualTo_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '2000-12-31 00:00:00' = timestamp '2000-12-31 00:00:00'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonEqualTo_p5
select 'SelectTimestampComparisonEqualTo_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '2000-12-31 12:00:00' = timestamp '2000-12-31 12:00:00'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonEqualTo_p6
select 'SelectTimestampComparisonEqualTo_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '2000-12-31 23:59:30.123' = timestamp '2000-12-31 23:59:30.123'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonGreaterThanOrEqualTo_p1
select 'SelectTimestampComparisonGreaterThanOrEqualTo_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '2010-01-01 10:20:30' >= timestamp '2000-01-01 00:00:00.0'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonGreaterThanOrEqualTo_p2
select 'SelectTimestampComparisonGreaterThanOrEqualTo_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '2010-01-01 10:20:30' >= timestamp '2000-01-01 12:00:00'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonGreaterThanOrEqualTo_p3
select 'SelectTimestampComparisonGreaterThanOrEqualTo_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '2010-01-01 10:20:30' >= timestamp '2000-01-01 23:59:30.123'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonGreaterThanOrEqualTo_p4
select 'SelectTimestampComparisonGreaterThanOrEqualTo_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '2010-01-01 10:20:30' >= timestamp '2000-12-31 00:00:00'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonGreaterThanOrEqualTo_p5
select 'SelectTimestampComparisonGreaterThanOrEqualTo_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '2010-01-01 10:20:30' >= timestamp '2000-12-31 12:00:00'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonGreaterThanOrEqualTo_p6
select 'SelectTimestampComparisonGreaterThanOrEqualTo_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '2010-01-01 10:20:30' >= timestamp '2000-12-31 23:59:30.123'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonGreaterThan_p1
select 'SelectTimestampComparisonGreaterThan_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '2010-01-01 10:20:30' > timestamp '2000-01-01 00:00:00.0'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonGreaterThan_p2
select 'SelectTimestampComparisonGreaterThan_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '2010-01-01 10:20:30' > timestamp '2000-01-01 12:00:00'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonGreaterThan_p3
select 'SelectTimestampComparisonGreaterThan_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '2010-01-01 10:20:30' > timestamp '2000-01-01 23:59:30.123'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonGreaterThan_p4
select 'SelectTimestampComparisonGreaterThan_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '2010-01-01 10:20:30' > timestamp '2000-12-31 00:00:00'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonGreaterThan_p5
select 'SelectTimestampComparisonGreaterThan_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '2010-01-01 10:20:30' > timestamp '2000-12-31 12:00:00'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonGreaterThan_p6
select 'SelectTimestampComparisonGreaterThan_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '2010-01-01 10:20:30' > timestamp '2000-12-31 23:59:30.123'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonLessThanOrEqualTo_p1
select 'SelectTimestampComparisonLessThanOrEqualTo_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '1989-01-01 10:20:30' <= timestamp '2000-01-01 00:00:00.0'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonLessThanOrEqualTo_p2
select 'SelectTimestampComparisonLessThanOrEqualTo_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '1989-01-01 10:20:30' <= timestamp '2000-01-01 12:00:00'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonLessThanOrEqualTo_p3
select 'SelectTimestampComparisonLessThanOrEqualTo_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '1989-01-01 10:20:30' <= timestamp '2000-01-01 23:59:30.123'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonLessThanOrEqualTo_p4
select 'SelectTimestampComparisonLessThanOrEqualTo_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '1989-01-01 10:20:30' <= timestamp '2000-12-31 00:00:00'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonLessThanOrEqualTo_p5
select 'SelectTimestampComparisonLessThanOrEqualTo_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '1989-01-01 10:20:30' <= timestamp '2000-12-31 12:00:00'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonLessThanOrEqualTo_p6
select 'SelectTimestampComparisonLessThanOrEqualTo_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '1989-01-01 10:20:30' <= timestamp '2000-12-31 23:59:30.123'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonLessThan_p1
select 'SelectTimestampComparisonLessThan_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '1989-01-01 10:20:30' < timestamp '2000-01-01 00:00:00.0'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonLessThan_p2
select 'SelectTimestampComparisonLessThan_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '1989-01-01 10:20:30' < timestamp '2000-01-01 12:00:00'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonLessThan_p3
select 'SelectTimestampComparisonLessThan_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '1989-01-01 10:20:30' < timestamp '2000-01-01 23:59:30.123'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonLessThan_p4
select 'SelectTimestampComparisonLessThan_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '1989-01-01 10:20:30' < timestamp '2000-12-31 00:00:00'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonLessThan_p5
select 'SelectTimestampComparisonLessThan_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '1989-01-01 10:20:30' < timestamp '2000-12-31 12:00:00'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonLessThan_p6
select 'SelectTimestampComparisonLessThan_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '1989-01-01 10:20:30' < timestamp '2000-12-31 23:59:30.123'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonNotEqualTo_p1
select 'SelectTimestampComparisonNotEqualTo_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '1989-01-01 10:20:30' <> timestamp '2000-01-01 00:00:00.0'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonNotEqualTo_p2
select 'SelectTimestampComparisonNotEqualTo_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '1989-01-01 10:20:30' <> timestamp '2000-01-01 12:00:00'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonNotEqualTo_p3
select 'SelectTimestampComparisonNotEqualTo_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '1989-01-01 10:20:30' <> timestamp '2000-01-01 23:59:30.123'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonNotEqualTo_p4
select 'SelectTimestampComparisonNotEqualTo_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '1989-01-01 10:20:30' <> timestamp '2000-12-31 00:00:00'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonNotEqualTo_p5
select 'SelectTimestampComparisonNotEqualTo_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '1989-01-01 10:20:30' <> timestamp '2000-12-31 12:00:00'
) Q
group by
f1
) Q ) P;
-- SelectTimestampComparisonNotEqualTo_p6
select 'SelectTimestampComparisonNotEqualTo_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 1 f1 from tversion union
select 1 from tversion where timestamp '1989-01-01 10:20:30' <> timestamp '2000-12-31 23:59:30.123'
) Q
group by
f1
) Q ) P;
-- SqrtCoreNull_p1
select 'SqrtCoreNull_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select null f1 from tversion union
select sqrt( null ) from tversion
) Q
group by
f1
) Q ) P;
-- SqrtCore_p1
select 'SqrtCore_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 2 f1 from tversion union
select sqrt( 4 ) from tversion
) Q
group by
f1
) Q ) P;
-- SqrtCore_p2
select 'SqrtCore_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 2 f1 from tversion union
select sqrt( 4.0e+0 ) from tversion
) Q
group by
f1
) Q ) P;
-- SqrtCore_p3
select 'SqrtCore_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 2 f1 from tversion union
select sqrt( 4.0 ) from tversion
) Q
group by
f1
) Q ) P;

