-- TRIGGER TO DELETE PERSON THAT WHO RELATED TO THE ACCOUNT
CREATE TRIGGER trigger_deleteAccount ON ACCOUNT AFTER DELETE AS
BEGIN
	DECLARE @ssn char(9)
	set @ssn = (select ssn from deleted )
	--print @ssn
	if @ssn in (select ssn from CUSTOMER_RECEIVE)
	BEGIN
		--PRINT 'CUSTOMER_RECEIVE'
		DELETE FROM CUSTOMER_RECEIVE WHERE SSN = @ssn
	END
	ELSE IF @ssn in (select ssn from CUSTOMER_SEND)
	BEGIN
		--PRINT 'CUSTOMER_SEND'
		DELETE FROM CUSTOMER_SEND WHERE SSN = @ssn
	END
	ELSE IF @ssn in (SELECT ssn from employee)
	begin
		--print 'EMPLOYEE'
		DELETE FROM EMPLOYEE WHERE SSN = @ssn
	end
	ELSE IF @ssn in (SELECT ssn from driver)
	begin 
		--print 'DRIVER'
		DELETE FROM DRIVER WHERE SSN = @ssn
	end
END