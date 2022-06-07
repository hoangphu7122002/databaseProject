use DRIVER_SERVICE

select * from person

delete from person where person.ssn = '087472489'

select * from account where account.ssn = '087472489'

create TABLE test(
num int,
numx int identity(1,1)
);

alter table test 
alter column num int not null;

ALTER TABLE test


alter table test add constraint PK_Test primary key(num);

insert into test
values (1)

insert into test
values (2)

insert into test
values (3)

create table test2 (
t2num int
foreign key (t2num) references test(num)
on delete cascade
on update cascade
);

alter table test2 add constraint FK_t2num2
foreign key (t2num) references test(num)
on delete cascade
on update cascade

select * from test2

insert into test2
values (3)

drop table test2

delete from test where num = 3

update test set num = 100 where num = 3

drop table test2

drop table test

/*

SELECT * FROM
					(SELECT CUSTOMER_SEND.SSN, PRICE_RATIO.RATIO
					FROM CUSTOMER_SEND
					JOIN PRICE_RATIO ON CUSTOMER_SEND.SERVICE = PRICE_RATIO.SERVICE_CUSTOMER) 
				AS TEMP WHERE TEMP.SSN = 182835988;

create TABLE test(
num int,
numx int identity(1,1)
);

drop table test

insert into test
values (2)

select * from test
*/