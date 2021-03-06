DROP FUNCTION IF EXISTS GET_RATIO_FROM_SSN
DROP FUNCTION IF EXISTS COST_FOR_CUSTOMER_SEND
DROP FUNCTION IF EXISTS COST_ORDER
DROP FUNCTION IF EXISTS EVAL_SERVICE

create or alter function EVAL_SERVICE(@type varchar(8))
returns nvarchar(100)
with inline=off
begin
    -- validate the service
    if @type not in ('NORMAL','EXPRESS','DISCOUNT')
        return 'SERVICE IS NOT AVAILABLE'

    declare @res real 
    set @res = (select AVG(rate) 
    from (CUSTOMER_SEND join corder on CUSTOMER_SEND.SSN = corder.SSN_CS) 
    where SERVICE =  @type group by service)
    	
    if @res <= 2
        return N'THE SERVICE IS BAD'
    else if @res = 3
        return N'THE SERVICE IS NORMAL'
    else if @res >= 4
        return N'THE SERVICE IS GOOD'
    
    return N'THE SERVICE HAS NOT BEEN USED'
end
go

SELECT dbo.EVAL_SERVICE('DISCOUNT') AS RESPOND
SELECT dbo.EVAL_SERVICE('EXPRESS') AS RESPOND
SELECT dbo.EVAL_SERVICE('FREE') AS RESPOND

--------------------------------------------------------------
CREATE OR ALTER FUNCTION GET_RATIO_FROM_SSN(@ssn VARCHAR(10))
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
END
GO

CREATE OR ALTER FUNCTION COST_ORDER (@add_cr VARCHAR(64), @o_id VARCHAR(11))
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
            BREAK;
    END
    RETURN @cost;
END
GO

CREATE OR ALTER FUNCTION COST_FOR_CUSTOMER_SEND(@ssn VARCHAR(10))
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
            BREAK;
    END
    
    RETURN @cost * @ratio
END
GO

SELECT dbo.COST_ORDER('CAN THO','3403032743') AS COST
SELECT dbo.COST_FOR_CUSTOMER_SEND('182835988') AS TOTAL_COST

