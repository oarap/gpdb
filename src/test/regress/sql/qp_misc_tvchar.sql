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
-- Name: tvchar; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace:
--

CREATE TABLE tvchar (
    rnum integer NOT NULL,
    cvchar character varying(32)
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
-- Name: vvchar; Type: VIEW; Schema: public; Owner: gpadmin
--
CREATE VIEW vvchar AS
    SELECT tvchar.rnum, tvchar.cvchar FROM tvchar;


--
-- Data for Name: tvchar; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tvchar (rnum, cvchar) FROM stdin;
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

-- SubstringBoundary_p5
select 'SubstringBoundary_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, '' f2 from tversion union
select 3 f1, '' f2 from tversion union
select 4 f1, '' f2 from tversion union
select 5 f1, '' f2 from tversion union
select rnum, substring( vvchar.cvchar from 0 for 0)  from vvchar
) Q
group by
f1,f2
) Q ) P;
-- SubstringBoundary_p6
select 'SubstringBoundary_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, '' f2 from tversion union
select 3 f1, '' f2 from tversion union
select 4 f1, '' f2 from tversion union
select 5 f1, '' f2 from tversion union
select rnum, substring( vvchar.cvchar from 100 for 1)  from vvchar
) Q
group by
f1,f2
) Q ) P;
-- SubstringBoundary_p7
select 'SubstringBoundary_p7' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, '' f2 from tversion union
select 3 f1, '' f2 from tversion union
select 4 f1, '' f2 from tversion union
select 5 f1, '' f2 from tversion union
select rnum, substring( tvchar.cvchar from 0 for 0)  from tvchar
) Q
group by
f1,f2
) Q ) P;
-- SubstringBoundary_p8
select 'SubstringBoundary_p8' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, '' f2 from tversion union
select 3 f1, '' f2 from tversion union
select 4 f1, '' f2 from tversion union
select 5 f1, '' f2 from tversion union
select rnum, substring( tvchar.cvchar from 100 for 1)  from tvchar
) Q
group by
f1,f2
) Q ) P;
-- SubstringCoreNestedVariableLength_p1
select 'SubstringCoreNestedVariableLength_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, ' ' f2 from tversion union
select 3 f1, 'B' f2 from tversion union
select 4 f1, 'E' f2 from tversion union
select 5 f1, 'F' f2 from tversion union
select vvchar.rnum, substring( substring(vvchar.cvchar from 1 for 2) from 1 for 1) from vvchar
) Q
group by
f1,f2
) Q ) P;
-- SubstringCoreNestedVariableLength_p2
select 'SubstringCoreNestedVariableLength_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, ' ' f2 from tversion union
select 3 f1, 'B' f2 from tversion union
select 4 f1, 'E' f2 from tversion union
select 5 f1, 'F' f2 from tversion union
select tvchar.rnum, substring( substring(tvchar.cvchar from 1 for 2) from 1 for 1) from tvchar
) Q
group by
f1,f2
) Q ) P;
-- SubstringCoreNoLength_p3
select 'SubstringCoreNoLength_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, '' f2 from tversion union
select 3 f1, 'B' f2 from tversion union
select 4 f1, 'E' f2 from tversion union
select 5 f1, 'F' f2 from tversion union
select rnum, substring( vvchar.cvchar from 2)  from vvchar
) Q
group by
f1,f2
) Q ) P;
-- SubstringCoreNoLength_p4
select 'SubstringCoreNoLength_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, '' f2 from tversion union
select 3 f1, 'B' f2 from tversion union
select 4 f1, 'E' f2 from tversion union
select 5 f1, 'F' f2 from tversion union
select rnum, substring( tvchar.cvchar from 2)  from tvchar
) Q
group by
f1,f2
) Q ) P;
-- SubstringCoreVariableLength_p1
select 'SubstringCoreVariableLength_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, '' f2 from tversion union
select 3 f1, 'B' f2 from tversion union
select 4 f1, 'E' f2 from tversion union
select 5 f1, 'F' f2 from tversion union
select rnum, substring( vvchar.cvchar from 2 for 1)  from vvchar
) Q
group by
f1,f2
) Q ) P;
-- SubstringCoreVariableLength_p2
select 'SubstringCoreVariableLength_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, '' f2 from tversion union
select 3 f1, 'B' f2 from tversion union
select 4 f1, 'E' f2 from tversion union
select 5 f1, 'F' f2 from tversion union
select rnum, substring( tvchar.cvchar from 2 for 1)  from tvchar
) Q
group by
f1,f2
) Q ) P;
-- TrimBothCoreVariableLength_p1
select 'TrimBothCoreVariableLength_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, ' ' f2 from tversion union
select 3 f1, '' f2 from tversion union
select 4 f1, 'EE' f2 from tversion union
select 5 f1, 'FF' f2 from tversion union
select vvchar.rnum, trim(both 'B' from vvchar.cvchar )  from vvchar
) Q
group by
f1,f2
) Q ) P;
-- TrimBothCoreVariableLength_p2
select 'TrimBothCoreVariableLength_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, ' ' f2 from tversion union
select 3 f1, '' f2 from tversion union
select 4 f1, 'EE' f2 from tversion union
select 5 f1, 'FF' f2 from tversion union
select tvchar.rnum, trim(both 'B' from tvchar.cvchar )  from tvchar
) Q
group by
f1,f2
) Q ) P;
-- TrimCore_p3
select 'TrimCore_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, '' f2 from tversion union
select 3 f1, 'BB' f2 from tversion union
select 4 f1, 'EE' f2 from tversion union
select 5 f1, 'FF' f2 from tversion union
select rnum, trim( vvchar.cvchar )  from vvchar
) Q
group by
f1,f2
) Q ) P;
-- TrimCore_p4
select 'TrimCore_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, '' f2 from tversion union
select 3 f1, 'BB' f2 from tversion union
select 4 f1, 'EE' f2 from tversion union
select 5 f1, 'FF' f2 from tversion union
select rnum, trim( tvchar.cvchar )  from tvchar
) Q
group by
f1,f2
) Q ) P;
-- UpperCoreVariableLength_p1
select 'UpperCoreVariableLength_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, null f2, 'BB' f3 from tversion union
select 1 f1, '' f2, 'BB' f3 from tversion union
select 2 f1, ' ' f2, 'BB' f3 from tversion union
select 3 f1, 'BB' f2, 'BB' f3 from tversion union
select 4 f1, 'EE' f2, 'BB' f3 from tversion union
select 5 f1, 'FF' f2, 'BB' f3 from tversion union
select vvchar.rnum, upper( vvchar.cvchar ), upper('bb') from vvchar
) Q
group by
f1,f2,f3
) Q ) P;
-- UpperCoreVariableLength_p2
select 'UpperCoreVariableLength_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2,f3, count(*) c  from (
select 0 f1, null f2, 'BB' f3 from tversion union
select 1 f1, '' f2, 'BB' f3 from tversion union
select 2 f1, ' ' f2, 'BB' f3 from tversion union
select 3 f1, 'BB' f2, 'BB' f3 from tversion union
select 4 f1, 'EE' f2, 'BB' f3 from tversion union
select 5 f1, 'FF' f2, 'BB' f3 from tversion union
select tvchar.rnum, upper( tvchar.cvchar ), upper('bb') from tvchar
) Q
group by
f1,f2,f3
) Q ) P;
-- CastCharsToChar_p3
select 'CastCharsToChar_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, '  ' f2 from tversion union
select 3 f1, 'BB' f2 from tversion union
select 4 f1, 'EE' f2 from tversion union
select 5 f1, 'FF' f2 from tversion union
select rnum, cast(vvchar.cvchar as char(34)) from vvchar
) Q
group by
f1,f2
) Q ) P;
-- CastCharsToChar_p4
select 'CastCharsToChar_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, '  ' f2 from tversion union
select 3 f1, 'BB' f2 from tversion union
select 4 f1, 'EE' f2 from tversion union
select 5 f1, 'FF' f2 from tversion union
select rnum, cast(tvchar.cvchar as char(34)) from tvchar
) Q
group by
f1,f2
) Q ) P;
-- CastCharsToVarchar_p3
select 'CastCharsToVarchar_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '     ' f2 from tversion union
select 2 f1, '     ' f2 from tversion union
select 3 f1, 'BB   ' f2 from tversion union
select 4 f1, 'EE   ' f2 from tversion union
select 5 f1, 'FF   ' f2 from tversion union
select vvchar.rnum, cast(vvchar.cvchar as varchar(32)) from vvchar
) Q
group by
f1,f2
) Q ) P;
-- CastCharsToVarchar_p4
select 'CastCharsToVarchar_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '     ' f2 from tversion union
select 2 f1, '     ' f2 from tversion union
select 3 f1, 'BB   ' f2 from tversion union
select 4 f1, 'EE   ' f2 from tversion union
select 5 f1, 'FF   ' f2 from tversion union
select tvchar.rnum, cast(tvchar.cvchar as varchar(32)) from tvchar
) Q
group by
f1,f2
) Q ) P;
-- CastVarcharToChar_p1
select 'CastVarcharToChar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, ' ' f2 from tversion union
select 3 f1, 'BB' f2 from tversion union
select 4 f1, 'EE' f2 from tversion union
select 5 f1, 'FF' f2 from tversion union
select rnum, cast(vvchar.cvchar as char(2)) from vvchar
) Q
group by
f1,f2
) Q ) P;
-- CastVarcharToChar_p2
select 'CastVarcharToChar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, ' ' f2 from tversion union
select 3 f1, 'BB' f2 from tversion union
select 4 f1, 'EE' f2 from tversion union
select 5 f1, 'FF' f2 from tversion union
select rnum, cast(tvchar.cvchar as char(2)) from tvchar
) Q
group by
f1,f2
) Q ) P;
-- CastVarcharToVarchar_p1
select 'CastVarcharToVarchar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, ' ' f2 from tversion union
select 3 f1, 'BB' f2 from tversion union
select 4 f1, 'EE' f2 from tversion union
select 5 f1, 'FF' f2 from tversion union
select rnum, cast(vvchar.cvchar as varchar(10)) from vvchar
) Q
group by
f1,f2
) Q ) P;
-- CastVarcharToVarchar_p2
select 'CastVarcharToVarchar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, ' ' f2 from tversion union
select 3 f1, 'BB' f2 from tversion union
select 4 f1, 'EE' f2 from tversion union
select 5 f1, 'FF' f2 from tversion union
select rnum, cast(tvchar.cvchar as varchar(10)) from tvchar
) Q
group by
f1,f2
) Q ) P;
-- CharlengthCoreVariableLength_p1
select 'CharlengthCoreVariableLength_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 2 f1, 1 f2 from tversion union
select 3 f1, 2 f2 from tversion union
select 4 f1, 2 f2 from tversion union
select 5 f1, 2 f2 from tversion union
select vvchar.rnum, char_length( vvchar.cvchar ) from vvchar
) Q
group by
f1,f2
) Q ) P;
-- CharlengthCoreVariableLength_p2
select 'CharlengthCoreVariableLength_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 2 f1, 1 f2 from tversion union
select 3 f1, 2 f2 from tversion union
select 4 f1, 2 f2 from tversion union
select 5 f1, 2 f2 from tversion union
select tvchar.rnum, char_length( tvchar.cvchar ) from tvchar
) Q
group by
f1,f2
) Q ) P;
-- ConcatCoreMaxLengthStringPlusBlankString_p3
select 'ConcatCoreMaxLengthStringPlusBlankString_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'UDA_VARIABLE_LENGTH_MAX_STRING                                ' f1 from tversion union
select 'UDA_VARIABLE_LENGTH_MAX_STRING' || vvchar.cvchar  from vvchar where vvchar.rnum = 2
) Q
group by
f1
) Q ) P;
-- ConcatCoreMaxLengthStringPlusBlankString_p4
select 'ConcatCoreMaxLengthStringPlusBlankString_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'UDA_VARIABLE_LENGTH_MAX_STRING                                ' f1 from tversion union
select 'UDA_VARIABLE_LENGTH_MAX_STRING' || tvchar.cvchar  from tvchar where tvchar.rnum = 2
) Q
group by
f1
) Q ) P;
-- ConcatCoreVariableLength_p1
select 'ConcatCoreVariableLength_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '1234567890' f2 from tversion union
select 2 f1, '1234567890 ' f2 from tversion union
select 3 f1, '1234567890BB' f2 from tversion union
select 4 f1, '1234567890EE' f2 from tversion union
select 5 f1, '1234567890FF' f2 from tversion union
select rnum, '1234567890' || vvchar.cvchar  from vvchar
) Q
group by
f1,f2
) Q ) P;
-- ConcatCoreVariableLength_p2
select 'ConcatCoreVariableLength_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '1234567890' f2 from tversion union
select 2 f1, '1234567890 ' f2 from tversion union
select 3 f1, '1234567890BB' f2 from tversion union
select 4 f1, '1234567890EE' f2 from tversion union
select 5 f1, '1234567890FF' f2 from tversion union
select rnum, '1234567890' || tvchar.cvchar  from tvchar
) Q
group by
f1,f2
) Q ) P;
-- ConcatException_p5
select 'ConcatException_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 2 f1, 'should throw error' f2 from tversion union
select vvchar.rnum,'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA' || vvchar.cvchar  from vvchar where vvchar.rnum > 2
) Q
group by
f1,f2
) Q ) P;
-- ConcatException_p6
select 'ConcatException_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 2 f1, 'should throw error' f2 from tversion union
select vvchar.rnum, 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA' || vvchar.cvchar  from vvchar where vvchar.rnum > 2
) Q
group by
f1,f2
) Q ) P;
-- ConcatException_p7
select 'ConcatException_p7' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 2 f1, 'should throw error' f2 from tversion union
select tvchar.rnum,'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA' || tvchar.cvchar  from tvchar where tvchar.rnum > 2
) Q
group by
f1,f2
) Q ) P;
-- ConcatException_p8
select 'ConcatException_p8' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 2 f1, 'should throw error' f2 from tversion union
select tvchar.rnum, 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA' || tvchar.cvchar  from tvchar where tvchar.rnum > 2
) Q
group by
f1,f2
) Q ) P;
-- EmptyStringIsNull_p1
select 'EmptyStringIsNull_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select vvchar.rnum, vvchar.cvchar  from vvchar where vvchar.cvchar is null
) Q
group by
f1,f2
) Q ) P;
-- EmptyStringIsNull_p2
select 'EmptyStringIsNull_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select tvchar.rnum, tvchar.cvchar  from tvchar where tvchar.cvchar is null
) Q
group by
f1,f2
) Q ) P;
-- LowerCoreVariableLength_p1
select 'LowerCoreVariableLength_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, ' ' f2 from tversion union
select 3 f1, 'bb' f2 from tversion union
select 4 f1, 'ee' f2 from tversion union
select 5 f1, 'ff' f2 from tversion union
select rnum, lower( vvchar.cvchar ) from vvchar
) Q
group by
f1,f2
) Q ) P;
-- LowerCoreVariableLength_p2
select 'LowerCoreVariableLength_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '' f2 from tversion union
select 2 f1, ' ' f2 from tversion union
select 3 f1, 'bb' f2 from tversion union
select 4 f1, 'ee' f2 from tversion union
select 5 f1, 'ff' f2 from tversion union
select rnum, lower( tvchar.cvchar ) from tvchar
) Q
group by
f1,f2
) Q ) P;
-- PositionCoreString1Empty_p3
select 'PositionCoreString1Empty_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 1 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 1 f2 from tversion union
select 5 f1, 1 f2 from tversion union
select rnum, position( '' in vvchar.cvchar ) from vvchar
) Q
group by
f1,f2
) Q ) P;
-- PositionCoreString1Empty_p4
select 'PositionCoreString1Empty_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 1 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 1 f2 from tversion union
select 5 f1, 1 f2 from tversion union
select rnum, position( '' in tvchar.cvchar ) from tvchar
) Q
group by
f1,f2
) Q ) P;
-- PositionCore_p3
select 'PositionCore_p3' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 0 f2 from tversion union
select rnum, position( 'B' in vvchar.cvchar ) from vvchar
) Q
group by
f1,f2
) Q ) P;
-- PositionCore_p4
select 'PositionCore_p4' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 0 f2 from tversion union
select rnum, position( 'B' in tvchar.cvchar ) from tvchar
) Q
group by
f1,f2
) Q ) P;
-- SelectCountChar_p5
select 'SelectCountChar_p5' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5 f1 from tversion union
select count(vvchar.cvchar) from vvchar
) Q
group by
f1
) Q ) P;
-- SelectCountChar_p6
select 'SelectCountChar_p6' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5 f1 from tversion union
select count(tvchar.cvchar) from tvchar
) Q
group by
f1
) Q ) P;
-- SelectCountVarChar_p1
select 'SelectCountVarChar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5 f1 from tversion union
select count(vvchar.cvchar) from vvchar
) Q
group by
f1
) Q ) P;
-- SelectCountVarChar_p2
select 'SelectCountVarChar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5 f1 from tversion union
select count(tvchar.cvchar) from tvchar
) Q
group by
f1
) Q ) P;
-- SelectMaxVarChar_p1
select 'SelectMaxVarChar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'FF' f1 from tversion union
select max( vvchar.cvchar ) from vvchar
) Q
group by
f1
) Q ) P;
-- SelectMaxVarChar_p2
select 'SelectMaxVarChar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'FF' f1 from tversion union
select max( tvchar.cvchar ) from tvchar
) Q
group by
f1
) Q ) P;
-- SelectMinVarChar_p1
select 'SelectMinVarChar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select ' ' f1 from tversion union
select min( vvchar.cvchar ) from vvchar
) Q
group by
f1
) Q ) P;
-- SelectMinVarChar_p2
select 'SelectMinVarChar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select ' ' f1 from tversion union
select min( tvchar.cvchar ) from tvchar
) Q
group by
f1
) Q ) P;

