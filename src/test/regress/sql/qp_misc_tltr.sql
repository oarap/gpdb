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
