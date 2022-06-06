USE DRIVER_SERVICE;

SELECT * FROM ACCOUNT;

UPDATE ACCOUNT
SET ID = '9999999999',ATYPE = 'ADMIN', UserName = 'root@test.com', PASS = '0123456789' 
WHERE ID = '9873246566'

SELECT CONVERT(VARCHAR,PERSON.FirstName) + ' ' + CONVERT(VARCHAR,PERSON.LastName) FROM PERSON,ACCOUNT WHERE ACCOUNT.USERNAME = 'root@test.com' AND ACCOUNT.SSN = PERSON.SSN;
SELECT * FROM PERSON

DROP PROC GET_DISPLAY_NAME
CREATE PROC GET_DISPLAY_NAME
@username VARCHAR(32)
AS
BEGIN
	SELECT CONVERT(VARCHAR,PERSON.FirstName) + ' ' + CONVERT(VARCHAR,PERSON.LastName) AS NAME FROM PERSON,ACCOUNT WHERE ACCOUNT.UserName LIKE @username AND ACCOUNT.SSN = PERSON.SSN;
END;
GO

EXEC GET_DISPLAY_NAME 'root@test.com'

SELECT * FROM EMPLOYEE;

SELECT * FROM ACCOUNT

SELECT * FROM CORDER

ALTER PROC GET_PACKAGE_FROM_ORDERID 
@orderid VARCHAR(10)
AS
BEGIN
	SELECT * FROM PACKAGE WHERE ORDERID = @orderid;
END

EXEC GET_PACKAGE_FROM_ORDERID '0469707344'