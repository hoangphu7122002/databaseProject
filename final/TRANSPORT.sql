DROP TABLE IF EXISTS ALTERNATIVE_RECEIVER
DROP TABLE IF EXISTS PACKAGE
DROP TABLE IF EXISTS CORDER
DROP TABLE IF EXISTS CUSTOMER_RECEIVE
DROP TABLE IF EXISTS CUSTOMER_SEND
DROP TABLE IF EXISTS DRIVES
DROP TABLE IF EXISTS DRIVER
DROP TABLE IF EXISTS EMPLOYEE
DROP TABLE IF EXISTS PERSON_MAIL
DROP TABLE IF EXISTS PERSON_PHONE
DROP TABLE IF EXISTS VEHICLE
DROP TABLE IF EXISTS ACCOUNT
DROP TABLE IF EXISTS PERSON
DROP TABLE IF EXISTS KILOMETER_DISTANCE
DROP TABLE IF EXISTS PRICE_RATIO
DROP TABLE IF EXISTS SALARY_BILL

CREATE TABLE PERSON (
    SSN		   CHAR(9) PRIMARY KEY,
    FirstName  TEXT NOT NULL,
    LastName   TEXT NOT NULL,
    Gender     CHAR NOT NULL
);

CREATE TABLE CUSTOMER_RECEIVE (
    SSN CHAR(9) PRIMARY KEY REFERENCES PERSON(SSN),
    ADDRESS   VARCHAR(64) NOT NULL
);

CREATE TABLE CUSTOMER_SEND (
    SSN     CHAR(9) PRIMARY KEY REFERENCES PERSON(SSN),
    SERVICE    VARCHAR(8) NOT NULL
);

CREATE TABLE EMPLOYEE (
	E_IDX		INT NOT NULL IDENTITY(1,1),
    SSN     CHAR(9) PRIMARY KEY REFERENCES PERSON(SSN),
    EID     CHAR(7) NOT NULL UNIQUE,
    DateBegin  DATE NOT NULL,
    EXP     TINYINT,
    SuperSSN  CHAR(9) REFERENCES EMPLOYEE(SSN),
	SALARY	BIGINT DEFAULT 0
);

CREATE TABLE VEHICLE (
    VNUM    CHAR(10) PRIMARY KEY,
    RNUM    CHAR(8) NOT NULL UNIQUE,
    VTYPE   TEXT
);

CREATE TABLE DRIVER (
    SSN     CHAR(9) PRIMARY KEY REFERENCES PERSON(SSN)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
    LICENSE_ID CHAR(9) NOT NULL UNIQUE,
    EXP TINYINT
);

CREATE TABLE DRIVES (
    SSN CHAR(9) NOT NULL REFERENCES DRIVER(SSN)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
    VNUM CHAR(10) NOT NULL REFERENCES VEHICLE(VNUM)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
    PRIMARY KEY (SSN, VNUM)
);

CREATE TABLE PERSON_MAIL (
    SSN CHAR(9) NOT NULL REFERENCES PERSON(SSN)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
    MAIL    VARCHAR(32) UNIQUE,
    PRIMARY KEY (SSN,MAIL)
);

CREATE TABLE PERSON_PHONE (
    SSN     CHAR(9) NOT NULL REFERENCES PERSON(SSN)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
    PHONE   CHAR(10) UNIQUE,
    PRIMARY KEY (SSN,PHONE)
);  

	
CREATE TABLE ALTERNATIVE_RECEIVER (
    SSN CHAR(9) NOT NULL REFERENCES CUSTOMER_RECEIVE(SSN)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
    FNAME VARCHAR(15) NOT NULL,
  	PHONE 	CHAR(10),
    RELATIONSHIP    VARCHAR(10),
  	PRIMARY KEY (SSN,FNAME)
);

CREATE TABLE ACCOUNT (
    ID      CHAR(10) PRIMARY KEY,
    ATYPE   VARCHAR(8),
    UserName   VARCHAR(32) NOT NULL,
    PASS   VARCHAR(32) NOT NULL,
    SSN     CHAR(9) NOT NULL REFERENCES PERSON(SSN)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE CORDER (
	O_IDX		INT NOT NULL IDENTITY(1,1),
    SSN_CR      CHAR(9) NOT NULL REFERENCES CUSTOMER_RECEIVE(SSN)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
    SSN_CS      CHAR(9) NOT NULL REFERENCES CUSTOMER_SEND(SSN)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
    SSN_EMP     CHAR(9) NOT NULL REFERENCES EMPLOYEE(SSN)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
    ORDERID 	CHAR(10) PRIMARY KEY,
    RATE        TINYINT,
    PaymentType    TEXT,
    OTIME		CHAR(10),
	STATUS		VARCHAR(10)
);

CREATE TABLE PACKAGE (
	P_IDX INT NOT NULL IDENTITY(1,1),
    PID         CHAR(9) PRIMARY KEY,
    PWEIGHT     FLOAT(3),
    TypeName    VARCHAR(7),
    TypeLevel   TINYINT,
    ORDERID CHAR(10) NOT NULL REFERENCES CORDER(ORDERID)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
    SSN     CHAR(9) NOT NULL REFERENCES DRIVER(SSN)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	TIME	CHAR(10),
    LOCATION   VARCHAR(64)
);

CREATE TABLE PRICE_RATIO (
	SERVICE_CUSTOMER VARCHAR(8) PRIMARY KEY,
	RATIO REAL
);

CREATE TABLE KILOMETER_DISTANCE (
	PROVINCE VARCHAR(32) PRIMARY KEY,
	DISTANCE INT
);

CREATE TABLE SALARY_BILL (
	EXP TINYINT PRIMARY KEY,
	SALARY BIGINT
);