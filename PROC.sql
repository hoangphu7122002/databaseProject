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

CREATE PROC UpdateAccount
@username VARCHAR(32), @password VARCHAR(32), @newPassword VARCHAR(32)
AS
BEGIN
	DECLARE @isRightPass INT = 0

	SELECT @isRightPass = COUNT(*) FROM ACCOUNT WHERE UserName = @username AND PASS = @password
	IF (@isRightPass = 1)
	BEGIN 
		IF (@newPassword != NULL AND @newPassword != '')
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

EXEC UpdateAccount  @username = '5763894824_EE@test.com' , @password = '8335562165', @newPassword = '';

SELECT * FROM ACCOUNT;

