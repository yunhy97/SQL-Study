--�Լ� �����ϱ�
--�Լ���
	--get_total_order_amount
--�Է°�
	--å��ȣ
--��ȯ��
	--å��ȣ�� �ش��ϴ� å�� �� �ֹ�����
create or replace function get_total_order_amount
(i_book_no in number)

return number
is
    v_amount             sample_book_orders.order_amount%type;
    v_total_order_amount number:=0;
    
    cursor order_list(param_book_no number) IS
    select order_amount
    from sample_book_orders
    where book_no = param_book_no;
     
begin
    FOR ord in order_list(i_book_no) LOOP
        v_amount := ord.order_amount;
        v_total_order_amount := v_total_order_amount + v_amount;
    END LOOP;
    
    RETURN v_total_order_amount;

    commit;
end;



--�Լ� �����ϱ�
--�Լ���
	--get_total_order_price
--�Է°�
	--å��ȣ
--��ȯ��
	--å��ȣ�� �ش��ϴ� å�� �� �ǸŰ���
    
create or replace function get_total_order_price
(i_book_no in number)

return number

is
    v_discount_price
    v_book_price
    v_order_price

begin

end;