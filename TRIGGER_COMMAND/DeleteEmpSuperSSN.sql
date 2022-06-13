use DRIVER_SERVICE
go

CREATE or ALTER TRIGGER NULL_WHEN_DELETE_SUPERSSN on EMPLOYEE
INSTEAD OF DELETE
AS
BEGIN
	DECLARE @ssn CHAR(9)
	set @ssn = (select ssn from deleted)
	IF @ssn in (select superssn from employee)
	begin
		update employee 
		set SuperSSN = NULL
		WHERE SuperSSN IN (SELECT SSN FROM deleted)
	end
	DELETE FROM EMPLOYEE WHERE SSN IN (SELECT SSN FROM deleted)
END
-- !!Check the employee with the ssn is not a superssn
go
