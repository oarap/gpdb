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

