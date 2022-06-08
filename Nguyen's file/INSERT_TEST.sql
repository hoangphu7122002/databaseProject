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

---EMPLOYEE---
INSERT INTO EMPLOYEE(SSN,EID,DateBegin,EXP,SuperSSN) VALUES
	('571938356','2010828','2022-05-22',1,NULL)