select employees.employee_id, employees.first_name, employees.job_id, departments.department_id
from employees, departments 
where employees.department_id = departments.department_id;

--조인하기
--급여를 5000달러 받는 사원의 아이디, 이름, 직종아이디, 소속부서아이디, 소속부서명을 조회하기
select employee_id, first_name, job_id, department_id
from employees
where salary = 3000;

select *
from employees, departments --조인할 테이블을 지정
where employees.salary = 3000     --조회조건을 정의
and employees.department_id = departments.department_id; -- 조인조건 정의

--급여를 15000달러 이상 받은 직원의
--직원아이디, 이름, 급여, 직종아이디, 직종제목, 직종최저급여, 직종 최고급여 조회하기
select a.employee_id, a.first_name ,a.salary ,a.employee_id, 
        b.job_id, b.job_title, b.min_salary, b.max_salary
from employees a, jobs b 
where a.salary >= 15000
and a.job_id = b.job_id;

--부서관리자가 지정된 부서의
--부서아이디, 부서명, 도시명, 우편번호, 주소 조회하기
select a.department_id, a.department_name, b.city, b.postal_code, b.street_address 
from departments a, locations b
where a.manager_id is not null
and a.location_id = b.location_id
order by a.department_id asc;

--관리자 지정된 부서의 
--부서아이디, 부서명, 관리자아이디, 관리자 이름을 조회하기
select a.department_id, a.department_name, a.manager_id,b.employee_id, b.first_name
from departments a, employees b 
where a.manager_id is not null
and a.manager_id = b.employee_id; 

--3개 이상의 테이블 조인하기
-- 급여를 12000이상 받은 사원의
--사원아이디,이름,급여,직종아이디,직종제목,소속부서아이디,소속부서명을 조회하기
select a.employee_id, a.salary
        , b.job_id, b.job_title
        , c.department_id, c.department_name
from employees a, jobs b, departments c
where a.salary >= 12000
and a.job_id = b.job_id
and a.department_id = c.department_id;

--부서 관리자가 지정된 부서의 
--부서아이디, 부서명, 관리자의 직원아이디, 직원명, 위치 아이디, 도시명, 주소 조회하기
select a.department_id, a.department_name
        , b.manager_id, b.first_name
        , c.location_id, c.city, c.street_address
from departments a, employees b, locations c 
where a.manager_id is not null
and a.manager_id = b.employee_id
and a.location_id = c.location_id;

--부서 관리자가 지정된 부서의
--부서아이디, 부서명, 위치 아이디, 도시명, 주소, 국가아이디, 국가명 조회하기
select a.department_id, a.department_name
        , b.location_id, b.city, b.street_address
        , c.country_id, c.country_name 
from departments a, locations b, countries c
where a.manager_id is not null 
and a.location_id = b.location_id
and b.country_id = c.country_id;

--Seattle에서 근무하는
--Seattle에 소재한 부서에서 근무하는 직원의 아이디, 이름, 직종,소속부서 아이디, 소속부서명을 조회하기
select b.employee_id, b.first_name, b.job_id, c.department_id, c.department_name
from locations a, employees b, departments c 
where a.city = 'Seattle'
and a.location_id = c.location_id
and b.department_id = c.department_id
order by b.employee_id;

--직종 변경 이력에서
--직원아이디, 직원이름, 업무시작일, 업무종료일, 직종아이디, 직종제목, 소속부서아이디, 부서명 조회하기
select h.employee_id, e.first_name, h.start_date, h.end_date, j.job_id, j.job_title, d.department_id, d.department_name
from job_history h, employees e, jobs j, departments d
where h.employee_id = e.employee_id
and h.job_id = j.job_id
and h.department_id = d.department_id
order by h.employee_id asc, h.start_date asc;

--job_grades 테이블 생성하기
create table job_grades (
    gra         char(2)     primary key,
    lowest_sal  number(6,0) not null,
    highest_sal number(6,0) not null
);

insert into job_grades values('A', 1000, 2999);
insert into job_grades values('B', 3000, 5999);
insert into job_grades values('C', 6000, 9999);
insert into job_grades values('D', 10000, 14999);
insert into job_grades values('E', 15000, 24999);
insert into job_grades values('F', 25000, 40000);

commit;

--비등가 조인
-- 50번 부서에 소속된 직원의 급여 등급을 조회하기
--직원아이디, 이름, 급여, 급여 등급
select e.employee_id, e.first_name, g.lowest_sal, e.salary, g.highest_sal, g.gra
from employees e, job_grades g
where e.department_id = 50
and e.salary >= g.lowest_sal and e.salary <= g.highest_sal
order by e.employee_id asc;

select e.employee_id, e.first_name, e.salary, g.gra
from employees e, job_grades g
where e.salary between g.lowest_sal and g.highest_sal
order by e.employee_id asc;

--직종별 최저급여의 등급 조회하기
--직종아이디, 직종제목, 직종최저급여, 급여등급, 직종최고급여, 급여등급
--동일한 테이블을 여러번 사용할 수 있다. -> 다른 별칭을 사용해서 사용
select j.job_id, j.job_title, j.min_salary, g.gra min_salary_gra, j.max_salary, jg.gra max_salary_gra
from jobs j, job_grades g, job_grades jg
where j.min_salary >= g.lowest_sal and j.min_salary <= g.highest_sal 
and j.max_salary >= jg.lowest_sal and j.max_salary <= jg.highest_sal
order by j.job_id asc;










