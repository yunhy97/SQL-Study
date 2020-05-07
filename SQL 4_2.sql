insert into sample_book_questions
(question_no, question_title, user_id, question_content, question_type)
values
(sample_question_seq.nextval, '자바관련질문?', 'hong', '책추천해주세요','품질');


--책에 대한 리뷰와 평점을 담는 테이블
create table sample_book_reviews (
    review_no number(7,0)           constraint review_no_pk primary key,
    review_content varchar2(2000)   constraint review_content_nn not null,
    review_point number(1,0)        constraint review_point_ck check(review_point >= 0 and review_point <= 5),
    review_registered_date date     default sysdate,
    book_no number(7,0)             constraint review_bookno_fk references sample_books (book_no),
    user_id varchar2(50)            constraint review_userid_fk references sample_book_users (user_id),
    constraint reviews_uk unique (book_no, user_id)
);

create sequence sample_review_seq nocache;

insert into sample_book_reviews
(review_no, review_content, review_point, book_no, user_id)
values
(sample_review_seq.nextval, '아주 좋은 내용이었습니다.', 5, 10007, 'hong');

insert into sample_book_reviews
(review_no, review_content, review_point, book_no, user_id)
values
(sample_review_seq.nextval, '아주 좋은 내용이었습니다.', 5, 10007, 'yunhy97');

insert into sample_book_reviews
(review_no, review_content, review_point, book_no, user_id)
values
(sample_review_seq.nextval, '잘 읽었습니다.', 5, 10004, 'yunhy97');

insert into sample_book_reviews
(review_no, review_content, review_point, book_no, user_id)
values
(sample_review_seq.nextval, '잘 읽었습니다.', 2, 10004, 'hong');

commit;

create table sample_book_likes (
    book_no number(7,0) not null,
    user_id varchar2(50) not null,
    constraint likes_bookno_fk foreign key (book_no) references sample_books (book_no),
    constraint likes_userid_fk foreign key (user_id) references sample_book_users (user_id),
    constraint likes_uk unique (book_no, user_id)
);

create or replace view emp_salary_grade_view
as select A.employee_id, A.first_name, A.salary, B.gra
	from employees A, job_grades B
	where a.salary >= b.lowest_sal and a.salary <= b.highest_sal;

select * 
from emp_salary_grade_view
where gra = 'A';

create or replace view emp_salary_view
as select employee_id, first_name, salary, salary*4*12+ salary*nvl(commission_pct, 0)*4*12 annual_salary
	from employees;

select *
from emp_details_view
where employee_id = 100;

--인라인뷰 사용하기
select id, name, salary, deptid
from (select employee_id id
        , first_name || ' '|| last_name name
        , salary, department_id deptid 
        from employees)
where deptid = 60;

--전체 직원중에서 자신이 소속된 부서의 평균급여보다 급여를 적게 받는 
--사원의 아이디, 이름, 급여, 부서아이디, 부서의 평균급여를 조회하기
select a.employee_id, a.first_name, a.salary, b.deptid, b.avg_salary
from employees a, (select department_id deptid, trunc(avg(salary)) avg_salary
        from employees
        where department_id is not null
        group by department_id) b
where a.department_id = b.deptid
and a.salary < b.avg_salary
order by a.employee_id asc;

--부서아이디, 부서명, 부서별 사원수, 도시명 출력하기
select a.department_id, a.department_name, b.city, c.cnt
from departments a, locations b, ( select department_id dept_id, count(*) cnt 
                                    from employees 
                                    group by department_id) c
where a.location_id =b.location_id
and a.department_id = c.dept_id
order by a.department_id asc;

select book_no, count(*)
from sample_book_likes
where book_no = 10004
group by book_no;

commit;



















