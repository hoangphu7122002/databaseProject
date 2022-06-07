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