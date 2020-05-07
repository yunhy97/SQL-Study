--Ʈ����� ó��
insert into sample_book_users                       --Ʈ�����1 ����
(user_id, user_password, user_name, user_email)
values
('tla123', 'zxcv1234', '�ɶ���', 'tla123@gmail.com');

update sample_book_users
set user_point = 1000
where user_id = 'tla123';

savepoint add_new_user;                             --�������� ����

insert into sample_book_orders
(order_no, user_id, book_no, order_price, order_amount)
values
(sample_order_seq.nextval, 'tla123', 10011, 24800, 3);

update sample_book_users
set user_point = user_point + trunc(24800*3*0.03)
where user_id = 'tla123';

commit;                           --���� Ʈ������� ���� ������ ����, ���� Ʈ����� ����, ��Ʈ����� ����

--DML1 �۾�
--DML2 �۾�
--DML3 �۾�

rollback;                         --���� ���۵� Ʈ������� ���泻��(DML1~3)�� ����, Ʈ����� ����, �� Ʈ����� ����

select rowid, user_id, user_name
from sample_book_users;

--�Ͻ���� ���� �亯 �Խ���
--��ȣ, ����, �ۼ���, ����, ��ȸ��, �ۼ���, ����(�亯�ϷῩ��),��������
--number, varchar2,varchar2, varchar2, number, date, char, varchar2
create table sample_book_questions (
    question_no                 number(7,0) primary key,
    question_title              varchar2(500) not null,
    user_id                     varchar2(50) references sample_book_users(user_id),
    question_content            varchar2(4000) not null,
    question_view_count         number(7,0) default 0,
    question_registered_date    date   default sysdate,
    question_status             char(1) default 'N',
    question_type               varchar2(200) not null
);

--�Ͻ���� �亯 �Խ���
--��ȣ, ����, �ۼ���, ���Ǳ� ��ȣ
--number, varchar2, date, number
create table sample_bookstore_answers (
    answer_no               number(7,0)     primary key,
    answer_content          varchar2(4000)  not null,
    answer_registered_date  date            default sysdate,
    question_no             number(7,0)     references sample_book_questions(question_no)
);

--���̺� �̸� �����ϱ�
rename sample_bookstore_answers to sample_book_answers;

--����/�亯 �Խ��ǿ� �Ϸù�ȣ ������ �����
create sequence sample_question_seq start with 1000000 nocache;
create sequence sample_answer_seq start with 1000000 nocache;

commit;




