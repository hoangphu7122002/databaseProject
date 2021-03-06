USE DRIVER_SERVICE

CREATE or alter FUNCTION GET_RATIO_FROM_SSN(@ssn VARCHAR(10))
RETURNS REAL
AS
BEGIN
	DECLARE @ratio REAL
	SET @ratio = (SELECT TEMP.RATIO FROM
					(SELECT CUSTOMER_SEND.SSN, PRICE_RATIO.RATIO
					FROM CUSTOMER_SEND
					JOIN PRICE_RATIO ON CUSTOMER_SEND.SERVICE = PRICE_RATIO.SERVICE_CUSTOMER) 
				AS TEMP WHERE TEMP.SSN = @ssn)
	RETURN @ratio;
END;

CREATE or alter FUNCTION COST_FOR_CUSTOMER_SEND(
	@ssn VARCHAR(10)
)
RETURNS REAL
AS
BEGIN
	--CHECK SSN
	IF LEN(@ssn) <> 9 OR @ssn NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
		RETURN -1.0
	ELSE IF @ssn NOT IN (SELECT SSN FROM PERSON) 
		RETURN -1.0
	--QUERY
	--1-N CUSTOMER SEND -> RETRIEVE SERVICE_RATIO;
	DECLARE @ratio REAL
	SET @ratio = (SELECT dbo.GET_RATIO_FROM_SSN(@ssn))
	--1-N CUSTOMER RECEIVE -> RETRIVE ADDRESS_RECEIVE;
	DECLARE @cost REAL = 0.0;
	DECLARE @cnt INT = 1;

	DECLARE @o_id VARCHAR(10) = ''; --DETERMINE PACKAGE ID
	DECLARE @ssn_cr VARCHAR(9) = '';
	DECLARE @add_cr VARCHAR(64) = '';
	DECLARE @cost_cnt REAL = 0.0;

	WHILE 0=0
	BEGIN
		IF @cnt in (SELECT O_IDX FROM CORDER) 
		BEGIN
			SET @o_id = (SELECT ORDERID FROM CORDER WHERE O_IDX = @cnt);
			SET @ssn_cr = (SELECT SSN_CR FROM CORDER WHERE O_IDX = @cnt);
			--1-N CUSTOMER_RECEIVE -> RETRIEVE ADDRESS_RECEIVE
			SET @add_cr = (SELECT ADDRESS FROM CUSTOMER_RECEIVE WHERE SSN = @ssn_cr)
			--GET DISTANCE FROM ADRRESS RECEIVE
			SET @cost_cnt = (SELECT dbo.COST_ORDER(@add_cr,@o_id)) 
			SET @cost = @cost + @cost_cnt 
				
			SET @cnt = @cnt + 1;
		END
		ELSE
			BREAK
	END;
	
	RETURN @cost * @ratio
END;

CREATE or alter FUNCTION COST_ORDER (@add_cr VARCHAR(64), @o_id VARCHAR(11))
RETURNS REAL
BEGIN
	IF LEN(@o_id) <> 10 OR @o_id NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
		RETURN -1.0;
	IF @o_id NOT IN (SELECT ORDERID FROM CORDER)
		RETURN -1.0;
	IF @add_cr NOT IN (SELECT PROVINCE FROM KILOMETER_DISTANCE)
		RETURN -1.0;
	DECLARE @distance_cr INT = 0;
	SET @distance_cr = (SELECT DISTANCE FROM KILOMETER_DISTANCE WHERE PROVINCE = @add_cr);
	DECLARE @cost REAL = 0.0;
	DECLARE @cnt INT = 1;
	DECLARE @oid VARCHAR(10) = '';
	DECLARE @location VARCHAR(64) = '';
	DECLARE @distance_cs INT = '';
	DECLARE @weight FLOAT = 0.0;
	WHILE 0 = 0

	BEGIN
		IF @cnt in (SELECT P_IDX FROM PACKAGE) 
		BEGIN
			--get o_id to check @o_id
			SET @oid = (SELECT ORDERID FROM PACKAGE WHERE P_IDX = @cnt)
			IF @o_id <> @oid
				--get location
				SET @cnt = @cnt + 1;
			ELSE
				BEGIN
					SET @location = (SELECT LOCATION FROM PACKAGE WHERE ORDERID = @o_id AND P_IDX = @cnt)
					SET @distance_cs = (SELECT DISTANCE FROM KILOMETER_DISTANCE WHERE PROVINCE = @location);
					SET @weight = (SELECT PWEIGHT FROM PACKAGE WHERE P_IDX = @cnt AND ORDERID = @oid)
				
					SET @distance_cs = ABS(@distance_cr - @distance_cs) * @weight
					SET @cost = @cost + @distance_cs
					SET @cnt = @cnt + 1;
				END
		END
		ELSE
			BREAK
	END;
	RETURN @cost;
END


SELECT dbo.COST_ORDER('CAN THO','3403032743') AS COST
SELECT dbo.COST_FOR_CUSTOMER_SEND('182835988') * 50


/*
--t??nh l????ng c???a nh??n vi??n v??n ph??ng
CREATE FUNCTION GET_SALARY_EMPLOYEE
(@ssn VARCHAR(10))
RETURNS BIGINT
BEGIN
	--check format ssn
	IF LEN(@ssn) <> 9 OR @ssn NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
		RETURN -1.0
	ELSE IF @ssn NOT IN (SELECT SSN FROM EMPLOYEE) 
		RETURN -1.0
	--supervisor
	DECLARE @exp TINYINT;
	SET @exp = (SELECT EXP FROM EMPLOYEE WHERE SSN = @ssn);
	DECLARE @salary BIGINT = 0;
	SET @salary = (SELECT SALARY FROM SALARY_BILL WHERE EXP = @exp)
	IF @ssn IN (SELECT SuperSSN FROM EMPLOYEE WHERE SuperSSN IS NOT NULL)
	BEGIN
		DECLARE @supervisee INT = 0;
		SET @supervisee = (SELECT COUNT(SSN) FROM EMPLOYEE GROUP BY(SuperSSN) HAVING SuperSSN = @ssn)
		
		RETURN @salary + @supervisee * 100
	END
	ELSE IF (SELECT SuperSSN FROM EMPLOYEE WHERE SSN = @ssn) IS NULL
		RETURN @salary
	--supervisee
	RETURN @salary - 100
END

SELECT dbo.GET_SALARY_EMPLOYEE('691463675') AS SALARY

CREATE FUNCTION GET_SALARY_DRIVER
(@ssn VARCHAR(10))
RETURNS BIGINT
BEGIN
	--check format ssn
	IF LEN(@ssn) <> 9 OR @ssn NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
		RETURN -1.0
	ELSE IF @ssn NOT IN (SELECT SSN FROM DRIVER) 
		RETURN -1.0
	--supervisor
	DECLARE @exp TINYINT;
	SET @exp = (SELECT EXP FROM DRIVER WHERE SSN = @ssn);
	DECLARE @salary BIGINT = 500;
	
	IF @exp > 7
		SET @salary = @salary + 200;
	ELSE IF @exp > 3
		SET @salary = @salary + 100;
	RETURN @salary;
END

SELECT dbo.GET_SALARY_DRIVER('329535850') AS SALARY
SELECT dbo.GET_SALARY_EMPLOYEE('691463675')
*/

-- Find the Employee average rating point
create or alter function AVE_RP(@eid char(8))
returns real
begin 
	-- TODO: VALIDATE THE EID
	IF LEN(@eid) <> 7 OR @eid NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
		RETURN -1.0;
	IF @eid in (SELECT EID FROM (EMPLOYEE JOIN CORDER ON EMPLOYEE.SSN = CORDER.SSN_EMP))
	begin
		Declare @num real
		declare @temp int
		set @temp = (select count(orderid) from (EMPLOYEE JOIN CORDER ON EMPLOYEE.SSN = CORDER.SSN_EMP) where EID = @eid)
		set @num = cast(@temp as real)
		set @temp = (select sum(RATE) from (EMPLOYEE JOIN CORDER ON EMPLOYEE.SSN = CORDER.SSN_EMP) where EID = @eid)
		DECLARE @AP real
		set @AP = cast(@temp as real)
		return cast ((@AP/@num) as real)
		return 1.0
	end
	return 0
end

select dbo.AVE_RP('2010025')
