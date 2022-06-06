/*
CREATE FUNCTION CheckNumberOfSSN(@ssn NUMERIC(9))
RETURNS BIT
AS
BEGIN 
	IF (@ssn > 99999999 AND @ssn < 1000000000)
	BEGIN 
		RETURN 1
	END
	RETURN 0
END
GO


DECLARE @ssn varchar(9)
SET @ssn = 'zzzz'
PRINT @ssn
IF ((@ssn) like '[a-z]*')
BEGIN
	PRINT 'HI'
END
*/

DECLARE @test char(9)
set @test = '123456789'
if (@test = '123456789')
begin 
	print 'HI'
end


CREATE PROC InsertPerson @ssn CHAR(9), @fname text, @lname text, @gen char(1)
AS
	-- Check the len of the ssn value
	IF NOT ((@ssn) LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' and Len(@ssn) = 9)
	BEGIN
		PRINT 'Invalid SSN.'
		RETURN -1
	END

	-- Check duplicated ssn
	IF EXISTS (SELECT * FROM PERSON WHERE PERSON.SSN = @ssn)
	BEGIN 
		PRINT 'Duplicate SSN id. Cannot insert Person'
		RETURN -1
	END

	-- Check invalid gender
	IF NOT (@gen = 'F' or @gen = 'M')
	BEGIN
		PRINT 'Invalid Gender.'
		RETURN -1
	END

	INSERT INTO PERSON 
	values	(@ssn, @fname, @lname, @gen);
	RETURN 1
GO

DROP PROC IF EXISTS InsertPerson;

DECLARE @isSuccess int
EXEC @isSuccess = InsertPerson @ssn = '123456789', @fname = 'Nguyen1', @lname = 'Truong', @gen = 'F';
IF (@isSuccess = 1)
BEGIN
	PRINT 'HI'
END
ELSE 
BEGIN
	PRINT 'SHIT'
END


/*
IF EXISTS (SELECT * FROM PERSON WHERE PERSON.SSN = 123456789)
BEGIN 
	PRINT 'There is a Nguyen in DB.'
	DELETE FROM PERSON WHERE SSN = 123456789;
END
ELSE 
BEGIN
	PRINT 'There no Nguyen at all.'
END
*/