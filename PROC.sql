CREATE PROC VIEW_ACCOUNT_BY_username
@username VARCHAR(32)
AS
BEGIN
	SELECT * FROM ACCOUNT WHERE UserName = @username
END
GO

EXEC VIEW_ACCOUNT_BY_username @username = '5763894824_EE@test.com'


USE DRIVER_SERVICE

CREATE PROC LOGIN_ACCOUNT
@username VARCHAR(32), @password VARCHAR(32)
AS
BEGIN 
	SELECT * FROM ACCOUNT WHERE UserName = @username AND PASS = @password
END
GO



EXEC LOGIN_ACCOUNT @username = '5763894824_EE@test.com' , @password = '8335562165';

DROP PROC UpdateAccount

ALTER PROC UpdateAccount
@username VARCHAR(32), @password VARCHAR(32), @newPassword VARCHAR(32)
AS
BEGIN
	DECLARE @isRightPass INT = 0

	SELECT @isRightPass = COUNT(*) FROM ACCOUNT WHERE UserName = @username AND PASS = @password
	IF (@isRightPass = 1)
	BEGIN 
		IF (@newPassword != '')
			BEGIN
				UPDATE ACCOUNT SET PASS = @newPassword WHERE UserName = @username
			END
		ELSE 
			BEGIN
				PRINT 'Invalid new Password';
			END
	END
END
GO

EXEC UpdateAccount  @username = '5763894824_EE@test.com' , @password = '8335562165', @newPassword = '071202';

SELECT * FROM ACCOUNT;

SELECT * FROM PERSON_PHONE;

DROP PROC InsertPhone;

ALTER PROC InsertPhone
@ssn VARCHAR(10), @phone VARCHAR(11)
AS
BEGIN
	IF (LEN(@ssn) <> 9 OR @ssn NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
		PRINT 'INVALID FORMAT SSN';
	ELSE IF (@ssn NOT IN (SELECT SSN FROM PERSON)) 
		PRINT 'SSN NOT IN DATABASE ';
	ELSE IF (LEN(@phone) <> 10 OR @phone NOT LIKE '0[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
		PRINT 'INVALID FORMAT PHONE';
	ELSE IF (@phone IN (SELECT PHONE FROM PERSON_PHONE))
		PRINT 'DUPLICATE PHONE IN DATABASE'
	ELSE
		BEGIN
			INSERT INTO PERSON_PHONE VALUES (@ssn,@phone);
			RETURN 1;
		END
	RETURN 0;
END;

EXEC InsertPhone @ssn = '658299807' , @phone = '0909090902';

ALTER PROC INSERT_MAIL @SSN VARCHAR(10), @mail VARCHAR(33)
AS
BEGIN
	IF LEN(@ssn) <> 9 OR @ssn NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
		PRINT 'Invalid format SSN';
	ELSE IF @ssn NOT IN (SELECT SSN FROM PERSON) 
		PRINT 'SSN not in database';
	ELSE IF LEN(@mail) > 32 OR @mail NOT LIKE '%_[@]_%[.]__%'
		PRINT 'Invalid format phone';
	ELSE IF @mail IN (SELECT Mail FROM PERSON_MAIL)
		PRINT 'Duplicate email in database' 
	ELSE
		BEGIN
			PRINT 'Insert successful'
			INSERT INTO PERSON_MAIL VALUES (@ssn, @mail);
			RETURN 1;
		END
	RETURN 0;
END

CREATE PROC TEST_CALL
@ssn VARCHAR(10), @mail VARCHAR(33), @phone VARCHAR(11)
AS
BEGIN 
	DECLARE @isSuccess int
	EXEC @isSuccess = InsertPhone @ssn, @phone
	IF (@isSuccess = 1)
		BEGIN
			EXEC @isSuccess = INSERT_MAIL @ssn, @mail
			IF (@isSuccess = 0)
				BEGIN
					DELETE PERSON_PHONE WHERE SSN = @ssn
					PRINT 'FAIL IN INSERT MAIL'
				END
		END
	ELSE
		PRINT 'FAIL IN INSERT PHONE';
END

EXEC TEST_CALL '087472489', 'hp@test.com', '0378410842'

--INSERT ACCOUNT
ALTER PROC InsertAccount 
@username VARCHAR(33), @password VARCHAR(33), @type VARCHAR(9), @ssn VARCHAR(10)
AS
BEGIN
	IF LEN(@ssn) <> 9 OR @ssn NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
		PRINT 'INVALID FORMAT SSN';
	ELSE IF @ssn NOT IN (SELECT SSN FROM PERSON) 
		PRINT 'SSN not in database';
	ELSE IF LEN(@username) > 32 OR @username NOT LIKE '%_@test.com'
		PRINT 'INVALID USERNAME'
	ELSE IF LEN(@password) > 32
		PRINT 'INVALID PASSWORD'
	ELSE IF @type NOT IN ('EMPLOYEE','DRIVER','CUSTOMER')
		PRINT 'INVALID TYPE'
	ELSE
		BEGIN
			--gen_d
			DECLARE @id CHAR(10)
			WHILE (0 = 0)
				BEGIN
					SELECT @id = CAST(CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 9999999999) AS BIGINT) AS CHAR(10))
					IF @id NOT IN (SELECT ID FROM ACCOUNT)
						BREAK
				END
			--insert
			PRINT 'INSERT SUCCESS'
			INSERT INTO ACCOUNT VALUES(@id,@type,@username,@password,@ssn)
			RETURN 0;
		END
	RETURN 1;
END

INSERT INTO PERSON VALUES ('191973998','Hoang','Phu','M')
EXEC InsertAccount 'phu@test.com', '071202', 'CUSTOMER', '191973998'

SELECT * FROM ACCOUNT WHERE SSN = '191973998'

SELECT * FROM PERSON

CREATE PROC INSERT_PERSON
@ssn VARCHAR(10), @fname VARCHAR(33), @lname VARCHAR(33), @gender VARCHAR(2)
AS
BEGIN
	--check ssn in database
	IF @ssn IN (SELECT SSN FROM PERSON)
		RETURN 0;
	INSERT INTO PERSON VALUES (@ssn,@fname,@lname,@gender);
	RETURN 1;
END;

EXEC INSERT_PERSON '191973991','Hien','Hien','F'

SELECT * FROM PERSON

SELECT * FROM ACCOUNT