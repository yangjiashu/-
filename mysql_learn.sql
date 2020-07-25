# 1. 创建数据库
create database mybank;
use mybank;

# 2. 创建数据表
create table customer (
    c_id char(6) primary key not null comment '客户标识',
    c_name varchar(32) not null comment '客户姓名',
    location varchar(32) comment '工作地点',
    salary double(8,2) comment '工资'
);

create table bank (
    b_id char(5) primary key not null comment '银行标识',
    bank_name char(32) comment '银行名称'
);

create table deposite
(
    d_id int auto_increment comment '存款流水号'
        primary key,
    c_id char(6) null comment '客户标示',
    b_id char(5) null comment '银行标识',
    dep_date date null comment '存入日期',
    dep_type int null comment '存款期限',
    amount double(20,2) null comment '存款金额',
    constraint deposite_bank_b_id_fk
        foreign key (b_id) references bank (b_id),
    constraint deposite_customer_c_id_fk
        foreign key (c_id) references customer (c_id)
);

# 3. 录入数据
insert into customer (c_id, c_name, location, salary) values ('101001', '孙杨', '广州', 1234);
insert into customer (c_id, c_name, location, salary) values ('101002', '宋江', '梁山', 5645);
insert into customer (c_id, c_name, location, salary) values ('101003', '马云', '杭州', 8955);
insert into customer (c_id, c_name, location, salary) values ('101004', '鹿晗', '北京', 2356);
insert into customer (c_id, c_name, location, salary) values ('101005', '杨佳澍', '武汉', 4000);

insert into bank (b_id, bank_name) VALUES ('B0001', '工商银行');
insert into bank (b_id, bank_name) VALUES ('B0002', '建设银行');
insert into bank (b_id, bank_name) VALUES ('B0003', '中国银行');
insert into bank (b_id, bank_name) VALUES ('B0004', '农业银行');

INSERT INTO deposite (d_id, c_id, b_id, dep_date, dep_type, amount)
VALUES (1, '101001', 'B0001', '2018-04-05', 3, 50000);

INSERT INTO deposite (d_id, c_id, b_id, dep_date, dep_type, amount)
VALUES (2, '101002', 'B0003', '2018-01-25', 1, 10000);

INSERT INTO deposite (d_id, c_id, b_id, dep_date, dep_type, amount)
VALUES (3, '101003', 'B0002', '2017-06-15', 5, 2000);

INSERT INTO deposite (d_id, c_id, b_id, dep_date, dep_type, amount)
VALUES (4, '101004', 'B0004', '2016-12-14', 10, 20151);

INSERT INTO deposite (d_id, c_id, b_id, dep_date, dep_type, amount)
VALUES (5, '101001', 'B0003', '2015-08-12', 2, 52415);

INSERT INTO deposite (d_id, c_id, b_id, dep_date, dep_type, amount)
VALUES (6, '101002', 'B0001', '2017-11-25', 12, 451515);

INSERT INTO deposite (d_id, c_id, b_id, dep_date, dep_type, amount)
VALUES (7, '101003', 'B0004', '2016-01-16', 5, 4515122);

INSERT INTO deposite (d_id, c_id, b_id, dep_date, dep_type, amount)
VALUES (8, '101004', 'B0002', '2015-12-12', 6, 52545);

INSERT INTO deposite (d_id, c_id, b_id, dep_date, dep_type, amount)
VALUES (9, '101001', 'B0002', '2013-07-08', 3, 524515);

INSERT INTO deposite (d_id, c_id, b_id, dep_date, dep_type, amount)
VALUES (10, '101002', 'B0004', '2014-09-15', 2, 52467);

INSERT INTO deposite (d_id, c_id, b_id, dep_date, dep_type, amount)
VALUES (11, '101003', 'B0003', '2014-02-15', 4, 89596);

INSERT INTO deposite (d_id, c_id, b_id, dep_date, dep_type, amount)
VALUES (12, '101005', 'B0001', '2014-11-26', 10, 1781872);

# 4.更新customer表的salary字段，将salary低于5000的客户的salary变为原来的是2倍
update customer set salary=salary*2 where salary < 5000;

# 5.对deposite表进行统计，按银行统计存款总数，显示b_id,total
select b_id, sum(amount) as total from deposite group by b_id;

# 6.对deposite，customer，bank进行查询，查询条件为location在广州，北京，武汉的客户存款在30000至60000之间的存款记录，显示为客户姓名，银行名称，存款金额。
select c.c_name, b.bank_name, d.amount from
deposite d, (select c_id, c_name from customer where location in ('广州', '北京', '武汉')) c, bank b
where d.c_id = c.c_id and d.b_id = b.b_id and d.amount between 30000 and 60000;

# 7.在deposit表中插入一条记录，字段值自定义
insert into deposite (d_id, c_id, b_id, dep_date, dep_type, amount)
values (13, '101005', 'B0002', '2020-07-25', 10, 12000);

# 8.1 在bank中插入一条记录B0005，银行自定义
insert into bank (b_id, bank_name) VALUES ('B0005', '招商银行');

# 8.2 查询今天到期的存款信息
select * from deposite where dep_date < now();

# 8.3 查询存款金额超过50000且存款期限为3年的存款信息
select * from deposite where dep_type=3 and amount>50000;

# 8.4 查询前三名的存款信息
select * from deposite order by amount desc limit 0,3;

# 8.5 查询孙杨在中国银行的存款信息
select c.c_name, b.bank_name, d.amount
from deposite d, bank b, (select c_id, c_name from customer where c_name='孙杨') c
where d.c_id=c.c_id and d.b_id=b.b_id;