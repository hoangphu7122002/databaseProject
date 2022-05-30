USE DRIVER_SERVICE;

CREATE TABLE PERSON (
    SSN			NUMERIC(9) PRIMARY KEY,
    FirstName  TEXT NOT NULL,
    LastName   TEXT NOT NULL,
    Gender     CHAR NOT NULL
);

CREATE TABLE CUSTOMER_RECEIVE (
    SSN NUMERIC(9) PRIMARY KEY REFERENCES PERSON(SSN),
    ADDRESS   VARCHAR(64) NOT NULL
);

    CREATE TABLE CUSTOMER_SEND (
        SSN     NUMERIC(9) NOT NULL REFERENCES PERSON(SSN),
        SERVICE    VARCHAR(8) NOT NULL, 
        PRIMARY KEY (SSN)
    );

   CREATE TABLE EMPLOYEE (
        SSN     NUMERIC(9) PRIMARY KEY REFERENCES PERSON(SSN),
        EID    NUMERIC(7) NOT NULL UNIQUE,
        DateBegin  DATE NOT NULL,
        EXP     TINYINT,
        SuperSSN  NUMERIC(9),
      	FOREIGN KEY (SuperSSN) REFERENCES EMPLOYEE(SSN)
    );

  CREATE TABLE VEHICLE(
        VNUM    CHAR(10) PRIMARY KEY,
        RNUM    CHAR(8) NOT NULL UNIQUE,
        VTYPE   TEXT
    );

   CREATE TABLE DRIVER(
        SSN     NUMERIC(9) NOT NULL REFERENCES PERSON(SSN),
        LICENSE_ID CHAR(9) NOT NULL,
        EXP TINYINT,
        PRIMARY KEY (SSN)
    );

   CREATE TABLE DRIVES(
        SSN NUMERIC(9) NOT NULL REFERENCES DRIVER(SSN),
        VNUM CHAR(10) NOT NULL REFERENCES VEHICLE(VNUM),
        PRIMARY KEY (SSN, VNUM)
    );

    CREATE TABLE PERSON_MAIL(
        SSN NUMERIC(9) NOT NULL REFERENCES PERSON(SSN),
        MAIL    VARCHAR(32),
        PRIMARY KEY (SSN,MAIL)
    );

   CREATE TABLE PERSON_PHONE(
        SSN     NUMERIC(9) NOT NULL REFERENCES PERSON(SSN),
        PHONE   NUMERIC(10),
        PRIMARY KEY (SSN,PHONE)
    );  

   CREATE TABLE ALTERNATIVE_RECEIVER(
        SSN NUMERIC(9) NOT NULL REFERENCES CUSTOMER_RECEIVE(SSN),
        FNAME VARCHAR(15) NOT NULL,
      	PHONE 	NUMERIC(10),
        RELATIONSHIP    VARCHAR(10),
      	PRIMARY KEY (SSN,FNAME)
    );

    CREATE TABLE ACCOUNT(
        ID      NUMERIC(10) PRIMARY KEY,
        ATYPE   VARCHAR(8),
        UserName   VARCHAR(32) NOT NULL,
        PASS   VARCHAR(32) NOT NULL,
        SSN     NUMERIC(9) NOT NULL REFERENCES PERSON(SSN)
    );

   CREATE TABLE CORDER(
        SSN_CR      NUMERIC(9) NOT NULL REFERENCES CUSTOMER_RECEIVE(SSN),
        SSN_CS      NUMERIC(9) NOT NULL REFERENCES CUSTOMER_SEND(SSN),
        SSN_EMP     NUMERIC(9) NOT NULL REFERENCES EMPLOYEE(SSN),
        ORDERID 	NUMERIC(10) NOT NULL,
        ADD_SEND    VARCHAR(64),
        ADD_RECEIVE VARCHAR(64),
        TotalWeight     FLOAT(3),
        NoPackage   SMALLINT,
        --TotalPrice      MONEY,
		TotalPrice INT,
        RATE        TINYINT,
        PaymentType    TEXT,
        --OTIME        DATETIME,
		OTIME		CHAR(10),
        PRIMARY KEY (ORDERID)
    );

   CREATE TABLE PACKAGE(
        PID NUMERIC(9) NOT NULL,
        PWEIGHT FLOAT(3),
        TypeName  VARCHAR(7),
        TypeLevel  TINYINT,
        ORDERID NUMERIC(10) NOT NULL REFERENCES CORDER(ORDERID),
        SSN     NUMERIC(9) NOT NULL REFERENCES DRIVER(SSN),
        --TIME   DATETIME,
		TIME	CHAR(10),
        LOCATION   VARCHAR(64),
        PRIMARY KEY (PID)
    );