--Ʈ���� ����2 
insert into sample_book_orders (order_no, user_id, book_no, order_price, order_amount)
values (sample_order_seq.nextval, 'hong', 10005, 40000,3);

select *
from sample_book_users
where user_id = 'hong';

--Ʈ����3
--å�� ���� ���䰡 �ۼ��� ������ å ��ȣ�� �ش� ������ �����ϴ� trigger
create or replace trigger update_review_point_trigger
    before--after
    insert on sample_book_reviews
    for each row
    
    declare 
        v_current_point     number(2,1);
        v_current_row_count number;
        v_temp_point        number;
        v_point             number(2,1);
begin
    --���� ����Ʈ�� ������
    select  book_point into v_current_point
    from sample_books
    where book_no = :new.book_no;
    
    select count(*) into v_current_row_count
    from sample_book_reviews
    where book_no = :new.book_no;
    
    v_temp_point :=(v_current_point*v_current_row_count + :new.review_point) / (v_current_row_count + 1);
    v_point := trunc(v_temp_point,1);
    
    --���������� sample_books�� book_point�� �ݿ�
    update sample_books
    set
        book_point = v_point
    where
        book_no = :NEW.book_no;
end;


