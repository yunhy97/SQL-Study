alter table questions add(branch_no number(3,0));
alter table questions add foreign key(branch_no) references branches(branch_no);

select a.user_id, a.user_tel, a.user_email, 
					b.question_type, b.question_title, b.question_content, 
					d.branch_addr_first, d.branch_name \
				from users a, questions b,orders c, (select branch_no,branch_name, branch_addr_first 
                                        				from branches \
                                        				where branch_addr_first like '%서울%') d 
				where a.user_no = 100
				and a.user_no = b.question_writer 
				and a.user_no = c.user_no 
				and c.branch_no = d.branch_no;
                
select a.user_id, a.user_tel, a.user_email, b.question_type, b.question_title, b.question_content, c.branch_addr_first, c.branch_name
from users a, questions b, branches c
where a.user_no (+)= b.question_writer
and b.branch_no (+)= c.branch_no
and a.user_no= 100;

select branch_no, branch_name
from branches
where branch_addr_first like '%' || '서울' || '%';

insert into questions
(question_no, question_writer, question_type, branch_no, question_title, question_content)
values
(QUESTION_NO_SEQ.nextval,?, ?, ?, ?, ?);

select row_number() over(order by question_no desc) as num , question_title, question_reg_date, answered_yn 
from questions
where question_writer = 100;

select row_number() over(order by salary desc), salary, first_name
from employees;

commit;

select b.user_no, nvl(a.count_question,0) as count_question 
								from (select question_writer ,count(question_writer) as count_question 
										from questions 
										group by question_writer) a, users b 
								where a.question_writer(+)=b.user_no 
								and b.user_no =100;
                                
select a.question_writer, a.question_no, a.question_type, a.question_title, a.question_content, b.answer_content , substr(c.branch_addr_first, 1, 2) branch_addr_first, c.branch_name
from questions a, answers b, branches c
where a.question_no = b.question_no(+)
and a.branch_no = c.branch_no
and a.question_writer = 100
and a.question_no = 125;

update questions \
				  set \
				  	question_del_yn = 'Y' \
				  where question_no = ?;

select user_no, user_quit_yn, user_quit_reason, user_quit_detail
from users
where user_no=100;

update users
set
    user_quit_yn=?,
    user_quit_reason=?,
    user_quit_detail=?
where user_no=?;

insert into events
values
(event_no_seq.nextval, '1번이벤트',sysdate, '2020-07-11','event1.png', 0, 'N', sysdate, 100);
insert into events
values
(event_no_seq.nextval, '2번이벤트',sysdate, '2020-07-20','event2.png', 0, 'N', sysdate, 101);
commit;

select event_no, event_name, event_start_date, event_end_date, event_image_src 
				          , event_discount_rate , event_disable_yn, event_reg_date, pizza_no 
				  from events 
				  where event_disable_yn = 'N'
                  and sysdate between event_start_date and event_end_date
				  order by event_no desc;


select event_no,event_image_src
from events
order by event_no desc;

commit;

select * 
from questions \
where question_writer = ? \
order by question_no desc;

select question_no, question_writer, question_title, question_content, answered_yn, question_del_yn, question_reg_date 
from (select question_no, question_writer, question_title, question_content, answered_yn , question_del_yn, question_reg_date , 
            row_number() over(order by question_no desc) rownumber
        from questions) a , questions b
where a.question_writer = 100
and b.question_no = a.question_no
and a.rownumber >= 1 and a.rownumber <= 2
order by question_no desc;

select question_writer,question_no, question_title, question_reg_date, answered_yn, question_del_yn,
        row_number() over(order by question_no desc) rownumber
        from questions;

select a.question_no, a.question_title, a.question_reg_date, a.answered_yn, a.question_del_yn
from questions a, (select question_no, question_title, question_reg_date, answered_yn, question_del_yn,
        row_number() over(order by question_no desc) rownumber
        from questions) b
where a.question_writer =100
and a.question_no = b.question_no
and rownumber >= 1 and rownumber <=2;

SELECT order_no, order_total_price, order_discount_price, order_status, \
							order_receiver_name, order_receiver_tel, user_no, order_request_time, \
							branch_no, order_request_detail, location_no, order_type, order_reg_date \
					  FROM orders \
					  WHERE user_no = ? \
					  AND order_type = 'C';
                      
delete from orders
where order_type='C'
and user_no = 100;

commit;
select *
from users;
