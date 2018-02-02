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
-- Name: tdec; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace:
--

CREATE TABLE tdec (
    rnum integer NOT NULL,
    cdec numeric(7,2)
) DISTRIBUTED BY (rnum);

--
-- Name: TABLE tdec; Type: COMMENT; Schema: public; Owner: gpadmin
--

COMMENT ON TABLE tdec IS 'This describes table TDEC.';


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
-- Name: vdec; Type: VIEW; Schema: public; Owner: gpadmin
--

CREATE VIEW vdec AS
    SELECT tdec.rnum, tdec.cdec FROM tdec;

cdec) FROM stdin;
3	1.00
0	\N
1	-1.00
2	0.00
5	10.00
4	0.10
\.


--
-- Data for Name: tversion; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tversion (rnum, c1, cver, cnnull, ccnull) FROM stdin;
0	1	1.0   	\N	\N
\.


-- VarExactNumeric_p1
select 'VarExactNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 20.402 f1 from tversion union
select variance( vdec.cdec ) from vdec
) Q
group by
f1
) Q ) P;
-- VarExactNumeric_p2
select 'VarExactNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 20.402 f1 from tversion union
select variance( tdec.cdec ) from tdec
) Q
group by
f1
) Q ) P;
-- VarSampExactNumeric_p1
select 'VarSampExactNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 20.402 f1 from tversion union
select var_samp( vdec.cdec ) from vdec
) Q
group by
f1
) Q ) P;
-- VarSampExactNumeric_p2
select 'VarSampExactNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 20.402 f1 from tversion union
select var_samp( tdec.cdec ) from tdec
) Q
group by
f1
) Q ) P;
-- CaseNestedExactNumeric_p1
select 'CaseNestedExactNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'nested else' f2 from tversion union
select 3 f1, 'nested else' f2 from tversion union
select 4 f1, 'nested else' f2 from tversion union
select 5 f1, 'nested inner' f2 from tversion union
select vdec.rnum,case  when vdec.cdec > -1  then case  when vdec.cdec > 1 then  'nested inner' else 'nested else' end else 'else'  end from vdec
) Q
group by
f1,f2
) Q ) P;
-- CaseNestedExactNumeric_p2
select 'CaseNestedExactNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'nested else' f2 from tversion union
select 3 f1, 'nested else' f2 from tversion union
select 4 f1, 'nested else' f2 from tversion union
select 5 f1, 'nested inner' f2 from tversion union
select tdec.rnum,case  when tdec.cdec > -1  then case  when tdec.cdec > 1 then  'nested inner' else 'nested else' end else 'else'  end from tdec
) Q
group by
f1,f2
) Q ) P;
-- CaseSubQueryExactNumeric_p1
select 'CaseSubQueryExactNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'else' f2 from tversion union
select 5 f1, 'true' f2 from tversion union
select vdec.rnum,case  when vdec.cdec= (select max( vdec.cdec) from vdec)    then 'true' else 'else' 	end from vdec
) Q
group by
f1,f2
) Q ) P;
-- CaseSubQueryExactNumeric_p2
select 'CaseSubQueryExactNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'else' f2 from tversion union
select 5 f1, 'true' f2 from tversion union
select tdec.rnum,case  when tdec.cdec= (select max( tdec.cdec) from tdec)    then 'true' else 'else' 	end from tdec
) Q
group by
f1,f2
) Q ) P;
-- CastDecimalToBigint_p1
select 'CastDecimalToBigint_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, cast(vdec.cdec as bigint) from vdec
) Q
group by
f1,f2
) Q ) P;
-- CastDecimalToBigint_p2
select 'CastDecimalToBigint_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, cast(tdec.cdec as bigint) from tdec
) Q
group by
f1,f2
) Q ) P;
-- CastDecimalToChar_p1
select 'CastDecimalToChar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1.00' f2 from tversion union
select 2 f1, '0.00 ' f2 from tversion union
select 3 f1, '1.00 ' f2 from tversion union
select 4 f1, '0.10 ' f2 from tversion union
select 5 f1, '10.00' f2 from tversion union
select rnum, cast(vdec.cdec as char(5)) from vdec
) Q
group by
f1,f2
) Q ) P;
-- CastDecimalToChar_p2
select 'CastDecimalToChar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1.00' f2 from tversion union
select 2 f1, '0.00 ' f2 from tversion union
select 3 f1, '1.00 ' f2 from tversion union
select 4 f1, '0.10 ' f2 from tversion union
select 5 f1, '10.00' f2 from tversion union
select rnum, cast(tdec.cdec as char(5)) from tdec
) Q
group by
f1,f2
) Q ) P;
-- CastDecimalToDouble_p1
select 'CastDecimalToDouble_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1.0 f2 from tversion union
select 2 f1, 0.0 f2 from tversion union
select 3 f1, 1.0 f2 from tversion union
select 4 f1, 0.1 f2 from tversion union
select 5 f1, 10.0 f2 from tversion union
select rnum, cast(vdec.cdec as double precision) from vdec
) Q
group by
f1,f2
) Q ) P;
-- CastDecimalToDouble_p2
select 'CastDecimalToDouble_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1.0 f2 from tversion union
select 2 f1, 0.0 f2 from tversion union
select 3 f1, 1.0 f2 from tversion union
select 4 f1, 0.1 f2 from tversion union
select 5 f1, 10.0 f2 from tversion union
select rnum, cast(tdec.cdec as double precision) from tdec
) Q
group by
f1,f2
) Q ) P;
-- CastDecimalToFloat_p1
select 'CastDecimalToFloat_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1.0 f2 from tversion union
select 2 f1, 0.0 f2 from tversion union
select 3 f1, 1.0 f2 from tversion union
select 4 f1, 0.1 f2 from tversion union
select 5 f1, 10.0 f2 from tversion union
select rnum, cast(vdec.cdec as float) from vdec
) Q
group by
f1,f2
) Q ) P;
-- CastDecimalToFloat_p2
select 'CastDecimalToFloat_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1.0 f2 from tversion union
select 2 f1, 0.0 f2 from tversion union
select 3 f1, 1.0 f2 from tversion union
select 4 f1, 0.1 f2 from tversion union
select 5 f1, 10.0 f2 from tversion union
select rnum, cast(tdec.cdec as float) from tdec
) Q
group by
f1,f2
) Q ) P;
-- CastDecimalToInteger_p1
select 'CastDecimalToInteger_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, cast(vdec.cdec as integer) from vdec
) Q
group by
f1,f2
) Q ) P;
-- CastDecimalToInteger_p2
select 'CastDecimalToInteger_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, cast(tdec.cdec as integer) from tdec
) Q
group by
f1,f2
) Q ) P;
-- CastDecimalToSmallint_p1
select 'CastDecimalToSmallint_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, cast(vdec.cdec as smallint) from vdec
) Q
group by
f1,f2
) Q ) P;
-- CastDecimalToSmallint_p2
select 'CastDecimalToSmallint_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, cast(tdec.cdec as smallint) from tdec
) Q
group by
f1,f2
) Q ) P;
-- CastDecimalToVarchar_p1
select 'CastDecimalToVarchar_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1.00' f2 from tversion union
select 2 f1, '0.00' f2 from tversion union
select 3 f1, '1.00' f2 from tversion union
select 4 f1, '0.10' f2 from tversion union
select 5 f1, '10.00' f2 from tversion union
select rnum, cast(vdec.cdec as varchar(5)) from vdec
) Q
group by
f1,f2
) Q ) P;
-- CastDecimalToVarchar_p2
select 'CastDecimalToVarchar_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, '-1.00' f2 from tversion union
select 2 f1, '0.00' f2 from tversion union
select 3 f1, '1.00' f2 from tversion union
select 4 f1, '0.10' f2 from tversion union
select 5 f1, '10.00' f2 from tversion union
select rnum, cast(tdec.cdec as varchar(5)) from tdec
) Q
group by
f1,f2
) Q ) P;
-- CeilCoreExactNumeric_p1
select 'CeilCoreExactNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 1 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, ceil( vdec.cdec ) from vdec
) Q
group by
f1,f2
) Q ) P;
-- CeilCoreExactNumeric_p2
select 'CeilCoreExactNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 1 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, ceil( tdec.cdec ) from tdec
) Q
group by
f1,f2
) Q ) P;
-- DistinctAggregateInCase_p7
select 'DistinctAggregateInCase_p7' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'test1' f1 from tversion union
select case when min(distinct(vdec.cdec))=-1 then 'test1' else 'else' end from vdec
) Q
group by
f1
) Q ) P;
-- DistinctAggregateInCase_p8
select 'DistinctAggregateInCase_p8' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 'test1' f1 from tversion union
select case when min(distinct(tdec.cdec))=-1 then 'test1' else 'else' end from tdec
) Q
group by
f1
) Q ) P;
-- ExactNumericOpAdd_p1
select 'ExactNumericOpAdd_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1,  000001.00 f2 from tversion union
select 2 f1,  000002.00 f2 from tversion union
select 3 f1,  000003.00 f2 from tversion union
select 4 f1,  000002.10 f2 from tversion union
select 5 f1,  000012.00 f2 from tversion union
select vdec.rnum,vdec.cdec + 2 from vdec
) Q
group by
f1,f2
) Q ) P;
-- ExactNumericOpAdd_p2
select 'ExactNumericOpAdd_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1,  000001.00 f2 from tversion union
select 2 f1,  000002.00 f2 from tversion union
select 3 f1,  000003.00 f2 from tversion union
select 4 f1,  000002.10 f2 from tversion union
select 5 f1,  000012.00 f2 from tversion union
select tdec.rnum,tdec.cdec + 2 from tdec
) Q
group by
f1,f2
) Q ) P;
-- ExactNumericOpDiv_p1
select 'ExactNumericOpDiv_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -00000.500000 f2 from tversion union
select 2 f1,  00000.000000 f2 from tversion union
select 3 f1,  00000.500000 f2 from tversion union
select 4 f1,  00000.050000 f2 from tversion union
select 5 f1,  00005.000000 f2 from tversion union
select vdec.rnum,vdec.cdec / 2 from vdec
) Q
group by
f1,f2
) Q ) P;
-- ExactNumericOpDiv_p2
select 'ExactNumericOpDiv_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -00000.500000 f2 from tversion union
select 2 f1,  00000.000000 f2 from tversion union
select 3 f1,  00000.500000 f2 from tversion union
select 4 f1,  00000.050000 f2 from tversion union
select 5 f1,  00005.000000 f2 from tversion union
select tdec.rnum,tdec.cdec / 2 from tdec
) Q
group by
f1,f2
) Q ) P;
-- ExactNumericOpMul_p1
select 'ExactNumericOpMul_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -0000002.00 f2 from tversion union
select 2 f1,  0000000.00 f2 from tversion union
select 3 f1,  0000002.00 f2 from tversion union
select 4 f1,  0000000.20 f2 from tversion union
select 5 f1,  0000020.00 f2 from tversion union
select vdec.rnum,vdec.cdec * 2 from vdec
) Q
group by
f1,f2
) Q ) P;
-- ExactNumericOpMul_p2
select 'ExactNumericOpMul_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -0000002.00 f2 from tversion union
select 2 f1,  0000000.00 f2 from tversion union
select 3 f1,  0000002.00 f2 from tversion union
select 4 f1,  0000000.20 f2 from tversion union
select 5 f1,  0000020.00 f2 from tversion union
select tdec.rnum,tdec.cdec * 2 from tdec
) Q
group by
f1,f2
) Q ) P;
-- ExactNumericOpSub_p1
select 'ExactNumericOpSub_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -000003.00 f2 from tversion union
select 2 f1, -000002.00 f2 from tversion union
select 3 f1, -000001.00 f2 from tversion union
select 4 f1, -000001.90 f2 from tversion union
select 5 f1,  000008.00 f2 from tversion union
select vdec.rnum,vdec.cdec - 2 from vdec
) Q
group by
f1,f2
) Q ) P;
-- ExactNumericOpSub_p2
select 'ExactNumericOpSub_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -000003.00 f2 from tversion union
select 2 f1, -000002.00 f2 from tversion union
select 3 f1, -000001.00 f2 from tversion union
select 4 f1, -000001.90 f2 from tversion union
select 5 f1,  000008.00 f2 from tversion union
select tdec.rnum,tdec.cdec - 2 from tdec
) Q
group by
f1,f2
) Q ) P;
-- ExpCoreExactNumeric_p1
select 'ExpCoreExactNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, .367879441 f2 from tversion union
select 2 f1, 1 f2 from tversion union
select 3 f1, 2.71828183 f2 from tversion union
select 4 f1, 1.10517092 f2 from tversion union
select 5 f1, 22026.4658 f2 from tversion union
select rnum, exp( vdec.cdec ) from vdec
) Q
group by
f1,f2
) Q ) P;
-- ExpCoreExactNumeric_p2
select 'ExpCoreExactNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, .367879441 f2 from tversion union
select 2 f1, 1 f2 from tversion union
select 3 f1, 2.71828183 f2 from tversion union
select 4 f1, 1.10517092 f2 from tversion union
select 5 f1, 22026.4658 f2 from tversion union
select rnum, exp( tdec.cdec ) from tdec
) Q
group by
f1,f2
) Q ) P;
-- FloorCoreExactNumeric_p1
select 'FloorCoreExactNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, floor( vdec.cdec ) from vdec
) Q
group by
f1,f2
) Q ) P;
-- FloorCoreExactNumeric_p2
select 'FloorCoreExactNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 10 f2 from tversion union
select rnum, floor( tdec.cdec ) from tdec
) Q
group by
f1,f2
) Q ) P;
-- AvgExactNumeric_p1
select 'AvgExactNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 2.02 f1 from tversion union
select avg(vdec.cdec) from vdec
) Q
group by
f1
) Q ) P;
-- AvgExactNumeric_p2
select 'AvgExactNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 2.02 f1 from tversion union
select avg(tdec.cdec) from tdec
) Q
group by
f1
) Q ) P;
-- ModCore2ExactNumeric_p1
select 'ModCore2ExactNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 3 f1, 0 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 3 f2 from tversion union
select vdec.rnum, mod( 3,vdec.cdec ) from vdec where vdec.rnum <> 2
) Q
group by
f1,f2
) Q ) P;
-- ModCore2ExactNumeric_p2
select 'ModCore2ExactNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 0 f2 from tversion union
select 3 f1, 0 f2 from tversion union
select 4 f1, 0 f2 from tversion union
select 5 f1, 3 f2 from tversion union
select tdec.rnum, mod( 3,tdec.cdec ) from tdec where tdec.rnum <> 2
) Q
group by
f1,f2
) Q ) P;
-- ModCoreExactNumeric_p1
select 'ModCoreExactNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, .1 f2 from tversion union
select 5 f1, 1 f2 from tversion union
select rnum, mod( vdec.cdec, 3 ) from vdec
) Q
group by
f1,f2
) Q ) P;
-- ModCoreExactNumeric_p2
select 'ModCoreExactNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, -1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, .1 f2 from tversion union
select 5 f1, 1 f2 from tversion union
select rnum, mod( tdec.cdec, 3 ) from tdec
) Q
group by
f1,f2
) Q ) P;
-- PowerCoreExactNumeric_p1
select 'PowerCoreExactNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, .01 f2 from tversion union
select 5 f1, 100 f2 from tversion union
select vdec.rnum, power( vdec.cdec,2 ) from vdec
) Q
group by
f1,f2
) Q ) P;
-- PowerCoreExactNumeric_p2
select 'PowerCoreExactNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1 f2 from tversion union
select 2 f1, 0 f2 from tversion union
select 3 f1, 1 f2 from tversion union
select 4 f1, .01 f2 from tversion union
select 5 f1, 100 f2 from tversion union
select tdec.rnum, power( tdec.cdec,2 ) from tdec
) Q
group by
f1,f2
) Q ) P;
-- AbsCoreExactNumeric_p1
select 'AbsCoreExactNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1.000000000000000e+000 f2 from tversion union
select 2 f1, 0.000000000000000e+000 f2 from tversion union
select 3 f1, 1.000000000000000e+000 f2 from tversion union
select 4 f1, 1.000000000000000e-001 f2 from tversion union
select 5 f1, 1.000000000000000e+001 f2 from tversion union
select rnum, abs( vdec.cdec ) from vdec
) Q
group by
f1,f2
) Q ) P;
-- SelectCountExactNumeric_p1
select 'SelectCountExactNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5 f1 from tversion union
select count(vdec.cdec) from vdec
) Q
group by
f1
) Q ) P;
-- SelectCountExactNumeric_p2
select 'SelectCountExactNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 5 f1 from tversion union
select count(tdec.cdec) from tdec
) Q
group by
f1
) Q ) P;
-- SelectMaxExactNumeric_p1
select 'SelectMaxExactNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10 f1 from tversion union
select max( vdec.cdec ) from vdec
) Q
group by
f1
) Q ) P;
-- SelectMaxExactNumeric_p2
select 'SelectMaxExactNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10 f1 from tversion union
select max( tdec.cdec ) from tdec
) Q
group by
f1
) Q ) P;
-- SelectMinExactNumeric_p1
select 'SelectMinExactNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select -1 f1 from tversion union
select min( vdec.cdec ) from vdec
) Q
group by
f1
) Q ) P;
-- SelectMinExactNumeric_p2
select 'SelectMinExactNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select -1 f1 from tversion union
select min( tdec.cdec ) from tdec
) Q
group by
f1
) Q ) P;
-- CaseBasicSearchExactNumeric_p1
select 'CaseBasicSearchExactNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'test1' f2 from tversion union
select 2 f1, 'other' f2 from tversion union
select 3 f1, 'other' f2 from tversion union
select 4 f1, 'test1' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select vdec.rnum,case when vdec.cdec in ( -1,10,0.1 )  then 'test1' else 'other' end from vdec
) Q
group by
f1,f2
) Q ) P;
-- SelectStanDevPopExactNumeric_p1
select 'SelectStanDevPopExactNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.04 f1 from tversion union
select stddev_pop( vdec.cdec ) from vdec
) Q
group by
f1
) Q ) P;
-- AbsCoreExactNumeric_p2
select 'AbsCoreExactNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, 1.000000000000000e+000 f2 from tversion union
select 2 f1, 0.000000000000000e+000 f2 from tversion union
select 3 f1, 1.000000000000000e+000 f2 from tversion union
select 4 f1, 1.000000000000000e-001 f2 from tversion union
select 5 f1, 1.000000000000000e+001 f2 from tversion union
select rnum, abs( tdec.cdec ) from tdec
) Q
group by
f1,f2
) Q ) P;
-- CaseBasicSearchExactNumeric_p2
select 'CaseBasicSearchExactNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'test1' f2 from tversion union
select 2 f1, 'other' f2 from tversion union
select 3 f1, 'other' f2 from tversion union
select 4 f1, 'test1' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select tdec.rnum,case when tdec.cdec in ( -1,10,0.1 )  then 'test1' else 'other' end from tdec
) Q
group by
f1,f2
) Q ) P;
-- SelectStanDevPopExactNumeric_p2
select 'SelectStanDevPopExactNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.04 f1 from tversion union
select stddev_pop( tdec.cdec ) from tdec
) Q
group by
f1
) Q ) P;
-- SelectSumExactNumeric_p1
select 'SelectSumExactNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10.1 f1 from tversion union
select sum( vdec.cdec ) from vdec
) Q
group by
f1
) Q ) P;
-- SelectSumExactNumeric_p2
select 'SelectSumExactNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 10.1 f1 from tversion union
select sum( tdec.cdec ) from tdec
) Q
group by
f1
) Q ) P;
-- SelectVarPopExactNumeric_p1
select 'SelectVarPopExactNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 16.3216 f1 from tversion union
select var_pop( vdec.cdec ) from vdec
) Q
group by
f1
) Q ) P;
-- SelectVarPopExactNumeric_p2
select 'SelectVarPopExactNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 16.3216 f1 from tversion union
select var_pop( tdec.cdec ) from tdec
) Q
group by
f1
) Q ) P;
-- SimpleCaseExactNumericElseDefaultsNULL_p1
select 'SimpleCaseExactNumericElseDefaultsNULL_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, null f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, null f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select vdec.rnum,case when vdec.cdec=10 then 'test1' when vdec.cdec=-0.1 then 'test2'  end from vdec
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseExactNumericElseDefaultsNULL_p2
select 'SimpleCaseExactNumericElseDefaultsNULL_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, null f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, null f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select tdec.rnum,case when tdec.cdec=10 then 'test1' when tdec.cdec=-0.1 then 'test2'  end from tdec
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseExactNumericElseExplicitNULL_p1
select 'SimpleCaseExactNumericElseExplicitNULL_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, null f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, null f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select vdec.rnum,case when vdec.cdec=10 then 'test1' when vdec.cdec=-0.1 then 'test2'  else null end from vdec
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseExactNumericElseExplicitNULL_p2
select 'SimpleCaseExactNumericElseExplicitNULL_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, null f2 from tversion union
select 1 f1, null f2 from tversion union
select 2 f1, null f2 from tversion union
select 3 f1, null f2 from tversion union
select 4 f1, null f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select tdec.rnum,case when tdec.cdec=10 then 'test1' when tdec.cdec=-0.1 then 'test2'  else null end from tdec
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseExactNumeric_p1
select 'SimpleCaseExactNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'else' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select vdec.rnum,case when vdec.cdec=10 then 'test1' when vdec.cdec=-0.1 then 'test2' else 'else' end from vdec
) Q
group by
f1,f2
) Q ) P;
-- SimpleCaseExactNumeric_p2
select 'SimpleCaseExactNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'else' f2 from tversion union
select 1 f1, 'else' f2 from tversion union
select 2 f1, 'else' f2 from tversion union
select 3 f1, 'else' f2 from tversion union
select 4 f1, 'else' f2 from tversion union
select 5 f1, 'test1' f2 from tversion union
select tdec.rnum,case when tdec.cdec=10 then 'test1' when tdec.cdec=-0.1 then 'test2' else 'else' end from tdec
) Q
group by
f1,f2
) Q ) P;
-- CaseComparisonsExactNumeric_p1
select 'CaseComparisonsExactNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'lt' f2 from tversion union
select 2 f1, 'in' f2 from tversion union
select 3 f1, '=' f2 from tversion union
select 4 f1, 'between' f2 from tversion union
select 5 f1, 'gt' f2 from tversion union
select vdec.rnum,case  when vdec.cdec =  1  then '=' when vdec.cdec >  9  then 'gt' when vdec.cdec < -0.1 then 'lt' when vdec.cdec in  (0,11)  then 'in' when vdec.cdec between 0 and 1  then 'between' else 'other' end from vdec
) Q
group by
f1,f2
) Q ) P;
-- CaseComparisonsExactNumeric_p2
select 'CaseComparisonsExactNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 0 f1, 'other' f2 from tversion union
select 1 f1, 'lt' f2 from tversion union
select 2 f1, 'in' f2 from tversion union
select 3 f1, '=' f2 from tversion union
select 4 f1, 'between' f2 from tversion union
select 5 f1, 'gt' f2 from tversion union
select tdec.rnum,case  when tdec.cdec =  1  then '=' when tdec.cdec >  9  then 'gt' when tdec.cdec < -0.1 then 'lt' when tdec.cdec in  (0,11)  then 'in' when tdec.cdec between 0 and 1  then 'between' else 'other' end from tdec
) Q
group by
f1,f2
) Q ) P;
-- StanDevExactNumeric_p1
select 'StanDevExactNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.516857 f1 from tversion union
select stddev( vdec.cdec ) from vdec
) Q
group by
f1
) Q ) P;
-- StanDevExactNumeric_p2
select 'StanDevExactNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.516857 f1 from tversion union
select stddev( tdec.cdec ) from tdec
) Q
group by
f1
) Q ) P;
-- StanDevSampExactNumeric_p1
select 'StanDevSampExactNumeric_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.516857 f1 from tversion union
select stddev_samp( vdec.cdec ) from vdec
) Q
group by
f1
) Q ) P;
-- StanDevSampExactNumeric_p2
select 'StanDevSampExactNumeric_p2' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 4.516857 f1 from tversion union
select stddev_samp( tdec.cdec ) from tdec
) Q
group by
f1
) Q ) P;
