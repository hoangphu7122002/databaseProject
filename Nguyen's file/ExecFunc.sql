use DRIVER_SERVICE

select * from person

delete from person where person.ssn = '087472489'

select * from account where account.ssn = '351524229'

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
);


select * from test2

insert into test2
values (3)

drop table test2
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

select * into t1 from (product_table join order_table on product_table.product_cate_id = order_table.product_cate_id);

select * into t2 from (order_table join user_table on order_table.user_id = user_table.user_id);

select sum(order_value) as total_order_value 
from t1 join t2 on t1.user_id = t2.user_id
group by user_segment, product_cate_name;