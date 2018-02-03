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
-- Name: tlth; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace:
--

CREATE TABLE tlth (
    rnum integer NOT NULL,
    c1 character(40),
    ord integer
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
-- Data for Name: tlth; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tlth (rnum, c1, ord) FROM stdin;
39	เ                                       	29
32	ไ                                       	33
49	!                                       	28
62	๛                                       	48
71	๏                                       	67
20	-                                       	11
13	ฯ                                       	54
38	&                                       	71
27	0                                       	32
48	ๆ                                       	49
57	9                                       	5
26	1                                       	47
3	00                                      	55
24	Zulu                                    	30
25	zulu                                    	39
54	ก                                       	21
51	ก็                                      	70
16	กกขนาก                                  	46
37	ก กา                                    	19
74	กก                                      	68
23	ก๊ก                                     	56
4	ก้งง                                    	62
69	ก๊ง                                     	10
34	กกๅ                                     	3
35	กกา                                     	25
52	กังก                                    	45
1	กฏิ                                     	72
66	กง                                      	15
67	ก้ง                                     	12
64	กำ                                      	40
73	ก้ำ                                     	53
22	ก่ง                                     	14
15	กฏุก                                    	38
12	กิ่ง                                    	43
41	กิก                                     	61
70	กฏุก-                                   	34
31	กระจาบ                                  	20
8	กู้หน้า                                 	6
21	กิ๊ก                                    	65
10	กรรมสิทธิ์เครื่องหมายและยี่ห้อการค้าขาย 	2
59	-กระจาม                                 	22
44	เก่น                                    	60
61	-เกงกอย                                 	17
2	กรรมสิทธิ์ผู้แต่งหนังสือ                	74
55	กระจาย                                  	75
72	แก่                                     	13
5	เกนๆ                                    	16
58	-กระจิ๋ง                                	23
47	ก่ำ                                     	50
68	แก้                                     	37
53	โก่                                     	66
30	กระจิด                                  	9
43	เก่                                     	52
56	แก่กล้า                                 	35
45	ใกล้                                    	51
14	กัง                                     	1
11	เก็บ                                    	36
28	ไก                                      	8
65	ฃ                                       	42
42	กั้ง                                    	73
19	แก                                      	59
60	คคน-                                    	24
17	๐๙                                      	31
6	เก                                      	4
75	ขง                                      	69
40	๘                                       	44
9	๑                                       	7
50	เกน                                     	41
7	ไฮฮี                                    	26
36	 ํ                                      	63
29	๒                                       	57
46	ค                                       	64
63	๐๐                                      	27
18	๐                                       	58
33	๙                                       	18
\.


--
-- Data for Name: tltr; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tltr (rnum, c1, ord) FROM stdin;
51	cable                                   	8
52	                                        	52
1	                                        	1
50	Cable                                   	40
31	COOP                                    	37
44	@@@@@                                   	45
13	@@@air                                  	44
34	Czech                                   	51
47	çapraz                                  	36
48	0000                                    	43
9	C.B.A.                                  	39
42	çizgiler                                	26
35	çıkmak                                  	30
20	999                                     	42
49	caption                                 	38
38	çoklu                                   	7
43	çizgi                                   	6
24	air@@@                                  	41
41	co-op                                   	4
30	Hata                                    	34
23	icon                                    	47
36	çevir                                   	48
25	CO-OP                                   	35
22	ıptali                                  	12
19	IP                                      	27
40	çizim                                   	31
45	çift                                    	32
18	Ipucu                                   	50
27	Item                                    	15
28	hub                                     	28
37	Çok                                     	29
26	İsteği                                  	25
11	step                                    	24
16	Ölçer                                   	17
33	digit                                   	14
14	option                                  	19
7	update                                  	13
12	özellikler                              	23
21	diğer                                   	33
10	şifreleme                               	22
3	Üyelik                                  	18
8	Şarkı                                   	49
5	Üyeleri                                 	20
6	Uzantısı                                	21
39	vicennial                               	11
4	üyelik                                  	3
29	vice                                    	16
46	verkehrt                                	46
15	vice-versa                              	9
32	vice versa                              	10
17	vice-admiral                            	5
2	Zero                                    	2
\.

--
-- Data for Name: tversion; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tversion (rnum, c1, cver, cnnull, ccnull) FROM stdin;
0	1	1.0   	\N	\N
\.


-- SelectThaiColumnConcat_p1
select 'SelectThaiColumnConcat_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 47 f1, '๛ก่ำ                               ' f2 from tversion union
select rnum, '๛' || c1 from tlth where rnum = 47
) Q
group by
f1,f2
) Q ) P;
-- SelectThaiColumnLower_p1
select 'SelectThaiColumnLower_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 47 f1, 'ก่ำ' f2 from tversion union
select rnum, lower(c1) from tlth where rnum=47
) Q
group by
f1,f2
) Q ) P;
-- SelectThaiColumnOrderByLocal_p1
select 'SelectThaiColumnOrderByLocal_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select  00000000000000000000000000000000000036 f1, ' ํ                                      ' f2 from tversion union
select  00000000000000000000000000000000000049 f1, '!                                       ' f2 from tversion union
select  00000000000000000000000000000000000020 f1, '-                                       ' f2 from tversion union
select  00000000000000000000000000000000000059 f1, '-กระจาม                                 ' f2 from tversion union
select  00000000000000000000000000000000000058 f1, '-กระจิ๋ง                                ' f2 from tversion union
select  00000000000000000000000000000000000061 f1, '-เกงกอย                                 ' f2 from tversion union
select  00000000000000000000000000000000000027 f1, '0                                       ' f2 from tversion union
select  00000000000000000000000000000000000003 f1, '00                                      ' f2 from tversion union
select  00000000000000000000000000000000000026 f1, '1                                       ' f2 from tversion union
select  00000000000000000000000000000000000057 f1, '9                                       ' f2 from tversion union
select  00000000000000000000000000000000000024 f1, 'Zulu                                    ' f2 from tversion union
select  00000000000000000000000000000000000025 f1, 'zulu                                    ' f2 from tversion union
select  00000000000000000000000000000000000054 f1, 'ก                                       ' f2 from tversion union
select  00000000000000000000000000000000000037 f1, 'ก กา                                    ' f2 from tversion union
select  00000000000000000000000000000000000074 f1, 'กก                                      ' f2 from tversion union
select  00000000000000000000000000000000000016 f1, 'กกขนาก                                  ' f2 from tversion union
select  00000000000000000000000000000000000035 f1, 'กกา                                     ' f2 from tversion union
select  00000000000000000000000000000000000034 f1, 'กกๅ                                     ' f2 from tversion union
select  00000000000000000000000000000000000066 f1, 'กง                                      ' f2 from tversion union
select  00000000000000000000000000000000000001 f1, 'กฏิ                                     ' f2 from tversion union
select  00000000000000000000000000000000000015 f1, 'กฏุก                                    ' f2 from tversion union
select  00000000000000000000000000000000000070 f1, 'กฏุก-                                   ' f2 from tversion union
select  00000000000000000000000000000000000002 f1, 'กรรมสิทธิ์ผู้แต่งหนังสือ                ' f2 from tversion union
select  00000000000000000000000000000000000010 f1, 'กรรมสิทธิ์เครื่องหมายและยี่ห้อการค้าขาย ' f2 from tversion union
select  00000000000000000000000000000000000031 f1, 'กระจาบ                                  ' f2 from tversion union
select  00000000000000000000000000000000000055 f1, 'กระจาย                                  ' f2 from tversion union
select  00000000000000000000000000000000000030 f1, 'กระจิด                                  ' f2 from tversion union
select  00000000000000000000000000000000000014 f1, 'กัง                                     ' f2 from tversion union
select  00000000000000000000000000000000000052 f1, 'กังก                                    ' f2 from tversion union
select  00000000000000000000000000000000000042 f1, 'กั้ง                                    ' f2 from tversion union
select  00000000000000000000000000000000000064 f1, 'กำ                                      ' f2 from tversion union
select  00000000000000000000000000000000000041 f1, 'กิก                                     ' f2 from tversion union
select  00000000000000000000000000000000000012 f1, 'กิ่ง                                    ' f2 from tversion union
select  00000000000000000000000000000000000021 f1, 'กิ๊ก                                    ' f2 from tversion union
select  00000000000000000000000000000000000008 f1, 'กู้หน้า                                 ' f2 from tversion union
select  00000000000000000000000000000000000051 f1, 'ก็                                      ' f2 from tversion union
select  00000000000000000000000000000000000022 f1, 'ก่ง                                     ' f2 from tversion union
select  00000000000000000000000000000000000047 f1, 'ก่ำ                                     ' f2 from tversion union
select  00000000000000000000000000000000000067 f1, 'ก้ง                                     ' f2 from tversion union
select  00000000000000000000000000000000000004 f1, 'ก้งง                                    ' f2 from tversion union
select  00000000000000000000000000000000000073 f1, 'ก้ำ                                     ' f2 from tversion union
select  00000000000000000000000000000000000023 f1, 'ก๊ก                                     ' f2 from tversion union
select  00000000000000000000000000000000000069 f1, 'ก๊ง                                     ' f2 from tversion union
select  00000000000000000000000000000000000075 f1, 'ขง                                      ' f2 from tversion union
select  00000000000000000000000000000000000065 f1, 'ฃ                                       ' f2 from tversion union
select  00000000000000000000000000000000000046 f1, 'ค                                       ' f2 from tversion union
select  00000000000000000000000000000000000060 f1, 'คคน-                                    ' f2 from tversion union
select  00000000000000000000000000000000000013 f1, 'ฯ                                       ' f2 from tversion union
select  00000000000000000000000000000000000039 f1, 'เ                                       ' f2 from tversion union
select  00000000000000000000000000000000000006 f1, 'เก                                      ' f2 from tversion union
select  00000000000000000000000000000000000050 f1, 'เกน                                     ' f2 from tversion union
select  00000000000000000000000000000000000005 f1, 'เกนๆ                                    ' f2 from tversion union
select  00000000000000000000000000000000000011 f1, 'เก็บ                                    ' f2 from tversion union
select  00000000000000000000000000000000000043 f1, 'เก่                                     ' f2 from tversion union
select  00000000000000000000000000000000000044 f1, 'เก่น                                    ' f2 from tversion union
select  00000000000000000000000000000000000019 f1, 'แก                                      ' f2 from tversion union
select  00000000000000000000000000000000000072 f1, 'แก่                                     ' f2 from tversion union
select  00000000000000000000000000000000000056 f1, 'แก่กล้า                                 ' f2 from tversion union
select  00000000000000000000000000000000000068 f1, 'แก้                                     ' f2 from tversion union
select  00000000000000000000000000000000000053 f1, 'โก่                                     ' f2 from tversion union
select  00000000000000000000000000000000000045 f1, 'ใกล้                                    ' f2 from tversion union
select  00000000000000000000000000000000000032 f1, 'ไ                                       ' f2 from tversion union
select  00000000000000000000000000000000000028 f1, 'ไก                                      ' f2 from tversion union
select  00000000000000000000000000000000000007 f1, 'ไฮฮี                                    ' f2 from tversion union
select  00000000000000000000000000000000000048 f1, 'ๆ                                       ' f2 from tversion union
select  00000000000000000000000000000000000071 f1, '๏                                       ' f2 from tversion union
select  00000000000000000000000000000000000018 f1, '๐                                       ' f2 from tversion union
select  00000000000000000000000000000000000063 f1, '๐๐                                      ' f2 from tversion union
select  00000000000000000000000000000000000017 f1, '๐๙                                      ' f2 from tversion union
select  00000000000000000000000000000000000009 f1, '๑                                       ' f2 from tversion union
select  00000000000000000000000000000000000029 f1, '๒                                       ' f2 from tversion union
select  00000000000000000000000000000000000040 f1, '๘                                       ' f2 from tversion union
select  00000000000000000000000000000000000033 f1, '๙                                       ' f2 from tversion union
select  00000000000000000000000000000000000062 f1, '๛                                       ' f2 from tversion union
select rnum, c1 from tlth where rnum <> 38
) Q
group by
f1,f2
) Q ) P;
-- SelectThaiColumnWhere_p1
select 'SelectThaiColumnWhere_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 62 f1, '๛                                     ' f2 from tversion union
select rnum, c1  from tlth where c1='๛'
) Q
group by
f1,f2
) Q ) P;
-- SelectThaiDistinctColumn_p1
select 'SelectThaiDistinctColumn_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 75 f1 from tversion union
select count (distinct c1)  from tlth
) Q
group by
f1
) Q ) P;
