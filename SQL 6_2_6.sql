--���ν��� ����
execute add_book_order('hong', 10006, 1000);

--������Լ� ����1
select book_no, book_title, book_stock, get_total_order_amount(book_no)
from sample_books;

--������Լ� ����2
select book_no ��ȣ,
        book_title ����,
        book_discount_price ���ΰ���,
        book_stock ���,
        get_total_order_amount(book_no) "�� �Ǹż���",
        get_total_order_price(book_no) "�� �Ǹűݾ�"
from sample_books;