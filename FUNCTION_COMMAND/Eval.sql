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
go

--(select dbo.EVAL_RP('EXPRESSs') as respond)
