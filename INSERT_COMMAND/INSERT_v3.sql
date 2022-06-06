USE DRIVER_SERVICE;

---PERSON---
INSERT INTO PERSON(SSN,FirstName,LastName,Gender) VALUES
	('182835988','Jason','Brown','F'),
	('658299807','Miss','Christine','M'),
	('553361078','Corey','Mccall','F'),
	('589646589','Daniel','Hansen','M'),
	('795908059','Chris','Lyons','F'),
	('351524229','Cynthia','Glenn','M'),
	('870904007','Brandon','Adams','F'),
	('266777952','Jocelyn','Lee','F'),
	('421478385','Victoria','Paul','F'),
	('625064565','David','Phillips','M'),
	('643400717','Brandon','Kidd','M'),
	('296401306','Nicole','Richardson','M'),
	('604048949','Cody','Pope','M'),
	('340747318','Vincent','Moore','M'),
	('215040471','Timothy','Jones','M'),
	('271251120','Kyle','Mcdonald','F'),
	('855496674','Christopher','Rubio','M'),
	('642346527','Kathy','Harrison','M'),
	('159951930','Kevin','Martin','F'),
	('387091691','Lisa','Tucker','M'),
	('571938356','Cathy','Meyer','M'),
	('691463675','Wesley','Steele','F'),
	('419869554','Tyler','Welch','F'),
	('087472489','Brittany','Moore','M'),
	('749280483','Casey','Silva','F'),
	('384392997','Charles','Osborne','M'),
	('831349683','Michael','Paul','F'),
	('507735440','Sharon','Stevens','M'),
	('485699746','Jason','Moore','M'),
	('597479722','Dorothy','Coleman','F'),
	('329535850','Gabriel','Douglas','M'),
	('094107343','Shawn','Pham','F'),
	('709139096','Matthew','Parker','M'),
	('843659624','Kimberly','Garrison','F'),
	('587281410','Heather','Clark','M'),
	('237468085','Cheryl','Sullivan','M'),
	('823790540','Heather','Hudson','M'),
	('617137664','Cassandra','Marsh','M');

---CUSTOMER_RECEIVE---
INSERT INTO CUSTOMER_RECEIVE(SSN,ADDRESS) VALUES
	('643400717','HA NOI'),
	('296401306','THANH HOA'),
	('604048949','BAC NINH'),
	('340747318','AN GIANG'),
	('215040471','DA LAT'),
	('271251120','CAN THO'),
	('855496674','NHA TRANG'),
	('642346527','DA LAT');


---CUSTOMER_SEND---
INSERT INTO CUSTOMER_SEND(SSN,SERVICE) VALUES
	('182835988','NORMAL'),
	('658299807','DISCOUNT'),
	('553361078','EXPRESS'),
	('589646589','DISCOUNT'),
	('795908059','DISCOUNT'),
	('351524229','NORMAL'),
	('870904007','DISCOUNT'),
	('266777952','NORMAL'),
	('421478385','DISCOUNT'),
	('625064565','NORMAL');

---EMPLOYEE---
INSERT INTO EMPLOYEE(SSN,EID,DateBegin,EXP,SuperSSN) VALUES
	('159951930','2010025','2022-05-13',1,'571938356'),
	('387091691','2010638','2022-05-07',2,NULL),
	('571938356','2010828','2022-05-22',1,NULL),
	('691463675','2010332','2022-05-15',1,NULL),
	('419869554','2010842','2022-05-11',2,'087472489'),
	('087472489','2010190','2022-05-23',3,NULL),
	('749280483','2010159','2022-05-01',2,'571938356'),
	('384392997','2010990','2022-05-02',1,NULL),
	('831349683','2010608','2022-05-15',3,'384392997'),
	('507735440','2010963','2022-05-17',1,'384392997');

---DRIVER---
INSERT INTO DRIVER(SSN,LICENSE_ID,EXP) VALUES
	('485699746','574079305',4),
	('597479722','355979139',3),
	('329535850','065443949',8),
	('094107343','289777125',4),
	('709139096','054232441',4),
	('843659624','196616956',1),
	('587281410','641346856',8),
	('237468085','559780279',4),
	('823790540','578415821',8),
	('617137664','726216902',6);

---VEHICLE---
INSERT INTO VEHICLE(VNUM,RNUM,VTYPE) VALUES
	('06T9/74098','98199736','TRUCK'),
	('22F3/18258','96509962','TRUCK'),
	('45s6/89743','79274037','CAR'),
	('09j2/14250','64815683','CAR'),
	('80t3/98029','32612252','TRUCK'),
	('88v1/89957','75272521','CAR'),
	('01H0/76287','85998326','TRUCK'),
	('16v5/37275','00804434','CAR'),
	('88l9/06382','55320941','TRUCK'),
	('08z5/67302','24898587','BIKE'),
	('75Q0/88337','72909716','TRUCK'),
	('14u5/25866','60527050','BIKE'),
	('45m3/35914','37683425','TRUCK'),
	('20z9/46415','84153594','TRUCK'),
	('90q1/18989','96006630','BIKE'),
	('69X9/14869','32251716','TRUCK'),
	('14s5/86083','68058717','TRUCK'),
	('54h3/16981','83614023','BIKE'),
	('42k5/20031','48645202','TRUCK'),
	('69u9/63540','93425414','BIKE');

---DRIVES---
INSERT INTO DRIVES(SSN,VNUM) VALUES
	('485699746','06T9/74098'),
	('485699746','22F3/18258'),
	('485699746','45s6/89743'),
	('485699746','09j2/14250'),
	('597479722','06T9/74098'),
	('597479722','22F3/18258'),
	('597479722','45s6/89743'),
	('597479722','09j2/14250'),
	('329535850','80t3/98029'),
	('329535850','88v1/89957'),
	('329535850','01H0/76287'),
	('329535850','16v5/37275'),
	('094107343','80t3/98029'),
	('094107343','88v1/89957'),
	('094107343','01H0/76287'),
	('094107343','16v5/37275'),
	('709139096','88l9/06382'),
	('709139096','08z5/67302'),
	('709139096','75Q0/88337'),
	('709139096','14u5/25866'),
	('843659624','88l9/06382'),
	('843659624','08z5/67302'),
	('843659624','75Q0/88337'),
	('843659624','14u5/25866'),
	('587281410','45m3/35914'),
	('587281410','20z9/46415'),
	('587281410','90q1/18989'),
	('587281410','69X9/14869'),
	('237468085','45m3/35914'),
	('237468085','20z9/46415'),
	('237468085','90q1/18989'),
	('237468085','69X9/14869'),
	('823790540','14s5/86083'),
	('823790540','54h3/16981'),
	('823790540','42k5/20031'),
	('823790540','69u9/63540'),
	('617137664','14s5/86083'),
	('617137664','54h3/16981'),
	('617137664','42k5/20031'),
	('617137664','69u9/63540');

---PERSON_MAIL---

INSERT INTO PERSON_MAIL(SSN,MAIL) VALUES
	('182835988','ismith@gmail.com'),
	('182835988','pyoung@yahoo.com'),
	('658299807','bradley34@gmail.com'),
	('658299807','fosterroberto@hotmail.com'),
	('553361078','andersenkelly@yahoo.com'),
	('553361078','welchdavid@gmail.com'),
	('795908059','bryanburke@hotmail.com'),
	('351524229','stephenparsons@gmail.com'),
	('351524229','hlewis@yahoo.com'),
	('870904007','sbrown@hotmail.com'),
	('870904007','suzanne12@gmail.com'),
	('266777952','juliejohnston@gmail.com'),
	('266777952','ghardy@gmail.com'),
	('421478385','blairmario@yahoo.com'),
	('625064565','wesleyedwards@gmail.com'),
	('625064565','charles21@hotmail.com'),
	('182835988','olee@yahoo.com'),
	('182835988','emyers@yahoo.com'),
	('643400717','campbellsheila@gmail.com'),
	('589646589','jessicaevans@gmail.com'),
	('589646589','iruiz@hotmail.com'),
	('296401306','meltonmichael@yahoo.com'),
	('296401306','susanmyers@gmail.com'),
	('604048949','cody10@yahoo.com'),
	('340747318','daniel49@yahoo.com'),
	('340747318','bishopjoshua@hotmail.com'),
	('215040471','aaron64@gmail.com'),
	('215040471','edwardsalazar@hotmail.com'),
	('271251120','lisavaldez@yahoo.com'),
	('271251120','williamssara@gmail.com'),
	('855496674','haasbarbara@gmail.com'),
	('642346527','bakeraaron@gmail.com'),
	('642346527','lindsey63@hotmail.com'),
	('159951930','phillipmckenzie@hotmail.com'),
	('387091691','qcrosby@yahoo.com'),
	('387091691','calderonjamie@hotmail.com'),
	('571938356','lauren61@yahoo.com'),
	('571938356','rlewis@hotmail.com'),
	('691463675','harrisjoshua@gmail.com'),
	('691463675','harrissabrina@hotmail.com'),
	('419869554','roblesjustin@gmail.com'),
	('419869554','yatesamy@yahoo.com'),
	('087472489','amartinez@yahoo.com'),
	('087472489','mark05@yahoo.com'),
	('749280483','danielsingleton@hotmail.com'),
	('384392997','turnershawn@gmail.com'),
	('384392997','mary18@hotmail.com'),
	('831349683','kmay@yahoo.com'),
	('831349683','washingtonmichael@hotmail.com'),
	('507735440','barbara94@yahoo.com'),
	('507735440','thomasruiz@gmail.com'),
	('485699746','collinskayla@yahoo.com'),
	('485699746','nschneider@gmail.com'),
	('597479722','shughes@yahoo.com'),
	('597479722','derekburnett@yahoo.com'),
	('329535850','currybrandon@hotmail.com'),
	('094107343','kristin44@hotmail.com'),
	('709139096','murrayfrank@hotmail.com'),
	('709139096','hunterandrea@gmail.com'),
	('843659624','megan82@yahoo.com'),
	('843659624','dgomez@yahoo.com'),
	('587281410','john06@hotmail.com'),
	('237468085','david19@yahoo.com'),
	('823790540','anthony91@yahoo.com'),
	('823790540','drew14@hotmail.com'),
	('617137664','steven85@yahoo.com'),
	('617137664','michael22@yahoo.com');

---PERSON_PHONE---
INSERT INTO PERSON_PHONE(SSN,PHONE) VALUES
	('658299807','0661154933'),
	('658299807','0756147811'),
	('553361078','0981290464'),
	('553361078','0645035583'),
	('795908059','0128151815'),
	('795908059','0565044156'),
	('351524229','0520662658'),
	('870904007','0730862630'),
	('870904007','0752494129'),
	('266777952','0489314548'),
	('421478385','0063331799'),
	('625064565','0763147041'),
	('625064565','0300479209'),
	('182835988','0746936672'),
	('182835988','0734938563'),
	('643400717','0906865813'),
	('643400717','0987698129'),
	('589646589','0913121114'),
	('296401306','0956356403'),
	('604048949','0263044801'),
	('604048949','0412997094'),
	('340747318','0636588528'),
	('340747318','0331799815'),
	('215040471','0938561412'),
	('215040471','0369133134'),
	('271251120','0456220883'),
	('271251120','0547874623'),
	('855496674','0088499704'),
	('642346527','0251299135'),
	('159951930','0931743460'),
	('387091691','0654228852'),
	('387091691','0760803323'),
	('571938356','0556126754'),
	('571938356','0931197477'),
	('691463675','0822274930'),
	('419869554','0938741801'),
	('087472489','0200368577'),
	('749280483','0187168125'),
	('749280483','0820637549'),
	('384392997','0948925166'),
	('384392997','0647564159'),
	('831349683','0259073300'),
	('831349683','0161845422'),
	('507735440','0586821633'),
	('485699746','0079396961'),
	('597479722','0730335230'),
	('329535850','0602174593'),
	('329535850','0574748609'),
	('094107343','0546782597'),
	('709139096','0219042295'),
	('843659624','0634956575'),
	('587281410','0315495541'),
	('587281410','0146411468'),
	('237468085','0183294193'),
	('237468085','0174272567'),
	('823790540','0159609428'),
	('823790540','0580496159'),
	('617137664','0121717115'),
	('617137664','0685622599');

---ALTERNATIVE_RECEIVER---
INSERT INTO ALTERNATIVE_RECEIVER(SSN,FNAME,PHONE,RELATIONSHIP) VALUES
	('643400717','Andrew', '0125973070','FAMILY'),
	('643400717','Joseph', '0288366441','FAMILY'),
	('296401306','Warren', '0775688624','FAMILY'),
	('296401306','Ricky',  '0088788284','FAMILY'),
	('604048949','Mr.',    '0132263823','FAMILY'),
	('604048949','Colton', '0965812118','FAMILY'),
	('340747318','Alan',   '0691801947','FRIEND'),
	('340747318','Scott',  '0449589518','FAMILY'),
	('215040471','Deborah','0807753396','FRIEND'),
	('215040471','Crystal','0471713895','FAMILY'),
	('271251120','Edwin',  '0785144441','FRIEND'),
	('271251120','Cynthia','0522936814','FAMILY'),
	('855496674','Melissa','0654488049','FRIEND'),
	('855496674','Frank',  '0532426796','FAMILY'),
	('642346527','Rhonda', '0367581250','FAMILY'),
	('642346527','Diana',  '0822863890','FAMILY');

---ACCOUNT---
INSERT INTO ACCOUNT(ID,ATYPE,UserName,PASS,SSN) VALUES
	('5509102969','EMPLOYEE','5763894824_EE@test.com','8335562165','159951930'),
	('2923137493','EMPLOYEE','9720132605_EE@test.com','7878426075','387091691'),
	('3870403005','EMPLOYEE','5694996893_EE@test.com','3233363953','571938356'),
	('9873246566','EMPLOYEE','7108632812_EE@test.com','1432130942','691463675'),
	('4187095262','EMPLOYEE','6536350294_EE@test.com','5802726846','419869554'),
	('6242517120','EMPLOYEE','8526777160_EE@test.com','5164333376','087472489'),
	('4654548903','EMPLOYEE','3250498437_EE@test.com','1369850934','749280483'),
	('4694929708','EMPLOYEE','8206911271_EE@test.com','1819175702','384392997'),
	('4658525873','EMPLOYEE','2113597113_EE@test.com','6225121818','831349683'),
	('5477304721','EMPLOYEE','9013261730_EE@test.com','5816575672','507735440');

INSERT INTO ACCOUNT(ID,ATYPE,UserName,PASS,SSN) VALUES
	('5147558164','DRIVER','0288306778_DR@test.com','1825899787','485699746'),
	('7555105095','DRIVER','2347384403_DR@test.com','4930535563','597479722'),
	('2947447951','DRIVER','6597427625_DR@test.com','2201157556','329535850'),
	('4046002513','DRIVER','3099286089_DR@test.com','3015912321','094107343'),
	('5824925321','DRIVER','2452874608_DR@test.com','8001957155','709139096'),
	('0591040376','DRIVER','8483459357_DR@test.com','1338452880','843659624'),
	('1637802382','DRIVER','5054642822_DR@test.com','5830854258','587281410'),
	('1317182392','DRIVER','5720567284_DR@test.com','3224693263','237468085'),
	('1618380322','DRIVER','8170834931_DR@test.com','2738658328','823790540'),
	('9857623404','DRIVER','0938158348_DR@test.com','7183710753','617137664');

INSERT INTO ACCOUNT(ID,ATYPE,UserName,PASS,SSN) VALUES
	('4642924228','CUSTOMER','4787462330_CR@test.com','6810101611','182835988'),
	('1150138369','CUSTOMER','8030088499_CR@test.com','0983670207','658299807'),
	('5766733386','CUSTOMER','3465098825_CR@test.com','3514005163','553361078'),
	('5744022853','CUSTOMER','5813727015_CR@test.com','6186135938','589646589'),
	('9569982942','CUSTOMER','2334818573_CR@test.com','1803919767','795908059'),
	('2172012704','CUSTOMER','3432640514_CR@test.com','4518284239','351524229'),
	('2774786960','CUSTOMER','3365973234_CR@test.com','2721130936','870904007'),
	('7196098568','CUSTOMER','3685447585_CR@test.com','1675760659','266777952'),
	('2453236862','CUSTOMER','7853510576_CR@test.com','4880914584','421478385'),
	('3064120934','CUSTOMER','5974218829_CR@test.com','0360335605','625064565');

INSERT INTO ACCOUNT(ID,ATYPE,UserName,PASS,SSN) VALUES
	('6865813384','CUSTOMER','5493353146_CR@test.com','4781140034','643400717'),
	('8151815140','CUSTOMER','3299131211_CR@test.com','1267287129','296401306'),
	('6583742732','CUSTOMER','5044156209_CR@test.com','5640301552','604048949'),
	('1299709441','CUSTOMER','1432909873_CR@test.com','6304480175','340747318'),
	('3658852866','CUSTOMER','3149707022_CR@test.com','1454825972','215040471'),
	('7041271153','CUSTOMER','3179981595_CR@test.com','1904197287','271251120'),
	('0964122994','CUSTOMER','9209385614_CR@test.com','7713691331','855496674'),
	('5622088344','CUSTOMER','1716672870_CR@test.com','1977431827','642346527');

---ORDER---
INSERT INTO CORDER(SSN_CR,SSN_CS,SSN_EMP,ORDERID,RATE,PaymentType,OTIME,STATUS) VALUES
	--(643400717,182835988,159951930,4096189409,'USS Charles/FPO AE 97075','53146 Jennings Shoals/Mathisport, NJ 73764',23,3,0,4,'DIRECT','2017-03-25');
	('643400717','658299807','387091691','5232248330',1,'DIRECT','2020-06-09','CLOSE'),
	('296401306','589646589','691463675','4380275930',4,'DIRECT','1994-06-11','PROGRESS'),
	('604048949','795908059','419869554','1981334826',4,'BANK','1999-11-12','PROGRESS'),
	('340747318','351524229','087472489','0834219676',3,'BANK','1972-08-06','CLOSE'),
	('215040471','870904007','749280483','0469707344',1,'DIRECT','1971-06-10','PROGRESS'),
	('215040471','870904007','749280483','4667586414',5,'DIRECT','1971-06-10','PROGRESS'),
	('271251120','266777952','384392997','6946130695',5,'DIRECT','2000-11-25','CLOSE'),
	('271251120','266777952','384392997','1138709388',5,'DIRECT','2000-11-25','CLOSE'),
	('855496674','421478385','831349683','3403032743',3,'MOMO','1975-06-27','CLOSE'),
	('855496674','421478385','831349683','7424321433',5,'MOMO','1975-06-27','PROGRESS'),
	('642346527','625064565','507735440','2027124675',2,'BANK','1986-09-01','PROGRESS'),
	('642346527','625064565','507735440','0979647474',2,'BANK','1986-09-01','CLOSE');

---PACKAGE---
INSERT INTO PACKAGE(PID,PWEIGHT,TypeName,TypeLevel,ORDERID,SSN,TIME,LOCATION) VALUES
	('630871144','28','HAZARD',1, '5232248330','485699746','1974-09-24','HA NOI'),
	('638686658','15','NORMAL',3, '4380275930','597479722','1974-09-24', 'HA NOI'),
	('807551802','25','HAZARD',2, '1981334826','329535850','1974-09-24','HA NOI'),
	('706909279','39','HAZARD',2, '0834219676','329535850','2000-04-29','HO CHI MINH'),
	('911006677','48','HAZARD',2, '0834219676','094107343','2000-04-29','HO CHI MINH'),
	('268237196','14','FRAGILE',4,'0834219676','094107343','2000-04-29','HO CHI MINH'),
	('223152288','47','FRAGILE',1,'0834219676','709139096','2000-04-29','HO CHI MINH'),
	('268584140','22','HAZARD',1, '0469707344','709139096','2000-04-29','HO CHI MINH'),
	('979869698','15','FRAGILE',3,'0469707344','843659624','1983-05-18','DA NANG'),
	('111068862','9','HAZARD',3,  '4667586414','843659624','1983-05-18','DA NANG'),
	('499341039','4','NORMAL',4,  '4667586414','843659624','1983-05-18','DA NANG'),
	('422624352','16','HAZARD',1, '6946130695','587281410','1983-05-18','DA NANG'),
	('273679761','30','HAZARD',1, '6946130695','587281410','1983-05-18','DA NANG'),
	('999638575','43','NORMAL',3, '1138709388','587281410','1973-05-27','HO CHI MINH'),
	('066846691','43','FRAGILE',4,'1138709388','237468085','1973-05-27','HO CHI MINH'),
	('372863992','49','NORMAL',2, '3403032743','237468085','1973-05-27','HO CHI MINH'),
	('275409114','41','NORMAL',3, '3403032743','237468085','1973-05-27','HO CHI MINH'),
	('541397032','25','HAZARD',1, '7424321433','823790540','1973-05-27','HO CHI MINH'),
	('171906714','40','FRAGILE',1,'7424321433','823790540','1983-08-22','HUE'),
	('535238481','36','HAZARD',3, '2027124675','823790540','1983-08-22','HUE'),
	('582479922','23','FRAGILE',4,'2027124675','617137664','1983-08-22','HUE'),
	('900879650','16','FRAGILE',1,'0979647474','617137664','1983-08-22','HUE'),
	('405491139','32','NORMAL',3, '0979647474','617137664','1983-08-22','HUE');

--PRICE_RATIO
INSERT INTO PRICE_RATIO (SERVICE_CUSTOMER,RATIO) VALUES
	('NORMAL',1.0),
	('DISCOUNT',0.8),
	('EXPRESS',1.2)

--KILOMETER_DISTANCE
INSERT INTO KILOMETER_DISTANCE (PROVINCE,DISTANCE) VALUES
	('HA NOI',0),
	('HO CHI MINH',1710),
	('HUE',658),
	('DA NANG',763),
	('BAC NINH',31),
	('AN GIANG',1900),
	('DA LAT',1481),
	('THANH HOA',153),
	('QUANG TRI',889),
	('PHU THO',93),
	('NHA TRANG',1278),
	('CAN THO',1877),
	('LAO CAI',338);

INSERT INTO SALARY_BILL VALUES 
	(3,4000),
	(2,2000),
	(1,1000);

UPDATE ACCOUNT
SET ID = '9999999999',ATYPE = 'ADMIN', UserName = 'root@test.com', PASS = '0123456789' 
WHERE ID = '9873246566'

