--
-- PostgreSQL database dump
--

-- Dumped from database version 17.3 (Debian 17.3-1.pgdg120+1)
-- Dumped by pg_dump version 17.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: customers; Type: TABLE; Schema: public; Owner: dhg503
--

CREATE TABLE public.customers (
    customerid integer NOT NULL,
    customername text,
    contactname text,
    address text,
    city text,
    postalcode text,
    country text
);


ALTER TABLE public.customers OWNER TO dhg503;

--
-- Name: customers_customerid_seq; Type: SEQUENCE; Schema: public; Owner: dhg503
--

CREATE SEQUENCE public.customers_customerid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customers_customerid_seq OWNER TO dhg503;

--
-- Name: customers_customerid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dhg503
--

ALTER SEQUENCE public.customers_customerid_seq OWNED BY public.customers.customerid;


--
-- Name: dynasty; Type: TABLE; Schema: public; Owner: dhg503
--

CREATE TABLE public.dynasty (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.dynasty OWNER TO dhg503;

--
-- Name: dynasty_id_seq; Type: SEQUENCE; Schema: public; Owner: dhg503
--

CREATE SEQUENCE public.dynasty_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dynasty_id_seq OWNER TO dhg503;

--
-- Name: dynasty_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dhg503
--

ALTER SEQUENCE public.dynasty_id_seq OWNED BY public.dynasty.id;


--
-- Name: mqshilu; Type: TABLE; Schema: public; Owner: dhg503
--

CREATE TABLE public.mqshilu (
    id integer NOT NULL,
    url text,
    title text,
    year integer,
    date text,
    content text,
    king text
);


ALTER TABLE public.mqshilu OWNER TO dhg503;

--
-- Name: customers customerid; Type: DEFAULT; Schema: public; Owner: dhg503
--

ALTER TABLE ONLY public.customers ALTER COLUMN customerid SET DEFAULT nextval('public.customers_customerid_seq'::regclass);


--
-- Name: dynasty id; Type: DEFAULT; Schema: public; Owner: dhg503
--

ALTER TABLE ONLY public.dynasty ALTER COLUMN id SET DEFAULT nextval('public.dynasty_id_seq'::regclass);


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: dhg503
--

COPY public.customers (customerid, customername, contactname, address, city, postalcode, country) FROM stdin;
1	Alfreds Futterkiste	Maria Anders	Obere Str. 57	Berlin	12209	Germany
2	Ana Trujillo Emparedados y helados	Ana Trujillo	Avda. de la Constitución 2222	México D.F.	05021	Mexico
3	Antonio Moreno Taquería	Antonio Moreno	Mataderos 2312	México D.F.	05023	Mexico
4	Around the Horn	Thomas Hardy	120 Hanover Sq.	London	WA1 1DP	UK
5	Berglunds snabbköp	Christina Berglund	Berguvsvägen 8	Luleå	S-958 22	Sweden
6	Blauer See Delikatessen	Hanna Moos	Forsterstr. 57	Mannheim	68306	Germany
7	Blondel père et fils	Frédérique Citeaux	24, place Kléber	Strasbourg	67000	France
8	Bólido Comidas preparadas	Martín Sommer	C/ Araquil, 67	Madrid	28023	Spain
9	Bon app	Elizabeth Lincoln	12, rue des Bouchers	Marseille	13008	France
10	Bottom-Dollar Marketse	Elizabeth Lincoln	23 Tsawassen Blvd.	Tsawassen	T2F 8M4	Canada
11	Bólido Comidas preparadas	Martín Sommer	C/ Araquil, 67	Madrid	28023	Spain
12	Cactus Comidas preparadas	Patricio Simpson	Cerrito 333	Buenos Aires	1010	Argentina
13	Centro comercial Moctezuma	Francisco Chang	Sierras de Granada 9993	México D.F.	05022	Mexico
14	Chop-suey Chinese	Yang Wang	Hauptstr. 29	Bern	3012	Switzerland
15	Comércio Mineiro	Pedro Afonso	Av. dos Lusíadas, 23	São Paulo	05432-043	Brazil
16	Consolidated Holdings	Elizabeth Brown	Berkeley Gardens 12  Brewery	London	WX1 6LT	UK
17	Drachenblut Delikatessen	Sven Ottlieb	Walserweg 21	Aachen	52066	Germany
18	Du monde entier	Janine Labrune	67, rue des Cinquante Otages	Nantes	44000	France
19	Eastern Connection	Ann Devon	35 King George	London	WX3 6FW	UK
20	Ernst Handel	Roland Mendel	Kirchgasse 6	Graz	8010	Austria
21	Familia Arquibaldo	Aria Cruz	Rua Orós, 92	São Paulo	05442-030	Brazil
22	FISSA Fabrica Inter. Salchichas S.A.	Diego Roel	C/ Moralzarzal, 86	Madrid	28034	Spain
23	Folies gourmandes	Martine Rancé	184, chaussée de Tournai	Lille	59000	France
24	Franchi S.p.A.	Paolo Accorti	Via Monte Bianco 34	Torino	10100	Italy
25	Frankenversand	Peter Franken	Berliner Platz 43	München	80805	Germany
26	France restauration	Carine Schmitt	54, rue Royale	Nantes	44000	France
27	Furia Bacalhau	Lino Rodriguez	Jardim das rosas n. 32	Lisboa	1675	Portugal
28	Galeria del gastronómo	Eduardo Saavedra	Rambla de Cataluña, 23	Barcelona	8022	Spain
29	Godos Cocina Típica	José Pedro Freyre	C/ Romero, 33	Sevilla	41101	Spain
30	Gourmet Lanchonetes	André Fonseca	Av. Brasil, 442	Campinas	04876-786	Brazil
31	Great Lakes Food Market	Howard Snyder	2732 Baker Blvd.	Eugene	97403	USA
32	GROSELLA-Restaurante	Manuel Pereira	5ª Ave. Los Palosgrandes	Caracas	1081	Venezuela
33	Hanari Carnes	Mario Barbosa	Rua do Paço, 67	Rio de Janeiro	05454-876	Brazil
34	HILARIÓN-Abastos	Carlos Hernández	Carrera 22 con Ave. Carlos Soublette #8-35	San Cristóbal	5022	Venezuela
35	Nordic Trading	Lars Peterson	Hovedgade 15	Copenhagen	2100	Denmark
36	Paris Délices	Marie Bertrand	25 Rue de la République	Paris	75001	France
37	Tokyo Traders	Yoshi Nagase	9-8 Sekimai Musashino-shi	Tokyo	100-0014	Japan
38	Sydney Seafood	Michael Barnes	456 George Street	Sydney	2000	Australia
39	Amsterdam Deli	Jan de Vries	Damrak 277	Amsterdam	1012	Netherlands
40	Milano Fine Foods	Giuseppe Romano	Via Dante 53	Milan	20123	Italy
41	Dublin Pub & Kitchen	Sean O'Connor	42 Temple Bar	Dublin	D02 YH76	Ireland
42	Stockholm Delicatessen	Eva Lundgren	Drottninggatan 89	Stockholm	111 60	Sweden
43	Vienna Coffee House	Franz Weber	Kärntner Straße 12	Vienna	1010	Austria
44	Lisboa Vinhos	Manuel Silva	Rua Augusta 165	Lisbon	1100-048	Portugal
45	Barcelona Tapas	Carmen Rodriguez	Las Ramblas 222	Barcelona	08002	Spain
46	Brussels Chocolatier	Pierre Dubois	Grand Place 5	Brussels	1000	Belgium
47	Oslo Fish Market	Erik Hansen	Storgata 45	Oslo	0182	Norway
48	Athens Olive Oil	Nikos Papadopoulos	Ermou 88	Athens	105 63	Greece
49	Warsaw Deli	Anna Kowalski	Nowy Świat 44	Warsaw	00-363	Poland
50	Prague Beer Garden	Josef Novak	Václavské náměstí 21	Prague	110 00	Czech Republic
51	Budapest Paprika	Zsolt Nagy	Váci utca 33	Budapest	1052	Hungary
52	Moscow Caviar	Ivan Petrov	Tverskaya Street 15	Moscow	125009	Russia
53	Beijing Duck House	Li Wei	Wangfujing Street 88	Beijing	100006	China
54	Seoul Kimchi	Park Min-ji	Gangnam-daero 162	Seoul	06120	South Korea
55	Bangkok Spices	Somchai Suk	Sukhumvit Soi 55	Bangkok	10110	Thailand
56	Singapore Seafood	Lee Kuan	Orchard Road 313	Singapore	238895	Singapore
57	Mumbai Curry House	Raj Patel	Colaba Causeway 28	Mumbai	400005	India
58	Dubai Dates	Ahmed Al-Sayed	Sheikh Zayed Road 155	Dubai	12345	UAE
59	Cape Town Wines	John Smith	Long Street 123	Cape Town	8001	South Africa
60	Buenos Aires Steaks	Diego Martinez	Avenida de Mayo 825	Buenos Aires	1084	Argentina
61	Santiago Seafood	Carlos Ruiz	Providencia 2233	Santiago	7510000	Chile
62	Lima Ceviche	Ana Garcia	Av. La Marina 1000	Lima	15084	Peru
63	Bogota Coffee	Juan Rodriguez	Carrera 7 #72-41	Bogota	110221	Colombia
64	Mexico City Tacos	Roberto Sanchez	Paseo de la Reforma 222	Mexico City	06600	Mexico
65	Toronto Maple	Sarah Johnson	200 Bay Street	Toronto	M5J 2J2	Canada
66	Vancouver Sushi	David Lee	Robson Street 1133	Vancouver	V6E 1B5	Canada
67	Chicago Deep Dish	Mike Williams	233 S Wacker Dr	Chicago	60606	USA
68	New York Deli	Rachel Green	350 5th Avenue	New York	10118	USA
69	San Francisco Sourdough	Tom Wilson	1 Ferry Building	San Francisco	94111	USA
70	Seattle Coffee	Emma Brown	Pike Place 85	Seattle	98101	USA
71	Melbourne Coffee	James Wilson	Collins Street 447	Melbourne	3000	Australia
72	Auckland Fish Market	Emma Thompson	Queen Street 85	Auckland	1010	New Zealand
73	Rome Pasta	Marco Rossi	Via del Corso 112	Rome	00186	Italy
74	Naples Pizza	Luigi Marino	Via Toledo 55	Naples	80132	Italy
75	Florence Wines	Andrea Conti	Via dei Calzaiuoli 65	Florence	50122	Italy
76	Hamburg Fish Market	Hans Schmidt	Reeperbahn 153	Hamburg	20359	Germany
77	Munich Biergarten	Klaus Weber	Karlsplatz 1	Munich	80335	Germany
78	Lyon Gastronomy	Philippe Martin	Rue de la République 86	Lyon	69002	France
79	Nice Mediterranean	Sophie Dubois	Promenade des Anglais 49	Nice	06000	France
80	Bordeaux Wines	Jean-Pierre Blanc	Cours de l'Intendance 50	Bordeaux	33000	France
81	Manchester Pies	William Brown	\N	Manchester	M1 1PW	UK
82	Edinburgh Whisky	Angus MacLeod	\N	Edinburgh	EH1 1SG	UK
83	Liverpool Docks	George Harrison	Albert Dock 12	Liverpool	L3 4AA	UK
84	Helsinki Market	Matti Virtanen	Mannerheimintie 13	Helsinki	00100	Finland
85	Reykjavik Fish	Björk Gudmundsdottir	Laugavegur 55	Reykjavik	101	Iceland
86	Tel Aviv Hummus	David Cohen	Dizengoff Street 150	Tel Aviv	6433222	Israel
87	Marrakech Spices	Hassan El Amrani	Jamaa el-Fna 1	Marrakech	40000	Morocco
88	Cairo Bazaar	Mohammed Ahmed	Khan el-Khalili	Cairo	11511	Egypt
89	Istanbul Kebab	Mehmet Yilmaz	Istiklal Caddesi 123	Istanbul	34435	Turkey
90	Beirut Mezze	Samir Khalil	Hamra Street 44	Beirut	11-2810	Lebanon
91	Rio Churrascaria	Pedro Santos	Copacabana Beach 100	Rio de Janeiro	22070-002	Brazil
92	Salvador Acarajé	Maria Oliveira	Pelourinho 55	Salvador	40301-110	Brazil
93	Cusco Andean	Miguel Torres	\N	Cusco	08002	Peru
94	Havana Café	José Rodriguez	\N	Havana	10100	Cuba
95	San Juan Mofongo	Carmen Vega	Calle del Cristo 207	San Juan	00901	Puerto Rico
96	Panama Fresh Market	Roberto Diaz	Calle 50 Final	Panama City	0801	Panama
97	Manila Seafood	Maria Santos	Bonifacio High Street	Manila	1634	Philippines
98	Jakarta Spice Market	Siti Widodo	Jalan Thamrin 10	Jakarta	10230	Indonesia
99	Ho Chi Minh Pho	Nguyen Van	Le Loi Street 15	Ho Chi Minh City	700000	Vietnam
100	Kuala Lumpur Street Food	Lee Ming	Jalan Alor	Kuala Lumpur	50200	Malaysia
101	Taipei Night Market	Chen Wei	Shilin Night Market	Taipei	111	Taiwan
102	Hong Kong Dim Sum	Wong Lee	Nathan Road 228	Hong Kong	999077	Hong Kong
103	Macau Casino Foods	Liu Chan	Cotai Strip 888	Macau	999078	Macau
104	Osaka Sushi	Tanaka Hiroshi	Dotonbori 1-1	Osaka	542-0071	Japan
105	Kyoto Traditional	Suzuki Kenji	Gion District 55	Kyoto	605-0073	Japan
106	Busan Fish Market	Kim Young-ho	Jagalchi Market 88	Busan	48994	South Korea
107	Shanghai Dumplings	Zhang Wei	Nanjing Road 123	Shanghai	200001	China
108	Guangzhou Cuisine	Lin Feng	Beijing Road 99	Guangzhou	510000	China
109	Chengdu Hotpot	Wang Lei	Chunxi Road 55	Chengdu	610000	China
110	Hanoi Street Food	Tran Hung	Old Quarter 36	Hanoi	100000	Vietnam
111	Delhi Curry House	Amit Kumar	Connaught Place E-12	New Delhi	110001	India
112	Bangalore Tech Café	Priya Sharma	MG Road 78	Bangalore	560001	India
113	Chennai Masala	Ravi Krishnan	Marina Beach Road 45	Chennai	600001	India
114	Colombo Spices	Kumar Perera	Galle Road 123	Colombo	00100	Sri Lanka
115	Kathmandu Kitchen	Ram Thapa	Thamel Marg 55	Kathmandu	44600	Nepal
116	Dhaka Biryani	Abdul Rahman	Gulshan Avenue 75	Dhaka	1212	Bangladesh
117	Karachi Grill	Hassan Ali	Zamzama Boulevard 88	Karachi	75500	Pakistan
118	Lahore Food Street	Fatima Khan	\N	Lahore	54000	Pakistan
119	Kabul Kebab	Ahmad Zahir	\N	Kabul	1001	Afghanistan
120	Tehran Cuisine	Reza Ahmadi	\N	Tehran	11369	Iran
121	Kuwait City Dates	Abdullah Al-Salem	Gulf Road 66	Kuwait City	15300	Kuwait
122	Doha Pearls	Mohammed Al-Thani	Corniche Street 99	Doha	23133	Qatar
123	Manama Market	Ali Al-Bahrani	Seef District 77	Manama	11111	Bahrain
124	Muscat Fish Market	Said Al-Said	Muttrah Corniche 44	Muscat	100	Oman
125	Riyadh Dates	Abdullah Al-Saud	Olaya Street 88	Riyadh	12214	Saudi Arabia
126	Amman Falafel	Omar Al-Hussein	Rainbow Street 33	Amman	11181	Jordan
127	Damascus Kitchen	Fadi Al-Assad	Straight Street 77	Damascus	11111	Syria
128	Baghdad Market	Karim Al-Iraqi	Karrada Street 55	Baghdad	10011	Iraq
129	Baku Caviar	Eldar Aliyev	Nizami Street 90	Baku	AZ1000	Azerbaijan
130	Tbilisi Wine	Giorgi Kvaratskhelia	Rustaveli Avenue 40	Tbilisi	0108	Georgia
131	Yerevan Brandy	Armen Sargsyan	Northern Avenue 21	Yerevan	0001	Armenia
132	Tashkent Plov	Timur Uzbekov	Amir Temur Street 107	Tashkent	100084	Uzbekistan
133	Almaty Apples	Nursultan Kazakh	Dostyk Avenue 85	Almaty	050000	Kazakhstan
134	Ashgabat Market	Gurbanguly Berdimuhamedow	Independence Square 44	Ashgabat	744000	Turkmenistan
\.


--
-- Data for Name: dynasty; Type: TABLE DATA; Schema: public; Owner: dhg503
--

COPY public.dynasty (id, name, created_at) FROM stdin;
1	Ming	2025-03-24 02:14:35.92042
2	Qing	2025-03-24 02:14:35.92042
3	Joseon	2025-03-24 02:14:35.92042
\.


--
-- Data for Name: mqshilu; Type: TABLE DATA; Schema: public; Owner: dhg503
--

COPY public.mqshilu (id, url, title, year, date, content, king) FROM stdin;
1	https://sillok.history.go.kr/mc/id/msilok_004_0340_0010_0010_0100_0020	宣宗章皇帝實錄 卷三十四 宣德二年 十二月 十日	1427	宣德二年 十二月 十日	○永昌等衛土韃軍滿剌亦剌思倒剌沙馬黑木等迯逸出境復還滿剌亦剌思奏願居京自效馬黑木願於天津衛隨營居住各賜襲衣鈔布仍命有司給房屋器皿等物如例	宣宗章皇帝
2	https://sillok.history.go.kr/mc/id/msilok_013_0690_0010_0010_0110_0010	熹宗哲皇帝實錄 卷六十九 天啟六年 三月 十一日	1626	天啟六年 三月 十一日	○甲寅清明節遣侯薛濂張國祥湯國祚李弘濟陳光裕伯王承恩孫廷勳毛孟龍楊崇猷郭邦棟吳遵周祭　長陵　獻陵　景陵　陵　茂陵泰陵　康陵　永陵　昭陵　定陵　慶陵武平伯陳世恩祭景皇帝陵寢都督劉岱祭　哀冲　莊敬二太子陵園	熹宗哲皇帝
3	https://sillok.history.go.kr/mc/id/msilok_005_2070_0010_0010_0260_0010	英宗睿皇帝實錄 卷二百七 景泰二年 八月 二十八日	1451	景泰二年 八月 二十八日	○癸巳陞永寧左衞指揮使徐琮徐琮:廣本琮作宗。為都指揮同知以其父禮陣亡故也	英宗睿皇帝
4	https://sillok.history.go.kr/mc/id/msilok_013_0340_0010_0010_0180_0010	熹宗哲皇帝實錄 卷三十四 天啟三年 五月 十八日	1623	天啟三年 五月 十八日	○丁未冊封張氏為裕妃命英國公張惟賢持節大學士葉向高捧冊禮成賜向高等紵羅銀鈔各有差　皇帝制曰椒塗贊化洵資壼掖之良葛藟承庥茂衍本支之慶維德儀之夙備繄位序之隆加彝典具存渥恩斯霈咨爾張氏秉心溫惠禔躬肅雝彤管遵規魚貫謹授環之節紫闈恪侍燕禖符佩韣之祈屬命秩之新膺宜嘉名之肇錫茲特遣使持節封爾為裕妃錫之冊命於戲謙乃受益和可致祥內職宜虔誦雞鳴而致儆後昆惟裕徵麟趾以開先祗服寵光永昌祚胤欽哉	熹宗哲皇帝
5	https://sillok.history.go.kr/mc/id/msilok_006_0900_0010_0010_0040_0010	憲宗純皇帝實錄 卷九十 成化七年 四月 四日	1471	成化七年 四月 四日	○丙午陞中書舍人馬麟為大理寺左寺副支從五品俸仍翰林院帶俸書辦	憲宗純皇帝
6	https://sillok.history.go.kr/mc/id/msilok_011_3530_0010_0010_0100_0010	神宗顯皇帝實錄 卷三百五十三 萬曆二十八年 十一月 十四日	1600	萬曆二十八年 十一月 十四日	○甲寅以　聖母以聖母:影印本以字未印出。萬壽聖節賜輔臣趙志臯沈一貫及講官劉元震等各金萬壽篆字金銀書黃紅符有差	神宗顯皇帝
7	https://sillok.history.go.kr/mc/id/msilok_011_4060_0010_0010_0180_0030	神宗顯皇帝實錄 卷四百六 萬曆三十三年 二月 二十日	1605	萬曆三十三年 二月 二十日	○以收完涇府所遺祿米二千石給　福王五百石　景恭王妃　汝安王繼妃　寧安大長公主　瑞安長公主　榮昌公主各三百石	神宗顯皇帝
8	https://sillok.history.go.kr/mc/id/msilok_006_0190_0010_0010_0040_0040	憲宗純皇帝實錄 卷十九 成化元年 七月 四日	1465	成化元年 七月 四日	○革羽林前衛指揮使等官蘇景等二十五員所陞職以其父祖俱冐迎駕功濫陞也	憲宗純皇帝
9	https://sillok.history.go.kr/mc/id/msilok_011_0650_0010_0010_0190_0030	神宗顯皇帝實錄 卷六十五 萬曆五年 八月 二十二日	1577	萬曆五年 八月 二十二日	○安德驛盤獲詐偽勘合兵部審係該犯描摹不係本部吏書盜賣得旨該司庇下容姦各撫按為部隱飾弊端不清朝廷法度何繇得行今後科道官訪實參奏	神宗顯皇帝
10	https://sillok.history.go.kr/mc/id/msilok_006_0570_0010_0010_0030_0020	憲宗純皇帝實錄 卷五十七 成化四年 八月 三日	1468	成化四年 八月 三日	○陞兵科左給事中陳龯為光祿寺少卿	憲宗純皇帝
11	https://sillok.history.go.kr/mc/id/msilok_001_0310_0010_0010_0110_0010	太祖高皇帝實錄 卷三十 洪武元年 二月 十三日	1368	洪武元年 二月 十三日	○甲寅平章楊璟遣千戶王廷王廷:嘉本國榷廷下有相字。將兵取寶慶進次郡陽茱萸灘賊眾千餘據險拒戰廷擊敗之追至城下周文貴遁去餘眾猶據城拒守廷進兵逼之明日賊眾縱火掠民財出走遂下其城留兵守之	太祖高皇帝
12	https://sillok.history.go.kr/mc/id/msilok_001_1610_0010_0010_0100_0010	太祖高皇帝實錄 卷一百五十九 洪武十七年 正月 十四日	1384	洪武十七年 正月 十四日	○壬子以雲南土首雲南土首:舊校改首作酋。申保為永昌府同知木德為麗江府知府羅克為蘭州知州俄陶為景東府知府阿吾為副千夫長阿日貢為順寧府知府高政為楚雄府同知阿魯為定邊縣丞高保為姚安府同知高惠為姚州同知高仲為鶴慶府同知阿這為大理府鄧川州知州楊奴為劍川州知州左禾為蒙化州判官施生為蒙化州正千夫長楊奴為雲南縣丞阿散為太和縣正千夫長李朱為副千夫長董賜為鶴慶府知府賜之子節為安寧州知州賜鈔一千七百四十錠	太祖高皇帝
13	https://sillok.history.go.kr/mc/id/msilok_010_0470_0010_0010_0030_0010	穆宗莊皇帝實錄 卷四十七 隆慶四年 七月 三日	1570	隆慶四年 七月 三日	○己巳○陞湖廣布政司右參議李堯德為陜西按察司副使撫治西寧番夷調河南按察司僉事蕭大亨于陜西整飾整飾:舊校改飾作飭。鞏昌撫民兵備	穆宗莊皇帝
14	https://sillok.history.go.kr/mc/id/msilok_011_5860_0010_0010_0040_0100	神宗顯皇帝實錄 卷五百八十六 萬曆四十七年 九月 四日	1619	萬曆四十七年 九月 四日	○以例予原任總督京營戎政忻城伯趙世新祭七壇	神宗顯皇帝
15	https://sillok.history.go.kr/mc/id/msilok_006_0270_0010_0010_0090_0010	憲宗純皇帝實錄 卷二十七 成化二年 三月 九日	1466	成化二年 三月 九日	○庚戌兵部言提督荊襄軍務工部尚書白圭等奏賊首千斤劉千斤劉:舊校改作劉千斤。等在襄陽房縣豆沙河等處萬山之中分作七屯臣等會總兵等官議欲分兵四路一從南漳一從安遠一從房縣一從穀城掎角並進剋期會勦　上曰兵不可遙制宜如圭等所擬行宜如圭等所擬行:抱本擬作議。	憲宗純皇帝
16	https://sillok.history.go.kr/mc/id/msilok_011_5060_0010_0010_0090_0020	神宗顯皇帝實錄 卷五百六 萬曆四十一年 三月 十八日	1613	萬曆四十一年 三月 十八日	○命廣東道御史董元儒董元儒:抱本元作延。廵按廣西	神宗顯皇帝
17	https://sillok.history.go.kr/mc/id/msilok_013_0380_0010_0010_0110_0030	熹宗哲皇帝實錄 卷三十八 天啟三年 九月 十二日	1623	天啟三年 九月 十二日	○加陞皇親錦衣衛正千戶王朝寵為都指揮僉事從其引例乞恩也	熹宗哲皇帝
18	https://sillok.history.go.kr/mc/id/msilok_005_0670_0010_0010_0090_0060	英宗睿皇帝實錄 卷六十七 正統五年 五月 十一日	1440	正統五年 五月 十一日	○山東濟南府所屬州縣各奏連年災傷乞將無徵夏稅抵輸布鈔事下行在戶部議每小麥一石二斗徵闊白綿布一疋解儲京庫從之	英宗睿皇帝
85	https://sillok.history.go.kr/mc/id/msilok_007_0240_0010_0010_0130_0020	孝宗敬皇帝實錄 卷二十四 弘治二年 三月 十五日	1489	弘治二年 三月 十五日	○陞錦衣衛百戶楊璽為副千戶璽駙馬都尉偉之子也	孝宗敬皇帝
19	https://sillok.history.go.kr/mc/id/msilok_007_2150_0010_0010_0120_0040	孝宗敬皇帝實錄 卷二百十五 弘治十七年 八月 十四日	1504	弘治十七年 八月 十四日	○刑部大理寺奏天文生張璽犯罪律宜發邊衞充軍但璽習業已成請如例發附近衞分充軍仍於欽天監應役今後兩京法司問刑如天文生犯罪當充軍者果習業已成請俱從此例其習業未成者仍發邊衞充軍從之	孝宗敬皇帝
20	https://sillok.history.go.kr/mc/id/msilok_002_0450_0010_0010_0240_0010	太宗文皇帝實錄 卷四十 永樂三年 三月 二十九日	1405	永樂三年 三月 二十九日	○甲子　命哈剌溫及兀良哈等處來帰酋長也里麻等四十五人為都指揮指揮千百戶賜鈔及文綺綵繒有差 △陞羽林前衛指揮使孫興為大寧都指揮同知楊青為山東都指揮僉事致是千戶致是千戶:廣本抱本是作仕，是也。杜榮甥馬原為金吾左衛指揮同知以金吾左衛指揮使甄全子海代父職 大明太宗文皇帝實錄卷四十	太宗文皇帝
21	https://sillok.history.go.kr/mc/id/msilok_011_2390_0010_0010_0250_0030	神宗顯皇帝實錄 卷二百三十九 萬曆十九年 八月 二十八日	1591	萬曆十九年 八月 二十八日	○以山西太原府知府韓萃善陞浙江副使	神宗顯皇帝
22	https://sillok.history.go.kr/mc/id/msilok_007_1580_0010_0010_0200_0020	孝宗敬皇帝實錄 卷一百五十八 弘治十三年 正月 二十六日	1500	弘治十三年 正月 二十六日	○命加賜哈密衛使臣滿剌阿力克綵叚四表裏絹十疋火只馬哈麻打力等四人各綵叚二表裏絹五疋以其自陳復本衛忠順王陜巴功也	孝宗敬皇帝
23	https://sillok.history.go.kr/mc/id/msilok_008_1850_0010_0010_0060_0040	武宗毅皇帝實錄 卷一百八十五 正德十五年 四月 七日	1520	正德十五年 四月 七日	○夜北方流星如盞色青白光照地尾跡炸散起自貫索北行至近濁	武宗毅皇帝
24	https://sillok.history.go.kr/mc/id/msilok_011_4540_0010_0010_0240_0020	神宗顯皇帝實錄 卷四百五十四 萬曆三十七年 正月 二十七日	1609	萬曆三十七年 正月 二十七日	○以三品滿考滿考:廣本抱本作考滿。加漕運總督李三才戶部尚書左副都御史	神宗顯皇帝
25	https://sillok.history.go.kr/mc/id/msilok_011_0390_0010_0010_0190_0020	神宗顯皇帝實錄 卷三十九 萬曆三年 六月 二十二日	1575	萬曆三年 六月 二十二日	○巡撫寧夏都御史羅鳳翔題請查過寧夏等七衛靈平二所萬曆二年分開過田墾開過田墾:廣本抱本作開墾田畝，疑是也。實徵粮草已未完之数	神宗顯皇帝
26	https://sillok.history.go.kr/mc/id/msilok_005_2320_0010_0010_0120_0030	英宗睿皇帝實錄 卷二百三十二 景泰四年 八月 十六日	1453	景泰四年 八月 十六日	○琉球國中山王尚金福遣通事程鴻等奉表來朝貢馬及方物賜宴并鈔幣表裏並鈔幣表裏:廣本抱本鈔下有綵字，疑是也。有差	英宗睿皇帝
27	https://sillok.history.go.kr/mc/id/msilok_009_3670_0010_0010_0200_0010	世宗肅皇帝實錄 卷三百六十五 嘉靖二十九年 九月 二十三日	1550	嘉靖二十九年 九月 二十三日	○癸丑赦失事逮繫副總兵錢濟民參將王臣守備楊鐸罪發宣大軍門立功　廣西桂林府徭賊徭賊:閣本徭作猺。莫良朋殺陽翱陽翺:閣本作楊翔，抱本作陽翔。按應作陽朔。知縣張士毅官軍計誘良朋擒之詔斬以狥　論入援功罪以仇鵉首功加太保兼太子太保賞銀五十兩紵絲四表裏副總兵徐珏遊擊王祿徐仁指揮陳榮以功多陞一級仍賜銀幣遊擊許棠以功多于罪陞俸一級總兵劉鼎副總兵朱楫孫勇遊擊賀慶賀慶:閣本慶作廷。姚冕以少奪俸三月參將趙臣孫時謙袁正以無功降一級完成降二級總兵趙國忠以有後功免罪把縂張継宗等原任參將孫麒孫麒:閣本麒作麟。等坐營等官祁勛等家丁黃熙等各贖罪立功獎勵有差　發太僕寺馬價馬價:廣本閣本價下有銀字，是也。一萬五千兩于薊鎮脩理邊墻堡砦　命兩廣提督侍郎歐陽必進等獎賞安南應襲都統莫宏瀷莫宏瀷:廣本閣本作莫浤。以擒叛賊范子儀等功也	世宗肅皇帝
28	https://sillok.history.go.kr/mc/id/msilok_010_0520_0010_0010_0090_0020	穆宗莊皇帝實錄 卷五十二 隆慶四年 十二月 九日	1570	隆慶四年 十二月 九日	○薊鎮總督劉應節等言近行永平密雲霸州等處訪採礦銀訪採礦銀:嘉本訪採作採訪。止將軍營橫嶺口二處稍生礦砂開取甚难得不償費具聚眾起釁具聚眾起釁:三本具作且，是也。無益　上是其言遂罷之	穆宗莊皇帝
29	https://sillok.history.go.kr/mc/id/msilok_006_0310_0010_0010_0130_0020	憲宗純皇帝實錄 卷三十一 成化二年 六月 十四日	1466	成化二年 六月 十四日	○魯王肇煇有疾遣醫士往療之	憲宗純皇帝
30	https://sillok.history.go.kr/mc/id/msilok_002_1460_0010_0010_0150_0010	太宗文皇帝實錄 卷一百四十一 永樂十一年 七月 二十日	1413	永樂十一年 七月 二十日	○丁酉　勑甘肅總兵官豐城侯李彬曰回回韃靼來朝貢所者貢之來朝貢所者貢之:舊校改所者作者所。廣本抱本之下有外字，是也。如有良馬可官市之遣人送赴北京價值俟其至京給之	太宗文皇帝
31	https://sillok.history.go.kr/mc/id/msilok_009_1690_0010_0010_0030_0020	世宗肅皇帝實錄 卷一百六十九 嘉靖十三年 十一月 三日	1534	嘉靖十三年 十一月 三日	○定國公徐延德宿衛　南郊請以蟒衣扈從　上曰賜蟒係出特恩何輒自請不許	世宗肅皇帝
32	https://sillok.history.go.kr/mc/id/msilok_005_0360_0010_0010_0060_0030	英宗睿皇帝實錄 卷三十六 正統二年 十一月 六日	1437	正統二年 十一月 六日	○行在驍騎右衞指揮同知陳友奉命往瓦剌順寧王脫歡處友乞以其原中淮鹽一千六百餘引不拘資次支助行費事下行在戶部覆奏以友之出使費皆官給既有餘裕無所事助　上以為然令其循次關給	英宗睿皇帝
48	https://sillok.history.go.kr/mc/id/msilok_011_3560_0010_0010_0030_0030	神宗顯皇帝實錄 卷三百五十六 萬曆二十九年 二月 三日	1601	萬曆二十九年 二月 三日	○戶部覆陝西陜西:影印本陜字不清晰。巡按畢三才條議茶馬五事一復課茶以充國計課茶徵輸歲有定額先因茶多餘積園戶觧納艱難以此改折今商絕跡今商絕跡:廣本抱本商下有人字，是也。五司茶空將漢中府西鄉等五州縣課茶課茶:廣本抱本無此二字，誤。議覆本色議覆本色:廣本抱本覆作復，是也。此後折色本色仍解量議行仍角量議行:廣本抱本角作酌，是也。一轄郡邑郡邑:廣本邑作縣。以便責成欲依廵塩巡倉巡鹽巡倉:廣本抱本作巡倉巡鹽。事例將湖廣寶慶府屬產茶州縣與商茶經繇地方與商茶經繇地方:廣本抱本無茶字。增入勑書與川陝一體舉劾一多招引以裕茶本有引則有茶有茶則有馬每歲中馬一萬一千九百餘匹大約用茶四百餘引乞每歲招商報滿五百引歲為定例滿五百引歲為定例:廣本無歲字。一清額地以贍芻牧欲查弘治年間都御史楊一清丈出荒田一千二萬八千餘頃一千二萬八千餘頃:廣本抱本作「一十二萬八千四百餘頃」，疑是也。撥給七監見在馬一優茶商以寓鼓舞命依議行	神宗顯皇帝
33	https://sillok.history.go.kr/mc/id/msilok_009_4590_0010_0010_0110_0010	世宗肅皇帝實錄 卷四百五十七 嘉靖三十七年 三月 十一日	1558	嘉靖三十七年 三月 十一日	○己未○兵部侍郎吳嘉會奉詔條上戰守十二事其前六事言救援右衛宜事救援右衛宜事:舊校改宜事作事宜。一請令縂督選調山西正兵老營堡遊兵宣府奇兵遊兵大同正奇遊兵蔚州渾源等處礦兵延綏遊兵各一部併力驅勦一請蒐簡本鎮主兵務充其伍仍多給本色粮草以繫軍心一計右衛主客兵馬不時增添之費令督撫及管餉郎中預處一各屯堡為虜所毀未能盡復其最要者若牛心站黃土坡單家等堡皆運道所經兵馬必由之處宜亟修理一屯營久廢軍士無所得食宜謹斥慎收保使得以戰守之暇稍緣南畝一請令督撫訪舉廢棄將材其後六事言經畧大同事宜一軍馬耗亡者令督撫查補原額定立營伍一本鎮墻墩六百里往者屯戍聯絡易為策應今盡廢不修專事守堡故虜入輒不支宜議復一招諭虜中降人如丘富周原趙全呂廷桓喬三等能悔罪來歸待以不死有功仍錄用之一請稍寬法禁有能潛入虜營斬獲者與臨陣斬獲同賞一請撫請撫:閣本請作巡。抱本請下有督字。專制全鎮守廵分轄五路各有職掌自法弛以來一切邊務俱付之通判經歷等官守廵苐以空文守轄不任地方之憂宜重加責成地方有事一体論罰一令甲守備不設者充軍盖為有兵而不能守者言也今大同雖有城堡信地之責而所部卒裸衣羸馬数不盈百每敵至則狼狽觸法故有一官而充兩軍者宜從末減疏入得旨允行	世宗肅皇帝
34	https://sillok.history.go.kr/mc/id/msilok_011_4380_0010_0010_0060_0030	神宗顯皇帝實錄 卷四百三十八 萬曆三十五年 九月 八日	1607	萬曆三十五年 九月 八日	○以協守寧夏副總兵姚國忠為中軍都督府僉書	神宗顯皇帝
35	https://sillok.history.go.kr/mc/id/msilok_008_0220_0010_0010_0220_0010	武宗毅皇帝實錄 卷二十二 正德二年 閏正月 二十三日	1507	正德二年 閏正月 二十三日	○丁卯改南京吏部尚書李傑為礼部尚書陞工部右侍郎吳洪為本部左侍郎縂督南京粮儲右副都御史張泰為工部右侍郎	武宗毅皇帝
36	https://sillok.history.go.kr/mc/id/msilok_005_0580_0010_0010_0130_0010	英宗睿皇帝實錄 卷五十八 正統四年 八月 十八日	1439	正統四年 八月 十八日	○癸巳命故河南都指揮僉事盛亦禿帖木兒子俊廣西都指揮僉事裴玉孫敬俱襲為指揮使四川都指揮僉事李信子真陝西都指揮僉事蔣勝蔣勝:廣本勝作盛。子泰俱襲為指揮僉事金吾左衛指揮使蕭廉兄達指揮同知張義子英指揮僉事李貴子旺府軍左衛指揮同知申廣子旺府軍前衛指揮同知王濬子隆府軍後衛指揮僉事錢實姪通濟陽衛指揮僉事張普弟亮俱襲職	英宗睿皇帝
37	https://sillok.history.go.kr/mc/id/msilok_001_1610_0010_0020_0050_0010	太祖高皇帝實錄 卷一百五十九 洪武十七年 二月 八日	1384	洪武十七年 二月 八日	○丙子雲南元江土酋那直來朝貢象	太祖高皇帝
38	https://sillok.history.go.kr/mc/id/msilok_009_1070_0010_0010_0050_0010	世宗肅皇帝實錄 卷一百七 嘉靖八年 十一月 八日	1529	嘉靖八年 十一月 八日	○庚子召大學士桂萼復任時史館儒士蔡圻上疏誦萼功請召還之　上曰萼前建言大禮贊成朕孝功不可泯頃以人言遂令致仕其亟召還撫按等官催趣上道乃賜萼勑曰卿性資篤實秉心忠誠先年建言大禮贊成朕孝功不可泯頃因人言著令致仕實俾保全見今內閣缺官辦事特召卿照舊供職勑至卿宜上緊馳驛前來以副朕眷注之懷勿得辭避遲違	世宗肅皇帝
39	https://sillok.history.go.kr/mc/id/msilok_009_2360_0010_0010_0150_0010	世宗肅皇帝實錄 卷二百三十四 嘉靖十九年 二月 十六日	1540	嘉靖十九年 二月 十六日	○己卯兵部請開武科鄉試　上以累科未見得人報罷給事中王夢弼言國朝武科本無定制間甞舉行後以六年為率士之登進者眾不過三十二人寡或二十人盖取之不廣故習者少也自　陛下定制以三年一試取或至五六十人士皆踴躍思奮而一旦報罷恐多士解體後之拊髀猶今之云云也請以六年一試著為令詔如前旨不許妄議責夢弼云云漫語非對君之言奪俸三月	世宗肅皇帝
40	https://sillok.history.go.kr/mc/id/msilok_005_2910_0010_0010_0190_0070	英宗睿皇帝實錄 卷二百九十一 天順二年 五月 二十日	1458	天順二年 五月 二十日	○六科十三道劾奏五城兵馬指揮司指揮李惟新等二十一員不帶夜廵銅牌事覺許令回詁奏對不實俱宜問罪　上命錦衣衛鎮撫司鞫之尋各調外任	英宗睿皇帝
41	https://sillok.history.go.kr/mc/id/msilok_008_1860_0010_0010_0110_0010	武宗毅皇帝實錄 卷一百八十六 正德十五年 五月 十九日	1520	正德十五年 五月 十九日	○丙午革廣西分守柳慶參將甘霖任以廵按御史劾其誘土官剋軍士之罪也	武宗毅皇帝
42	https://sillok.history.go.kr/mc/id/msilok_013_0600_0010_0010_0030_0050	熹宗哲皇帝實錄 卷六十 天啟五年 六月 三日	1625	天啟五年 六月 三日	○兵部左侍郎張鳳翔引疾求去許之	熹宗哲皇帝
43	https://sillok.history.go.kr/mc/id/msilok_011_5020_0010_0010_0140_0020	神宗顯皇帝實錄 卷五百二 萬曆四十年 閏十一月 十六日	1612	萬曆四十年 閏十一月 十六日	○陞工部郎中周泰峙周泰峙:廣本峙作奇。為直隸順德府知府	神宗顯皇帝
44	https://sillok.history.go.kr/mc/id/msilok_005_0930_0010_0010_0120_0010	英宗睿皇帝實錄 卷九十三 正統七年 六月 十五日	1442	正統七年 六月 十五日	○甲辰書復魯王肇煇曰承喻欲來賀立中宮足見親厚之意但道途跋涉非易可不必來後諸王欲來賀者俱復書止之	英宗睿皇帝
45	https://sillok.history.go.kr/mc/id/msilok_006_1360_0010_0010_0230_0020	憲宗純皇帝實錄 卷一百三十六 成化十年 十二月 二十五日	1474	成化十年 十二月 二十五日	○改刑部尚書項忠于兵部召廵撫大同右都御史董方為刑部尚書	憲宗純皇帝
46	https://sillok.history.go.kr/mc/id/msilok_010_0140_0010_0010_0150_0010	穆宗莊皇帝實錄 卷十四 隆慶元年 十一月 十八日	1567	隆慶元年 十一月 十八日	○己巳　孝惠皇后忌辰遣武安侯鄭崑祭　茂陵　孝烈皇后忌辰　弘孝殿行祭禮遣安平伯方承裕祭　永陵	穆宗莊皇帝
47	https://sillok.history.go.kr/mc/id/msilok_007_0080_0010_0010_0290_0020	孝宗敬皇帝實錄 卷八 成化二十三年 十二月 二十九日	1487	成化二十三年 十二月 二十九日	○廵撫寧夏都察院右僉都御史崔讓乞致仕不允	孝宗敬皇帝
49	https://sillok.history.go.kr/mc/id/msilok_007_1960_0010_0010_0210_0010	孝宗敬皇帝實錄 卷一百九十六 弘治十六年 二月 二十三日	1503	弘治十六年 二月 二十三日	○庚申　命各王府及內外勳戚之家管庄內使家人有生事害人者罪之每莊止許一人庄所多者亦不得過三人	孝宗敬皇帝
86	https://sillok.history.go.kr/mc/id/msilok_006_0940_0010_0010_0070_0010	憲宗純皇帝實錄 卷九十四 成化七年 八月 八日	1471	成化七年 八月 八日	○戊申祭　太社　太稷	憲宗純皇帝
50	https://sillok.history.go.kr/mc/id/msilok_006_1550_0010_0010_0090_0010	憲宗純皇帝實錄 卷一百五十五 成化十二年 七月 九日	1476	成化十二年 七月 九日	○庚戌貴州宣慰使司宣慰使司:廣本司下有宣慰使三字，是也。安貴榮四川石砫宣撫司宣撫馬澄各遣舍人把事等來朝貢馬賜綵叚鈔錠有差	憲宗純皇帝
51	https://sillok.history.go.kr/mc/id/msilok_011_4420_0010_0010_0200_0030	神宗顯皇帝實錄 卷四百四十二 萬曆三十六年 正月 二十五日	1608	萬曆三十六年 正月 二十五日	○予原任太子少保禮部尚書兼東閣大學士于慎行贈太子太保謚文定	神宗顯皇帝
52	https://sillok.history.go.kr/mc/id/msilok_006_1980_0010_0010_0150_0010	憲宗純皇帝實錄 卷一百九十八 成化十五年 十二月 二十一日	1479	成化十五年 十二月 二十一日	○壬申朝鮮國王李娎遣陪臣金永需等奉表貢馬及方物來朝賀明年正旦節	憲宗純皇帝
53	https://sillok.history.go.kr/mc/id/msilok_008_0090_0010_0010_0180_0010	武宗毅皇帝實錄 卷九 正德元年 正月 二十三日	1506	正德元年 正月 二十三日	○癸卯陞總督兩廣軍務兼理廵撫左都御史潘蕃為南京刑部尚書	武宗毅皇帝
54	https://sillok.history.go.kr/mc/id/msilok_001_2350_0010_0030_0100_0010	太祖高皇帝實錄 卷二百三十三 洪武二十七年 七月 十七日	1394	洪武二十七年 七月 十七日	○甲寅旌表孝子李德成及節婦高氏德成易州淶水縣人易州淶水縣人:抱本淶誤涑。其母早亡德成念劬勞之恩乃摶土肖象日奠飲食奉之如生一夕夢母墮寒冰間挽之不能淂既寤與妻王氏徒跣行三百里至〔昌〕平昌平:影印本昌字不明晰。墓所臥冰七日時天大雪冰為融釋鄉里稱之會朝廷徵孝廉有司以德成應詔擢光祿司光祿司:抱本司誤寺。署丞遷太常寺贊禮郎尋陞尚寶司丞至是復旌其門曰孝行之門高氏蘇州府長洲縣民張德妻也年二十五而夫亡姑何氏憐其少欲嫁之高氏自陳願攻紡績奉姑訓子誓不易志事聞詔表其門為貞節之門	太祖高皇帝
55	https://sillok.history.go.kr/mc/id/msilok_013_0190_0010_0010_0290_0070	熹宗哲皇帝實錄 卷十九 天啟二年 二月 二十九日	1622	天啟二年 二月 二十九日	○兵部右侍郎兼都察院右僉都御史經略遼東解經邦疏辭新命不許	熹宗哲皇帝
56	https://sillok.history.go.kr/mc/id/msilok_007_0880_0010_0010_0150_0040	孝宗敬皇帝實錄 卷八十八 弘治七年 五月 十八日	1494	弘治七年 五月 十八日	○以水災免直隸徐州及豐沛二縣弘治六年秋糧八千三百四十三石有奇草一萬四百五十餘包	孝宗敬皇帝
57	https://sillok.history.go.kr/mc/id/msilok_001_0910_0010_0010_0020_0020	太祖高皇帝實錄 卷八十九 洪武七年 五月 四日	1374	洪武七年 五月 四日	○免蘇州松江嘉興諸府夏稅	太祖高皇帝
58	https://sillok.history.go.kr/mc/id/msilok_013_0130_0010_0010_0080_0010	熹宗哲皇帝實錄 卷十三 天啟元年 八月 八日	1621	天啟元年 八月 八日	○丁丑　孝康敬皇帝后忌辰　奉先殿行祭禮遣忻誠伯趙之龍祭　泰陵　祭　先師孔子遣大學士韓爌行禮	熹宗哲皇帝
59	https://sillok.history.go.kr/mc/id/msilok_001_0650_0010_0010_0140_0010	太祖高皇帝實錄 卷六十三 洪武四年 閏三月 二十九日	1371	洪武四年 閏三月 二十九日	○壬午以陳修為吏部尚書蔣毅趙孠堅為刑部侍郎朱從善為戶部侍郎	太祖高皇帝
60	https://sillok.history.go.kr/mc/id/msilok_001_1200_0010_0010_0040_0010	太祖高皇帝實錄 卷一百十八 洪武十一年 四月 七日	1378	洪武十一年 四月 七日	○己酉享太廟	太祖高皇帝
61	https://sillok.history.go.kr/mc/id/msilok_009_1020_0010_0010_0230_0010	世宗肅皇帝實錄 卷一百二 嘉靖八年 六月 二十七日	1529	嘉靖八年 六月 二十七日	○庚寅陞河南左布政使張翰為都察院右副都御史提督鴈門等関兼廵撫山西地方	世宗肅皇帝
62	https://sillok.history.go.kr/mc/id/msilok_007_2070_0010_0010_0010_0020	孝宗敬皇帝實錄 卷二百七 弘治十七年 正月 一日	1504	弘治十七年 正月 一日	○遣儀賓周鉞祭　景皇帝陵寢	孝宗敬皇帝
63	https://sillok.history.go.kr/mc/id/msilok_005_2210_0010_0010_0050_0040	英宗睿皇帝實錄 卷二百二十一 景泰三年 閏九月 七日	1452	景泰三年 閏九月 七日	○兵部奏亦力把里雖處遐方恪守臣節往年不隨也先犯邊今復遣使來朝忠誠可嘉其使臣捨哈三等乞授官職宜不限常例允其所請詔俱授為副千戶	英宗睿皇帝
64	https://sillok.history.go.kr/mc/id/msilok_013_0290_0010_0010_0210_0150	熹宗哲皇帝實錄 卷二十九 天啟二年 十二月 二十二日	1622	天啟二年 十二月 二十二日	○陞嘉湖參將江之靖為狼山副總兵貴州都司胡嘉定為安順參將陞廣東練兵遊擊王揚德為昭平參將鎮邊參將王應槐為五軍八營參將福建都司沈志亮為瓊崖參將尤固都司王希曾為蘆塘參將浮圖守備胡進忠為神樞十營佐擊南京遊擊王應文為廣西廵撫坐營陜西都司董用文為神樞四營佐擊坌道守備趙廷壁為昌平左車營遊擊萬全守備孫大啟為五軍五營佐擊山東都司僉書董國威為寧山遊擊南京遊擊劉崇禮為疊茂遊擊中都都司僉書陳奇偉為福建中路遊擊宣府遊擊錢中選為通州參將陜西都司何道興為神樞二營參將柳溝參將柳溝參將:梁本脫將以上十八字。秦光祚為馬水口參將長安守備許定德為神樞五營佐擊	熹宗哲皇帝
65	https://sillok.history.go.kr/mc/id/msilok_009_1320_0010_0010_0180_0010	世宗肅皇帝實錄 卷一百三十二 嘉靖十年 十一月 二十七日	1531	嘉靖十年 十一月 二十七日	○丁丑○遣行人周文燭齎勑召致士致士:三本東本士作仕，是也。少傅兼太子太傅吏部尚書謹身殿大學士張孚敬復任辦事令亟乘傳赴闕又以勑促之曰朕聞君臣相與自昔為難卿以赤誠輔朕朕亦腹心是託朕亦腹心是託:抱本亦下有以字，是也。不意一時被惑自陷于過㪯朕不敢私特令卿致仕以避人言自卿去後切朕思切朕思:舊校改作軫。　聖母嗟問者亦数次矣夫人誰無過矧臣子于君父義法具在茲以萬机事重輔贊乏人朕費類朕費類:三本東本費作弗，是也。必得卿終始以佐之而後可今遣行人周文燭勑往敕往:廣本閣本東本勑上有齎字，是也。起文燭主日文燭主日:三本東本主作至，是也。卿即兼程星夜而進急復任事庶慰我　聖母至懷以副朕思託之思托之:三本東本之下有至字，是也。如忌而疑之恐非事君之道郡宜早來郡宜早來:三本東本郡作卿，是也。以匡朕治以符信備騐朕宁俟卿來故茲催勑卿其承之慎勿自負　上諭大學士李時等曰卿等以朕建醮祈　天求生哲嗣為國重典朕聞聖人有曰不孝之罪無後為大今朕大婚十載近冊九氏近冊九氏:東本氏作人。嗣祥未兆乃遵　祖宗故事修醮以祈顧君臣一体況卿等愛國之心甚切昨有請已分遣廷臣儔之分遣廷臣儔之:三本東本儔作禱，是也。嶽鎮但恐擾民耳茲欲又侍朕行礼茲欲又侍朕行禮:三本東本欲又作又欲，是也。醮坛其悉听之禮部尚書夏言又請令在廷文武百官各致斋以格高穹報可	世宗肅皇帝
66	https://sillok.history.go.kr/mc/id/msilok_005_0840_0010_0010_0200_0010	英宗睿皇帝實錄 卷八十四 正統六年 十月 二十一日	1441	正統六年 十月 二十一日	○甲申迤北瓦剌等處脫脫不花王遣使臣都督阿都赤等貢馬二千五百三十七匹貂鼠銀鼠等皮二萬一千二百箇賜宴并金織襲衣等物	英宗睿皇帝
67	https://sillok.history.go.kr/mc/id/msilok_005_2200_0010_0010_0010_0030	英宗睿皇帝實錄 卷二百二十 景泰三年 九月 一日	1452	景泰三年 九月 一日	○調金吾左衞帶俸都指揮同知耿全於廣東都司	英宗睿皇帝
68	https://sillok.history.go.kr/mc/id/msilok_005_2510_0010_0010_0070_0010	英宗睿皇帝實錄 卷二百五十一 景泰六年 三月 八日	1455	景泰六年 三月 八日	△癸丑△戶部奏正統十三年浙江漕運軍二萬二千六百七十人後因征處州寇賊軍有不足令民代運今寇賊既平民運艱苦宜命鎮守浙江及管漕運等官揀選浙江軍餘補足正統十三年漕運軍数凡民運粮米盡令軍運用寬民力從之　詔直隷蘇州等府民粮負欠者俱暫停徵以廵撫官奏其地連歲無收故也	英宗睿皇帝
69	https://sillok.history.go.kr/mc/id/msilok_001_1420_0010_0010_0040_0010	太祖高皇帝實錄 卷一百四十 洪武十四年 十一月 六日	1381	洪武十四年 十一月 六日	○丁亥以鳳陽府之徐州直隸六部仍以豊沛蕭碭山四縣属之復以直隸嘉興湖州二府隸浙江	太祖高皇帝
70	https://sillok.history.go.kr/mc/id/msilok_002_1290_0010_0010_0040_0010	太宗文皇帝實錄 卷一百二十四 永樂十年 正月 六日	1412	永樂十年 正月 六日	○辛卯○享　太廟	太宗文皇帝
71	https://sillok.history.go.kr/mc/id/msilok_005_2910_0010_0010_0110_0040	英宗睿皇帝實錄 卷二百九十一 天順二年 五月 十二日	1458	天順二年 五月 十二日	○四川重慶等衛石柱宣撫等司并湖廣麻寮千戶所各遣人貢馬賜綵幣鈔絹有差	英宗睿皇帝
72	https://sillok.history.go.kr/mc/id/msilok_009_1090_0010_0010_0200_0020	世宗肅皇帝實錄 卷一百九 嘉靖九年 正月 二十五日	1530	嘉靖九年 正月 二十五日	○四川廵撫都御史唐鳳儀劾奏提學僉事蔡宗堯以疾乞休未奉明旨輒離職任命廵按御史逮問以聞	世宗肅皇帝
73	https://sillok.history.go.kr/mc/id/msilok_009_4290_0010_0010_0020_0030	世宗肅皇帝實錄 卷四百二十七 嘉靖三十四年 十月 二日	1555	嘉靖三十四年 十月 二日	○廵按直隸御史李鳳毛疏報宣府虜警兵部覆言虜数萬眾突入龍門信宿之聞信宿之聞:三本聞作間，是也。即達居庸関唐見菴唐見菴:三本見作兒。境御史言且不及是宣府烽火失傳也乞行查究失事地方功罪今縂督今總督:廣本抱本今作令，是也。撫按官會奏從之	世宗肅皇帝
74	https://sillok.history.go.kr/mc/id/msilok_004_0330_0010_0010_0150_0030	宣宗章皇帝實錄 卷三十三 宣德二年 十一月 十八日	1427	宣德二年 十一月 十八日	○瓦剌順寧王脫歡遣使臣把把的遼東自在州指揮僉事亦領哈等來朝貢馬及方物	宣宗章皇帝
75	https://sillok.history.go.kr/mc/id/msilok_013_0750_0010_0010_0040_0050	熹宗哲皇帝實錄 卷七十五 天啟六年 八月 五日	1626	天啟六年 八月 五日	○起原任遼東廵撫張鳳翼為都察院右僉都御史廵撫保定紫荊等關兼理海防軍務	熹宗哲皇帝
76	https://sillok.history.go.kr/mc/id/msilok_007_0720_0010_0010_0110_0010	孝宗敬皇帝實錄 卷七十二 弘治六年 二月 十一日	1493	弘治六年 二月 十一日	○丙午建州左等衞野人女直都督等官脫羅等來貢賜宴并衣服綵叚等物有差	孝宗敬皇帝
77	https://sillok.history.go.kr/mc/id/msilok_011_3010_0010_0010_0050_0040	神宗顯皇帝實錄 卷三百一 萬曆二十四年 閏八月 九日	1596	萬曆二十四年 閏八月 九日	○南京刑部主事劉冠南題狂勳肆惡等事　上諭今國家無事劉世延妄指星象妖言惑眾又詐旨擅造軍器動稱起兵入援征伐與反叛何異著南京三法司嚴拏究問聽候處斷蘆洲事一併下部	神宗顯皇帝
78	https://sillok.history.go.kr/mc/id/msilok_011_0070_0010_0010_0260_0060	神宗顯皇帝實錄 卷七 隆慶六年 十一月 二十七日	1572	隆慶六年 十一月 二十七日	○遼東總兵官李成梁敗土蠻於遼河詔賞督撫及成梁等銀幣有差先是十月間土蠻聚眾聲言入犯至十一月朔賊精兵五六百騎營舊遼陽北河去邊二百餘里成梁親赴鎮遠堡防剿仍調參遊馬文龍唐朴等合營唐朴等合營:廣本抱本合作各。甲申成梁哨見前賊料其必俟眾集大舉不如先伐其謀乃夜發伏兵約黎明突衝賊壘起火為號至期火起成梁統兵趣應賊遂大奔兵部奏言是役斬首不過二十餘級獲馬不過二百餘匹然掩其不備出奇襲擊先發制人為功實多	神宗顯皇帝
79	https://sillok.history.go.kr/mc/id/msilok_001_1850_0010_0010_0010_0010	太祖高皇帝實錄 卷一百八十三 洪武二十年 七月 一日	1387	洪武二十年 七月 一日	明太祖高皇帝實錄卷之一百八十三 洪武二十年秋七月戊寅朔以登州衞指揮使謝䂓為後軍都督府都督僉事	太祖高皇帝
80	https://sillok.history.go.kr/mc/id/msilok_011_5300_0010_0010_0010_0060	神宗顯皇帝實錄 卷五百三十 萬曆四十三年 三月 一日	1615	萬曆四十三年 三月 一日	○降罪宗懷圢為庶人發閑宅拘住刑部議其與兄爭產與兄爭產:抱本兄作父。以臣詈君事干敗倫罪在不赦念係宗藩且在議親之列姑革去封爵姑革去封爵:廣本抱本去作故。降為庶人拘住從之	神宗顯皇帝
81	https://sillok.history.go.kr/mc/id/msilok_005_2840_0010_0010_0020_0030	英宗睿皇帝實錄 卷二百八十四 天順元年 十一月 二日	1457	天順元年 十一月 二日	○迤北韃靼奄克不花塔歹乃來忽來歸俱命為頭目隷錦衣衛鎮撫司帶管給房屋器物	英宗睿皇帝
82	https://sillok.history.go.kr/mc/id/msilok_011_4590_0010_0010_0210_0020	神宗顯皇帝實錄 卷四百五十九 萬曆三十七年 六月 二十二日	1609	萬曆三十七年 六月 二十二日	○貴州巡按馮奕垣疏結黔事安堯臣之離鎮雄也諸夷目埶留其妻祿氏不肯放黔中諸臣數遣人陰向祿氏諭以禍福至是祿氏紿諸目歸督堯臣取回水西	神宗顯皇帝
83	https://sillok.history.go.kr/mc/id/msilok_013_0410_0010_0010_0250_0020	熹宗哲皇帝實錄 卷四十一 天啟三年 十一月 二十九日	1623	天啟三年 十一月 二十九日	○錄川貴搗巢解圍功朱燮元加右都御史兼兵部右侍郎仍舊縂督楊述中陞俸一級仍俟推用王三善加兵部左侍郎兼右僉都御史薛貞加副都御史俱照舊廵撫張論侯恂林宰楊松年俱候陞京堂戴燝陞二級閔夢得王世仁李仙品赫奕陳龍光吳光儀劉可訓朱芹繆國維陳堯言向日升徐清楊世賞各陞一級周著楊述程丘志充准各起用楊述程丘志充仍加陞一級	熹宗哲皇帝
84	https://sillok.history.go.kr/mc/id/msilok_004_0420_0010_0010_0160_0010	宣宗章皇帝實錄 卷四十二 宣德三年 閏四月 十七日	1428	宣德三年 閏四月 十七日	○戊戌命陽武侯薛祿充總兵官清平伯吳成為副總兵率領官軍防護糧餉赴開平	宣宗章皇帝
87	https://sillok.history.go.kr/mc/id/msilok_007_1740_0010_0010_0100_0010	孝宗敬皇帝實錄 卷一百七十四 弘治十四年 五月 十一日	1501	弘治十四年 五月 十一日	○戊午免湖廣武昌等府州縣正官明年朝覲以地方災傷苗獞猖獗與脩盖王府從廵撫等官請也	孝宗敬皇帝
88	https://sillok.history.go.kr/mc/id/msilok_010_0040_0010_0010_0100_0030	穆宗莊皇帝實錄 卷四 隆慶元年 二月上 九日	1567	隆慶元年 二月上 九日	○直隸巡按御史王廷瞻劾奏南京兵部右侍郎劉畿前以給事中管工躐致通顯及險佞卑污宜罷斥狀疏下吏部覆議畿雖陞轉太驟而巡撫時巡撫時:武大本撫作按，誤。頗有勞績未可遽棄得旨令策勵供職	穆宗莊皇帝
89	https://sillok.history.go.kr/mc/id/msilok_013_0700_0010_0010_0200_0050	熹宗哲皇帝實錄 卷七十 天啟六年 四月 二十日	1626	天啟六年 四月 二十日	○薊遼緫督閻鳴泰疏言連日屡接遼東塘報有謂奴酋的在四月初七八以裏上馬過河復要來搶者有謂歹青台吉聚兵一千親身與裏邊助力若奴酋果來帶領兵馬住於女兒河屯營者此或出於屬夷之偵探或得自回鄉之目擊事似近真第此番傾巢而來其勢必眾乘怒而出其鋒必銳多算而行其計必詭或陽攻寧遠而陰薄関門或陸出関門而水窺島上或明攻関外而暗襲関內皆勢之所必至而防之不可不周者也然觀其造船之多似意在島蓋奴向未知覺華之險故忽而不爭今既見島嶼之勝遂羡而欲焉萬一此島為奴所據則大事去矣尤當遣名將重兵備加防禦以護関門之眼睛而控寧遠之咽喉者也唯是西虜報讐之說向來屡屡出自虜口目前之西協可無他慮而歹青之助兵虗實未卜虎酋之講賞真偽難憑臣前顧後盻不無凜凜此尤緫兵王世忠副將王牧民參將朱梅王李兩喇嘛之責而時時聯絡時時偵探不可過信疏防者也至於毛文龍塘報一事尤為可異據其所稱攻掠海州者正月二十二日也此正奴酋攻圍寧遠之日海州去三岔河僅六十里既云火砲連天喊聲動地何奴中寂無一聞而按兵逍遙若無事而回獨不畏其掣也近誦　聖旨行令兵部酌量住扎要害之地臣数夜躊躇莫如令文龍統舟師屯水寨於蓋州套夫蓋州一區萬山環抱大海四旋固全遼之心腹而東西之樞軸也國初馬雲葉旺殲虜成功即在蓋套之連雲島今文龍所慮者餉也至此則餉易運所乏者器械也至此則器械易給矣所難安插者遼人也至此則山東之礦利可專而軍興且有所資矣所難者在海面風濤照應不及至此則矜帶相連呼吸互應而音信已通矣北以連雲一島為門戶而南以兔兒長生諸島為家室種種方便尚難枚舉故與其虗撓背後何如直剌脇窩與其僻處殊方何如儼居城內文龍曷不計及此而他是求也或曰文龍倘離東江恐朝鮮一折而入於奴不知王京千里非易到之地忠貞屡代非肯二之人而我水陸大兵交集於此交集於此:此字起，至第三十頁後九行任事二字止，據紅本校。為極要害之地宜速移兵住扎於此以圖策應之便者也伏乞勑下該部再加酌議即移檄毛文龍令其相機進止章下兵部	熹宗哲皇帝
90	https://sillok.history.go.kr/mc/id/msilok_011_0190_0010_0010_0250_0030	神宗顯皇帝實錄 卷十九 萬曆元年 十一月 二十九日	1573	萬曆元年 十一月 二十九日	○兵部覆廵捕提督署都督僉事尹鳳條陳十事一補給額馬以便追捕一嚴選尖哨以備剿捕一革退老弱以圖實用一議處下夜以備不虞一嚴禁逃軍以祛宿弊一裁革冗員以便責成一立公補冊以杜夤緣一重賞賚以勵人心一修理公署以便行事一修理教塲以便操練十事中惟議以各地方把總兼管尖哨領哨把總仍不裁革其餘皆如鳳議上依行之	神宗顯皇帝
91	https://sillok.history.go.kr/mc/id/msilok_007_2040_0010_0010_0210_0010	孝宗敬皇帝實錄 卷二百四 弘治十六年 十月 二十五日	1503	弘治十六年 十月 二十五日	○戊午傳旨陞朝天等官朝天等官:舊校改官作宮。高士杜永祺等五人為真人左右至靈錢雲嵄等三人俱為高士右玄義栢尚寬等四人俱為道錄司左右正一陳良福等三人俱為左演法李得晟等七人俱為左至靈李雲嵱等三人俱為右至靈道士余允謙余允謙:抱本余作徐。等三人俱為左玄義朱尚美等十五人俱為右玄義	孝宗敬皇帝
92	https://sillok.history.go.kr/mc/id/msilok_002_2550_0010_0010_0120_0010	太宗文皇帝實錄 卷二百五十 永樂二十年 六月 二十二日	1422	永樂二十年 六月 二十二日	○丁未皇太子令工部脩令工部修:廣本抱本令作命。　孝陵殿及墻垣	太宗文皇帝
93	https://sillok.history.go.kr/mc/id/msilok_005_0480_0010_0010_0160_0010	英宗睿皇帝實錄 卷四十八 正統三年 十一月 十八日	1438	正統三年 十一月 十八日	○戊戌陞行在翰林院侍講洪璵為吏部試右侍郎	英宗睿皇帝
94	https://sillok.history.go.kr/mc/id/msilok_007_0440_0010_0010_0110_0020	孝宗敬皇帝實錄 卷四十四 弘治三年 十月 十七日	1490	弘治三年 十月 十七日	○命以順天府所屬戶口食塩錢鈔給京縣鋪戶償市物米給之價	孝宗敬皇帝
95	https://sillok.history.go.kr/mc/id/msilok_010_0550_0010_0010_0010_0010	穆宗莊皇帝實錄 卷五十五 隆慶五年 三月 一日	1571	隆慶五年 三月 一日	大明穆宗莊皇帝實錄卷之五十五 隆慶五年三月壬戌朔　孝肅皇后忌辰遣定西侯蔣佑祭　裕陵	穆宗莊皇帝
96	https://sillok.history.go.kr/mc/id/msilok_005_2110_0010_0010_0220_0020	英宗睿皇帝實錄 卷二百十一 景泰二年 十二月 二十四日	1451	景泰二年 十二月 二十四日	○命前軍都督府右都督張軏掌本府事仍兼督操軍馬	英宗睿皇帝
97	https://sillok.history.go.kr/mc/id/msilok_005_2660_0010_0010_0170_0010	英宗睿皇帝實錄 卷二百六十六 景泰七年 五月 二十一日	1456	景泰七年 五月 二十一日	○己丑南京兵部給事中兵部給事中:廣本抱本部作科，是也。謝琚言直隸鳳陽等府所属州縣民連遭旱澇灾傷不勝凋弊所養孳牧官馬每年北京差官印烙之後例應南京差內外官三員同太僕寺官於各處俵散官多事擾民何以堪乞用北京事例止差御史太僕寺官庶不擾民事下兵部覆奏從之　初滿剌加國正副使柰靄等來朝貢至廣東新會縣靄以犯姦自戕死副使巫沙等已訖事還鴻臚寺通寺鴻臚寺通寺:廣本抱本通寺作通事，是也。馬貴等憑番人亞末首請稱請稱:廣本抱本請作奏，是也。靄有夜光珍珠并猫晴石未進朝廷信之遣員外郎秦顒并貴帶回亞末等乘傅至廣東會官追取至是鎮守廣東并廵按三司等官及顒等會奏將靄男女行禮男女行禮:廣本抱本禮作李，是也。逐一檢閱別無前項寶物命擒貴等送法司如律治之	英宗睿皇帝
98	https://sillok.history.go.kr/mc/id/msilok_009_4610_0010_0010_0030_0010	世宗肅皇帝實錄 卷四百五十九 嘉靖三十七年 五月 五日	1558	嘉靖三十七年 五月 五日	○壬子罷端午宴　詔以兩淮長蘆殘塩仍派薊鎮上納本色其各處倉塲召買糧草倣宣大分別主客兵事例主兵属之管粮郎中客兵主之兵備道客兵主之兵備道:閣本主作屬，是也。各先期給票商人照数買完方得領價如領價在先侵欠不完者主守官吏酌量多寡議罰議罰:閣本罰作罪。從御史萬民英奏也	世宗肅皇帝
99	https://sillok.history.go.kr/mc/id/msilok_002_2600_0010_0010_0040_0020	太宗文皇帝實錄 卷二百五十四下 永樂二十年 閏十二月 十三日	1422	永樂二十年 閏十二月 十三日	○山東登州府言寧海等八州縣連歲水旱田穀不登農民乏食今本府見儲粮五十萬石乞以賑貸從之	太宗文皇帝
100	https://sillok.history.go.kr/mc/id/msilok_003_0060_0010_0010_0100_0010	仁宗昭皇帝實錄 卷三上 永樂二十二年 十月 十日	1424	永樂二十二年 十月 十日	辛亥勑甘肅縂兵官都督費近聞賢義王太平為瓦賴瓦賴:抱本中本作瓦剌，是也。順寧王脫歡所侵害太平人馬潰散有迯至甘肅邊境潛住者爾等即整搠士馬哨瞭如果則遣人詔諭如果則遣人詔諭:三本作如果是實則遣人招諭。同來仍嚴束束:舊校改作約束。差去人善加撫恤毌盜其馬疋牛羊等物庶不失遠人來歸之心命羽林前衛指揮僉僉事指揮僉僉事:舊校刪一僉字。汪致淵子㒮祖龍職汪致淵子㒮祖龍職:舊校改㒮作豗，龍作襲。古麻剌等正國剌必等吉麻剌等正國剌必等:舊校改正國作國王。三本必作苾。遣頭目叭諦吉三等奉金葉表箋來朝貢方物賜之鈔幣賜之鈔幣:廣本幣下有有差二字。	仁宗昭皇帝
101	https://sillok.history.go.kr/mc/id/msilok_001_2150_0010_0010_0050_0020	太祖高皇帝實錄 卷二百十三 洪武二十四年 十月 六日	1391	洪武二十四年 十月 六日	○車里軍民宣慰使刀暹答刁暹答:舊校改刁作刀。遣其弟刀三怕剌等貢象及方物刀暹答刀砍之子也	太祖高皇帝
102	https://sillok.history.go.kr/mc/id/msilok_013_0720_0010_0010_0130_0030	熹宗哲皇帝實錄 卷七十二 天啟六年 六月 十三日	1626	天啟六年 六月 十三日	○刑部尚書徐兆魁等奏欽奉　聖諭臣等敢不仰體但大工之宜稍停也兵餉之宜清覈也民窮之宜寬恤也嘗賦且逋遼餉復沠見征方急帶征復催重以不肖之有司火耗加頭之不免又重以俸薪之既奪將藉口飬廉之無資民心悅而天意得願　陛下時存此念何患錫福不隆也得旨聖諭內多增一字事屬不敬大工已有次第屡旨甚明如何妄請停止捐俸出諸臣樂助之意如何說飬廉無資大臣章疏還湏詳慎有體	熹宗哲皇帝
103	https://sillok.history.go.kr/mc/id/msilok_008_1890_0010_0010_0010_0050	武宗毅皇帝實錄 卷一百八十九 正德十五年 八月 一日	1520	正德十五年 八月 一日	○朝鮮國王李懌遣陪臣吏曹判書申鏜等來朝貢方物馬匹賜宴并賞金織衣綵叚等物有差	武宗毅皇帝
104	https://sillok.history.go.kr/mc/id/msilok_011_2850_0010_0010_0060_0030	神宗顯皇帝實錄 卷二百八十五 萬曆二十三年 五月 六日	1595	萬曆二十三年 五月 六日	○原任山西副使李三才起補山東提學副使湖廣右參政李同芳陞貴州按察使雲南副使李先著陞雲南右參政福建泉州知府泉州知府:廣本抱本州下有府字。汪道亨陞福建副使江西僉事吳鴻功陞陝西右參議	神宗顯皇帝
105	https://sillok.history.go.kr/mc/id/msilok_009_5500_0010_0010_0110_0010	世宗肅皇帝實錄 卷五百四十八 嘉靖四十四年 七月 二十五日	1565	嘉靖四十四年 七月 二十五日	○己未　陞禮部右侍郎高儀為本部左侍郎太常寺卿管國子監祭酒事陳以勤馬禮部右侍陳以勤馬禮部右侍:三本庫本馬作為，侍下有郎字，是也。廵撫山東戶部右侍郎鮑象賢為兵部左侍郎光祿寺卿謝登之為都察院右副都御史廵撫應天　陞兵科左給事中胡應嘉吏科左給事中王元春俱為都給事中禮科給事中周舜岳何起鳴吏科給事中周詩戶科給事中倪光薦俱為右給事中應嘉吏科元春起鳴俱工科舜岳戶科詩禮科光薦刑科　發太僕寺寄飬馬一千二百匹於薊鎮兌給入衛延綏固原寧夏遊兵 大明世宗肅皇帝實錄卷五百四十八	世宗肅皇帝
106	https://sillok.history.go.kr/mc/id/msilok_009_0660_0010_0010_0160_0010	世宗肅皇帝實錄 卷六十六 嘉靖五年 七月 二十三日	1526	嘉靖五年 七月 二十三日	○甲辰達思蠻長官司遣都綱番僧沙加藏等四百三十八人來貢禮部以其貢使視額數過多請减半給賞從之	世宗肅皇帝
107	https://sillok.history.go.kr/mc/id/msilok_001_1940_0010_0010_0010_0020	太祖高皇帝實錄 卷一百九十二 洪武二十一年 七月 一日	1388	洪武二十一年 七月 一日	○追贈故金山侯濮英為樂浪公誥曰丈夫生天地間知事君之大義立志愈堅故能臨難舍生取義名垂千載耿耿不磨爾都督濮英以果勇之資為國將臣昔命從征朔漠方觀成功何期失機偶中彼計然抗節盡忠凜然不可奪若斯之為古今有數耳嗚呼舍生就死立大節於當時忠義動天地芳名垂不朽真可謂烈丈夫矣朕嘉爾志悼念不忘特越侯爵追封爾為樂浪公爾其有知服茲寵命	太祖高皇帝
108	https://sillok.history.go.kr/mc/id/msilok_009_2260_0010_0010_0190_0040	世宗肅皇帝實錄 卷二百二十四 嘉靖十八年 五月 二十二日	1539	嘉靖十八年 五月 二十二日	○命陝西以所在諸司贓罰銀帛及口鹽商稅諸色餘銀補給秦韓肅慶四府積逋祿粮及歲派不足之数仍著為令	世宗肅皇帝
109	https://sillok.history.go.kr/mc/id/msilok_001_1900_0010_0020_0150_0020	太祖高皇帝實錄 卷一百八十八 洪武二十一年 二月 十七日	1388	洪武二十一年 二月 十七日	○四川布政使司奏川中產茶曩者西番諸羗以毛布毛纓之類相與貿易以故歲課不虧近者朝廷頒定課額官自立倉收貯專用市馬民不敢私採每歲課程民皆陪納請仍令民間採摘與羗人交易如此則非惟民得其便抑且官課不虧詔從之	太祖高皇帝
110	https://sillok.history.go.kr/mc/id/msilok_006_0490_0010_0010_0170_0020	憲宗純皇帝實錄 卷四十九 成化三年 十二月 十九日	1467	成化三年 十二月 十九日	○陞福建布政司左參政柳春為浙江右布政使	憲宗純皇帝
111	https://sillok.history.go.kr/mc/id/msilok_011_5280_0010_0010_0130_0030	神宗顯皇帝實錄 卷五百二十八 萬曆四十三年 正月 二十一日	1615	萬曆四十三年 正月 二十一日	○戶科給事中姚宗文劾稅璫高寀聞命遷延沿途橫索既經山東撫按會參乃昨者疏進錢糧內稱有稅銀九千餘兩被鄉官林世吉等家奴併各衙門員役搶去寀之為此謊奏不過欲借搶奪之名以自文其竊盜之罪乞寘諸理不報	神宗顯皇帝
112	https://sillok.history.go.kr/mc/id/msilok_010_0160_0010_0010_0160_0010	穆宗莊皇帝實錄 卷十六 隆慶二年 正月 十八日	1568	隆慶二年 正月 十八日	○戊辰吏部左侍郎兼翰林院學士掌詹事府事潘晟再疏乞休　上不允令供職如故	穆宗莊皇帝
113	https://sillok.history.go.kr/mc/id/msilok_001_0630_0010_0010_0050_0010	太祖高皇帝實錄 卷六十一 洪武四年 二月 五日	1371	洪武四年 二月 五日	○己未吏部言宣使考滿有文學才能者宜任以有司有幹辦使令之才宜於廵檢內用奏差考滿通儒吏者就陞令史書吏若儒吏皆不通於廵檢驛官內用從之	太祖高皇帝
114	https://sillok.history.go.kr/mc/id/msilok_007_0350_0010_0010_0210_0030	孝宗敬皇帝實錄 卷三十五 弘治三年 二月 二十五日	1490	弘治三年 二月 二十五日	○夜東方流星如盞色青白光燭地自貫索東行至天市垣內而散	孝宗敬皇帝
115	https://sillok.history.go.kr/mc/id/msilok_006_1340_0010_0010_0220_0010	憲宗純皇帝實錄 卷一百三十四 成化十年 十月 二十四日	1474	成化十年 十月 二十四日	○丙午復除監察御史何純于浙江道葉稠於廣東道吳真于南京山東道授理刑濟南府推官黃傑宜興縣知縣何鑑為監察御史傑福建道鑑山東道	憲宗純皇帝
116	https://sillok.history.go.kr/mc/id/msilok_011_0100_0010_0010_0120_0010	神宗顯皇帝實錄 卷十 萬曆元年 二月 十二日	1573	萬曆元年 二月 十二日	○癸亥　上御經筵	神宗顯皇帝
117	https://sillok.history.go.kr/mc/id/msilok_001_1320_0010_0010_0160_0010	太祖高皇帝實錄 卷一百三十 洪武十三年 二月 二十六日	1380	洪武十三年 二月 二十六日	○丁亥戶部奏定文移減繁之式凡天下郡縣如歲終所報戶口戶絕者明言其故有析合者有司裁定之不必申請但五年一具冊申部若租稅課程則通類申部徵收既足則別具通關申報改科者則具所由其各衛所給軍士糧草則以簿籍軍士之名及聽支之數有司庫藏所收每以歲終起解至京畿內郡縣徑送內藏達數于部在外稅課司局官考滿就以任內所徵課數申呈郡縣郡縣稽其籍以次申部注代天下有司倉庫金榖錢帛其陜西北平四川山東山西五布政司供給軍需者兩月一報其餘布政司并直隸府州半年一報大軍鹽糧口糧學生樂舞生食米按月齊支各衛軍士凡有賜給之物賜給之物:各本賜給作給賜，是也。都府籍其名數送部轉下倉庫支給如轉輸糧儲各布政司會計缺糧之處以隣近有餘者撥運不須申請惟以所撥郡縣之數具報從之	太祖高皇帝
118	https://sillok.history.go.kr/mc/id/msilok_013_0670_0010_0010_0230_0200	熹宗哲皇帝實錄 卷六十七 天啟六年 正月 二十七日	1626	天啟六年 正月 二十七日	○陝西岷州衛起送番人郭由等族著木剌的等及剌章等族存的豁剌等各來朝貢馬匹盔甲宴賀如例	熹宗哲皇帝
141	https://sillok.history.go.kr/mc/id/msilok_013_0690_0010_0010_0060_0060	熹宗哲皇帝實錄 卷六十九 天啟六年 三月 六日	1626	天啟六年 三月 六日	○陞太僕寺少卿潘汝禎為都察院右僉都御史廵撫浙江	熹宗哲皇帝
119	https://sillok.history.go.kr/mc/id/msilok_009_4040_0010_0010_0140_0010	世宗肅皇帝實錄 卷四百二 嘉靖三十二年 九月 十七日	1553	嘉靖三十二年 九月 十七日	○庚申南京左軍都督府掌府事南和伯方東卒賜祭葬如例　以灾傷免大同府所属州縣皮衛所稅粮皮衛所稅粮:廣本閣本皮作及，抱本作各。有差	世宗肅皇帝
120	https://sillok.history.go.kr/mc/id/msilok_007_0670_0010_0010_0200_0010	孝宗敬皇帝實錄 卷六十七 弘治五年 九月 二十七日	1492	弘治五年 九月 二十七日	○乙未降湖廣鄖陽府同知王輔為雲南楚雄府通判輔先任浙江按察司僉事欺侮按察使毛鸃毛鸃:閣本鸃作。坐同僚不和降前職至是復與知府劉璣相訐奏廵撫都御史王道復欲兩調之吏部言輔之過視璣為重宜留璣而調輔故有是命	孝宗敬皇帝
121	https://sillok.history.go.kr/mc/id/msilok_009_0190_0010_0010_0160_0030	世宗肅皇帝實錄 卷十九 嘉靖元年 十月 十八日	1522	嘉靖元年 十月 十八日	○誠孝昭皇后忌辰　奉先殿行禮奉先殿行禮:東本行下有祭字，是也。遣玉田伯蔣輪祭　獻陵	世宗肅皇帝
122	https://sillok.history.go.kr/mc/id/msilok_010_0590_0010_0010_0010_0040	穆宗莊皇帝實錄 卷五十九 隆慶五年 七月 一日	1571	隆慶五年 七月 一日	○起原任廣東按察司副使王化為惠潮兵備僉事化罷後廵按御史趙焞薦其知兵部覆請降職起用仍限以三年立功補過故有是命	穆宗莊皇帝
123	https://sillok.history.go.kr/mc/id/msilok_011_2950_0010_0010_0250_0020	神宗顯皇帝實錄 卷二百九十五 萬曆二十四年 三月 二十七日	1596	萬曆二十四年 三月 二十七日	○陞浙江副使唐守欽為本省參政	神宗顯皇帝
124	https://sillok.history.go.kr/mc/id/msilok_013_0740_0010_0010_0210_0100	熹宗哲皇帝實錄 卷七十四 天啟六年 七月 二十三日	1626	天啟六年 七月 二十三日	○革漳潮副總兵袁大年任	熹宗哲皇帝
125	https://sillok.history.go.kr/mc/id/msilok_001_0360_0010_0020_0080_0010	太祖高皇帝實錄 卷三十五 洪武元年 十月 十日	1368	洪武元年 十月 十日	○丁丑　上至自北京	太祖高皇帝
126	https://sillok.history.go.kr/mc/id/msilok_002_0460_0010_0010_0130_0010	太宗文皇帝實錄 卷四十一 永樂三年 四月 十七日	1405	永樂三年 四月 十七日	○壬午　萬壽聖節　上御奉天殿受朝賀大宴文武羣臣及四夷朝使命婦朝　皇后于坤寧宮錫宴是日　上命禮部自今命婦雖大朝亦止於三品以上餘悉免之著為令	太宗文皇帝
127	https://sillok.history.go.kr/mc/id/msilok_009_5600_0010_0010_0180_0010	世宗肅皇帝實錄 卷五百五十八 嘉靖四十五年 五月 二十五日	1566	嘉靖四十五年 五月 二十五日	○乙卯○大祭　地于　方澤先期請　太祖配及是日行禮俱成國公朱希忠代俱成國公朱希忠代:閣本俱下有命字。	世宗肅皇帝
128	https://sillok.history.go.kr/mc/id/msilok_005_2610_0010_0010_0080_0010	英宗睿皇帝實錄 卷二百六十一 景泰六年 十二月 十一日	1455	景泰六年 十二月 十一日	○壬子戶部奏貴州黎平府龍里蠻夷長官司因苖賊攻破城寨燒刼倉粮人民流散今招撫漸回人力罷弊所負景泰四年至今年秋粮二百六十九石有餘宜移文廵撫左副都御史蔣琳覆實停免流移者亦令招撫復業若雖被賊圍不曾搶刼搶刼:廣本刼作奪。者令如數納令如數納:廣本數下有徵字。從之	英宗睿皇帝
129	https://sillok.history.go.kr/mc/id/msilok_001_0670_0010_0010_0090_0010	太祖高皇帝實錄 卷六十五 洪武四年 五月 十日	1371	洪武四年 五月 十日	○辛酉應天府江寧縣進白兎	太祖高皇帝
130	https://sillok.history.go.kr/mc/id/msilok_013_0260_0010_0010_0240_0020	熹宗哲皇帝實錄 卷二十六 天啟二年 九月 二十五日	1622	天啟二年 九月 二十五日	○兵部覆保定廵撫張鳳翔疏請以毛兵營都司董世賢并兵一千留鎮景州俟事平撤回　上是之	熹宗哲皇帝
131	https://sillok.history.go.kr/mc/id/msilok_006_1930_0010_0010_0060_0010	憲宗純皇帝實錄 卷一百九十三 成化十五年 八月 六日	1479	成化十五年 八月 六日	○己丑增寧陽侯陳瑛祿米二百石米鈔中半兼支初瑛因爭襲爵革其半祿至是自陳艱窘請如遂安伯陳韶例事下戶部覆奏從之	憲宗純皇帝
132	https://sillok.history.go.kr/mc/id/msilok_011_5190_0010_0010_0140_0010	神宗顯皇帝實錄 卷五百十九 萬曆四十二年 四月 十八日	1614	萬曆四十二年 四月 十八日	○庚子朝鮮王李暉李暉:抱本暉作琿，是也。差陪臣朴弘耇朴弘耈:抱本朴作林，誤。等四十一員進獻方物馬匹奏請追封生母金氏准奏宴賞如例	神宗顯皇帝
133	https://sillok.history.go.kr/mc/id/msilok_006_0980_0010_0010_0050_0010	憲宗純皇帝實錄 卷九十八 成化七年 十一月 六日	1471	成化七年 十一月 六日	○甲辰詹事府少詹事兼翰林院學士柯潛自其家具奏辭免召命乞終制許之	憲宗純皇帝
134	https://sillok.history.go.kr/mc/id/msilok_010_0010_0010_0010_0110_0030	穆宗莊皇帝實錄 卷一 嘉靖四十五年 十二月 二十九日	1566	嘉靖四十五年 十二月 二十九日	○葬常嬪高氏王氏	穆宗莊皇帝
135	https://sillok.history.go.kr/mc/id/msilok_007_0150_0010_0010_0040_0030	孝宗敬皇帝實錄 卷十五 弘治元年 六月 五日	1488	弘治元年 六月 五日	○鎮守寧夏總兵官署都督僉事傅泰卒泰直隸安肅人初襲金吾衞指揮使累陞都指揮同知分守松潘弘治初進今職鎮守寧夏未幾卒訃聞賜祭葬如例	孝宗敬皇帝
136	https://sillok.history.go.kr/mc/id/msilok_011_4570_0010_0010_0210_0020	神宗顯皇帝實錄 卷四百五十七 萬曆三十七年 四月 二十六日	1609	萬曆三十七年 四月 二十六日	○初武定印失克舉擒自言印埋法干朝廷責東川祿壽尋獻迄弗獲雲南廵按周懋相因請更鑄兼言祿壽祿哲兄弟相殘既擒獻克舉受重賞畧無顧忌今且時縱土夷出沒緬甸烏龍箐等處乞嚴行戒諭仍將撫臣勑書內增入節制該府如建昌畢節事例以請	神宗顯皇帝
137	https://sillok.history.go.kr/mc/id/msilok_005_2530_0010_0010_0150_0020	英宗睿皇帝實錄 卷二百五十三 景泰六年 五月 十七日	1455	景泰六年 五月 十七日	○命浦河南都司浦南都司:廣本抱本浦作河，是也。署都指揮僉事青雲子鑑代為指揮僉事以雲老疾故也	英宗睿皇帝
138	https://sillok.history.go.kr/mc/id/msilok_013_0070_0010_0010_0260_0070	熹宗哲皇帝實錄 卷七 天啟元年 閏二月 二十七日	1621	天啟元年 閏二月 二十七日	○以神機營參將沈勳補五軍八營參將孫文亮補廵捕營左營參將	熹宗哲皇帝
139	https://sillok.history.go.kr/mc/id/msilok_013_0730_0010_0010_0030_0040	熹宗哲皇帝實錄 卷七十三 天啟六年 閏六月 三日	1626	天啟六年 閏六月 三日	○太常寺少卿趙興邦冠帶閑住以御史陳朝輔疏紏也	熹宗哲皇帝
140	https://sillok.history.go.kr/mc/id/msilok_005_0340_0010_0010_0110_0010	英宗睿皇帝實錄 卷三十四 正統二年 九月 十三日	1437	正統二年 九月 十三日	○庚子命河南按察司副使榮華復職仍督理漕運以丁憂起復也	英宗睿皇帝
142	https://sillok.history.go.kr/mc/id/msilok_009_0020_0010_0010_0250_0060	世宗肅皇帝實錄 卷二 正德十六年 五月 二十八日	1521	正德十六年 五月 二十八日	○詔各邊撫臣并管糧郎中凡支散錢糧及召啇上納芻糗開中引塩並會廵按御史酌議以行從戶部覆都給事中邵錫議也	世宗肅皇帝
143	https://sillok.history.go.kr/mc/id/msilok_004_0240_0010_0010_0080_0010	宣宗章皇帝實錄 卷二十四 宣德二年 正月 九日	1427	宣德二年 正月 九日	○戊戌肉迷回回火者乞等來朝貢方物	宣宗章皇帝
144	https://sillok.history.go.kr/mc/id/msilok_007_0690_0010_0010_0190_0030	孝宗敬皇帝實錄 卷六十九 弘治五年 十一月 二十三日	1492	弘治五年 十一月 二十三日	○遣內官祭　恭讓章皇后陵寢　上詣　奉先殿　奉慈殿　太皇太后　皇太后宮行禮畢出御奉天殿文武群臣及四夷朝使行慶賀禮　太皇太后皇太后　皇后俱免命婦朝賀	孝宗敬皇帝
145	https://sillok.history.go.kr/mc/id/msilok_013_0290_0010_0010_0050_0010	熹宗哲皇帝實錄 卷二十九 天啟二年 十二月 五日	1622	天啟二年 十二月 五日	○丙寅　上以宗室開科係今日特典朱慎䤰首登甲第足光天潢令吏禮二部即會議優選京秩仍著為令從大學士何宗彥朱國祚請也後吏部覆議銓註慎䤰為中書舍人	熹宗哲皇帝
146	https://sillok.history.go.kr/mc/id/msilok_011_5850_0010_0010_0080_0040	神宗顯皇帝實錄 卷五百八十五 萬曆四十七年 八月 八日	1619	萬曆四十七年 八月 八日	○暹羅國王妃差官貢孔雀象牙降香等物賜宴賞併賜金緞紗羅金緞紗羅:廣本抱本緞作段。衣服靴襪有差	神宗顯皇帝
147	https://sillok.history.go.kr/mc/id/msilok_002_0530_0010_0010_0130_0010	太宗文皇帝實錄 卷四十八 永樂三年 十一月 十六日	1405	永樂三年 十一月 十六日	○戊申○夜有星如鷄子大青白色有尾跡出郎將傍北行餘丈餘丈:舊校改餘丈作丈餘。發光如碗大至近濁	太宗文皇帝
148	https://sillok.history.go.kr/mc/id/msilok_011_3760_0010_0010_0010_0030	神宗顯皇帝實錄 卷三百七十六 萬曆三十年 九月 一日	1602	萬曆三十年 九月 一日	○通政使沈子木上辯白疏上辯白疏:廣本抱本作上疏辨白。乞休報已有旨	神宗顯皇帝
149	https://sillok.history.go.kr/mc/id/msilok_013_0820_0010_0010_0030_0020	熹宗哲皇帝實錄 卷八十二 天啟七年 三月 三日	1627	天啟七年 三月 三日	○兵部上毛文龍揭言麗官麗人招奴害職職堅守不拔職堅守不拔:影印本職字不明晰。所傷不滿千人奴恨麗人殺死麗兵六萬燒糧米百萬餘石移兵攻麗等情得旨覽奏奴兵東襲毛帥銳氣未傷朕心深慰麗人導奴入境固自作孽然屬國不支折而入奴則奴勢益張亦非吾利還速傳諭毛帥相機應援勿懷宿嫌致悞大計饑軍需餉甚急著登撫那借青登萊三府倉儲乘風刻日開帆接濟其動支贓銀以勵戎士速發火藥以壯軍聲委係目前急著俱上緊傳與登撫如議行	熹宗哲皇帝
150	https://sillok.history.go.kr/mc/id/msilok_007_1760_0010_0010_0110_0020	孝宗敬皇帝實錄 卷一百七十六 弘治十四年 七月 十三日	1501	弘治十四年 七月 十三日	○命崇信伯費住費住:抱本閣本住作柱，是也。領五軍營大營錦衣衞都指揮使王銘領伸威營各坐營管操	孝宗敬皇帝
151	https://sillok.history.go.kr/mc/id/msilok_009_2810_0010_0010_0210_0030	世宗肅皇帝實錄 卷二百七十九 嘉靖二十二年 十月 二十五日	1543	嘉靖二十二年 十月 二十五日	○辛未進士授戶部主事授戶部主事:廣本閣本事下有「歷員外郎中，陜西參議副使參政」十三字。累陞僉都御史廵撫甘肅督理屯田督理屯田:閣本督上有尋字。陞南京都察院副都御史以事回籍聽勘至是卒載才識警敏才識警敏:廣本閣本作「才具周贍，機應警敏。初以商洛平賊著聲，遂膺邊任」在甘肅十二年廵撫滿兩考屡獲邊功撫綏民夷營屯飭武飭武:廣本閣本武以上十二字作「撫綏民夷，營屯飭武，前後屢獻功捷」。易荒裔為雄鎮河西至今賴之載既歿朝廷追錄其功追錄其功:廣本閣本作追念邊功。廕子應豊為國子生廕子應豐為國子生:廣本閣本廕作錄其。	世宗肅皇帝
152	https://sillok.history.go.kr/mc/id/msilok_010_0280_0010_0010_0110_0020	穆宗莊皇帝實錄 卷二十八 隆慶三年 正月 十四日	1569	隆慶三年 正月 十四日	○禮部尚書兼學士高儀等疏請	穆宗莊皇帝
153	https://sillok.history.go.kr/mc/id/msilok_009_5050_0010_0010_0040_0020	世宗肅皇帝實錄 卷五百三 嘉靖四十年 十一月 五日	1561	嘉靖四十年 十一月 五日	○朝鮮國王李峘遣工曹參判李龜琛等賀冬至貢馬及方物宴賚如例	世宗肅皇帝
154	https://sillok.history.go.kr/mc/id/msilok_004_0430_0010_0010_0230_0030	宣宗章皇帝實錄 卷四十三 宣德三年 五月 二十四日	1428	宣德三年 五月 二十四日	○賜交阯新安府所屬來朝土官主簿鄭吳等并土僧智深等二十人銀鈔綵幣表裏紵絲衣服布絹等物有差	宣宗章皇帝
155	https://sillok.history.go.kr/mc/id/msilok_013_0780_0010_0010_0140_0040	熹宗哲皇帝實錄 卷七十八 天啟六年 十一月 十四日	1626	天啟六年 十一月 十四日	○宴四夷入貢使臣如例	熹宗哲皇帝
156	https://sillok.history.go.kr/mc/id/msilok_013_0090_0010_0010_0250_0060	熹宗哲皇帝實錄 卷九 天啟元年 四月 二十五日	1621	天啟元年 四月 二十五日	○加陞柴溝堡守備盧抱忠盧抱忠:李本忠作中。都司僉書	熹宗哲皇帝
157	https://sillok.history.go.kr/mc/id/msilok_006_1680_0010_0010_0010_0010	憲宗純皇帝實錄 卷一百六十八 成化十三年 七月 一日	1477	成化十三年 七月 一日	明憲宗純皇帝實錄卷之一百六十八 成化十三年秋七月丙寅朔享　太廟	憲宗純皇帝
158	https://sillok.history.go.kr/mc/id/msilok_011_5590_0010_0010_0060_0010	神宗顯皇帝實錄 卷五百五十九 萬曆四十五年 七月 七日	1617	萬曆四十五年 七月 七日	○己巳大學士方從哲因風雹之變上言時事以補大僚補科道舉熱審釋纍臣諸要務為請	神宗顯皇帝
159	https://sillok.history.go.kr/mc/id/msilok_009_0160_0010_0010_0110_0010	世宗肅皇帝實錄 卷十六 嘉靖元年 七月 十一日	1522	嘉靖元年 七月 十一日	○乙卯詔定武舉式騎射四矢以上步射二矢以上策論如故中式者免分等第槩陞署二級	世宗肅皇帝
160	https://sillok.history.go.kr/mc/id/msilok_008_1050_0010_0010_0090_0020	武宗毅皇帝實錄 卷一百五 正德八年 十月 九日	1513	正德八年 十月 九日	○命給還故平江伯陳熊沒人家產熊既復爵病卒其母袁氏奏訴乃盡給之	武宗毅皇帝
194	https://sillok.history.go.kr/mc/id/msilok_008_0090_0010_0010_0230_0030	武宗毅皇帝實錄 卷九 正德元年 正月 二十八日	1506	正德元年 正月 二十八日	○命福建都指揮僉事張勇張勇:廣本勇作永。充右參將協守貴州兼提督清浪等處地方	武宗毅皇帝
161	https://sillok.history.go.kr/mc/id/msilok_010_0150_0010_0010_0090_0010	穆宗莊皇帝實錄 卷十五 隆慶元年 十二月 九日	1567	隆慶元年 十二月 九日	○己丑○吏科都給事王浩吏科都給事王浩:抱本嘉本事下有中字，三本浩作治，是也。等言故禮部侍郎何塘理學純臣宜加羙謚原任大學士夏言人品事業雖不可知至所論復套事未為過失未為過失:三本過失作失策。其視曾銑均属無辜宜加雪宥宜加雪宥:抱本嘉本加作與。大理寺卿朱廷立刑部侍郎詹澣詹澣:三本澣作瀚，下同。鍜成夏言曾銑之獄宜追奪原聀礼部覆議如其言　詔賜塘謚文定復言吏部尚書澣與廷立追奪原聀追奪原職:嘉本追上有俱字。	穆宗莊皇帝
162	https://sillok.history.go.kr/mc/id/msilok_009_1130_0010_0010_0070_0020	世宗肅皇帝實錄 卷一百十三 嘉靖九年 五月 八日	1530	嘉靖九年 五月 八日	○戶科給事中王聘言農桑衣食之農桑衣食之:三本東本之下有本字，是也。王業之端宜令天下郡縣各置一官專理農事仍勑廵撫及二司官二司官:東本二作三。以時廵省部覆得旨治農不必添設治農不必添設:三本東本農下有官字，是也。惟令撫按各行所屬委官管理務順民情毋有所擾	世宗肅皇帝
163	https://sillok.history.go.kr/mc/id/msilok_007_0030_0010_0010_0130_0030	孝宗敬皇帝實錄 卷三 成化二十三年 九月下 二十七日	1487	成化二十三年 九月下 二十七日	○申刻日生左珥色赤黃	孝宗敬皇帝
164	https://sillok.history.go.kr/mc/id/msilok_006_2000_0010_0010_0070_0060	憲宗純皇帝實錄 卷二百 成化十六年 二月 八日	1480	成化十六年 二月 八日	○夜月犯西咸星	憲宗純皇帝
165	https://sillok.history.go.kr/mc/id/msilok_012_0040_0010_0010_0020_0140	光宗貞皇帝實錄 卷四 泰昌元年 八月 六日	1620	泰昌元年 八月 六日	○起陞原任南京吏部考功司郎中饒伸為光祿寺少卿伸以刑部主事論輔臣王錫爵子衡不宜中科削為民起原任禮部祠祭司主事為民萬建崑為南京禮部精膳司主事建崑以萬曆二十六年有憂危宏議一書傳於朝語涉國本皇親鄭承恩疏辯御史趙之翰遂言此給事中戴士衡所為蓋疑士衡曾為大學士張位邑令此書受位指使而建崑與位同里有連因牽及之遂降雜職邊方尋疏辯為民	光宗貞皇帝
166	https://sillok.history.go.kr/mc/id/msilok_004_1110_0010_0010_0150_0020	宣宗章皇帝實錄 卷一百十一 宣德九年 六月 十五日	1434	宣德九年 六月 十五日	○遼王貴烚以衡陽王貴㷂母言其過奏乞入朝面訢復書止之曰嚮已諭王當省躬思過有即改之無則加勉今朝廷既置不問則兄弟宜相與友愛如初何必喋喋置喙哉	宣宗章皇帝
167	https://sillok.history.go.kr/mc/id/msilok_006_0880_0010_0010_0050_0030	憲宗純皇帝實錄 卷八十八 成化七年 二月 六日	1471	成化七年 二月 六日	○南京都察院右僉都御史高明奏乞致仕不許	憲宗純皇帝
168	https://sillok.history.go.kr/mc/id/msilok_011_0110_0010_0010_0240_0030	神宗顯皇帝實錄 卷十一 萬曆元年 三月 二十六日	1573	萬曆元年 三月 二十六日	○南京吏科給事中史朝鉉等條奏考察事宜一曰慎題一曰慎題覆:廣本一曰作一。覆以俟考察一曰催冊籍一曰催冊籍:廣本一曰作二。以稽吏治一曰酌地方一曰酌地方:廣本一曰作三。以定去留一曰均覈實一曰均覈實:廣本一曰作四。以處卑職一曰飭舊例一曰飭舊例:廣本一曰作五，飭作遵。以寓旌別湖廣道御史陳堂等條奏七事一曰崇實政一曰崇實政:廣本無曰字。一曰重質問一曰重質問:廣本一曰作二。一曰稽錢糧一曰稽錢糧:廣本一曰作三。一曰重方面一曰重方面:廣本一曰作四。一曰簡教職一曰簡教職:廣本一曰作五。一曰重遠方一曰重遠方:廣本一曰作六。一曰惜人才一曰惜人才:廣本一曰作七。章俱下吏部	神宗顯皇帝
169	https://sillok.history.go.kr/mc/id/msilok_010_0590_0010_0010_0200_0020	穆宗莊皇帝實錄 卷五十九 隆慶五年 七月 二十四日	1571	隆慶五年 七月 二十四日	○陞都察院右僉都御史李棠為右副都御史廵撫南贛汀漳提督軍務	穆宗莊皇帝
170	https://sillok.history.go.kr/mc/id/msilok_001_1550_0010_0020_0090_0040	太祖高皇帝實錄 卷一百五十三 洪武十六年 四月 十五日	1383	洪武十六年 四月 十五日	○賜文華殿大學士兼左中允全思誠致仕歸鄉里勑曰朕觀古人其有志之士雖髮白氣衰而心猶不怠故能善其始終使名垂方冊光照後世卿懷才抱德肩古志人惜乎以衰老之年志雖存而力不能任朕不忍復勞特令卿還鄉里以撫子孫享其奉養不亦悅乎	太祖高皇帝
171	https://sillok.history.go.kr/mc/id/msilok_006_0620_0010_0010_0030_0020	憲宗純皇帝實錄 卷六十二 成化五年 正月 三日	1469	成化五年 正月 三日	○六科十三道官具本認罪　上宥之先是給事中沈珤等及監察御史劉璧等陳言公薦舉事奉旨命吏部考永樂以後勑旨除授并宣德以後保官事例來聞既而吏部覆奏　上責珤等令回話於是珤等言臣等伏覩綸音措躬無地仰惟　皇上德同堯舜納諫如流邇因修德弭災爰命臣等勉于修職臣等感激思欲仰副　聖心少露犬馬之誠乃以公薦舉事會本具奏實出眾情今　皇上欲遵　祖宗簡賢任官舊䂓舉而行之盖所以圖治理也但　宸衷淵默非凡庸所能仰測况學識膚淺昧於典故輒陳迂言冐瀆　聖聽臣等不勝戰慄待罪之至　上曰爾等違　祖宗舊制違祖宗舊制:抱本違上有故字。欺誑朝廷本當逮問但既引罪姑宥之仍各停俸三月	憲宗純皇帝
172	https://sillok.history.go.kr/mc/id/msilok_009_5120_0010_0010_0180_0010	世宗肅皇帝實錄 卷五百十 嘉靖四十一年 六月 二十八日	1562	嘉靖四十一年 六月 二十八日	○庚辰　孝穆皇后忌辰遣成安伯郭應乾祭　茂陵 世宗肅皇帝實錄卷之五百十	世宗肅皇帝
173	https://sillok.history.go.kr/mc/id/msilok_006_1340_0010_0010_0060_0030	憲宗純皇帝實錄 卷一百三十四 成化十年 十月 六日	1474	成化十年 十月 六日	○法司奏今歲死囚總九十一人奉旨會官審錄于朝得情真無詞者二十人餘或訴冤并情可矜疑及父母告其子而復息詞者皆具獄以聞詔情真無詞者如律處决訴冤者許重鞫情可矜疑者減死充邊軍充邊軍:廣本無邊字。息詞者杖而釋之	憲宗純皇帝
174	https://sillok.history.go.kr/mc/id/msilok_007_0650_0010_0010_0220_0020	孝宗敬皇帝實錄 卷六十五 弘治五年 七月 二十五日	1492	弘治五年 七月 二十五日	○命南京工部右侍郎黃孔昭之孫綰為國子監生從其請也	孝宗敬皇帝
175	https://sillok.history.go.kr/mc/id/msilok_007_1440_0010_0010_0030_0020	孝宗敬皇帝實錄 卷一百四十四 弘治十一年 閏十一月 四日	1498	弘治十一年 閏十一月 四日	○昏刻月犯壘壁陣西第二星	孝宗敬皇帝
195	https://sillok.history.go.kr/mc/id/msilok_013_0830_0010_0010_0020_0050	熹宗哲皇帝實錄 卷八十三 天啟七年 四月 二日	1627	天啟七年 四月 二日	○天壽山守備太監孟進寶言盜伐　皇陵禁木遺火延燒該口官軍不行禁緝劾把總趙應奎等命刑部提問依律正罪	熹宗哲皇帝
176	https://sillok.history.go.kr/mc/id/msilok_011_0330_0010_0010_0200_0010	神宗顯皇帝實錄 卷三十三 萬曆二年 閏十二月 二十日	1574	萬曆二年 閏十二月 二十日	○庚寅　上御文華殿講讀是日　上從容問輔臣張居正等元夕鰲山烟火　祖制乎對曰非也始成化間以奉　母后母后:廣本抱本作聖母。起居注與館本同。然當時諫者不獨言官即如翰林亦有三四人上疏嘉靖中嘗間舉亦以奉神非為遊觀隆慶以來乃歲供元夕之娛糜費糜費:抱本起居注作靡費。無益是在新政所當節省是在新政所當節省:廣本抱本新政作皇上，誤。　上曰然夫鰲山者聚燈為棚耳第懸燈殿上亦自足觀安用此太監馮保從旁言他日治平久或可間一舉以彰盛事　上曰朕觀一度卽與千百觀同居正言明歲雖禫繼此　上大婚上大婚:廣本上上有皇字。　潞王出閣諸公主釐降大事尚多大事尚多:抱本事作舉。起居注與館本同。每事率費數千萬金率費數千萬金:廣本抱本無率字。抱本起居注千作十。作十是也。天下民力殫詘有司計無所出及今無事時加意撙節加意撙節:廣本抱本加上有皇上當三字。稍蓄以待用不然臣恐浚民脂膏不給也臣恐浚民脂膏不給也:廣本抱本浚民作民之。　上曰朕極知民竆如先生言居正曰即如　聖節元旦舊例賞賜各十餘萬無名之費太多其他縱不得已亦當量省　上悉嘉納明年元夕罷烟火鰲山	神宗顯皇帝
177	https://sillok.history.go.kr/mc/id/msilok_013_0610_0010_0010_0250_0050	熹宗哲皇帝實錄 卷六十一 天啟五年 七月 二十七日	1625	天啟五年 七月 二十七日	○福建按臣姚應嘉請改督學關防避　御名也	熹宗哲皇帝
178	https://sillok.history.go.kr/mc/id/msilok_005_2720_0010_0010_0090_0010	英宗睿皇帝實錄 卷二百七十二 景泰七年 十一月 十二日	1456	景泰七年 十一月 十二日	○戊寅○獨石等處協贊軍務右參政葉盛言臣父老病在牀氣息奄奄臣以邊務不敢乞假歸省雖厯任五年不得赴京考滿以此于例不得加封父母即今邊事少寧伏乞　聖恩容臣赴京考滿使臣得以援例請乞恩命以榮父母實為萬幸　帝曰冬間正賊寇侵擾邊境之時不允赴京所請誥命　命吏部特予之	英宗睿皇帝
179	https://sillok.history.go.kr/mc/id/msilok_011_3050_0010_0010_0140_0020	神宗顯皇帝實錄 卷三百五 萬曆二十四年 十二月 十七日	1596	萬曆二十四年 十二月 十七日	○給存恤科道關防	神宗顯皇帝
180	https://sillok.history.go.kr/mc/id/msilok_009_1090_0010_0010_0050_0010	世宗肅皇帝實錄 卷一百九 嘉靖九年 正月 九日	1530	嘉靖九年 正月 九日	○庚子初甘肅鎮廵等官唐澤等言土魯番屡年犯邊盖恃瓦剌為外援今因議婚彼此有隙宜遣使齎賞遠結瓦剌以離土魯番之交總制尚書王瓊則言無故齎賞僥倖不可必成之功自啟釁端兵部覆議鎮廵所論固兵家用間之策而總制以生事啟釁為慮尤得中國正大之體宜咨各官查照議奏事理土魯番不來犯邊許其照舊通貢許其照舊通貢:舘本通上四字蟲蝕。若再侵犯即絕其貢使瓦剌叩關納欵量行犒賞如其不來不必遣使庶夷情自服國體自尊從之	世宗肅皇帝
181	https://sillok.history.go.kr/mc/id/msilok_013_0030_0010_0010_0120_0030	熹宗哲皇帝實錄 卷三 泰昌元年 十一月 十二日	1620	泰昌元年 十一月 十二日	○雲南道試御史王大年言一陽節屆　郊祀肇興望　皇上躬親大典用迓天庥而又以揭請望閣臣以贊成責中官報聞	熹宗哲皇帝
182	https://sillok.history.go.kr/mc/id/msilok_013_0420_0010_0010_0090_0010	熹宗哲皇帝實錄 卷四十二 天啟三年 十二月 九日	1623	天啟三年 十二月 九日	○甲午賜華陽王至漶特勑鈐束諸宗以專城另居且漸近蠻洞故也	熹宗哲皇帝
183	https://sillok.history.go.kr/mc/id/msilok_011_3050_0010_0010_0210_0010	神宗顯皇帝實錄 卷三百五 萬曆二十四年 十二月 二十九日	1596	萬曆二十四年 十二月 二十九日	○辛卯行　大祫禮遣公徐文璧恭代遣侯徐文煒伯王學禮分獻	神宗顯皇帝
184	https://sillok.history.go.kr/mc/id/msilok_005_2670_0010_0010_0010_0010	英宗睿皇帝實錄 卷二百六十七 景泰七年 六月 一日	1456	景泰七年 六月 一日	大明英宗睿皇帝實錄卷二百六十七 廢帝郕戾王附錄第八十五 景泰七年六月己亥朔　太上皇帝居南宮　賜楚府江夏王庶長子鎮國將軍李塈李塈:舊校改李作季。廣本塈作，抱本作㙱。夫人凍氏　誥命冠服　給褒城王府鎮國將軍徵鐌歲祿一千石米鈔中半兼支　改武成中衛為壽陵馬壽陵馬:廣本抱本馬作衞，是也。　禮科給事中張寧言邇者天心仁愛國家特示警告　朝廷克謹天成克謹天成:廣本抱本成作戒，是也。頒降　敕諭軍民利弊所不及者並許開具來聞臣謹具所言事宜一近觀南京禮科給事中唐瑜等奏南京各衙門官員多有老疾等項欲加考察吏部覆奏奉旨令南京吏部等衙門公同查勘臣惟朝廷為端本之地而京官為倡率之臣故風化必始於王畿而黜罰當先乎貴近除舊布新莫急於此今在南京者既加考察而在北京者一概優容涇渭莫分薰蕕同器乞敕吏部以在京各衙門堂上官員具名奏聞奏聞:廣本作開奏，抱本作聞奏。取自上裁其餘大小官員從本衙門堂上官考察果有老疾不堪任用者俱從吏部循例施行如此則激勸之源激勸之源:廣本抱本源作原。出於朝廷而內外澄清矣一在京各衛武職官員帶俸等項數多有一衛二千餘名者有一衛千五百餘名者通計不下三萬餘員每歲共支食米三十六萬餘石折俸銀四十八萬八千餘石八千餘石:廣本抱本石作兩，是也。若併胡椒蘇木折鈔等項總計動經百萬之數縻耗錢粮莫甚於此况其間亦有老幼怯弱騎射住疏之人既無差調又無掌管徒建虛名以銷實俸今府庫告乏四方飢饉相仍平時錢粮仰給去處多致停免節財慎用正在此時乃以有限之資而供無窮之費臣訪得天下都司衛所官員多有員缺不行申補乞敕兵部計議將前項帶俸官員內除應存留備禦者不動其餘照缺補調補調:舊校改作調補。在外都司衛所管事如此則在外無曠官之弊在內省冗食之憂事體人情兩得其便若能去一分則國有一分之積矣則國有一分之積矣:影印本積字不清楚。詔以所言有理令該衙門閱實行之後竟不行	英宗睿皇帝
185	https://sillok.history.go.kr/mc/id/msilok_013_0810_0010_0010_0020_0060	熹宗哲皇帝實錄 卷八十一 天啟七年 二月 二日	1627	天啟七年 二月 二日	○加陞太常寺少卿田吉為太僕寺卿仍管職方司事	熹宗哲皇帝
186	https://sillok.history.go.kr/mc/id/msilok_011_4810_0010_0010_0170_0010	神宗顯皇帝實錄 卷四百八十一 萬曆三十九年 三月 二十日	1611	萬曆三十九年 三月 二十日	○庚申予原任廵撫順天兵部尚書兼都察院右副都御史劉四科祭葬贈太子少保廕一子入監讀書四科剔厯內外剔歷內外:廣本抱本剔作敭，是也。峻節直言時稱其有大臣風節	神宗顯皇帝
187	https://sillok.history.go.kr/mc/id/msilok_002_1820_0010_0010_0170_0010	太宗文皇帝實錄 卷一百七十七 永樂十四年 六月 二十八日	1416	永樂十四年 六月 二十八日	○戊子○禮部言湖廣興國州民歐文受妻李氏一產三男命循例優給	太宗文皇帝
188	https://sillok.history.go.kr/mc/id/msilok_001_1210_0010_0040_0130_0040	太祖高皇帝實錄 卷一百十九 洪武十一年 九月 二十七日	1378	洪武十一年 九月 二十七日	○置府軍左右二衛指揮使司	太祖高皇帝
189	https://sillok.history.go.kr/mc/id/msilok_010_0380_0010_0010_0130_0020	穆宗莊皇帝實錄 卷三十八 隆慶三年 十月 十八日	1569	隆慶三年 十月 十八日	○命中軍都督府僉書署都督僉事郭琥充縂兵官鎮守山西并提督鴈門等関	穆宗莊皇帝
190	https://sillok.history.go.kr/mc/id/msilok_006_0160_0010_0010_0140_0010	憲宗純皇帝實錄 卷十六 成化元年 四月 十六日	1465	成化元年 四月 十六日	○壬辰 仁祖淳皇帝忌辰　奉先殿行祭禮	憲宗純皇帝
191	https://sillok.history.go.kr/mc/id/msilok_013_0580_0010_0010_0180_0050	熹宗哲皇帝實錄 卷五十八 天啟五年 四月 十九日	1625	天啟五年 四月 十九日	○調補原任四川按察司副使曾應棨於廣東南韶道	熹宗哲皇帝
192	https://sillok.history.go.kr/mc/id/msilok_011_4180_0010_0010_0090_0020	神宗顯皇帝實錄 卷四百十八 萬曆三十四年 二月 十日	1606	萬曆三十四年 二月 十日	○署工部事刑部右侍郎右侍郎:廣本抱本右作左。沈應文言繕治城垣工程最亟其見在灰車各役極稱疲憊獨肩則有不均之嗟編派又有騷擾之慮無已惟於灰車等戶移文順天府查訪的確殷實之家量僉報灰戶八名車戶十名少為幫助其城工舊役仍著令上緊協辦臣部酌量給發預支接濟　上報以城工最急城工最急:廣本抱本急作緊。灰車二戶不得不量行僉報但不許多派人數及以中等之家搪塞致滋告擾其已経審明的確殷實者亦不許鑽求勢要多方避匿爾部還酌量多寡給發預支俾無偏累以安都民	神宗顯皇帝
193	https://sillok.history.go.kr/mc/id/msilok_006_0320_0010_0010_0160_0010	憲宗純皇帝實錄 卷三十二 成化二年 七月 十八日	1466	成化二年 七月 十八日	○丁亥　太宗文皇皇帝忌辰　奉先殿行祭禮遣駙馬都尉薛桓祭長陵	憲宗純皇帝
196	https://sillok.history.go.kr/mc/id/msilok_011_3190_0010_0010_0180_0030	神宗顯皇帝實錄 卷三百十九 萬曆二十六年 二月 二十三日	1598	萬曆二十六年 二月 二十三日	○大學士趙志臯以人言乞罷　上溫諭留之	神宗顯皇帝
197	https://sillok.history.go.kr/mc/id/msilok_013_0100_0010_0010_0190_0010	熹宗哲皇帝實錄 卷十 天啟元年 五月 十九日	1621	天啟元年 五月 十九日	○庚申陞通州領兵馬曠為宣大標下遊擊	熹宗哲皇帝
198	https://sillok.history.go.kr/mc/id/msilok_009_3480_0010_0010_0120_0010	世宗肅皇帝實錄 卷三百四十六 嘉靖二十八年 三月 十四日	1549	嘉靖二十八年 三月 十四日	○甲申命太傅兼太子太傅成國公朱希忠以　皇太子加冠告于　太廟內命婦告　孝烈皇后几筵	世宗肅皇帝
199	https://sillok.history.go.kr/mc/id/msilok_007_0480_0010_0010_0240_0010	孝宗敬皇帝實錄 卷四十八 弘治四年 二月 二十六日	1491	弘治四年 二月 二十六日	○壬申太僕寺少卿李鑑卒鑑河內人成化五年進士授兵部武庫司主事陞員外郎郎中至太僕寺少卿僅三月而卒武庫職出納諸司柴薪皂隸銀或有利其奇贏者鑑一無所私為大司馬諸公所器重其少卿之擢亦諸公薦之云	孝宗敬皇帝
200	https://sillok.history.go.kr/mc/id/msilok_011_3810_0010_0010_0160_0010	神宗顯皇帝實錄 卷三百八十一 萬曆三十一年 二月 十六日	1603	萬曆三十一年 二月 十六日	○癸卯初制遼東鎮歲額民運銀一十四萬七千餘兩徵派山東布運二司徑觧該鎮交納給軍萬曆七年因該省徵觧延緩徵解延緩:廣本抱本緩作綏，誤。暫改類觧太倉給發彼時太倉充餘故資其那儹太倉充餘故資其那儧:廣本抱本故作數，儧作借，作借是也。今太倉匱極勢難代發戶部請如舊制從之	神宗顯皇帝
201	https://sillok.history.go.kr/mc/id/msilok_005_0650_0010_0010_0110_0020	英宗睿皇帝實錄 卷六十五 正統五年 三月 十一日	1440	正統五年 三月 十一日	○陜西臨洮府寶塔寺剌麻綽吉朶兒只甘州寄住撒馬兒罕回回馬黑木等俱來朝貢馬駝青鼠皮等物賜綵幣等物有差	英宗睿皇帝
202	https://sillok.history.go.kr/mc/id/msilok_008_1910_0010_0010_0150_0010	武宗毅皇帝實錄 卷一百九十一 正德十五年 九月 三十日	1520	正德十五年 九月 三十日	○甲申詔自今戶部歲差一主事或員外郎一人于蘭州專管甘肅糧餉專管甘肅糧餉:廣本管作理。禮部乃鑄関防給之乃鑄關防給之:廣本抱本乃作仍，是也。從廵按御史潘倣奏也	武宗毅皇帝
203	https://sillok.history.go.kr/mc/id/msilok_005_1840_0010_0010_0130_0040	英宗睿皇帝實錄 卷一百八十四 正統十四年 十月 十三日	1449	正統十四年 十月 十三日	○敕指揮同知石彪都指揮孔旺等率所領官軍來涿州接應殺賊	英宗睿皇帝
204	https://sillok.history.go.kr/mc/id/msilok_002_2730_0010_0010_0070_0010	太宗文皇帝實錄 卷二百六十七 永樂二十二年 正月 十日	1424	永樂二十二年 正月 十日	○丁亥○哈密回回千戶悟牙思悟牙恩:廣本抱本悟作恪。撒馬兒罕回回迭力迷貢羊馬廣西果花州果花州:抱本花作化，是也。土官知州趙應貴州卭水一十五峒一十五峒:廣本峒作洞。蠻夷長官楊勝武等來朝貢馬各賜鈔幣	太宗文皇帝
205	https://sillok.history.go.kr/mc/id/msilok_008_0310_0010_0010_0180_0030	武宗毅皇帝實錄 卷三十一 正德二年 十月 十九日	1507	正德二年 十月 十九日	○巡按直隸御史閭潔奏揚州府通州及海門泰興二縣田地草塲自永樂等年以來陸續坍沒入江者計二千五百三十餘頃遺下稅糧黃豆馬草租鈔以石以包以貫計者共二萬五千六百九十有餘俱累見在人戶及里甲陪納宜悉蠲免戶部覆議所徵稅糧俱起運存留歲用之數未易除免宜行巡按御史巡按御史:廣本抱本按作撫。委官詣坍沒之所從實踏勘所坍旁近有漲出為洲或被勢豪據為業者覈其頃畝撥補辦納今所虧稅糧所虧稅糧:廣本稅作歲。如或不足仍查各州縣遠年籍冊籍冊:抱本作冊籍。內有空閒未稅田地照畝撥補以足原額若坍沒是實別無田地可以撥補則起存歲額查照折銀事例處之如此則常賦不虧而民亦免包陪之累矣議入從之	武宗毅皇帝
206	https://sillok.history.go.kr/mc/id/msilok_007_1320_0010_0010_0070_0010	孝宗敬皇帝實錄 卷一百三十二 弘治十年 十二月 七日	1497	弘治十年 十二月 七日	○甲戌戶部左侍郎劉大夏奉命整理邊儲還奏宣府地險積寡已於東城置倉數十間未有以實之而順聖川地肥饒屯田團種之外尚多私占請令廵撫廵按等官清查歸官其軍餘原領屯田團種者每分額外量與餘田勿令過二十畝清出歸官者或原人領種或別召承佃每畝起科納糧三升草一斤與東西二城并蔚州衞屯田糧料俱令運赴新修東倉及附近草塲草場:閣本草作倉。上納倘宣府不足於農隙時運去備豫其他地方及西城蔚州二處不足宜發銀就彼糴買不得那借至若懷來城尤為要害亦須增置倉廒糴蓄糧料以備倉卒之用戶部覆奏從之	孝宗敬皇帝
207	https://sillok.history.go.kr/mc/id/msilok_011_4920_0010_0010_0110_0030	神宗顯皇帝實錄 卷四百九十二 萬曆四十年 二月 十四日	1612	萬曆四十年 二月 十四日	○陞思石守備張世臣為四川疊茂遊擊	神宗顯皇帝
\.


--
-- Name: customers_customerid_seq; Type: SEQUENCE SET; Schema: public; Owner: dhg503
--

SELECT pg_catalog.setval('public.customers_customerid_seq', 1, false);


--
-- Name: dynasty_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dhg503
--

SELECT pg_catalog.setval('public.dynasty_id_seq', 3, true);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: dhg503
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customerid);


--
-- Name: dynasty dynasty_name_key; Type: CONSTRAINT; Schema: public; Owner: dhg503
--

ALTER TABLE ONLY public.dynasty
    ADD CONSTRAINT dynasty_name_key UNIQUE (name);


--
-- Name: dynasty dynasty_pkey; Type: CONSTRAINT; Schema: public; Owner: dhg503
--

ALTER TABLE ONLY public.dynasty
    ADD CONSTRAINT dynasty_pkey PRIMARY KEY (id);


--
-- Name: mqshilu mqshilu_pkey; Type: CONSTRAINT; Schema: public; Owner: dhg503
--

ALTER TABLE ONLY public.mqshilu
    ADD CONSTRAINT mqshilu_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

