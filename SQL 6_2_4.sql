--트리거 실행3
insert into sample_book_reviews
(review_no, review_content, review_point, book_no, user_id)
values
(sample_review_seq.nextval, '테스트입니다.', 0, 10004, 'suyoung');

select book_no, book_point
from sample_books;
--_____________________________________________________________________________________________________
--과제 : 프로시저 정의
--프로시저명 : add_book_order
--변수 : 1.구매가격을 저장할 변수
--구현 : 1.책번호에 해당하는 책의 할인가격과 현재 재고를 조회해서 변수에 저장
--      2.현재 재고가 구매수량보다 크거나 같을 때만(if문)      
--          3.주문정보저장
--          4.책정보에서 재고를 변경(구매수량만큼 빼기)

create or replace procedure add_book_order
(i_user_id in varchar2,i_book_no in number, i_order_amount in number)   --입력값 : 사용자아이디, 책번호, 구매수량
is
    v_order_price number;
    v_current_book_stock number;
    
    --사용자정의 예외 선언
    book_application_error exception;
begin
--처리 : 주문 -> 주문번호(sequence), 사용자아이디(입력값에서 가져오기), 책번호(입력값에서 가져오기), 
--구매가격(책번호로 할인가격을 조회한 것), 구매수량(입력값에서 가져오기)

     --책의 할인가격,현재재고 정보 조회
    select book_discount_price, book_stock
    into v_order_price, v_current_book_stock    --조회된 컬럼의 값을 변수에 저장
    from sample_books
    where book_no = i_book_no;
     
    IF v_current_book_stock >= i_order_amount then  
        insert into sample_book_orders       --주문정보 저장
        (order_no, user_id, book_no, order_price, order_amount,order_registered_date)
        values
        (sample_order_seq.nextval, i_user_id, i_book_no, v_order_price, i_order_amount, sysdate);
  
        update sample_books     --책의 재고 변경
        set
            book_stock = book_stock - i_order_amount
        where
            book_no = i_book_no;
            
    ELSE
        --책의 재고가 주문량보다 부족한 경우 예외 발생
        raise book_application_error;
    end if;
    
    --예외처리
    EXCEPTION
        --사용자정의 예외가 발생했다면 오라클의 RAISE_APPLICATION_ERROR(에러코드, 에러메세지)를 실행시킨다.
        when book_application_error then
            --오류코드는 -20000 ~20999 사이의 값을 사용한다.
            RAISE_APPLICATION_ERROR(-20000, '재고가 부족합니다.');
    
    --데이터베이스에 반영
    commit;
end;