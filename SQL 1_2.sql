--테이블의 모든 정보 조히하기
--사원정보 전부 조회하기
select * 
from employees;

--부서정보 전부 조회하기
select * 
from departments;

--테이블에서 열을 선택해서 조해회기
--사원아이디, 사원명, 직종아이디, 급여 조회하기
select employee_id, job_id, salary
from employees;

--직종아이디, 직종의 최소급여, 최대급여 조회하기
select job_id, min_salary, max_salary
from jobs;

--지역아이디, 도시명, 주소 조회하기
select location_id, city, street_address
from locations;

--사원아이디, 사원명, 입사일 조회하기
select employee_id,first_name, hire_date
from employees;

--연산자를 이용하기,별칭 사용하기
--사원아이디, 직종, 급여, 연봉을 조회하기
select employee_id, job_id, salary, (salary*12) AS year_money
from employees;

--사원아이디, 직종, 급여, 시급을 조회하기, 시급은 급여/(5*8)-> 반올림
select employee_id 사원아이디, job_id 직종, salary 급여, round(salary/(5*8)) AS 시급
from employees;

--행을 제한해서 조회하기
--60번 부서에서 근무하는 사원의 아이디, 이름, 직종, 부서아이디를 조회하기
select employee_id, first_name || ' ' || last_name name, job_id, salary, department_id
from employees
where department_id = 60;

--급여를 5000달러 이하로 받는 사원아이디, 이름, 직종, 급여를 조회하기
select employee_id, first_name, job_id, salary
from employees
where salary <= 5000;

--100번 직원에게 보고하는 직원의 아이디, 이름 조회하기
select employee_id, first_name
from employees
where manager_id = 100;

--100번 사원이 부서담당자로 지정된 부서의 아이디, 부서명을 조회하기
select department_id, department_name
from departments
where manager_id = 100;

--직종 최대 급여가 15000달러 이상되는 직종의 아이디, 직종제목, 최대급여 조회하기
select job_id, job_title, max_salary
from jobs
where max_salary >= 15000;

--시급을 100달러 이상받는 직원의 아이디, 이름 직종아이디, 급여, 시급을 조회하기
select employee_id, first_name, job_id, salary, round(salary/(5*8)) as time_salary
from employees
where round(salary/(5*8)) >= 100;

--이름이 Neena인 사람의 직원아이디, 이름, 이메일, 전화번호를 조회하기
select employee_id, first_name, email, phone_number
from employees
where first_name = 'Neena';

--커미션이 nulll인 직원의 직원아이디, 이름, 직종아이디, 소속부서 아이디 조회하기
select employee_id, first_name, job_id, department_id
from employees
where commission_pct is null;

--커미션이 nulll인 아닌 직원의 직원아이디, 이름, 직종아이디, 소속부서 아이디 조회하기
select employee_id, first_name, job_id, department_id
from employees
where commission_pct is not null;

--소속부서를 배정받지 못한 직원의 아이디, 이름, 입사일 조회하기
select employee_id, first_name, hire_date
from employees
where department_id is null;

--부서담당자가 지정되지 않은 부서의 아이디, 부서명을 조회하기
select department_id, department_name
from departments
where manager_id is null;

--부서 담당자가 지정된 부서의 부서아이디, 부서명, 담당자 직원아이디를 조회하기
select department_id, department_name, manager_id
from departments
where manager_id is not null;

--between A and B 사용하기
--급여가 2000이상 3000이하로 받는 사원의 아이디, 이름, 직종, 급여를 조회하기
select employee_id, first_name, job_id, salary
from employees
where salary between 2000 and 3000;

--in(값1, 값2, 값3, ...) 사용하기
--10번 부서와 20번 부서에 소속된 사원의 아이디, 이름, 소속부서 아이디 조회하기
select employee_id, first_name, department_id
from employees
where department_id in(10, 20);  

--50, 60, 70, 80번 부서에 소속되지 않은 사원의 아이디, 이름, 소속부서 아이디 조회하기
select employee_id, first_name, department_id
from employees
where department_id not in(50, 60, 70, 80);  

--국가아이디가 JP, US인 지역의 위치아이디, 주소, 국가아이디를 조회하기
select location_id, street_address
from locations
where country_id in('JP', 'US');

--직원의 직종아이디가 AD_PRES이거나 AD_VP인 직원의 아이디, 이름, 직종을 조회하기
select employee_id, first_name, job_id
from employees
where job_id in('AD_PRES','AD_VP');

--50번 혹은 60번 부서에 근무한 적이 있는 사원의 아이디, 근무시작일, 근무종료일을 조회하기
select employee_id, start_date, end_date
from job_history
where department_id in(50, 60);

--101번이나 102번 직원이 상사로 지정된 사원의 아이디, 이름, 매니저아이디를 조회하기
select employee_id, first_name, manager_id
from employees
where manager_id in(101, 102);

--직종아이디가 **_MAN인 직원의 아이디, 이름, 직종아이디, 급여를 조회하기
select employee_id, first_name, job_id, salary
from employees
where job_id like'%MAN';

--이름이 'A'로 시작하는 직원의 이름을 전부 조회하기
select first_name, last_name
from employees
where first_name like 'A%';

--이름이 'A'로 시작하고 이름이 네글자인 직원의 이름을 전부 조회하기
select first_name, last_name
from employees
where first_name like 'A___';

--이름에 'e'가 포함된 직원의 이름을 전부 조회하기
select first_name
from employees
where first_name like '%e%';

--논리 연산자를 사용해서 2개 이상의의 조건을 만족하는 행을 조회하기
--80번 부서에서 일하는 직원 중 급여가 3000 미만인 사원 아이디, 이름, 급여를 조회하기
select employee_id, first_name, salary
from employees
where department_id = 50 
and salary < 3000;

--50번 부서에서 일하는 직원 중 직종이 매니저인 직원의 직원아이디, 이름, 직종아이디, 급여를 조회하기
select employee_id, first_name, job_id, salary
from employees
where department_id = 50
and job_id like '%MAN';

--50번 부서에서 일하고 급여를 2500불 이하로 받고, 자신의 매니저가 121번인 직원의 아이디, 이름, 입사일, 급여, 직종아이디를 조회하기
select employee_id, first_name, hire_date, salary, job_id
from employees
where department_id = 50 
and salary <=2500 
and manager_id = 121;

--50번이나 60번 부서에 소속된 직원 중에서 이름이 'A;로 시작하는 직원의 아이디, 이름, 부서아이디를 조회하기
select employee_id, first_name, department_id
from employees
where department_id in (50,60) -- (department_id=50 or department_id= 60)or와and가 같이 있으면 or를 반드시 괄호를 묶어줘야됨
and first_name like 'A%';

--커미션을 받는 직원 중에서 급여를 10000달러 이상 받는 직원의 아이디, 이름, 직종, 입사일, 급여, 연봉을 조회하기
--연봉 = 급여*4*12 + 급여*커미션*4*12
select employee_id, first_name, job_id, hire_date, salary, (salary*4*12+salary*commission_pct*4*12) as year_salary
from employees
where commission_pct is not null 
and salary >= 10000;

--조인
select employee_id, first_name, job_id, hire_date, salary, employees.department_id, department_name
from employees, departments
where employees.department_id = departments.department_id
and employees.department_id = 50 and salary >=5000;

--정렬하기
--60번 부서에 소속된 사원들의 아이디, 이름, 급여, 입사일을 조회하기
--이름순으로 오름차순 정렬하기
select employee_id, first_name, hire_date, salary
from employees
where department_id = 60
order by first_name;  --asc 생략

--60번 부서에 소속된 사원들의 아이디, 이름, 급여, 입사일을 조회하기
--이름순으로 내림차순 정렬하기
select employee_id, first_name, hire_date, salary
from employees
where department_id = 60
order by first_name desc;

--60번 부서에 소속된 사원들의 아이디, 이름, 급여, 연봉,입사일을 조회하기
--연봉 오름차순 정렬하기
select employee_id, first_name, hire_date, salary, (salary*4*12) as year_salary
from employees
where department_id = 60
order by 5;   --asc 생략, 컬럼의 순번을 사용해서 정렬

--60번 부서에 소속된 사원들의 아이디, 이름, 급여, 연봉,입사일을 조회하기
--연봉 오름차순 정렬하기
select employee_id, first_name, hire_date, salary, (salary*4*12) as year_salary
from employees
where department_id = 60
order by salary*4*12;   --연산식으로 사용 

--60번 부서에 소속된 사원들의 아이디, 이름, 급여, 연봉,입사일을 조회하기
--연봉 오름차순 정렬하기
select employee_id, first_name, hire_date, salary, (salary*4*12) as year_salary
from employees
where department_id = 60
order by year_salary;   --별칭으로 사용, 추천

--실행오류
--select절에서 정의한 별칭을 where절에서 사용할 수 없다.
--select절에서 정의한 별칭은 order by절에서만 사용할 수 있다.
select employee_id, first_name, hire_date, salary, (salary*4*12) as year_salary
from employees
where department_id = 50
and year_salary >= 200000   --별칭을 사용할 수 없다. 읽어오는 순서가 from-where-select-order by이다
order by year_salary;

--50번 부서에서 근무하는 직원들의 이름, 급여를 조회하고
--급여순으로 내림차순 정렬하고, 만약 급여가 동일하면 이름순으로 오름차순 정렬하기
select first_name, salary
from employees
where department_id = 50
order by salary desc, first_name asc;   --너무 많이 정렬요소를 적지 않는다.

--단일행 함수 중 문자함수 사용하기
--사원의 아이디, 이름을 조회하기(이름을 대문자로 표시)
select employee_id
        , upper(first_name)
        , lower(first_name)
        , length(first_name)
        , concat(first_name, last_name)
        , lpad(first_name, 10, '#')
        , rpad(first_name, 10, '@')
from employees;
