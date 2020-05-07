--1. 급여가 5000이상 12000이하인 사원의 아이디, 이름, 급여를 조회하기
select employee_id, first_name, salary
from employees
where salary between 5000 and 12000;

--2. 사원들이 소속된 부서의 부서명을 중복없이 조회하기
select distinct department_name
from departments d, employees e
where e.department_id = d.department_id;

--3. 2007년에 입사한 사원의 아이디, 이름, 입사일을 조회하기
select employee_id, first_name, hire_date
from employees
where to_char(hire_date,'yyyy') = '2007';

--4. 급여가 5000이상 12000이하이고, 20번과 50번 부서에 소속된 사원의 아이디, 이름, 급여, 소속부서명을 
--   조회하기
select e.employee_id, e.first_name, e.salary, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and e.salary between 5000 and 12000
and e.department_id in(20,50);

--5. 100직원에게 보고하는 사원의 아이디, 이름, 급여, 급여등급을 조회하기
select e.employee_id, e.first_name, e.salary, g.gra
from employees e, job_grades g
where e.salary>=g.lowest_sal and e.salary <= g.highest_sal
and e.manager_id = 100
order by employee_id;

--6. 80번 부서에 소속되어 있고, 80번 부서의 평균급여보다 적은 급여를 받는 사원의 아이디, 이름, 
--   급여를 조회하기
select employee_id, first_name, salary
from employees
where department_id = 80
and salary < (select avg(salary)
                        from employees
                        where department_id = 80
                        group by department_id);

--7. 50번 부서에 소속된 사원 중에서 해당 직종의 최소급여보다 2배 이상의 급여를 받는 사원의 아이디, 
--   이름, 급여를 조회하기
select e.employee_id, e.first_name, e.salary
from employees e, jobs j
where e.department_id = 50
and j.min_salary*2 <= e.salary
and e.job_id = j.job_id
order by e.employee_id;

--8. 사원들 중에서 자신의 상사보다 먼저 입사한 사원의 아이디, 이름, 입사일, 상사의 이름, 
--   상사의 입사일을 조회하기
select e.employee_id, e.first_name, e.hire_date, ee.first_name, ee.hire_date
from employees e, employees ee
where e.employee_id = ee.manager_id
and e.hire_date < ee.hire_date;

--?9. Steven King과 같은 부서에서 근무하는 사원의 아이디와 이름을 조회하기
select employee_id, first_name
from (select employee_id, first_name, department_id
        from employees
        where first_name = 'Steven King') a, departments d
where a.department_id = d.department_id;

--10. 관리자별 사원수를 조회하기, 관리자 아이디, 사원수를 출력한다. 관리자 아이디순으로 오름차순 정렬
select manager_id, count(*)
from employees
group by manager_id
order by manager_id asc;

--11. 커미션을 받는 사원의 아이디, 이름, 급여, 커미션을 조회하기
select employee_id, first_name, salary, commission_pct
from employees
where commission_pct is not null;

--12. 급여를 가장 많이 받는 사원 3명의 아이디, 이름, 급여를 조회하기
select num, employee_id, first_name, salary
from (select row_number() over(order by salary desc) num,employee_id, salary, first_name
        from employees)
where num <=3;

--?13. 'Ismael'과 같은 해에 입사했고, 같은 부서에 근무하는 사원의 아이디, 이름, 입사일을 조회하기
select employee_id, first_name, hire_date
from employees;

--14. 'Renske'에게 보고받는 사원의 아이디와 이름, 급여, 급여 등급을 조회하기
select e.employee_id, e.first_name, e.salary, g.gra
from employees e, job_grades g, employees ee
where e.salary >= g.lowest_sal and e.salary <= g.highest_sal
and e.employee_id = ee.manager_id
and ee.first_name = 'Renske';

--15. 사원테이블의 급여를 기준으로 급여등급을 조회했을 때, 급여등급별 사원수를 조회하기
select g.gra, count(*)
from employees e, job_grades g
where  g.lowest_sal <= e.salary and e.salary >= g.highest_sal
group by g.gra;

--16. 입사자가 가장 적은 년도와 그 해에 입사한 사원수를 조회하기
select hire_date, count(*)
from employees
where to_char(hire_date,'yyyy') = (select min(to_char(hire_date,'yyyy'))
                                     from employees)
group by hire_date;

--17. 관리자별 사원수를 조회했을 때 관리자하는 사원수가 10명을 넘는 관리자의 아이디와 사원수를 조회하기
select manager_id, count(*)
from employees
group by manager_id
having count(*) > 10;

--18. 'Europe'지역에서 근무중이 사원의 아이디, 이름, 소속부서명, 소재지 도시명, 나라이름을 조회하기
select e.employee_id, e.first_name, d.department_name, l.city, c.country_name
from employees e, departments d, locations l, countries c, regions r
where e.department_id = d.department_id
and d.location_id = l.location_id
and c.country_id = l.country_id
and r.region_id = c.region_id
and r.region_name = 'Europe'
order by employee_id;

--19. 전체 사원의 사원아이디, 이름, 급여, 소속부서아이디, 소속부서명, 상사의 이름을 조회하기
select e.employee_id, e.first_name, e.salary, d.department_id, d.department_name, ee.first_name
from employees e, employees ee, departments d
where e.employee_id = ee.manager_id
and e.department_id = d.department_id;

--?20. 50번 부서에 근무중이 사원들의 급여를 500달러 인상시키기

--21. 사원의 아이디, 이름, 급여, 보너스를 조회하기,
--    보너스는 20000달러 이상은 급여의 10%, 10000달러 이상은 급여의 15%, 그 외는 급여의 20%를 지급한다.
select employee_id, first_name, salary
    , CASE
        when salary >= 20000 then salary+salary*0.1
        when salary >= 10000 then salary+salary*0.15
        else salary+salary*0.2
    END as 보너스
from employees
order by employee_id;

--?X22. 소속부서에서 입사일이 늦지만, 더 많은 급여를 받는 사원의 이름, 입사일, 소속부서명, 급여를 조회하기
select first_name, hire_date, department_name, salary;

--23. 부서별 평균급여를 조회했을 때 부서별 평균급여가 10000달러 이하인 부서의 아이디, 부서명, 평균급여를
--    조회하기 (평균급여는 소숫점 1자리까지만 표시)

--24. 사원들 중에서 자신 종사하고 있는 직종의 최대급여와 동일한 급여를 받는 사원의 아이디, 이름, 급여를
--    조회하기

----25. 분석함수를 사용해서 사원들을 급여순으로 정렬하고, 순번을 부여했을 때 6~10번째 속하는 순번,
--    사원의 아이디, 이름, 급여, 급여등급을 조회하기
select num, e.employee_id, e.first_name, e.salary, g.gra
from (select row_number() over(order by salary asc) num, employee_id, first_name, salary
        from employees) e, job_grades g
where  g.lowest_sal <= e.salary and e.salary >= g.highest_sal
and num <=6;









