--�Լ� �����ϱ�1 
--�Լ���
	--get_total_order_amount
--�Է°�
	--å��ȣ
--��ȯ��
	--å��ȣ�� �ش��ϴ� å�� �� �ֹ�����
create or replace function get_total_order_amount
(i_book_no in number)

--��ȯŸ�� ����
return number
is
    --�� ���ż����� ������ ����
    v_total_order_amount number;
begin
    --�ѱ��ż����� ��ȸ�ؼ� ������ ���
    select nvl(sum(order_amount), 0)
    into v_total_order_amount
    from sample_book_orders
    where book_no = i_book_no;
    --������ ����� �� ��ȯ�ϱ�
    RETURN v_total_order_amount;
end;



--�Լ� �����ϱ�2
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
    v_total_order_price number;
begin
    --�ѱ��ż��� ��ȸ�ϱ�
    select nvl(sum(order_price * order_amount),0)
    into v_total_order_price
    from sample_book_orders
    where book_no = i_book_no;
    
    --������ ����� �� ��ȯ�ϱ�
    return v_total_order_price;
end;










