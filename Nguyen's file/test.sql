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