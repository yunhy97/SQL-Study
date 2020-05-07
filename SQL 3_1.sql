--å ������ �����ϴ� ���̺� �����ϱ�
create table sample_books(
    book_no             number(6,0) primary key,
    book_title          varchar2(500) not null,
    book_writer         varchar2(200) not null,
    book_genre          varchar2(200) not null,
    book_publisher      varchar2(200) not null,
    book_price          number(7,0) not null,
    book_discount_price number(7,0) not null,
    book_registered     date 
);

--�Ϸù�ȣ�� �����ϴ� ������ �����ϱ�, �տ� ��ȣ���� �ϳ� �� ū ���� ���
create sequence sample_book_seq start with 10000;

select sample_book_seq.nextval from dual;

insert into sample_books
(book_no, book_title, book_writer, book_genre, book_publisher, book_price, book_discount_price, book_registered)
values
(sample_book_seq.nextval, '�ڹ��� ����', '���ü�', 'IT','�������ǻ�',30000, 27000,sysdate);

--�� ������ �����ϴ� ���̺� �����ϱ�
create table sample_book_users (
    user_id varchar2(50) primary key,
    user_password varchar2(50) not null,
    user_name varchar2(100) not null,
    user_email varchar2(256) not null,
    user_point number(10,0),
    user_registered_date date 
);

create table sample_book_orders(
    order_no number(6,0) primary key,                               --�ֹ���ȣ
    user_id varchar2(50) references sample_book_users (user_id),    --�ֹ��� ���̵�
    book_no number(6,0) references sample_books (book_no),          --�ֹ����� ��ȣ
    order_price number(7,0),                                        --���Ű���
    order_amount number(3,0),                                       --���ż���
    order_registered_date date                                      --�ֹ���¥
);

--�ֹ���ȣ �߻��� ����
create sequence sample_order_seq start with 500000;

--����� ���
insert into sample_book_users (user_id, user_password, user_name, user_email, user_point, user_registered_date)
values 
('hong','zxcv1234','ȫ�浿','hong@gmail.com',1000,sysdate);

--
insert into sample_book_orders (order_no, user_id, book_no, order_price, order_amount, order_registered_date)
values
(sample_order_seq.nextval, 'hong', 10003, 27000, 2, sysdate);

commit;








