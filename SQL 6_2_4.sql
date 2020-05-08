--트리거 실행3
insert into sample_book_reviews
(review_no, review_content, review_point, book_no, user_id)
values
(sample_review_seq.nextval, '테스트입니다.', 0, 10004, 'suyoung');

select book_no, book_point
from sample_books;

--과제 : 프로시저 정의
--프로시저명 : add_book_order
--변수 : 1.구매가격을 저장할 변수
--구현 : 1.책번호에 해당하는 책의 할인가격과 현재 재고를 조회해서 변수에 저장
--      2.현재 재고가 구매수량보다 크거나 같을 때만(if문)      
--          3.주문정보저장
--          4.책정보에서 재고를 변경(구매수량만큼 빼기)

create or replace procedure add_book_order
(i_book_no in number)
is
--입력값 : 사용자아이디, 책번호, 구매수량
    v_user_id sample_book_orders.user_id%type;              --사용자아이디
    v_order_amount sample_book_orders.order_amount%type;    --구매수량
    v_book_price sample_books.book_price%type;
    v_book_discount_price sample_books.book_discount_price%type;
    v_book_stock sample_books.book_stock%type;
begin
--처리 : 주문 -> 주문번호(sequence), 사용자아이디(입력값에서 가져오기), 책번호(입력값에서 가져오기), 
--구매가격(책번호로 할인가격을 조회한 것), 구매수량(입력값에서 가져오기)

    select book_discount_price
    INTO v_book_discount_price
    from sample_books
    where book_no = i_book_no;

    select book_stock           --현재재고
    into v_book_stock
    from sample_books
    where book_no = i_book_no;
    
    IF v_book_stock >= v_order_amount then 
           insert into sample_book_orders (order_no, user_id, book_no, order_price, order_amount)
            values (sample_order_seq.nextval, v_user_id, i_book_no, 
                    v_book_price - v_book_discount_price, v_order_amount);
  
                        update sample_books
                        set
                            book_stock = v_book_stock - v_order_amount
                        where
                            book_no = i_book_no;
    end if;
    commit;
end;