insert into sample_book_reviews
(review_no, review_content, review_point, book_no, user_id)
values
(sample_review_seq.nextval,'ererer',5,10003,'hong');

select order_no, user_id, book_no, order_price, order_amount, order_registered_date
from sample_book_orders
order by order_no desc;

select A.order_no, A.user_id, B.user_name, B.user_point,
        A.book_no, C.book_title, A.order_price, A.order_amount, A.order_registered_date,
        nvl2(D.review_no, 'Y', 'N') review_yn        
from sample_book_orders A, sample_book_users B, sample_books C, sample_book_reviews D
where A.user_id = B.user_id
and A.book_no = C.book_no
and A.book_no = D.book_no(+)
and A.user_id = D.user_id(+)
and A.user_id = 'hong'
order by A.order_no desc;
