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
-- Name: tlja; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace:
--

CREATE TABLE tlja (
    rnum integer NOT NULL,
    c1 character(40),
    ord integer
) DISTRIBUTED BY (rnum);



--
-- Name: tlja_jp; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace:
--

CREATE TABLE tlja_jp (
    rnum integer NOT NULL,
    c1 character(40),
    ord integer
) DISTRIBUTED BY (rnum);



--
-- Name: tlth; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace:
--

CREATE TABLE tlth (
    rnum integer NOT NULL,
    c1 character(40),
    ord integer
) DISTRIBUTED BY (rnum);



--
-- Name: tltr; Type: TABLE; Schema: public; Owner: gpadmin; Tablespace:
--

CREATE TABLE tltr (
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
-- Data for Name: tlja; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tlja (rnum, c1, ord) FROM stdin;
11	(1)ｲﾝﾃﾞｯｸｽ                              	36
12	<5>Switches                             	37
9	666Sink                                 	40
10	400ｒａｎｋｕ                                	39
27	エコー                                     	34
28	コート                                     	3
13	R-Bench                                 	38
14	P-Cabels                                	35
31	ズボン                                     	5
40	さんしょう                                   	6
25	ガード                                     	4
26	エチャント                                   	24
39	はっぽ                                     	43
36	せんたくざい                                  	46
29	ゴム                                      	1
30	スワップ                                    	41
35	フッコク                                    	49
32	ダイエル                                    	45
41	ざぶと                                     	2
38	はつ剤                                     	44
47	音声認識                                    	7
8	「２」計画                                   	47
37	せっけい                                    	42
34	ファイル                                    	48
43	記録機                                     	11
44	記載                                      	10
33	フィルター                                   	50
46	暗視                                      	9
7	⑤号線路                                    	21
48	国立公園                                    	18
45	音楽                                      	8
42	高機能                                     	15
3	ＰＶＤＦ                                    	19
4	ＲＯＭＡＮ-８                                 	13
49	国立大学                                    	22
50	国家利益                                    	14
15	ｱﾝｶｰ                                    	12
16	ｴﾝｼﾞﾝ                                   	30
5	（Ⅰ）番号列                                  	23
2	９８０Series                               	16
19	ｶｯﾄﾏｼﾝ                                  	29
20	ｶｰﾄﾞ                                    	28
1	３５６CAL                                  	17
6	＜ⅸ＞Pattern                              	20
23	ﾌｫﾙﾀﾞｰ                                  	33
24	ｻｲﾌ                                     	27
17	ｺﾞｰﾙﾄﾞ                                  	25
18	ｺｰﾗ                                     	26
21	ﾂｰｳｨﾝｸﾞ                                 	32
22	ﾏﾝﾎﾞ                                    	31
\.


--
-- Data for Name: tlja_jp; Type: TABLE DATA; Schema: public; Owner: gpadmin
--

COPY tlja_jp (rnum, c1, ord) FROM stdin;
11	(1)ｲﾝﾃﾞｯｸｽ                              	36
12	<5>Switches                             	37
9	666Sink                                 	40
10	400ｒａｎｋｕ                                	39
7	⑤号線路                                    	7
8	「２」計画                                   	8
13	R-Bench                                 	38
14	P-Cabels                                	35
39	はっぽ                                     	6
40	さんしょう                                   	4
41	ざぶと                                     	3
38	はつ剤                                     	5
27	エコー                                     	41
36	せんたくざい                                  	2
37	せっけい                                    	1
26	エチャント                                   	42
31	ズボン                                     	48
28	コート                                     	45
25	ガード                                     	46
30	スワップ                                    	44
35	フッコク                                    	17
32	ダイエル                                    	50
29	ゴム                                      	43
34	ファイル                                    	49
43	記録機                                     	21
48	国立公園                                    	15
33	フィルター                                   	47
50	国家利益                                    	16
47	音声認識                                    	22
44	記載                                      	20
49	国立大学                                    	18
46	暗視                                      	19
3	ＰＶＤＦ                                    	13
4	ＲＯＭＡＮ-８                                 	9
45	音楽                                      	24
42	高機能                                     	23
15	ｱﾝｶｰ                                    	10
16	ｴﾝｼﾞﾝ                                   	34
5	（Ⅰ）番号列                                  	25
2	９８０Series                               	11
19	ｶｯﾄﾏｼﾝ                                  	31
20	ｶｰﾄﾞ                                    	30
1	３５６CAL                                  	12
6	＜ⅸ＞Pattern                              	14
23	ﾌｫﾙﾀﾞｰ                                  	28
24	ｻｲﾌ                                     	32
17	ｺﾞｰﾙﾄﾞ                                  	29
18	ｺｰﾗ                                     	33
21	ﾂｰｳｨﾝｸﾞ                                 	27
22	ﾏﾝﾎﾞ                                    	26
\.


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


-- SelectJapaneseColumnConcat_p1
select 'SelectJapaneseColumnConcat_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 47 f1, '「２」計画音声認識                  ' f2 from tversion union
select rnum, '「２」計画' || c1 from tlja where rnum = 47
) Q
group by
f1,f2
) Q ) P;
-- SelectJapaneseColumnLower_p1
select 'SelectJapaneseColumnLower_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 47 f1, '音声認識                  ' f2 from tversion union
select rnum, lower(c1) from tlja where rnum = 47
) Q
group by
f1,f2
) Q ) P;
-- SelectJapaneseColumnOrderByLocal_p1
select 'SelectJapaneseColumnOrderByLocal_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select  00000000000000000000000000000000000011 f1, '(1)ｲﾝﾃﾞｯｸｽ      ' f2 from tversion union
select  00000000000000000000000000000000000010 f1, '400ｒａｎｋｕ            ' f2 from tversion union
select  00000000000000000000000000000000000009 f1, '666Sink                       ' f2 from tversion union
select  00000000000000000000000000000000000014 f1, 'P-Cabels                      ' f2 from tversion union
select  00000000000000000000000000000000000013 f1, 'R-Bench                       ' f2 from tversion union
select  00000000000000000000000000000000000007 f1, '⑤号線路                  ' f2 from tversion union
select  00000000000000000000000000000000000008 f1, '「２」計画               ' f2 from tversion union
select  00000000000000000000000000000000000040 f1, 'さんしょう               ' f2 from tversion union
select  00000000000000000000000000000000000041 f1, 'ざぶと                     ' f2 from tversion union
select  00000000000000000000000000000000000037 f1, 'せっけい                  ' f2 from tversion union
select  00000000000000000000000000000000000036 f1, 'せんたくざい            ' f2 from tversion union
select  00000000000000000000000000000000000039 f1, 'はっぽ                     ' f2 from tversion union
select  00000000000000000000000000000000000038 f1, 'はつ剤                     ' f2 from tversion union
select  00000000000000000000000000000000000027 f1, 'エコー                     ' f2 from tversion union
select  00000000000000000000000000000000000026 f1, 'エチャント               ' f2 from tversion union
select  00000000000000000000000000000000000025 f1, 'ガード                     ' f2 from tversion union
select  00000000000000000000000000000000000028 f1, 'コート                     ' f2 from tversion union
select  00000000000000000000000000000000000029 f1, 'ゴム                        ' f2 from tversion union
select  00000000000000000000000000000000000030 f1, 'スワップ                  ' f2 from tversion union
select  00000000000000000000000000000000000031 f1, 'ズボン                     ' f2 from tversion union
select  00000000000000000000000000000000000032 f1, 'ダイエル                  ' f2 from tversion union
select  00000000000000000000000000000000000034 f1, 'ファイル                  ' f2 from tversion union
select  00000000000000000000000000000000000033 f1, 'フィルター               ' f2 from tversion union
select  00000000000000000000000000000000000035 f1, 'フッコク                  ' f2 from tversion union
select  00000000000000000000000000000000000050 f1, '国家利益                  ' f2 from tversion union
select  00000000000000000000000000000000000048 f1, '国立公園                  ' f2 from tversion union
select  00000000000000000000000000000000000049 f1, '国立大学                  ' f2 from tversion union
select  00000000000000000000000000000000000046 f1, '暗視                        ' f2 from tversion union
select  00000000000000000000000000000000000044 f1, '記載                        ' f2 from tversion union
select  00000000000000000000000000000000000043 f1, '記録機                     ' f2 from tversion union
select  00000000000000000000000000000000000047 f1, '音声認識                  ' f2 from tversion union
select  00000000000000000000000000000000000045 f1, '音楽                        ' f2 from tversion union
select  00000000000000000000000000000000000042 f1, '高機能                     ' f2 from tversion union
select  00000000000000000000000000000000000005 f1, '（Ⅰ）番号列            ' f2 from tversion union
select  00000000000000000000000000000000000001 f1, '３５６CAL                  ' f2 from tversion union
select  00000000000000000000000000000000000002 f1, '９８０Series               ' f2 from tversion union
select  00000000000000000000000000000000000006 f1, '＜ⅸ＞Pattern              ' f2 from tversion union
select  00000000000000000000000000000000000003 f1, 'ＰＶＤＦ                  ' f2 from tversion union
select  00000000000000000000000000000000000004 f1, 'ＲＯＭＡＮ-８           ' f2 from tversion union
select  00000000000000000000000000000000000015 f1, 'ｱﾝｶｰ                  ' f2 from tversion union
select  00000000000000000000000000000000000016 f1, 'ｴﾝｼﾞﾝ               ' f2 from tversion union
select  00000000000000000000000000000000000019 f1, 'ｶｯﾄﾏｼﾝ            ' f2 from tversion union
select  00000000000000000000000000000000000020 f1, 'ｶｰﾄﾞ                  ' f2 from tversion union
select  00000000000000000000000000000000000018 f1, 'ｺｰﾗ                     ' f2 from tversion union
select  00000000000000000000000000000000000017 f1, 'ｺﾞｰﾙﾄﾞ            ' f2 from tversion union
select  00000000000000000000000000000000000024 f1, 'ｻｲﾌ                     ' f2 from tversion union
select  00000000000000000000000000000000000021 f1, 'ﾂｰｳｨﾝｸﾞ         ' f2 from tversion union
select  00000000000000000000000000000000000023 f1, 'ﾌｫﾙﾀﾞｰ            ' f2 from tversion union
select  00000000000000000000000000000000000022 f1, 'ﾏﾝﾎﾞ                  ' f2 from tversion union
select rnum, c1 from tlja where rnum <> 12
) Q
group by
f1,f2
) Q ) P;
-- SelectJapaneseColumnWhere_p1
select 'SelectJapaneseColumnWhere_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 47 f1, '音声認識                                ' f2 from tversion union
select rnum, c1  from tlja where c1='音声認識'
) Q
group by
f1,f2
) Q ) P;
-- SelectJapaneseDistinctColumn_p1
select 'SelectJapaneseDistinctColumn_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 50 f1 from tversion union
select count (distinct c1)  from tlja
) Q
group by
f1
) Q ) P;
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
-- SelectTurkishColumnConcat_p1
select 'SelectTurkishColumnConcat_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select  00000000000000000000000000000000000001 f1, 'Ã§Ä±kmak' f2 from tversion union
select  00000000000000000000000000000000000002 f1, 'Ã§Ä±kmakZero                          ' f2 from tversion union
select  00000000000000000000000000000000000003 f1, 'Ã§Ä±kmakÜyelik                       ' f2 from tversion union
select  00000000000000000000000000000000000004 f1, 'Ã§Ä±kmaküyelik                       ' f2 from tversion union
select  00000000000000000000000000000000000005 f1, 'Ã§Ä±kmakÜyeleri                      ' f2 from tversion union
select  00000000000000000000000000000000000006 f1, 'Ã§Ä±kmakUzantısı                    ' f2 from tversion union
select  00000000000000000000000000000000000007 f1, 'Ã§Ä±kmakupdate                        ' f2 from tversion union
select  00000000000000000000000000000000000008 f1, 'Ã§Ä±kmakŞarkı                       ' f2 from tversion union
select  00000000000000000000000000000000000009 f1, 'Ã§Ä±kmakC.B.A.                        ' f2 from tversion union
select  00000000000000000000000000000000000010 f1, 'Ã§Ä±kmakşifreleme                    ' f2 from tversion union
select  00000000000000000000000000000000000011 f1, 'Ã§Ä±kmakstep                          ' f2 from tversion union
select  00000000000000000000000000000000000012 f1, 'Ã§Ä±kmaközellikler                   ' f2 from tversion union
select  00000000000000000000000000000000000013 f1, 'Ã§Ä±kmak@@@air                        ' f2 from tversion union
select  00000000000000000000000000000000000014 f1, 'Ã§Ä±kmakoption                        ' f2 from tversion union
select  00000000000000000000000000000000000015 f1, 'Ã§Ä±kmakvice-versa                    ' f2 from tversion union
select  00000000000000000000000000000000000016 f1, 'Ã§Ä±kmakÖlçer                       ' f2 from tversion union
select  00000000000000000000000000000000000017 f1, 'Ã§Ä±kmakvice-admiral                  ' f2 from tversion union
select  00000000000000000000000000000000000018 f1, 'Ã§Ä±kmakIpucu                         ' f2 from tversion union
select  00000000000000000000000000000000000019 f1, 'Ã§Ä±kmakIP                            ' f2 from tversion union
select  00000000000000000000000000000000000020 f1, 'Ã§Ä±kmak999                           ' f2 from tversion union
select  00000000000000000000000000000000000021 f1, 'Ã§Ä±kmakdiğer                        ' f2 from tversion union
select  00000000000000000000000000000000000022 f1, 'Ã§Ä±kmakıptali                       ' f2 from tversion union
select  00000000000000000000000000000000000023 f1, 'Ã§Ä±kmakicon                          ' f2 from tversion union
select  00000000000000000000000000000000000024 f1, 'Ã§Ä±kmakair@@@                        ' f2 from tversion union
select  00000000000000000000000000000000000025 f1, 'Ã§Ä±kmakCO-OP                         ' f2 from tversion union
select  00000000000000000000000000000000000026 f1, 'Ã§Ä±kmakİsteği                      ' f2 from tversion union
select  00000000000000000000000000000000000027 f1, 'Ã§Ä±kmakItem                          ' f2 from tversion union
select  00000000000000000000000000000000000028 f1, 'Ã§Ä±kmakhub                           ' f2 from tversion union
select  00000000000000000000000000000000000029 f1, 'Ã§Ä±kmakvice                          ' f2 from tversion union
select  00000000000000000000000000000000000030 f1, 'Ã§Ä±kmakHata                          ' f2 from tversion union
select  00000000000000000000000000000000000031 f1, 'Ã§Ä±kmakCOOP                          ' f2 from tversion union
select  00000000000000000000000000000000000032 f1, 'Ã§Ä±kmakvice versa                    ' f2 from tversion union
select  00000000000000000000000000000000000033 f1, 'Ã§Ä±kmakdigit                         ' f2 from tversion union
select  00000000000000000000000000000000000034 f1, 'Ã§Ä±kmakCzech                         ' f2 from tversion union
select  00000000000000000000000000000000000035 f1, 'Ã§Ä±kmakçıkmak                      ' f2 from tversion union
select  00000000000000000000000000000000000036 f1, 'Ã§Ä±kmakçevir                        ' f2 from tversion union
select  00000000000000000000000000000000000037 f1, 'Ã§Ä±kmakÇok                          ' f2 from tversion union
select  00000000000000000000000000000000000038 f1, 'Ã§Ä±kmakçoklu                        ' f2 from tversion union
select  00000000000000000000000000000000000039 f1, 'Ã§Ä±kmakvicennial                     ' f2 from tversion union
select  00000000000000000000000000000000000040 f1, 'Ã§Ä±kmakçizim                        ' f2 from tversion union
select  00000000000000000000000000000000000041 f1, 'Ã§Ä±kmakco-op                         ' f2 from tversion union
select  00000000000000000000000000000000000042 f1, 'Ã§Ä±kmakçizgiler                     ' f2 from tversion union
select  00000000000000000000000000000000000043 f1, 'Ã§Ä±kmakçizgi                        ' f2 from tversion union
select  00000000000000000000000000000000000044 f1, 'Ã§Ä±kmak@@@@@                         ' f2 from tversion union
select  00000000000000000000000000000000000045 f1, 'Ã§Ä±kmakçift                         ' f2 from tversion union
select  00000000000000000000000000000000000046 f1, 'Ã§Ä±kmakverkehrt                      ' f2 from tversion union
select  00000000000000000000000000000000000047 f1, 'Ã§Ä±kmakçapraz                       ' f2 from tversion union
select  00000000000000000000000000000000000048 f1, 'Ã§Ä±kmak0000                          ' f2 from tversion union
select  00000000000000000000000000000000000049 f1, 'Ã§Ä±kmakcaption                       ' f2 from tversion union
select  00000000000000000000000000000000000050 f1, 'Ã§Ä±kmakCable                         ' f2 from tversion union
select  00000000000000000000000000000000000051 f1, 'Ã§Ä±kmakcable                         ' f2 from tversion union
select  00000000000000000000000000000000000052 f1, 'Ã§Ä±kmak' f2 from tversion union
select rnum, 'Ã§Ä±kmak' || c1 from tltr
) Q
group by
f1,f2
) Q ) P;
-- SelectTurkishColumnLower_p1
select 'SelectTurkishColumnLower_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select  00000000000000000000000000000000000001 f1, null f2 from tversion union
select  00000000000000000000000000000000000002 f1, 'zero                          ' f2 from tversion union
select  00000000000000000000000000000000000003 f1, 'üyelik                       ' f2 from tversion union
select  00000000000000000000000000000000000004 f1, 'üyelik                       ' f2 from tversion union
select  00000000000000000000000000000000000005 f1, 'üyeleri                      ' f2 from tversion union
select  00000000000000000000000000000000000006 f1, 'uzantısı                    ' f2 from tversion union
select  00000000000000000000000000000000000007 f1, 'update                        ' f2 from tversion union
select  00000000000000000000000000000000000008 f1, 'şarkı                       ' f2 from tversion union
select  00000000000000000000000000000000000009 f1, 'c.b.a.                        ' f2 from tversion union
select  00000000000000000000000000000000000010 f1, 'şifreleme                    ' f2 from tversion union
select  00000000000000000000000000000000000011 f1, 'step                          ' f2 from tversion union
select  00000000000000000000000000000000000012 f1, 'özellikler                   ' f2 from tversion union
select  00000000000000000000000000000000000013 f1, '@@@air                        ' f2 from tversion union
select  00000000000000000000000000000000000014 f1, 'option                        ' f2 from tversion union
select  00000000000000000000000000000000000015 f1, 'vice-versa                    ' f2 from tversion union
select  00000000000000000000000000000000000016 f1, 'ölçer                       ' f2 from tversion union
select  00000000000000000000000000000000000017 f1, 'vice-admiral                  ' f2 from tversion union
select  00000000000000000000000000000000000018 f1, 'ipucu                         ' f2 from tversion union
select  00000000000000000000000000000000000019 f1, 'ip                            ' f2 from tversion union
select  00000000000000000000000000000000000020 f1, '999                           ' f2 from tversion union
select  00000000000000000000000000000000000021 f1, 'diğer                        ' f2 from tversion union
select  00000000000000000000000000000000000022 f1, 'ıptali                       ' f2 from tversion union
select  00000000000000000000000000000000000023 f1, 'icon                          ' f2 from tversion union
select  00000000000000000000000000000000000024 f1, 'air@@@                        ' f2 from tversion union
select  00000000000000000000000000000000000025 f1, 'co-op                         ' f2 from tversion union
select  00000000000000000000000000000000000026 f1, 'isteği                      ' f2 from tversion union
select  00000000000000000000000000000000000027 f1, 'item                          ' f2 from tversion union
select  00000000000000000000000000000000000028 f1, 'hub                           ' f2 from tversion union
select  00000000000000000000000000000000000029 f1, 'vice                          ' f2 from tversion union
select  00000000000000000000000000000000000030 f1, 'hata                          ' f2 from tversion union
select  00000000000000000000000000000000000031 f1, 'coop                          ' f2 from tversion union
select  00000000000000000000000000000000000032 f1, 'vice versa                    ' f2 from tversion union
select  00000000000000000000000000000000000033 f1, 'digit                         ' f2 from tversion union
select  00000000000000000000000000000000000034 f1, 'czech                         ' f2 from tversion union
select  00000000000000000000000000000000000035 f1, 'çıkmak                      ' f2 from tversion union
select  00000000000000000000000000000000000036 f1, 'çevir                        ' f2 from tversion union
select  00000000000000000000000000000000000037 f1, 'çok                          ' f2 from tversion union
select  00000000000000000000000000000000000038 f1, 'çoklu                        ' f2 from tversion union
select  00000000000000000000000000000000000039 f1, 'vicennial                     ' f2 from tversion union
select  00000000000000000000000000000000000040 f1, 'çizim                        ' f2 from tversion union
select  00000000000000000000000000000000000041 f1, 'co-op                         ' f2 from tversion union
select  00000000000000000000000000000000000042 f1, 'çizgiler                     ' f2 from tversion union
select  00000000000000000000000000000000000043 f1, 'çizgi                        ' f2 from tversion union
select  00000000000000000000000000000000000044 f1, '@@@@@                         ' f2 from tversion union
select  00000000000000000000000000000000000045 f1, 'çift                         ' f2 from tversion union
select  00000000000000000000000000000000000046 f1, 'verkehrt                      ' f2 from tversion union
select  00000000000000000000000000000000000047 f1, 'çapraz                       ' f2 from tversion union
select  00000000000000000000000000000000000048 f1, '0000                          ' f2 from tversion union
select  00000000000000000000000000000000000049 f1, 'caption                       ' f2 from tversion union
select  00000000000000000000000000000000000050 f1, 'cable                         ' f2 from tversion union
select  00000000000000000000000000000000000051 f1, 'cable                         ' f2 from tversion union
select  00000000000000000000000000000000000052 f1, '' f2 from tversion union
select rnum, lower(c1) from tltr
) Q
group by
f1,f2
) Q ) P;
-- SelectTurkishColumnOrderByLocal_p1
select 'SelectTurkishColumnOrderByLocal_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select  00000000000000000000000000000000000048 f1, '0000                          ' f2 from tversion union
select  00000000000000000000000000000000000020 f1, '999                           ' f2 from tversion union
select  00000000000000000000000000000000000044 f1, '@@@@@                         ' f2 from tversion union
select  00000000000000000000000000000000000013 f1, '@@@air                        ' f2 from tversion union
select  00000000000000000000000000000000000009 f1, 'C.B.A.                        ' f2 from tversion union
select  00000000000000000000000000000000000025 f1, 'CO-OP                         ' f2 from tversion union
select  00000000000000000000000000000000000031 f1, 'COOP                          ' f2 from tversion union
select  00000000000000000000000000000000000050 f1, 'Cable                         ' f2 from tversion union
select  00000000000000000000000000000000000034 f1, 'Czech                         ' f2 from tversion union
select  00000000000000000000000000000000000030 f1, 'Hata                          ' f2 from tversion union
select  00000000000000000000000000000000000019 f1, 'IP                            ' f2 from tversion union
select  00000000000000000000000000000000000018 f1, 'Ipucu                         ' f2 from tversion union
select  00000000000000000000000000000000000027 f1, 'Item                          ' f2 from tversion union
select  00000000000000000000000000000000000006 f1, 'Uzantısı                    ' f2 from tversion union
select  00000000000000000000000000000000000002 f1, 'Zero                          ' f2 from tversion union
select  00000000000000000000000000000000000024 f1, 'air@@@                        ' f2 from tversion union
select  00000000000000000000000000000000000051 f1, 'cable                         ' f2 from tversion union
select  00000000000000000000000000000000000049 f1, 'caption                       ' f2 from tversion union
select  00000000000000000000000000000000000041 f1, 'co-op                         ' f2 from tversion union
select  00000000000000000000000000000000000033 f1, 'digit                         ' f2 from tversion union
select  00000000000000000000000000000000000021 f1, 'diğer                        ' f2 from tversion union
select  00000000000000000000000000000000000028 f1, 'hub                           ' f2 from tversion union
select  00000000000000000000000000000000000023 f1, 'icon                          ' f2 from tversion union
select  00000000000000000000000000000000000014 f1, 'option                        ' f2 from tversion union
select  00000000000000000000000000000000000011 f1, 'step                          ' f2 from tversion union
select  00000000000000000000000000000000000007 f1, 'update                        ' f2 from tversion union
select  00000000000000000000000000000000000046 f1, 'verkehrt                      ' f2 from tversion union
select  00000000000000000000000000000000000029 f1, 'vice                          ' f2 from tversion union
select  00000000000000000000000000000000000032 f1, 'vice versa                    ' f2 from tversion union
select  00000000000000000000000000000000000017 f1, 'vice-admiral                  ' f2 from tversion union
select  00000000000000000000000000000000000015 f1, 'vice-versa                    ' f2 from tversion union
select  00000000000000000000000000000000000039 f1, 'vicennial                     ' f2 from tversion union
select  00000000000000000000000000000000000037 f1, 'Çok                          ' f2 from tversion union
select  00000000000000000000000000000000000016 f1, 'Ölçer                       ' f2 from tversion union
select  00000000000000000000000000000000000005 f1, 'Üyeleri                      ' f2 from tversion union
select  00000000000000000000000000000000000003 f1, 'Üyelik                       ' f2 from tversion union
select  00000000000000000000000000000000000047 f1, 'çapraz                       ' f2 from tversion union
select  00000000000000000000000000000000000036 f1, 'çevir                        ' f2 from tversion union
select  00000000000000000000000000000000000045 f1, 'çift                         ' f2 from tversion union
select  00000000000000000000000000000000000043 f1, 'çizgi                        ' f2 from tversion union
select  00000000000000000000000000000000000042 f1, 'çizgiler                     ' f2 from tversion union
select  00000000000000000000000000000000000040 f1, 'çizim                        ' f2 from tversion union
select  00000000000000000000000000000000000038 f1, 'çoklu                        ' f2 from tversion union
select  00000000000000000000000000000000000035 f1, 'çıkmak                      ' f2 from tversion union
select  00000000000000000000000000000000000012 f1, 'özellikler                   ' f2 from tversion union
select  00000000000000000000000000000000000004 f1, 'üyelik                       ' f2 from tversion union
select  00000000000000000000000000000000000026 f1, 'İsteği                      ' f2 from tversion union
select  00000000000000000000000000000000000022 f1, 'ıptali                       ' f2 from tversion union
select  00000000000000000000000000000000000008 f1, 'Şarkı                       ' f2 from tversion union
select  00000000000000000000000000000000000010 f1, 'şifreleme                    ' f2 from tversion union
select  00000000000000000000000000000000000052 f1, null f2 from tversion union
select  00000000000000000000000000000000000001 f1, null f2 from tversion union
select rnum, c1 from tltr
) Q
group by
f1,f2
) Q ) P;
-- SelectTurkishColumnWhere_p1
select 'SelectTurkishColumnWhere_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1,f2, count(*) c  from (
select 35 f1, 'çıkmak                                ' f2 from tversion union
select rnum, c1  from tltr where c1='çıkmak'
) Q
group by
f1,f2
) Q ) P;
-- SelectTurkishDistinctColumn_p1
select 'SelectTurkishDistinctColumn_p1' test_name_part, case when c = 1 then 1 else 0 end pass_ind from (
select count(distinct c) c from (
select f1, count(*) c  from (
select 51 f1 from tversion union
select count (distinct c1)  from tltr
) Q
group by
f1
) Q ) P;

