create table sample_todo_users (
	user_id varchar2(20) primary key,
    user_name varchar2(100) not null,
    user_password varchar2(20) not null,
    user_email varchar2(256) not null,
    user_created_date date default sysdate
);

drop table sample_todos;

create table sample_todos (
    todo_no number(6) primary key,
    todo_title varchar2(200) not null,
    todo_content varchar2(2000) not null,
    todo_day date not null,
    todo_completed_day date,
    todo_status varchar2(100) default '처리예정',
    user_id varchar2(20) references sample_todo_users (user_id),
    todo_created_date date default sysdate
);

create sequence sample_todo_seq;

insert into sample_todo_users
(user_id, user_name, user_password, user_email, user_created_date)
values
(?, ?, ?, ?, sysdate);


select user_id, user_name, user_password, user_email, user_created_date
from sample_todo_users
where user_id = ?
;

insert into sample_todos(todo_no, todo_title, todo_content, todo_day, user_id)
values(sample_todo_seq.nextval, '일정' || sample_todo_seq.currval, '텍스트 일정',sysdate + sample_todo_seq.currval, 'kang');

commit;

select * from sample_todos;
select * 
						from (select A.*, rownum \
								from sample_books A \
								order by book_no desc) \
						where rownum <=3;

select *
from (select A.todo_no,A.todo_title,A.todo_content,A.todo_day,A.todo_completed_day,A.todo_status,A.user_id,A.todo_created_date,B.user_name, rownum
        from sample_todos A, sample_users B
        where A.user_id = B.user_id
        and B.user_id = 'hong'
        and A.todo_day >=sysdate
        order by todo_day asc)
        where rownum <=6;
    
select A.todo_title, B.user_name, A.todo_created_date, A.todo_day, A.todo_status
from sample_todos A, sample_users B
where A.user_id = B.user_id
and todo_no = 2;