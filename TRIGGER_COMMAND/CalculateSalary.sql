use DRIVER_SERVICE;
go 

CREATE or ALTER TRIGGER Derrived_salary ON EMPLOYEE
AFTER INSERT AS
BEGIN
	DECLARE @cnt INT
	SET @cnt = 1
	DECLARE @ssn CHAR(9), @exp TINYINT
	DECLARE @salary BIGINT
	WHILE 0=0
	BEGIN
		IF @cnt in (select E_IDX FROM inserted)
		BEGIN
				SET @ssn = (SELECT SSN FROM inserted WHERE E_IDX = @cnt)
				SET @exp = (SELECT EXP FROM inserted WHERE E_IDX = @cnt)
				IF @exp = 1
				BEGIN 
					SET @salary = 1000
				end
				else IF @exp = 2
				BEGIN
					SET @salary = 2000
				end
				else 
				BEGIN 
					SET @salary = 4000
				end

				IF exists (SELECT SuperSSN FROM inserted WHERE E_IDX = @cnt and SuperSSN is not null)
				BEGIN
					SET @salary = @salary - 100
				END

				IF @ssn in (select SuperSSN FROM employee WHERE SuperSSN is not null)
				BEGIN
					DECLARE @supervisee INT = 0;
					SET @supervisee = (SELECT COUNT(SSN) FROM EMPLOYEE GROUP BY(SuperSSN) HAVING SuperSSN = @ssn)
					SET @salary = @salary + 100*@supervisee
				END

				UPDATE EMPLOYEE 
				SET SALARY = @salary
				WHERE SSN = @ssn

				SET @cnt = @cnt + 1
		END
		ELSE
		BEGIN
			BREAK
		END
	END
END
-- select * from employee
-- delete from employee
/*
---EMPLOYEE---
*/
