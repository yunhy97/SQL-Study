--Top-N 분석
--50번 부서에 소속된 사원 중에서 급여를 가장 많이 받는 직원 3명을 조회하기
select ROWNUM, salary, first_name 
from (select salary, first_name
      from employees
      where department_id = 50
      order by salary desc)    
where ROWNUM <= 3;

--부서별 사원수를 계산했을 때 사원수가 가장 많은 부서 3곳을 조회하기
select rownum ranking, department_id ,cnt
from (select department_id, count(*) cnt
      from employees
      group by department_id
      order by cnt desc)
where rownum <= 3;

--부서별 사원수를 계산했을 때 사원수가 가장 많은 부서 3곳을 조회하기
--순번, 부서아이디, 부서명, 사원수가 출력되어야 함.
select B.ranking, A.department_id, A.department_name, B.cnt
from departments A, (select rownum ranking, department_id ,cnt
                    from (select department_id, count(*) cnt
                            from employees
                            group by department_id
                            order by cnt desc)
                    where rownum <= 3) B
where A.department_id = B.department_id;

--가격이 가장 비싼 책 3권을 조회하기
--순위, 제목, 가격이 출력되어야 함.
select rownum ranking, book_title, book_price
from (select  book_title, book_price
        from sample_books
        order by book_price desc)
where rownum <=3;

--가격이 가장 비싼 책 3권을 조회했을 때
--최근 1주일 이내에 이 책을 산 사용자를 조회하기
--사용자 아이디 ,사용자명, 책제목, 가격,구매수량, 구매날짜가 출력되어야 함.
select C.user_id, C.user_name, B.book_title, A.order_price, A.order_amount, A.order_registered_date
from sample_book_orders A,(select rownum ranking,book_no ,book_title, book_price
                        from (select  book_no, book_title, book_price
                                from sample_books
                                order by book_price desc) 
                        where rownum <=3) B, sample_book_users C
where A.order_registered_date > sysdate - 7
and A.book_no = B.book_no
and A.user_id = C.user_id;

--구매총액을 계산했을 때 구매총액이 가장 많은 사용자의
--아이디, 이름, 총구매금액을 조회하기
select A.user_id, A.user_name, B.total_price
from sample_book_users A, (select user_id, total_price
                            from (select user_id, sum(order_price*order_amount) total_price
                                    from sample_book_orders
                                    group by user_id
                                    order by total_price desc)
                            where rownum = 1) B
where A.user_id = B.user_id;

--분석함수 사용하기
--급여를 기준으로 정렬해서 순번 부여하기
select row_number() over(order by salary desc), salary, first_name
from employees;

--급여를 기준으로 내림차순 정렬해서 순번을 부여했을 때 최고 급여를 받는 직원 3명의
--아이디, 이름, 급여를 조회하기
select num, employee_id, first_name, salary
from (select row_number() over(order by salary desc) num,employee_id, salary, first_name
        from employees)
where num <= 3;

--급여를 기준으로 내림차순 정렬해서 순번을 부여했을 때 급여 순위가 11~20위에 해당하는 직원의
--아이디, 이름, 급여를 조회하기
select num, employee_id, first_name, salary
from (select row_number() over(order by salary desc) num,employee_id, salary, first_name
        from employees)
where num >= 11 and num <=20;

--부서별로 급여를 기준으로 내림차순 정렬해서 순번을 부여하기
select row_number() over(partition by department_id order by salary desc) num,
        department_id, salary, first_name
from employees;

--부서별로 급여를 기준으로 내림차순 정렬해서 순번을 부여했을 때
--해당 부서에서 가장 급여를 많이 받는 직원의
--이름, 급여, 부서아이디를 조회하기
select first_name, salary, department_id
from (select row_number() over(partition by department_id order by salary desc) num,
        department_id, salary, first_name
        from employees)
where num = 1;

--row_number(), rank(), dense_rank()값의 차이점 확인해보기
select row_number()     over(order by salary desc) row_number, 
        rank()          over(order by salary desc) rank,
        dense_rank()   over(order by salary desc) densce_rank,
        salary
from employees;

--row_number() over()를 활용해서 데이터를 특정 컬럼값을 기준으로 범위별로 나눠서 조회하기
select *
from (select row_number() over(order by employee_id asc) num, employee_id, first_name
        from employees)
where num >= 1 and num <=10;

select *
from (select row_number() over(order by employee_id asc) num, employee_id, first_name
        from employees)
where num >= 11 and num <=20;

--새로운 일련번호를 조회
select sample_order_seq.nextval from dual;
--현재 시퀀스의 일련번호를 조회
select sample_order_seq.currval from dual;

select employee_id , rowid
from employees;

--
create index sample_user_name_idx
on sample_book_users (user_name);

create index sample_order_date_idx
on sample_book_orders (to_char(order_registered_date, 'yyyy-mm-dd'));
select *
 from employees
 where last_name = 'King';

select *
from sample_book_users
where user_name = '홍길동';

select *
from sample_book_orders
where to_char(order_registered_date, 'yyyy-mm-dd') = '2020-04-28';

















