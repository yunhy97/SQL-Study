--Ʈ���� �����ϱ�1
--SAMPLE_BOOK_LIKES�� INSERT �۾��� ����� ������ �ڵ����� SAMPLE_BOOKS�� BOOK_LIKES �÷��� ���� 1������Ų��.
create or replace trigger INCREASE_BOOK_LIKES_TRIGGER
    after
    insert on SAMPLE_BOOK_LIKES
    for each row
begin
    
    update SAMPLE_BOOKS
    set
        BOOK_LIKES = BOOK_LIKES + 1
    where
        BOOK_NO = :NEW.BOOK_NO;
end;