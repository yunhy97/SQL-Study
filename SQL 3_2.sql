--����� ���� ����ϱ�
--��� �÷��� ���� ��������� �����ϱ�
--������ �÷������� �°� ���� �����Ѵ�.
insert into sample_book_users
(user_id, user_password, user_name, user_email, user_point, user_registered_date)
values
('hay', 'zxcv1234', '���Ͽ�','yun@nave.com', 10, sysdate);

--�÷����� ������ ���
--���̺��� �÷������� �°� ���� �����Ѵ�.
insert into sample_book_users
values
('neena','zxcv1234', '�ϳ�', 'nee@gmail.com', 100, sysdate);

--�÷����� ������ ���
--�ݵ�� ���̺��� �÷������� �°� ��� ���� �����ؾ� �Ѵ�.
insert into sample_book_users
values
('ssosso', 'zxcv1234', '�ҿ�����', 'ssosso@gmail.com');  --����, ���� ������.

--������ �÷����� ���� �����ϰ�, �������� null�̳� default���� ����ǰ� �ϱ�
insert into sample_book_users
(user_id, user_password, user_name)
values
('suyoung', 'zxcv1234', '�����');

--�ʼ��Է°��� ������ ���
insert into sample_book_users
(user_id, user_password)
values
('dalchong', 'zxcv1234');  --����

--�÷��� ũ�⺸�� ū ���� �ԷµǴ� ���
insert into sample_book_users
(user_id, user_password, user_name)  --����
values
('dalchong', 'zxcv1234', '����ѹ��ź��̿͵η�̻�õ���ڵ��ڻ����ѹ��ź��̿͵η�̻�õ���ڵ��ڻ����ѹ��ź��̿͵η�̻�õ���ڵ��ڻ�');

--���̺��� �� �����ϱ�
--��� ���� Ư�� �÷����� �����ϱ�(where ���� �����ϸ� �ȴ�.)
--��� ������� ��й�ȣ�� 'zxcv1234'�� �����ϱ�
update sample_book_users
set 
    user_password = 'zxcv1234';
--commit;
--commit�ϰ� �� �� rollback�� �ϸ� ������� �ʴ´�.
--rollback;

--��� ���� Ư�� �÷����� �����ϱ�
--��� �������� �޿��� 500�� �λ��ϱ�
update employees
set
    salary = salary + 500;

--where���� ����ؼ� ���ǽ��� �����ϴ� Ư������ �÷����� �����ϱ�
--90�� �μ��� �Ҽӵ� ������ �޿��� 10000�޷� �λ��Ű��
update employees
set
    salary = salary + 10000
where department_id = 90;

--�� ���� ���� �÷��� ���� �����ϱ�
--10005�� å�� ����, ����, ���ΰ����� �����ϱ�
update sample_books
set
    book_title = '�̰��� �ڹٴ� ������' ,
    book_price = 40000,
    book_discount_price = 38000
where book_no = 10005;

--���������� �̿��ؼ� �� �����ϱ�
--132�� ������ �޿��� �ҼӺμ�(50���μ�)�� ��ձ޿��� �����ϱ�
update employees
set
    salary = (select trunc(avg(salary))
            from employees
            where department_id = 50)
where employee_id=132;

--10�� �μ��� �μ���ȣ�� 300������ �����ϱ�
update departments
set
    department_id = 300
where department_id = 10;  --����, �ڽ����̺�(employees)�� �ڽķ��ڵ� ����

--100�� ����� �ҼӺμ��� 500���� �����ϱ�
update departments
set
    department_id = 500
where employee_id = 100;  --����, �θ����̺�(departments)�� 500�� �μ��� �������� ����

--������(��) �����ϱ�
--���̵� neena�� �� �����ϱ�
delete from sample_book_users
where user_id = 'neena';

create table copy_sample_book_users(
    user_id varchar2(50) primary key,
    user_password varchar2(50) not null,
    user_name varchar2(100) not null,
    user_email varchar2(256),
    user_point number(10,0),
    user_registered_date date 
);

--sample_book_users�� ��� ���� copy_sample_book_users�� �߰��ϱ�
insert into copy_sample_book_users
(user_id,user_password,user_name,user_email,user_point,user_registered_date)
select user_id, user_password, user_name, user_email, user_point, user_registered_date
from sample_book_users;

--�������̺� ���ο� �߰�
insert into sample_book_users
values ('ryu', 'zxcv1234','������','avc123@gmail.com', 10, sysdate);

insert into sample_book_users
values ('kkang', 'zxcv1234','������','kkang111@gmail.com', 100, sysdate);

--�������̺�� ������̺� �����ϱ�
merge into copy_sample_book_users B
      using sample_book_users A
      on (B.user_id = A.user_id)
when matched then
    update set
        B.user_password = A.user_password,
        B.user_name = A.user_name,
        B.user_email = A.user_email,
        B.user_point = A.user_point,
        B.user_registered_date = A.user_registered_date
when not matched then
    insert values
    (A.user_id, A.user_password, A.user_name, 
     A.user_email, A.user_point, A.user_registered_date);

commit;

select a.order_no,b.user_name, c.book_title, c.book_price, a.order_price,a.order_amount, a.order_registered_date
from sample_book_orders a, sample_book_users b, sample_books c
where a.user_id = b.user_id
and a.book_no = c.book_no
and a.order_no = 500000
order by a.order_no desc;

commit;



























