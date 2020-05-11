--프로시저 실행
execute add_book_order('hong', 10006, 1000);

--사용자함수 실행1
select book_no, book_title, book_stock, get_total_order_amount(book_no)
from sample_books;

--사용자함수 실행2
select book_no 번호,
        book_title 제목,
        book_discount_price 할인가격,
        book_stock 재고량,
        get_total_order_amount(book_no) "총 판매수량",
        get_total_order_price(book_no) "총 판매금액"
from sample_books;