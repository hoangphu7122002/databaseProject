create table parrent(
	num int primary key
);

create table child1(
	num int primary key references parrent(num)
	on delete cascade
	on update cascade
);

create table child2(
	num int primary key references parrent(num)
	on delete cascade
	on update cascade
);

create table grandchild(
	n1 int references child1(num)
	on delete cascade
	on update cascade
	,
	n2 int references child2(num)
	on delete cascade
	on update cascade
);

drop table if exists child1;
drop table if exists child2;
drop table if exists grandchild;
drop table if exists parrent;

create trigger DELETE_person
	on dbo.PERSON
	instead of delete
as
begin
	set nocount on;
	DELETE from CUSTOMER_RECEIVE WHERE SSN IN (SELECT SSN FROM deleted)
	DELETE from CUSTOMER_SEND WHERE SSN IN (SELECT SSN FROM deleted)
	DELETE from EMPLOYEE WHERE SSN IN (SELECT SSN FROM deleted)
	DELETE from DRIVER WHERE SSN IN (SELECT SSN FROM deleted)
	DELETE from PERSON_MAIL WHERE SSN IN (SELECT SSN FROM deleted)
	DELETE from PERSON_PHONE WHERE SSN IN (SELECT SSN FROM deleted)
	DELETE from ACCOUNT WHERE SSN IN (SELECT SSN FROM deleted)
	DELETE FROM PERSON WHERE SSN IN (SELECT SSN FROM deleted)
end
GO

CREATE TRIGGER DELETE_drives
	ON dbo.DRIVES
	
select * from person

create trigger DELETE_Person
	on 
USE DRIVER_SERVICE
select * from CORDER order by o_idx 
select * from package
select count(P_idx) as NumberofPackage, ORDERID from Package group by (orderid)
delete from CORDER where ssn_cr = '215040471'
SELECT * FROM PACKAGE WHERE ORDERID = '0834219676'

select * from account
delete from account where ssn = '340747318'
SELECT * FROM CUSTOMER_SEND WHERE SSN = '658299807'
SELECT * FROM CUSTOMER_RECEIVE WHERE SSN = '340747318'
--843659624

use master

create table test(
	n1 int,
	n2 int,
	n3 int default 0
)

alter trigger insert_test on test
instead of insert as
begin
	DECLARE @exp int
	set @exp = (select n2 from inserted)
	if @exp > 0
	begin
		print 'Greater than 0'
		update test
		set n3 = 100
		where n2 = @exp
	end
	else 
	begin
		print 'Lower or equal than 0'
		update test
		set n3 = -100
		where n2 = @exp
	end
end

insert into test (n1,n2)
values (5,2)

select * from test


if exists (select (n1) from test where n1 = 5)
begin
	print 'shiet'
end

use master

create table [dbo].[TableA]
(
ID integer not null,
TotalQty integer not null,
Date Date not null
)
go
create table [dbo].[TableB]
(
ID integer not null,
OrderQty nvarchar(10) not null,
Date Date not null
)
go

CREATE TRIGGER [dbo].[InsertFromAToB]
ON [dbo].[TableA]
AFTER  INSERT
AS
BEGIN
Declare @counter as integer;
set @counter=1;
Declare @qty as integer;
set @qty = (Select TotalQty from inserted);
    While(@counter <= @qty)
    Begin
        Insert into TableB(ID,OrderQty,Date) select ID,(CONVERT(nvarchar(10),@counter) + ' of ' + Convert(nvarchar(10),@qty)) as OrderQty,Date From inserted
        set @counter=@counter+1;
    END
END

insert into TableA
values 
(1,2,GETDATE()),
(2,2,GETDATE()),
(3,2,GETDATE()),
(4,2,GETDATE()),
(5,2,GETDATE()),
(6,2,GETDATE());


select * from TableA
select * from TableB