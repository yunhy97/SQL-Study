--트리거 생성하기1
--SAMPLE_BOOK_LIKES에 INSERT 작업이 실행될 떄마다 자동으로 SAMPLE_BOOKS의 BOOK_LIKES 컬럼의 값을 1증가시킨다.
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