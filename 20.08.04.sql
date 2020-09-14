create table spring_categories(
    category_id varchar2(100) primary key,
    category_name varchar2(200) not null
);
insert into spring_categories values('디지털','디지털제품');
insert into spring_categories values('생활가전','대형/생활가전');
insert into spring_categories values('가구','가구/침구/인테리어');
insert into spring_categories values('주방','조리/식탁/주방용품');
insert into spring_categories values('유아동','유아/아동/완구/애완용품');
insert into spring_categories values('의류','의류/가방/악세사리/잡화');

commit;

create table spring_products(
    product_no number(10) primary key,
    category_id varchar2(100) references spring_categories(category_id),
    product_name varchar2(500) not null,
    product_price number(10) not null,
    product_discount_price number(10) not null,
    produdct_stock number(10) default 100,
    product_created_date date default sysdate
);

create sequence spring_product_seq;

commit;
-----------------------------------------------------------
create table spring_orders (
    order_no number(10) primary key,
    order_username varchar2(100) not null,
    order_tel varchar2(20) not null,
    order_status varchar2(100) default '결제완료',
    order_created_date date default sysdate
);

create table spring_order_items (
    item_no number(10) primary key,
    order_no number(10) references spring_orders (order_no),
    product_no number(10) references spring_products (product_no),
    item_price number(10) not null,
    item_amount number(5) not null
);

create table spring_order_payments(
    pay_no number(10) primary key,
    pay_type varchar2(100) not null,
    pay_account varchar2(100) not null,
    order_no number(10) references spring_orders (order_no)
);

create table spring_order_delivery(
    delivery_no number(10) primary key,
    delivery_username varchar2(100) not null,
    delivery_tel varchar2(30) not null,
    delivery_address varchar2(500) not null,
    delivery_status varchar2(40) default '물품준비중',
    order_no number(10) references spring_orders (order_no)
);

create sequence spring_order_seq;