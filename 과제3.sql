--1. 모든 직원들의 모든 업무아이디를 조회하기
select distinct job_id
from employees;

--2. 급여를 12,000달러 이상 받는 직원의 이름과 급여를 조회하기
select first_name, salary
from employees
where salary >= 12000;

--확인
--3. 직원번호가 176번 직원과 같은 부서에서 근무하는 직원의 아이디와 이름 직종아이디를 조회하기
select e.employee_id, e.first_name, e.job_id
from employees e, departments d, departments dd
where employee_id =176
and e.department_id = d.department_id
and dd.department_id = d.department_id;

--4. 급여를 12,000달러 이상 15,000달러 이하 받는 직원들의 직원 아이디와 이름과 급여를 조회하기
select employee_id, first_name, salary
from employees
where salary >=12000 and salary<=15000;

--5. 2005년 1월 1일부터 2005년 6월 30일 사이에 입사한 직원의 아이디, 이름, 업무아이디, 입사일을 조회하기
select employee_id, first_name, job_id, hire_date
from employees
where hire_date >= to_date('2005-01-01','yyyy-mm-dd')
and hire_date <= to_date('2005-06-30', 'yyyy-mm-dd');

--6. 급여가 5,000달러와 12,000달러 사이이고, 부서번호가 20 또는 50인 직원의 이름과 급여를 조회하기
select first_name, salary
from employees
where salary between 5000 and 12000 
and department_id in(20,50);

--7. 관리자가 없는 직원의 이름과 업무아이디를 조회하기
select first_name, job_id
from employees
where manager_id is null;

--8. 커미션을 받는 모든 직원의 이름과 급여, 커미션을 급여 및 커미션의 내림차순으로 정렬해서 조회하기
select first_name, salary, commission_pct
from employees
where commission_pct is not null
order by salary desc, commission_pct desc;

--9. 이름의 2번째 글자가 e인 모든 직원의 이름을 조회하기
select first_name
from employees
where first_name like '_e%';

--10. 업무아이디가 ST_CLERK 또는 SA_REP이고 급여를 2,500달러, 3,500달러, 7,000달러 받는 모든 직원의 이름과 업무아이디, 급여를 조회하기
select first_name, job_id, salary
from employees
where job_id in('ST_CLERK', 'SA_REP')
and salary in(2500,3500,7000);

--11. 모든 직원의 이름과 입사일, 근무 개월 수를 계산하여 조회하기, 근무개월 수는 정수로 반올림하고, 근무개월수를 기준으로 오름차순으로 정렬하기
select first_name, hire_date, round(months_between(sysdate, hire_date)) month_hire
from employees
order by month_hire;

--12. 직원의 이름과 커미션을 조회하기, 커미션을 받지 않는 직원은 '없음'으로 표시하기
select first_name, nvl(to_char(commission_pct),'없음')
from employees;

--13. 모든 직원의 이름, 부서번호, 부서이름을 조회하기
select e.first_name, d.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id;

--14. 80번부서에 소속된 직원의 이름과 업무아이디, 업무제목, 부서이름을 조회하기
select e.first_name, j.job_id, j.job_title, d.department_name
from employees e, jobs j, departments d
where e.job_id = j.job_id
and e.department_id = d.department_id
and e.department_id = 80
order by first_name;

--15. 커미션을 받는 모든 직원의 이름과 업무아이디, 업무제목, 부서이름, 부서소재지 도시명을 조회하기
select e.first_name, j.job_id, j.job_title, d.department_name, l.city
from employees e, jobs j, departments d, locations l
where e.commission_pct is not null
and e.job_id = j.job_id
and e.department_id = d.department_id(+)
and d.location_id = l.location_id(+);

--16. 유럽에 소재지를 두고 있는 모든 부서아이디와 부서이름을 조회하기
select d.department_id, d.department_name
from departments d, locations l, countries c, regions r
where d.location_id = l.location_id
and l.country_id = c.country_id
and c.region_id = r.region_id
and r.region_name = 'Europe';

--17. 직원의 이름과 소속부서명, 급여, 급여 등급을 조회하기
select e.first_name, d.department_name, e.salary, g.gra
from employees e, departments d, job_grades g
where e.department_id = d.department_id
and e.salary >= g.lowest_sal and e.salary <= g.highest_sal;

--18. 직원의 이름과 소속부서명, 소속부서의 관리자명을 조회하기, 
--소속부서가 없는 직원은 소속부서명 '없음, 관리자명 '없음'으로 표시하기
select e.first_name, nvl(d.department_name,'없음'), nvl(em.first_name,'없음')
from employees e, departments d, employees em
where e.department_id = d.department_id(+)
and d.manager_id = em.employee_id(+);

--19. 모든 사원의 이름, 직종아이디, 급여, 소속부서명을 조회하기
select e.first_name, e.job_id, e.salary, d.department_name
from employees e, departments d
where e.department_id = d.department_id;

--20. 모든 사원의 이름, 직종아이디, 직종제목, 급여, 최소급여, 최대급여를 조회하기
select e.first_name, j.job_id, j.job_title, e.salary, g.lowest_sal, g.highest_sal
from employees e, jobs j, job_grades g
where e.job_id = j.job_id
and e.salary >= g.lowest_sal
and e.salary <= g.highest_sal;

--21. 모든 사원의 이름, 직종아이디, 직종제목, 급여, 최소급여와 본인 급여의 차이를 조회하기
select e.first_name, j.job_id, j.job_title, e.salary, e.salary-j.min_salary
from employees e, jobs j
where e.job_id = j.job_id;

--22. 커미션을 받는 모든 사원의 아이디, 부서이름, 소속부서의 소재지(도시명)을 조회하기
select e.employee_id, d.department_id, d.department_name, l.city
from employees e, departments d, locations l
where e.commission_pct is not null
and e.department_id = d.department_id
and d.location_id = l.location_id;

--23. 이름이 A나 a로 시작하는 모든 사원의 이름과 직종, 직종제목, 급여, 소속부서명을 조회하기
select e.first_name, j.job_id, j.job_title, e.salary, d.department_name
from employees e, jobs j, departments d
where (e.first_name like 'A%' or e.first_name like 'a%')
and e.job_id = j.job_id
and e.department_id = d.department_id;

--24. 30, 60, 90번 부서에 소속되어 있는 사원들 중에서 100에게 보고하는 사원들의 이름, 직종, 급여,
--    급여등급을 조회하기
select first_name, job_id, salary, gra
from employees e, job_grades g
where e.department_id in(30,60,90)
and e.manager_id = 100
and e.salary >= g.lowest_sal and e.salary <= g.highest_sal;

--25. 80번 부서에 소속된 사원들의 이름, 직종, 직종제목, 급여, 최소급여, 최대급여, 급여등급, 
--    소속부서명을 조회하기
select e.first_name, j.job_id, j.job_title, e.salary, g.lowest_sal, g.highest_sal, g.gra, d.department_name
from employees e, jobs j, job_grades g, departments d
where e.department_id =80
and e.job_id = j.job_id
and e.department_id = d.department_id
and e.salary >= g.lowest_sal and e.salary <= g.highest_sal
order by e.first_name;

--26. 사원들중에서 자신의 상사보다 먼저 입사한 사원들의 이름, 입사일, 상사의 이름, 상사의 입사일을
--    조회하기
select e.first_name,e.hire_date, em.first_name, em.hire_date
from employees e, employees em
where e.manager_id = em.employee_id
and e.hire_date < em.hire_date;

--27. 부서명이 IT인 부서에 근무하는 사원들의 이름과, 직종, 급여, 급여등급, 상사의 이름과 직종을
--    조회하기
select e.first_name, e.job_id, e.salary, g.gra, em.first_name, em.job_id
from employees e, employees em, job_grades g, departments d
where e.employee_id = em.employee_id
and e.department_id = d.department_id
and e.salary >= g.lowest_sal and e.salary <= g.highest_sal
and d.department_name = 'IT';

--28. 'ST_CLERK'로 근무하다가 다른 직종으로 변경한 사원의 아이디, 이름, 변경전 부서명,
--     현재 직종, 현재 근무부수명을 조회하기
select e.employee_id, e.first_name, dh.department_name, e.job_id, d.department_name, h.employee_id
from employees e, departments d, job_history h, departments dh
where e.department_id = d.department_id
and e.job_id =h.job_id
and dh.department_id = h.department_id
and h.job_id = 'ST_CLERK';












