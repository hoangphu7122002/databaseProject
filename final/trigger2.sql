CREATE or ALTER TRIGGER Derrived_salary ON EMPLOYEE
AFTER INSERT AS
BEGIN
    DECLARE @cnt INT
    SET @cnt = 1
    DECLARE @ssn CHAR(9), @exp TINYINT
    DECLARE @salary BIGINT
    WHILE 0=0
    BEGIN
        IF @cnt in (select E_IDX FROM EMPLOYEE)
        BEGIN
            SET @ssn = (SELECT SSN FROM inserted WHERE E_IDX = @cnt)
            SET @exp = (SELECT EXP FROM inserted WHERE E_IDX = @cnt)
            IF @exp = 1
            BEGIN 
                SET @salary = 1000
            END
            ELSE IF @exp = 2
            BEGIN
                SET @salary = 2000
            END
            ELSE 
            BEGIN 
                SET @salary = 4000
            END
    
            IF exists (SELECT SuperSSN FROM inserted WHERE E_IDX = @cnt and SuperSSN is not null)
            BEGIN
                SET @salary = @salary - 100
            END
    
            IF @ssn in (select SuperSSN FROM employee WHERE SuperSSN is not null)
            BEGIN
                DECLARE @supervisee INT = 0;
                SET @supervisee = (SELECT COUNT(SSN) FROM EMPLOYEE GROUP BY(SuperSSN) 
                                    HAVING SuperSSN = @ssn)
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
GO

SELECT * FROM EMPLOYEE
INSERT INTO PERSON(SSN, FirstName, LastName, Gender) VALUES ('123456789','dac','loc','M')
INSERT INTO EMPLOYEE(SSN, EID, DateBegin, EXP) VALUES ('123456789', '2010396', '2022-06-12', 4)
SELECT * FROM EMPLOYEE

DELETE FROM EMPLOYEE WHERE SSN = '123456789'

--------------------------------------------
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
-- Check the employee with the ssn is not a superssn
GO

SELECT * FROM EMPLOYEE
DELETE FROM EMPLOYEE WHERE SSN = '571938356'
SELECT * FROM EMPLOYEE
