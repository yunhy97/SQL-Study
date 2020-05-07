select * 
from scott.contacts;

--전화번호 변경하기
update scott.contacts
set
    contact_tel = '010-1122-3333'
where
    contact_name = '홍길동';

--이름변경하기, 객체권한 부족으로 실행오류
update scott.contacts
set
    contact_name = '강감찬'
where
    contact_name = '김유신';


--scott.contacts에 대한 테이블의 동의어를 생성하기
create synonym contacts for scott.contacts;

select *
from contacts;

--데이터사전
--사용자의 모든 테이블 정보 조회
select * 
from user_tables;

--사용자의 모든 뷰 정보 조회
select * 
from user_views;

--사용자의 모든 시퀀스 정보 조회
select *
from user_sequences;

--사용자 정보 조회
select * 
from user_users;

--집합연산자 사용하기
--모든 사원의 현재 및 이전에 근무했던 직종을 조회하기
--사원별로 한번씩만 표시하기
select employee_id, job_id      --현재 근무중인 직종 조회하기
from employees
union
select employee_id, job_id      --이전에 근무했던 직종 조회하기
from job_history;

--모든 사원의 현재 부서아이디와 이전 소속부서 아이디를 조회하기
select employee_id, department_id
from employees
union all
select employee_id, department_id
from job_history;

--현재 종사하는 직종과 같은 직종에서 종사하고 있는 직원의 아이디와 직종아이디 조회하기
select employee_id, job_id
from employees
intersect
select employee_id, job_id
from job_history;

select a.employee_id, a.job_id
from employees a, job_history b
where a.employee_id = b.employee_id
and a.job_id = b.job_id;

--직종이 변경된 적이 없는 사원의 아이디를 조회하기
select employee_id
from employees
minus
select employee_id
from job_history;

--직종이 변경된 적이 없는 사원의 아이디, 이름을 조회하기
select a.employee_id, b.first_name
from (select employee_id
        from employees
        minus
        select employee_id
        from job_history) a, employees b
where a.employee_id = b.employee_id
order by 1;

--직종이 변경된 적이 없는 사원의 아이디, 이름, 현재 직종, 소속부서명을 조회하기
select a.employee_id, b.first_name, b.job_id, c.department_name
from (select employee_id
        from employees
        minus
        select employee_id
        from job_history) a, employees b, departments c
where a.employee_id = b.employee_id
and b.department_id = c.department_id;

--모든 사원의 현재 및 이전에 근무했던 직종을 조회하기
--사원아이디, 직종, 급여를 조회하기
select employee_id, job_id, salary
from employees
union
select employee_id, job_id, 0 
from job_history;
















