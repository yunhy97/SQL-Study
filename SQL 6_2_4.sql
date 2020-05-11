--Ʈ���� ����3
insert into sample_book_reviews
(review_no, review_content, review_point, book_no, user_id)
values
(sample_review_seq.nextval, '�׽�Ʈ�Դϴ�.', 0, 10004, 'suyoung');

select book_no, book_point
from sample_books;
--_____________________________________________________________________________________________________
--���� : ���ν��� ����
--���ν����� : add_book_order
--���� : 1.���Ű����� ������ ����
--���� : 1.å��ȣ�� �ش��ϴ� å�� ���ΰ��ݰ� ���� ��� ��ȸ�ؼ� ������ ����
--      2.���� ��� ���ż������� ũ�ų� ���� ����(if��)      
--          3.�ֹ���������
--          4.å�������� ��� ����(���ż�����ŭ ����)

create or replace procedure add_book_order
(i_user_id in varchar2,i_book_no in number, i_order_amount in number)   --�Է°� : ����ھ��̵�, å��ȣ, ���ż���
is
    v_order_price number;
    v_current_book_stock number;
    
    --��������� ���� ����
    book_application_error exception;
begin
--ó�� : �ֹ� -> �ֹ���ȣ(sequence), ����ھ��̵�(�Է°����� ��������), å��ȣ(�Է°����� ��������), 
--���Ű���(å��ȣ�� ���ΰ����� ��ȸ�� ��), ���ż���(�Է°����� ��������)

     --å�� ���ΰ���,������� ���� ��ȸ
    select book_discount_price, book_stock
    into v_order_price, v_current_book_stock    --��ȸ�� �÷��� ���� ������ ����
    from sample_books
    where book_no = i_book_no;
     
    IF v_current_book_stock >= i_order_amount then  
        insert into sample_book_orders       --�ֹ����� ����
        (order_no, user_id, book_no, order_price, order_amount,order_registered_date)
        values
        (sample_order_seq.nextval, i_user_id, i_book_no, v_order_price, i_order_amount, sysdate);
  
        update sample_books     --å�� ��� ����
        set
            book_stock = book_stock - i_order_amount
        where
            book_no = i_book_no;
            
    ELSE
        --å�� ��� �ֹ������� ������ ��� ���� �߻�
        raise book_application_error;
    end if;
    
    --����ó��
    EXCEPTION
        --��������� ���ܰ� �߻��ߴٸ� ����Ŭ�� RAISE_APPLICATION_ERROR(�����ڵ�, �����޼���)�� �����Ų��.
        when book_application_error then
            --�����ڵ�� -20000 ~20999 ������ ���� ����Ѵ�.
            RAISE_APPLICATION_ERROR(-20000, '��� �����մϴ�.');
    
    --�����ͺ��̽��� �ݿ�
    commit;
end;