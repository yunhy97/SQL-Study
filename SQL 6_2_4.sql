--Ʈ���� ����3
insert into sample_book_reviews
(review_no, review_content, review_point, book_no, user_id)
values
(sample_review_seq.nextval, '�׽�Ʈ�Դϴ�.', 0, 10004, 'suyoung');

select book_no, book_point
from sample_books;

--���� : ���ν��� ����
--���ν����� : add_book_order
--���� : 1.���Ű����� ������ ����
--���� : 1.å��ȣ�� �ش��ϴ� å�� ���ΰ��ݰ� ���� ��� ��ȸ�ؼ� ������ ����
--      2.���� ��� ���ż������� ũ�ų� ���� ����(if��)      
--          3.�ֹ���������
--          4.å�������� ��� ����(���ż�����ŭ ����)

create or replace procedure add_book_order
(i_book_no in number)
is
--�Է°� : ����ھ��̵�, å��ȣ, ���ż���
    v_user_id sample_book_orders.user_id%type;              --����ھ��̵�
    v_order_amount sample_book_orders.order_amount%type;    --���ż���
    v_book_price sample_books.book_price%type;
    v_book_discount_price sample_books.book_discount_price%type;
    v_book_stock sample_books.book_stock%type;
begin
--ó�� : �ֹ� -> �ֹ���ȣ(sequence), ����ھ��̵�(�Է°����� ��������), å��ȣ(�Է°����� ��������), 
--���Ű���(å��ȣ�� ���ΰ����� ��ȸ�� ��), ���ż���(�Է°����� ��������)

    select book_discount_price
    INTO v_book_discount_price
    from sample_books
    where book_no = i_book_no;

    select book_stock           --�������
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