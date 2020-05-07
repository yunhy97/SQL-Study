-- 1.  시스템의 현재 날짜와 시간 조회하기 (dual 사용)
select sysdate
from dual;

-- 2.  급여를 5000달러 이상받고, 2005년에 입사한 직원의 아이디, 이름, 급여, 입사일을 조회하기
select employee_id, first_name, salary, hire_date
from employees
where salary >= 5000
and to_char(hire_date, 'YYYY') = '2005';
--hire_date >= to_date('2005/01/01','yyyy/mm/dd')
--and hire_date < to_date('2006/01/01', 'yyyy/mm/dd')'

-- 3.  이름에 e나 E가 포함된 직원 중에서 급여를 10000달러 이상 받는 직원의 아이디, 이름, 급여를 조회하기
select employee_id, first_name, salary
from employees
where (first_name like'%e%'
or first_name like '%E%')
and salary >= 10000;

-- 4.  입사년도와 상관없이 4월에 입사한 직원들의 아이디, 이름, 입사일을 조회하기
select employee_id, first_name, hire_date
from employees
where to_char(hire_date,'mm') = '04';

-- 5.  2006년 상반기(1/1 ~ 6/30)에 입사한 직원들의 아이디, 이름, 입사일 조회하기
select employee_id, first_name, hire_date
from employees
where hire_date >= to_date('2006-01-01','yyyy-mm-dd')
and hire_date <= to_date('2006-06-30', 'yyyy-mm-dd');

-- 6.  50번 부서에 소속된 직원들의 급여를 13%인상시키려고 한다.
--     직원아이디, 이름, 현재 급여, 인상된 급여를 조회하기
--     인상된 급여는 소숫점 이하는 버린다.
select employee_id, first_name, salary, trunc(salary+(salary*0.13))
from employees
where department_id = 50;
-- 7.  50번 부서에 소속된 직원들의 급여를 조회하려고 한다.
--     직원 아이디, 이름, 급여 그리고, 급여 1000달러당 *를 하나씩 표시하라.
--     120 Matthew 8000 ********
--     122 Shanta  6500 ******
select employee_id, first_name, salary, lpad('*',(salary/1000),'*')
from employees
where department_id = 50;

-- 8.  관리자가 지정되어 있지 않는 부서의 
--     부서아이디, 부서명, 위치아이디, 도시명, 주소를 조회하기
select d.department_id, d.department_name, l.location_id, l.city, l.street_address
from departments d,locations l
where d.manager_id is null
and d.location_id = l.location_id
order by department_id asc;

-- 9.  90번 부서에 소속된 직원의 직원아이디, 이름, 직종, 급여를 조회하기
select employee_id, first_name, job_id, salary
from employees
where department_id = 90;

-- 10. 100번 직원이 부서관리자로 지정된 부서에 소속된 직원의 직원아이디, 이름, 직종, 급여를 조회하기
select e.employee_id, e.first_name, e.job_id, e.salary
from employees e, departments d 
where d.manager_id = 100
and e.department_id = d.department_id;

-- 11. 10, 20, 30번 부서에 소속된 직원들의 직원아이디, 이름, 급여, 급여등급을 조회하기
select e.employee_id, e.first_name, e.salary, g.gra
from employees e, job_grades g
where department_id in(11,10,20,30)
and e.salary >= g.lowest_sal and e.salary <= g.highest_sal;

-- 12. 직원들의 직종정보를 참고했을 때 자신이 종사하고 있는 직종의 최저급여를 받고 있는
--     직원의 아이디, 이름, 급여, 직종아이디, 직종최저급여를 조회하기
select e.employee_id, e.first_name, e.salary, j.job_id, j.min_salary
from employees e, jobs j
where e.job_id=j.job_id
and e.salary = j.min_salary;

-- 13. 커미션을 받는 직원들의 직원아이디, 이름, 커미션, 급여, 직종아이디, 직종제목, 급여, 소속부서 아이디, 부서명을 조회하기
select e.employee_id, e.first_name, e.commission_pct, e.salary, j.job_id, j.job_title, d.department_id, d.department_name
from employees e, jobs j, departments d
where commission_pct is not null
and e.job_id = j.job_id
and e.department_id = d.department_id
order by employee_id asc;

-- 14. 'Canada'에서 근무하고 있는 직원의 아이디, 이름, 소속부서 아이디, 소속부서명, 위치 아이디, 도시명, 주소를 조회하기
select e.employee_id, e.first_name, d.department_id, d.department_name, l.location_id, l.city, l.street_address
from employees e, departments d, locations l, countries c
where c.country_name = 'Canada'
and e.department_id = d.department_id
and d.location_id = l.location_id
and c.country_id = l.country_id;

-- 15. 모든 직원의 직원아이디, 이름, 직종아이디, 직종제목, 급여, 급여등급, 소속부서 아이디, 소속부서명, 도시명을 조회하기
select e.employee_id, e.first_name, j.job_id, j.job_title, e.salary, g.gra, d.department_id, d.department_name, l.city
from employees e, departments d, jobs j, job_grades g, locations l
where e.job_id = j.job_id
and e.department_id = d.department_id
and d.location_id = l.location_id
and e.salary >= g.lowest_sal and e.salary <= g.highest_sal;

-- 16. 급여를 5000달러 이하로 받는 직원들의 아이디, 이름, 직종, 소속부서 아이디, 소속부서명, 소속부서 관리자 직원아이디, 
--     소속부서 관리자 직원이름을 조회하기
select e.employee_id, e.first_name, e.job_id, d.department_id, d.department_name, d.manager_id, ee.first_name
from employees e, departments d, employees ee
where e.salary <= 5000
and e.department_id = d.department_id
and ee.employee_id = d.manager_id
order by e.employee_id;

-- 17. 'Asia'지역에 소재지를 두고 있는 부서의 아이디, 부서명, 부서관리자 이름을 조회하기
select d.department_id, d.department_name, e.first_name
from departments d, locations l, countries c, regions r, employees e
where e.employee_id = d.manager_id
and d.location_id = l.location_id
and l.country_id = c.country_id
and c.region_id = r.region_id
and r.region_name = 'Asia';

-- 18. 101번 직원이 근무했던 부서에서 근무중이 직원의 아이디, 이름, 부서아이디, 부서명을 조회하기
select distinct e.employee_id, e.first_name, d.department_id, d.department_name
from employees e, departments d , job_history h
where e.department_id = d.department_id
and d.department_id = h.department_id
and h.employee_id = 101;

-- 19. 직원중에서 자신이 종사하고 있는 직종의 최고급여 50%이상을 급여로 받고 있는 
--     직원의 아이디, 이름, 급여, 직종아이디, 직종 최고급여를 조회하기
select e.employee_id, e.first_name, e.salary, j.job_id, j.max_salary
from employees e, jobs j
where e.job_id = j.job_id
and e.salary >= j.max_salary/2;

-- 20. 미국(US)에 위치하고 있는 부서의 아이디, 이름, 위치번호, 도시명, 주소를 조회하기 
select d.department_id, e.first_name, l.location_id, l.city, l.street_address
from departments d, locations l, employees e
where d.department_id = e.department_id
and d.location_id = l.location_id
and l.country_id = 'US'
order by d.department_id asc;