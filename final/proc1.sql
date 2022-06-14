CREATE or alter PROC InsertAccount 
@username VARCHAR(33), @password VARCHAR(33), @type VARCHAR(9), @ssn VARCHAR(10)
AS
BEGIN
    IF LEN(@ssn) <> 9 OR @ssn NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
        PRINT 'INVALID FORMAT SSN';
    ELSE IF @ssn NOT IN (SELECT SSN FROM PERSON) 
        PRINT 'SSN not in database';
    ELSE IF LEN(@username) > 32 OR @username NOT LIKE '%_@test.com'
        PRINT 'INVALID USERNAME';
    ELSE IF LEN(@password) > 32
        PRINT 'INVALID PASSWORD';
    ELSE IF @type NOT IN ('EMPLOYEE','DRIVER','CUSTOMER')
        PRINT 'INVALID TYPE';
    ELSE
        BEGIN
            --generate id
            DECLARE @id CHAR(10)
            WHILE (0 = 0)
                BEGIN
                    SELECT @id = CAST(CAST(FLOOR(RAND(CHECKSUM(NEWID())) * 9999999999) 
                    AS BIGINT) AS CHAR(10))
                    IF @id NOT IN (SELECT ID FROM ACCOUNT)
                        BREAK
                END
        PRINT 'INSERT SUCCESS'
        INSERT INTO ACCOUNT VALUES(@id,@type,@username,@password,@ssn)
        END
END
GO

DELETE FROM PERSON WHERE SSN = '191973998'

INSERT INTO PERSON VALUES ('191973998','Hoang','Phu','M')
EXEC InsertAccount 'phu@test.com', '071202', 'CUSTOMER', '191973998'

INSERT INTO PERSON VALUES ('191973999','Hoang','Phu','M')
EXEC InsertAccount 'test.com', '0123', 'EMPLOYEE', '191973999'
--SELECT * FROM ACCOUNT WHERE SSN = '191973998'

------------------------------------
CREATE or alter PROC UpdateAccount
@username VARCHAR(33), @password VARCHAR(33), @newPassword VARCHAR(32)
AS
BEGIN
	IF LEN(@username) > 32 OR LEN(@password) > 32
		PRINT 'Invalid format User name or Password';
	ELSE IF @username NOT IN (SELECT UserName FROM ACCOUNT) 
		PRINT 'User name is not in database';

	DECLARE @isRightPass INT = 0

	SELECT @isRightPass = COUNT(*) FROM ACCOUNT WHERE UserName = @username AND PASS = @password
	IF (@isRightPass = 1)
	BEGIN 
		IF (@newPassword != '')
			BEGIN
				PRINT 'UPDATE SUCESS';
				UPDATE ACCOUNT SET PASS = @newPassword WHERE UserName = @username
			END
		ELSE 
			PRINT 'Invalid new Password';
	END
	ELSE
		PRINT 'Incorrect Password';
END
GO

EXEC UpdateAccount  @username = '5763894824_EE@test.com' , @password = '8335562165', @newPassword = '071202'

EXEC UpdateAccount  @username = '5763894824_EE@test.com' , @password = '833556216', @newPassword = '071202'

-----------------------------------
CREATE or alter PROC DeleteAccount
@id VARCHAR(11)
AS
BEGIN
	IF LEN(@id) <> 10 OR @id NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
		PRINT 'Invalid format ID';
	ELSE IF @id NOT IN (SELECT ID FROM ACCOUNT) 
		PRINT 'Account is not in database';
	ELSE 
		PRINT 'DELETE SUCESS';
		DELETE FROM ACCOUNT WHERE ID = @id;
END
GO

EXEC DeleteAccount '9857623404'

EXEC DeleteAccount '9857623402'