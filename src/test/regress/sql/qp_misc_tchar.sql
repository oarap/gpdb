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
-- Name: tchar; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace:
--

CREATE TABLE tchar (
    rnum integer NOT NULL,
    cchar character(32)
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
-- Name: vchar; Type: VIEW; Schema: public; Owner: gpadmin
--

CREATE VIEW vchar AS
    SELECT tchar.rnum, tchar.cchar FROM tchar;

--
-- Data for Name: tchar; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tchar (rnum, cchar) FROM stdin;
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

-- SubstringBoundary_p1
select 'SubstringBoundary_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, '' f2 from tversion union
select 3 f1, '' f2 from tversion union
select 4 f1, '' f2 from tversion union
select 5 f1, '' f2 from tversion union
select rnum, substring( vchar.cchar from 0 for 0)  from vchar
) Q
group by
f1,f2
) Q ) P;
-- SubstringBoundary_p2
select 'SubstringBoundary_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, '' f2 from tversion union
select 3 f1, '' f2 from tversion union
select 4 f1, '' f2 from tversion union
select 5 f1, '' f2 from tversion union
select rnum, substring( vchar.cchar from 100 for 1)  from vchar
) Q
group by
f1,f2
) Q ) P;
-- SubstringBoundary_p3
select 'SubstringBoundary_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, '' f2 from tversion union
select 3 f1, '' f2 from tversion union
select 4 f1, '' f2 from tversion union
select 5 f1, '' f2 from tversion union
select rnum, substring( tchar.cchar from 0 for 0)  from tchar
) Q
group by
f1,f2
) Q ) P;
-- SubstringBoundary_p4
select 'SubstringBoundary_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, '' f2 from tversion union
select 3 f1, '' f2 from tversion union
select 4 f1, '' f2 from tversion union
select 5 f1, '' f2 from tversion union
select rnum, substring( tchar.cchar from 100 for 1)  from tchar
) Q
group by
f1,f2
) Q ) P;
-- SubstringCoreFixedLength_p1
select 'SubstringCoreFixedLength_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, ' ' f2 from tversion union
select 2 f1, ' ' f2 from tversion union
select 3 f1, 'B' f2 from tversion union
select 4 f1, 'E' f2 from tversion union
select 5 f1, 'F' f2 from tversion union
select rnum, substring( vchar.cchar from 2 for 1)  from vchar
) Q
group by
f1,f2
) Q ) P;
-- SubstringCoreFixedLength_p2
select 'SubstringCoreFixedLength_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, ' ' f2 from tversion union
select 2 f1, ' ' f2 from tversion union
select 3 f1, 'B' f2 from tversion union
select 4 f1, 'E' f2 from tversion union
select 5 f1, 'F' f2 from tversion union
select rnum, substring( tchar.cchar from 2 for 1)  from tchar
) Q
group by
f1,f2
) Q ) P;
-- SubstringCoreNestedFixedLength_p1
select 'SubstringCoreNestedFixedLength_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, ' ' f2 from tversion union
select 2 f1, ' ' f2 from tversion union
select 3 f1, 'B' f2 from tversion union
select 4 f1, 'E' f2 from tversion union
select 5 f1, 'F' f2 from tversion union
select vchar.rnum, substring( substring(vchar.cchar from 1 for 2) from 1 for 1) from vchar
) Q
group by
f1,f2
) Q ) P;
-- SubstringCoreNestedFixedLength_p2
select 'SubstringCoreNestedFixedLength_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, ' ' f2 from tversion union
select 2 f1, ' ' f2 from tversion union
select 3 f1, 'B' f2 from tversion union
select 4 f1, 'E' f2 from tversion union
select 5 f1, 'F' f2 from tversion union
select tchar.rnum, substring( substring(tchar.cchar from 1 for 2) from 1 for 1) from tchar
) Q
group by
f1,f2
) Q ) P;
-- SubstringCoreNoLength_p1
select 'SubstringCoreNoLength_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, '' f2 from tversion union
select 3 f1, 'B' f2 from tversion union
select 4 f1, 'E' f2 from tversion union
select 5 f1, 'F' f2 from tversion union
select rnum, substring( vchar.cchar from 2)  from vchar
) Q
group by
f1,f2
) Q ) P;
-- SubstringCoreNoLength_p2
select 'SubstringCoreNoLength_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, '' f2 from tversion union
select 3 f1, 'B' f2 from tversion union
select 4 f1, 'E' f2 from tversion union
select 5 f1, 'F' f2 from tversion union
select rnum, substring( tchar.cchar from 2)  from tchar
) Q
group by
f1,f2
) Q ) P;
-- TrimBothCoreFixedLength_p1
select 'TrimBothCoreFixedLength_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '                                ' f2 from tversion union
select 2 f1, '                                ' f2 from tversion union
select 3 f1, '                              ' f2 from tversion union
select 4 f1, 'EE                              ' f2 from tversion union
select 5 f1, 'FF                              ' f2 from tversion union
select vchar.rnum, trim(both 'B' from vchar.cchar )  from vchar
) Q
group by
f1,f2
) Q ) P;
-- TrimBothCoreFixedLength_p2
select 'TrimBothCoreFixedLength_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '                                ' f2 from tversion union
select 2 f1, '                                ' f2 from tversion union
select 3 f1, '                              ' f2 from tversion union
select 4 f1, 'EE                              ' f2 from tversion union
select 5 f1, 'FF                              ' f2 from tversion union
select tchar.rnum, trim(both 'B' from tchar.cchar )  from tchar
) Q
group by
f1,f2
) Q ) P;
-- TrimCore_p1
select 'TrimCore_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, '' f2 from tversion union
select 3 f1, 'BB' f2 from tversion union
select 4 f1, 'EE' f2 from tversion union
select 5 f1, 'FF' f2 from tversion union
select rnum, trim( vchar.cchar )  from vchar
) Q
group by
f1,f2
) Q ) P;
-- TrimCore_p2
select 'TrimCore_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, '' f2 from tversion union
select 3 f1, 'BB' f2 from tversion union
select 4 f1, 'EE' f2 from tversion union
select 5 f1, 'FF' f2 from tversion union
select rnum, trim( tchar.cchar )  from tchar
) Q
group by
f1,f2
) Q ) P;
-- UpperCoreFixedLength_p1
select 'UpperCoreFixedLength_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, null f2, 'BB' f3 from tversion union
select 1 f1, '                                ' f2, 'BB' f3 from tversion union
select 2 f1, '                                ' f2, 'BB' f3 from tversion union
select 3 f1, 'BB                              ' f2, 'BB' f3 from tversion union
select 4 f1, 'EE                              ' f2, 'BB' f3 from tversion union
select 5 f1, 'FF                              ' f2, 'BB' f3 from tversion union
select vchar.rnum, upper( vchar.cchar ),upper('bb') from vchar
) Q
group by
f1,f2,f3
) Q ) P;
-- UpperCoreFixedLength_p2
select 'UpperCoreFixedLength_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, null f2, 'BB' f3 from tversion union
select 1 f1, '                                ' f2, 'BB' f3 from tversion union
select 2 f1, '                                ' f2, 'BB' f3 from tversion union
select 3 f1, 'BB                              ' f2, 'BB' f3 from tversion union
select 4 f1, 'EE                              ' f2, 'BB' f3 from tversion union
select 5 f1, 'FF                              ' f2, 'BB' f3 from tversion union
select tchar.rnum, upper( tchar.cchar ),upper('bb') from tchar
) Q
group by
f1,f2,f3
) Q ) P;
-- CastCharsToChar_p1
select 'CastCharsToChar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, '  ' f2 from tversion union
select 3 f1, 'BB' f2 from tversion union
select 4 f1, 'EE' f2 from tversion union
select 5 f1, 'FF' f2 from tversion union
select rnum, cast(vchar.cchar as char(34)) from vchar
) Q
group by
f1,f2
) Q ) P;
-- CastCharsToChar_p2
select 'CastCharsToChar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, '  ' f2 from tversion union
select 3 f1, 'BB' f2 from tversion union
select 4 f1, 'EE' f2 from tversion union
select 5 f1, 'FF' f2 from tversion union
select rnum, cast(tchar.cchar as char(34)) from tchar
) Q
group by
f1,f2
) Q ) P;
-- CastCharsToVarchar_p1
select 'CastCharsToVarchar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '     ' f2 from tversion union
select 2 f1, '     ' f2 from tversion union
select 3 f1, 'BB   ' f2 from tversion union
select 4 f1, 'EE   ' f2 from tversion union
select 5 f1, 'FF   ' f2 from tversion union
select vchar.rnum, cast(vchar.cchar as varchar(32)) from vchar
) Q
group by
f1,f2
) Q ) P;
-- CastCharsToVarchar_p2
select 'CastCharsToVarchar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '     ' f2 from tversion union
select 2 f1, '     ' f2 from tversion union
select 3 f1, 'BB   ' f2 from tversion union
select 4 f1, 'EE   ' f2 from tversion union
select 5 f1, 'FF   ' f2 from tversion union
select tchar.rnum, cast(tchar.cchar as varchar(32)) from tchar
) Q
group by
f1,f2
) Q ) P;
-- CharlengthCoreFixedLength_p1
select 'CharlengthCoreFixedLength_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 32 f2 from tversion union
select 2 f1, 32 f2 from tversion union
select 3 f1, 32 f2 from tversion union
select 4 f1, 32 f2 from tversion union
select 5 f1, 32 f2 from tversion union
select vchar.rnum, char_length( vchar.cchar ) from vchar
) Q
group by
f1,f2
) Q ) P;
-- CharlengthCoreFixedLength_p2
select 'CharlengthCoreFixedLength_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 32 f2 from tversion union
select 2 f1, 32 f2 from tversion union
select 3 f1, 32 f2 from tversion union
select 4 f1, 32 f2 from tversion union
select 5 f1, 32 f2 from tversion union
select tchar.rnum, char_length( tchar.cchar ) from tchar
) Q
group by
f1,f2
) Q ) P;
-- ConcatCoreFixedLength_p1
select 'ConcatCoreFixedLength_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '1234567890                                ' f2 from tversion union
select 2 f1, '1234567890                                ' f2 from tversion union
select 3 f1, '1234567890BB                              ' f2 from tversion union
select 4 f1, '1234567890EE                              ' f2 from tversion union
select 5 f1, '1234567890FF                              ' f2 from tversion union
select vchar.rnum, '1234567890' || vchar.cchar  from vchar
) Q
group by
f1,f2
) Q ) P;
-- ConcatCoreFixedLength_p2
select 'ConcatCoreFixedLength_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '1234567890                                ' f2 from tversion union
select 2 f1, '1234567890                                ' f2 from tversion union
select 3 f1, '1234567890BB                              ' f2 from tversion union
select 4 f1, '1234567890EE                              ' f2 from tversion union
select 5 f1, '1234567890FF                              ' f2 from tversion union
select tchar.rnum, '1234567890' || tchar.cchar  from tchar
) Q
group by
f1,f2
) Q ) P;
-- ConcatCoreMaxLengthStringPlusBlankString_p1
select 'ConcatCoreMaxLengthStringPlusBlankString_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'UDA_VARIABLE_LENGTH_MAX_STRING                                ' f1 from tversion union
select 'UDA_VARIABLE_LENGTH_MAX_STRING' || vchar.cchar  from vchar where vchar.rnum = 2
) Q
group by
f1
) Q ) P;
-- ConcatCoreMaxLengthStringPlusBlankString_p2
select 'ConcatCoreMaxLengthStringPlusBlankString_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'UDA_VARIABLE_LENGTH_MAX_STRING                                ' f1 from tversion union
select 'UDA_VARIABLE_LENGTH_MAX_STRING' || tchar.cchar  from tchar where tchar.rnum = 2
) Q
group by
f1
) Q ) P;
-- ConcatException_p1
select 'ConcatException_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 2 f1, 'should throw error' f2 from tversion union
select vchar.rnum,'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA' || vchar.cchar  from vchar where vchar.rnum > 2
) Q
group by
f1,f2
) Q ) P;
-- ConcatException_p2
select 'ConcatException_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 2 f1, 'should throw error' f2 from tversion union
select vchar.rnum, 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA' || vchar.cchar  from vchar where vchar.rnum > 2
) Q
group by
f1,f2
) Q ) P;
-- ConcatException_p3
select 'ConcatException_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 2 f1, 'should throw error' f2 from tversion union
select tchar.rnum,'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA' || tchar.cchar  from tchar where tchar.rnum > 2
) Q
group by
f1,f2
) Q ) P;
-- ConcatException_p4
select 'ConcatException_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 2 f1, 'should throw error' f2 from tversion union
select tchar.rnum, 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA' || tchar.cchar  from tchar where tchar.rnum > 2
) Q
group by
f1,f2
) Q ) P;
-- LowerCoreFixedLength_p1
select 'LowerCoreFixedLength_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '                                ' f2 from tversion union
select 2 f1, '                                ' f2 from tversion union
select 3 f1, 'bb                              ' f2 from tversion union
select 4 f1, 'ee                              ' f2 from tversion union
select 5 f1, 'ff                              ' f2 from tversion union
select rnum, lower( vchar.cchar ) from vchar
) Q
group by
f1,f2
) Q ) P;
-- LowerCoreFixedLength_p2
select 'LowerCoreFixedLength_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '                                ' f2 from tversion union
select 2 f1, '                                ' f2 from tversion union
select 3 f1, 'bb                              ' f2 from tversion union
select 4 f1, 'ee                              ' f2 from tversion union
select 5 f1, 'ff                              ' f2 from tversion union
select rnum, lower( tchar.cchar ) from tchar
) Q
group by
f1,f2
) Q ) P;
-- PositionCoreString1Empty_p1
select 'PositionCoreString1Empty_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 1 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 1 f2 from tversion union
select 5 f1, 1 f2 from tversion union
select rnum, position( '' in vchar.cchar ) from vchar
) Q
group by
f1,f2
) Q ) P;
-- PositionCoreString1Empty_p2
select 'PositionCoreString1Empty_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 1 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 1 f2 from tversion union
select 5 f1, 1 f2 from tversion union
select rnum, position( '' in tchar.cchar ) from tchar
) Q
group by
f1,f2
) Q ) P;
-- PositionCore_p1
select 'PositionCore_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 0 f2 from tversion union
select rnum, position( 'B' in vchar.cchar ) from vchar
) Q
group by
f1,f2
) Q ) P;
-- PositionCore_p2
select 'PositionCore_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 0 f2 from tversion union
select rnum, position( 'B' in tchar.cchar ) from tchar
) Q
group by
f1,f2
) Q ) P;
-- SelectCountChar_p1
select 'SelectCountChar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5 f1 from tversion union
select count(vchar.cchar) from vchar
) Q
group by
f1
) Q ) P;
-- SelectCountChar_p2
select 'SelectCountChar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5 f1 from tversion union
select count(tchar.cchar) from tchar
) Q
group by
f1
) Q ) P;
-- SelectCountChar_p3
select 'SelectCountChar_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5 f1 from tversion union
select count(vchar.cchar) from vchar
) Q
group by
f1
) Q ) P;
-- SelectCountChar_p4
select 'SelectCountChar_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5 f1 from tversion union
select count(tchar.cchar) from tchar
) Q
group by
f1
) Q ) P;
-- SelectMaxChar_p1
select 'SelectMaxChar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'FF                              ' f1 from tversion union
select max( vchar.cchar ) from vchar
) Q
group by
f1
) Q ) P;
-- SelectMaxChar_p2
select 'SelectMaxChar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'FF                              ' f1 from tversion union
select max( tchar.cchar ) from tchar
) Q
group by
f1
) Q ) P;
-- SelectMinChar_p1
select 'SelectMinChar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select '                                ' f1 from tversion union
select min( vchar.cchar ) from vchar
) Q
group by
f1
) Q ) P;
-- SelectMinChar_p2
select 'SelectMinChar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select '                                ' f1 from tversion union
select min( tchar.cchar ) from tchar
) Q
group by
f1
) Q ) P;
