create table sample_users(
    user_id varchar2(20) constraint sample_user_id_pk primary key,
    user_name varchar2(100) not null,
    user_password varchar2(100) not null,
    user_email varchar2(256) not null,
    user_disabled char(1) default 'N',
    user_create_date date default sysdate
);

create table sample_boards(
    board_no number(7) constraint sample_board_no_pk primary key,
    board_title varchar2(500) not null,
    board_writer varchar2(20) not null,
    board_content varchar2(4000) not null,
    board_hit number(7) default 0,
    board_reply_cnt number(5) default 0,
    board_del_yn char(1) default 'N',
    board_create_date date default sysdate,
    constraint sample_board_writer_fk foreign key (board_writer) references sample_users(user_id)
);

create table sample_replys (
    reply_no number(7) constraint sample_reply_no_pk primary key,
    reply_writer varchar2(20) not null,
    reply_content varchar2(2000) not null,
    reply_del_yn char(1) default 'N',
    reply_create_date date default sysdate,
    constraint sample_reply_writer_fk foreign key (reply_writer) references sample_users(user_id)
);

create SEQUENCE board_seq nocache;
create sequence reply_seq nocache;

insert into sample_users
(user_id, user_name, user_password, user_email)
values
('hong','홍길동','zxcv1234','hong@gmail.com');

alter table sample_replys add board_no number(7) constraint sample_board_no_fk references sample_boards(board_no);

commit;

select user_id, user_name, user_password, user_email, user_disabled
from sample_users
where user_id = ?;

insert into sample_boards
(board_no, board_title, board_writer, board_content)
values
(board_seq.nextval, '하이', 'hong', '헤이모두들 안녕');

select board_no, board_title, board_writer, board_content, board_hit, board_reply_cnt, board_del_yn, board_create_date
from sample_boards A, sample_users B
where  board_no = 1;
commit;

select A.board_no, A.reply_no, A.reply_writer, A.reply_content, A.reply_del_yn, A.reply_create_date, B.user_id
from sample_replys A, sample_users B
where board_no = 1;

select board_no, board_title, board_writer, board_content, board_hit, board_reply_cnt, board_del_yn, board_create_date 
						from sample_boards 
						where board_no = 1;
                        
insert into sample_replys
(reply_no, reply_writer, reply_content, board_no)
values
(reply_seq.nextval, 'hong','반가워요',1);

commit;

