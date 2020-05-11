--함수 정의하기1 
--함수명
	--get_total_order_amount
--입력값
	--책번호
--반환값
	--책번호에 해당하는 책의 총 주문수량
create or replace function get_total_order_amount
(i_book_no in number)

--반환타입 정의
return number
is
    --총 구매수량을 저장할 변수
    v_total_order_amount number;
begin
    --총구매수량을 조회해서 변수에 담기
    select nvl(sum(order_amount), 0)
    into v_total_order_amount
    from sample_book_orders
    where book_no = i_book_no;
    --변수에 저장된 값 반환하기
    RETURN v_total_order_amount;
end;



--함수 정의하기2
--함수명
	--get_total_order_price
--입력값
	--책번호
--반환값
	--책번호에 해당하는 책의 총 판매가격
    
create or replace function get_total_order_price
(i_book_no in number)

return number

is
    v_total_order_price number;
begin
    --총구매수량 조회하기
    select nvl(sum(order_price * order_amount),0)
    into v_total_order_price
    from sample_book_orders
    where book_no = i_book_no;
    
    --변수에 저장된 값 반환하기
    return v_total_order_price;
end;










