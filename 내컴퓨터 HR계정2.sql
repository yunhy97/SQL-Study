select A.order_no, B.user_name, C.book_title, A.order_price, A.order_amount, 
        				A.order_price*A.order_amount, A.order_registered_date 
					from sample_book_orders A, sample_book_users B, sample_books C 
					where A.user_id = B.user_id 
					and A.book_no = C.book_no;
                    
select A.order_no, B.user_name, C.book_title, A.order_price, A.order_amount, 
        				A.order_price*A.order_amount, A.order_registered_date 
					from sample_book_orders A, sample_book_users B, sample_books C 
					where A.user_id = B.user_id 
					and A.book_no = C.book_no
                    and C.book_genre = 'IT';
                    
insert into sample_book_likes
(book_no, user_id)
values
(10003,'hong');

create table sample_book_boards (
    board_no  number(7,0) primary key,
    board_title varchar2(200) not null,
    board_writer varchar2(100) not null,
    board_content varchar2(4000) not null,
    board_password number(4,0) not null,
    board_hit number(5,0),
    board_del_yn char(1) default 'N',
    baord_registered_date date  default sysdate
);

create table sample_book_board_replys (
    reply_no number(7,0) primary key,
    reply_writer varchar2(100) not null,
    reply_content varchar2(3000) not null,
    reply_registered_date date default sysdate,
    board_no number(7,0)  references sample_book_boards(board_no)
);

create sequence sample_board_seq start with 10000 nocache;
create sequence sample_reply_seq start with 10000 nocache;

commit;

insert into sample_book_boards
(board_no, board_title, board_writer, board_content, board_password)
values
(sample_board_seq.nextval, '안녕하세요','홍길동','자바 책이 엄청많아요',1234);

select board_no, board_title, board_writer, board_hit, board_registered_date
from sample_book_boards;

commit;

insert into sample_book_board_replys
(reply_no, reply_writer, reply_content, board_no)
values
(sample_reply_seq.nextval, '류관순', '하하', 10000);

select board_no, board_title, board_writer, board_hit, board_registered_date
from sample_book_boards
where board_no = ?;

select board_no, board_title, board_writer, board_hit, board_registered_date
from sample_book_boards
where board_title like '%안녕%';

select reply_no, reply_writer, reply_content, reply_registered_date, board_no
from sample_book_board_replys
where board_no= 10000;

commit;