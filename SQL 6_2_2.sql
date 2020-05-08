--트리거 실행1
insert into sample_book_likes (book_no, user_id)
values(10004, 'ryu');

--트리거2
--sample_book_orders에 새로운 주문이 추가될 때마다 sample_book_users의 포인트를 증가시킨다.

create or replace trigger increase_user_point_trigger
    after
    insert on sample_book_orders
    for each row
    
    declare
        v_price             sample_book_orders.order_price%type;
        v_amount            sample_book_orders.order_amount%type;
        v_deposit_point     sample_book_users.user_point%type;
    
begin

    v_price         := :NEW.order_price;
    v_amount        := :NEW.order_amount;
    v_deposit_point := trunc(v_price*v_amount*0.02);
    
    update sample_book_users
    set
        user_point = user_point + v_deposit_point
    where
        user_id = :NEW.user_id;
    
end;
