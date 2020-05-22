--최근 입고된 도서
--책번호 순으로 내림차순 정렬했을 때5번째 책까지 조회하기
select num, book_no, book_title,book_writer, book_price
from (select row_number() over(order by book_no desc) num ,  book_no, book_title,book_writer, book_price
        from sample_books)
where num <=5 ;

select book_no, book_title,book_writer, book_price
from (select book_no, book_title,book_writer, book_price
        from sample_books
        order by book_no desc)
where rownum <=5 ;


--최근 가입한 사용자
--가입일 순으로 내림차순 정렬했을 때 5번째 사용자까지 조회하기
select num,user_id, user_name, user_email, user_registered_date
from(select row_number() over(order by user_registered_date desc) num, user_id, user_name, user_email, user_registered_date
    from sample_book_users)
where num <=5;

select user_id, user_name, user_email, user_registered_date
from(select  user_id, user_name, user_email, user_registered_date
    from sample_book_users
    order by user_registered_date desc)
where rownum <=5;

select book_no, book_title, book_writer, book_publisher, book_point, book_price,
        (select count(*) from sample_book_reviews where book_no = A.book_no) review_cnt, 
        book_price, book_discount_price, book_likes, book_stock
from sample_books A
where book_no=  10010;

select A.review_no, B.user_name, A.review_point, A.review_content, a.review_registered_date
from sample_book_reviews A, sample_book_users B
where A.user_id = B.user_id
and A.book_no = 10004;

select book_no, book_title, book_writer, book_genre, book_publisher, book_price, book_discount_price, book_registered, book_stock, book_point, book_likes
from sample_books;

delete from sample_books 
where book_no=10020;

commit;