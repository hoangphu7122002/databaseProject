-- Find the Employee average rating point
create function AVE_RP(@eid char(8))
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

use driver_service
create or alter function EVAL_RP(@type varchar(8))
returns nvarchar(100)
with inline=off
begin
	-- check the service
	IF @type not in (SELECT * FROM SERVICE_TYPE)
	begin 
		return 'SERVICE IS NOT AVAILABLE'
	end
	declare @res real 
	set @res = (select AVG(rate) from (CUSTOMER_SEND join corder on CUSTOMER_SEND.SSN = corder.SSN_CS) where SERVICE =  @type group by service)
	
	if @res <= 2
	begin
		return N'THE SERVICE IS BAD'
	end
	else if @res = 3
	begin
		return N'THE SERVICE IS NORMAL'
	end
	else if @res >= 4
		return N'THE SERVICE IS GOOD'
	
	return N'THE SERVICE HAS NOT BEEN USED'
end

(select dbo.EVAL_RP('EXPRESSs') as respond)

