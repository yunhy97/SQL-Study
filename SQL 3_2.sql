--사용자 정보 등록하기
--모든 컬럼에 값을 명시적으로 저장하기
--나열된 컬럼순서에 맞게 값을 나열한다.
insert into sample_book_users
(user_id, user_password, user_name, user_email, user_point, user_registered_date)
values
('hay', 'zxcv1234', '윤하영','yun@nave.com', 10, sysdate);

--컬럼명으 생략한 경우
--테이블의 컬럼순서에 맞게 값을 나열한다.
insert into sample_book_users
values
('neena','zxcv1234', '니나', 'nee@gmail.com', 100, sysdate);

--컬럼명을 생략한 경우
--반드시 테이블의 컬럼순서에 맞게 모든 값을 나열해야 한다.
insert into sample_book_users
values
('ssosso', 'zxcv1234', '소영선배', 'ssosso@gmail.com');  --오류, 값이 부족함.

--나열된 컬럼에만 값을 저장하고, 나머지는 null이나 default값이 저장되게 하기
insert into sample_book_users
(user_id, user_password, user_name)
values
('suyoung', 'zxcv1234', '김수영');

--필수입력값이 누락된 경우
insert into sample_book_users
(user_id, user_password)
values
('dalchong', 'zxcv1234');  --오류

--컬럼의 크기보다 큰 값이 입력되는 경우
insert into sample_book_users
(user_id, user_password, user_name)  --오류
values
('dalchong', 'zxcv1234', '김수한무거북이와두루미삼천갑자동박삭김수한무거북이와두루미삼천갑자동박삭김수한무거북이와두루미삼천갑자동박삭');

--테이블의 값 수정하기
--모든 행의 특정 컬럼값을 수정하기(where 절을 생략하면 된다.)
--모든 사용자의 비밀번호를 'zxcv1234'로 변경하기
update sample_book_users
set 
    user_password = 'zxcv1234';
--commit;
--commit하고 난 후 rollback을 하면 적용되지 않는다.
--rollback;

--모든 행의 특정 컬럼값을 수정하기
--모든 직원들의 급여를 500불 인상하기
update employees
set
    salary = salary + 500;

--where절을 사용해서 조건식을 만족하는 특정행의 컬럼값을 수정하기
--90번 부서에 소속된 직원의 급여를 10000달러 인상시키기
update employees
set
    salary = salary + 10000
where department_id = 90;

--한 번에 여러 컬럼의 값을 변경하기
--10005번 책의 제목, 가격, 할인가격을 수정하기
update sample_books
set
    book_title = '이것이 자바다 개정판' ,
    book_price = 40000,
    book_discount_price = 38000
where book_no = 10005;

--서브쿼리를 이용해서 값 변경하기
--132번 직원의 급여를 소속부서(50번부서)의 평균급여로 변경하기
update employees
set
    salary = (select trunc(avg(salary))
            from employees
            where department_id = 50)
where employee_id=132;

--10번 부서의 부서번호를 300번으로 변경하기
update departments
set
    department_id = 300
where department_id = 10;  --오류, 자식테이블(employees)에 자식레코드 존재

--100번 사원의 소속부서를 500으로 변경하기
update departments
set
    department_id = 500
where employee_id = 100;  --오류, 부모테이블(departments)에 500번 부서가 존재하지 않음

--데이터(행) 삭제하기
--아이디가 neena인 행 삭제하기
delete from sample_book_users
where user_id = 'neena';

create table copy_sample_book_users(
    user_id varchar2(50) primary key,
    user_password varchar2(50) not null,
    user_name varchar2(100) not null,
    user_email varchar2(256),
    user_point number(10,0),
    user_registered_date date 
);

--sample_book_users의 모든 행을 copy_sample_book_users에 추가하기
insert into copy_sample_book_users
(user_id,user_password,user_name,user_email,user_point,user_registered_date)
select user_id, user_password, user_name, user_email, user_point, user_registered_date
from sample_book_users;

--원본테이블에 새로운 추가
insert into sample_book_users
values ('ryu', 'zxcv1234','류관순','avc123@gmail.com', 10, sysdate);

insert into sample_book_users
values ('kkang', 'zxcv1234','강감찬','kkang111@gmail.com', 100, sysdate);

--원본테이블과 대상테이블 병합하기
merge into copy_sample_book_users B
      using sample_book_users A
      on (B.user_id = A.user_id)
when matched then
    update set
        B.user_password = A.user_password,
        B.user_name = A.user_name,
        B.user_email = A.user_email,
        B.user_point = A.user_point,
        B.user_registered_date = A.user_registered_date
when not matched then
    insert values
    (A.user_id, A.user_password, A.user_name, 
     A.user_email, A.user_point, A.user_registered_date);

commit;

select a.order_no,b.user_name, c.book_title, c.book_price, a.order_price,a.order_amount, a.order_registered_date
from sample_book_orders a, sample_book_users b, sample_books c
where a.user_id = b.user_id
and a.book_no = c.book_no
and a.order_no = 500000
order by a.order_no desc;

commit;



























