-- 다중열 서브쿼리 사용하기
-- 'Karen'과 같은 직종에 종사하고, 같은 부서에 소속되어있는 사원의 아이디, 이름, 직종, 부서아이디 조회하기
select *
from employees
where (job_id, department_id) in (select job_id, department_id
                                  from employees
                                  where first_name = 'Karen');
                                  
-- 부서별 최고 급여를 받는 사원의 아이디, 이름, 급여, 부서아이디를 조회하기
select department_id, max(salary)
from employees
where department_id is not null
group by department_id;

select employee_id, first_name, job_id, salary, department_id
from employees
where (department_id, salary) in (select department_id, max(salary)
                                from employees
                                where department_id is not null
                                group by department_id)
order by employee_id;

--스칼라 서브쿼리 사용하기
--전체 평균보다 적은 급여를 받는 사원의 아이디, 이름, 급여, 평균급여, 평균급여와의 차이를 조회하기
select employee_id, first_name, salary,
    trunc((select avg(salary) from employees) - salary) salary_gap      --스칼라 서브쿼리 : 1행1열
from employees
where salary < (select avg(salary)
                from employees)
order by salary_gap;
                
--20000달러 이상은 평균 급여의 10%를 보너스로, 10000달러 이상은 15%, 그 외는 20%를
--보너스로 지급하려고 한다. 아이디, 이름, 급여, 보너스 조회하기
select employee_id, first_name, salary,
    case
        when salary >= 20000 then trunc((select avg(salary) from employees)*0.1)
        when salary >= 10000 then trunc((select avg(salary) from employees)*0.15)
        else trunc((select avg(salary) from employees)*0.2)
    end bonus
from employees;

--전체 평균급여보다 급여를 많이 받는 사원의 이름, 급여를 조회하기
select first_name, salary
from employees
where salary > (select avg(salary)
                from employees);

--자신이 소속된 소속부서의 평균급여보다 많은 급여를 받는 사원의 이름, 급여를 조회하기
select outter.first_name, outter.salary
from employees outter
where outter.commission_pct is null 
and outter.salary > (select avg(inner.salary)
                        from employees inner
                        where inner.department_id = outter.department_id);
--외부 SQL문이 먼저 실행되어서 행을 가져온다.(후보행)
--후보행의 행마다 department_id값을 가져와서 서브쿼리를 실행한다.
--서브쿼리의 결과값을 사용해서 후보행을 검증한다.
--후보행이 남지 않을 때까지 반복한다.

select to_date('20200101', 'yyyymmdd') + level -1
from dual
connect by level <=31;

--부서아이디, 부서명, 해당부서의 사원수를 조회하기
select outter.department_id, outter.department_name,
    (select count(*)
    from employees inner
    where inner.department_id = outter.department_id) cnt
from departments outter;









