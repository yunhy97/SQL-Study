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

--exists 연산자 사용하기
--부하직원을 가지고 있는 직원을 조회하기
select *
from employees 상사
where (select count(*)
        from employees 부하
        where 부하.manager_id = 상사.employee_id) > 0;  --count() 사용 비추천

select *
from employees 상사
where exists (select 1
                from employees 부하
                where 부하.manager_id = 상사.employee_id);  --exists 사용 추천
                
-- with 절
with 
dept_costs AS   --부서이름, 부서총급여
    (select B.department_name, sum(A.salary) as dept_total
    from employees A, departments B
    where A.department_id = B.department_id
    group by B.department_name),  --가상의 테이블
avg_cost AS     --부서별 총 급여에 대한 평균급여
    (select sum(dept_total)/count(*) as dept_avg
    from dept_costs)  --가상의 테이블
select *
from dept_costs
where dept_total > (select dept_avg     --부서총급여가 평균급여
                    from avg_cost)
order by department_name;

--118번 사원의 상사를 조회하기
select employee_id, first_name, manager_id
from employees
start with employee_id = 118
connect by prior manager_id=employee_id;

--101번 직원의 모든 부하 조회하기
select lpad(employee_id, level*4,' '), first_name, manager_id
from employees
start with employee_id = 101
connect by prior employee_id = manager_id;

--100(사장)번 직원의 부하직원 조회
select lpad(first_name, length(first_name) + level*5-5, ' ')
from employees
start with employee_id = 100
connect by prior employee_id = manager_id;

--100의 모든 부하직원 조회, connect by에서 Neena는 제외(Neena의 부하도 제외)
select lpad(first_name, length(first_name) + level*5-5, ' ')
from employees
start with employee_id = 100
connect by prior employee_id = manager_id
and first_name != 'Neena';

--100의 모든 부하직원 조회, where절에서 Neena는 제외(Neena만 제외), 오류
select lpad(first_name, length(first_name) + level*5-5, ' ')
from employees
where first_name != 'Neena'
start with employee_id = 100
connect by prior employee_id = manager_id;

--100의 부하직원 조회하기
select lpad(first_name, length(first_name) + level*5-5, ' ')
from employees
start with employee_id = 100
connect by prior employee_id = manager_id 
and level <= 2;

--2020/01/01 ~ 2020/12/31날짜 만들기
select to_date('2020/01/01','yyyy/mm/dd') + level-1
from dual
connect by level <= 366;

--2005년도 월별 입사자 수를 조사
select to_char(hire_date, 'yyyy-mm'), count(*)
from employees
where to_char(hire_date, 'yyyy') ='2003'
group by to_char(hire_date, 'yyyy-mm')
order by 1;

with 
months as 
   (select '2003-' || 
        case 
            when level < 10 then '0' || level
            else to_char(level)
        end mon
    from dual
    connect by level <= 12),
month_emp_count as
    (select to_char(hire_date, 'yyyy-mm') mon, count(*) cnt
     from employees
     where to_char(hire_date, 'yyyy') ='2003'
     group by to_char(hire_date, 'yyyy-mm'))
select A.mon,nvl(B.cnt,0)
from months A, month_emp_count B
where A.mon = B.mon(+)
order by 1;

























