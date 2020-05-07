--셀프조인(자체조인)
--101번 사원의 이름, 직종, 자신의 상사이름을 조회하기
select e.first_name "직원명", e.job_id "직원의 직종", em.first_name "상사의 이름"
from employees e, employees em
where e.employee_id = 101
and e.manager_id = em.employee_id;

--60번 부서에 근무중인 사원의 아이디, 이름, 사원의 직종, 상사의 이름, 상사의 직종, 
--부서아이디, 부서명, 부서관리자 아이디, 부서관리자 이름을 조회하기
select e.employee_id 직원아이디, e.first_name 직원이름, e.job_id 직원직종
        , em.first_name 상사이름, em.job_id 상사직종
        , d.department_id 직원부서아이디, d.department_name 직원부서명, d.manager_id 부서관리자아이디
        , emm.first_name 부서관리자이름
from employees e, employees em, departments d, employees emm
where d.department_id = 60
and e.manager_id = em.employee_id       --직원과 상사간의 조인조건
and e.department_id = d.department_id   --직원과 부서간의 조인조건
and emm.employee_id = d.manager_id;     --부서와 부서관리자간의 조인조건

--포괄조인
--부서아이디, 부서명, 부서관리자아이디, 부서관리자 이름 조회하기
select d.department_id, d.department_name, d.manager_id, e.first_name
from departments d, employees e
where d.manager_id = e.employee_id(+)
order by department_id;

--모든 직원의 이름, 급여, 직종아이디, 소속부서명을 조회하기
select e.first_name, e.salary, e.job_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+)
order by e.employee_id;

--다중행 함수 사용하기
--employees의 모든 행의 갯수 조회하기
select count(*)
from employees;

--50번 부서에서 일하는 직원의 수를 조회하기
select count(*)
from employees
where department_id = 50;

--커미션을 받는 직원의 수를 조회하기
select count(commission_pct)  --컬럼을 지정하면 해당 컬럼의 값이 null이 아닌 것만 카운트한다.
from employees;

--커미션을 받는 직원의 수를 조회하기
select count(*)
from employees
where commission_pct is not null;

--직원들 중에서 최고급여, 최저급여를 받는 직원의 급여를 조회하기
select max(salary), min(salary)
from employees;

--최고급여를 받는 사람의 이름과 최고급여를 조회하기
--같이 적을 수가 없다.
select first_name, max(salary)  --오류: 그룹함수와 그룹함수가 아닌 표현식을 같이 사용할 수 없다.
from employees;

select first_name, salary
from employees
where salary = (select max(salary)
                from employees);
                
--조회된 행의 갯수를 구하기
--count(*) : 조회된 모든 행의 갯수를 반환한다.
--count(컬럼명) : 해당 컬럼의 값이 null이 아닌 행의 갯수를 반환한다.
--count(distinct 컬럼명) : 해당 컬럼의 값에 대해 중복된 값은 1번만 카운트해서 행의 갯수를 반환한다.
select count(*)
from employees;                 --107

select count(job_id)
from employees;                 --107

select count(distinct job_id)
from employees;                 --19

select count(distinct to_char(hire_date, 'yyyy'))
from employees;                 --8

--조회된 행의 특정 컬럼에 대한 합계를 구하기
--sum(컬럼명) : 해당 컬럼의 값 중에서 null을 제외한 값들의 합계를 반환한다.
select sum(salary)              --전체 사원들의 급여 총액
from employees;                 --691416

select sum(commission_pct)      --전체 사원들의 커미션에 대한 합계, 커미션 값이 null인 것은 계산에 포함되지 않음
from employees;                 --7.8

--조회된 행의 특정 컬럼에 대한 평균을 구하기
--avg(컬럼명) : 해당 컬럼의 값 중에서 null을 제외한 값을 가진 행들에 대한 평균값으 반환한다.
select trunc(avg(salary))       --전체 직원들의 급여 평균
from employees;                 --6461

select trunc(avg(commission_pct),2) --전체 사원들의 커미션에 대한 평균, 커미션 값이 null인 것은 계산에 포함되지 않음
from employees;                 --0.22

--조회된 행의 특정 컬럼에 대한 최대값, 최소값 구하기
--min(컬럼명) : 해당 컬럼의 값 중에서 null을 제외한 가장 작은 값을 반환한다.
--max(컬럼명) : 해당 컬럼의 값 중에서 null을 제외한 가장 큰 값을 반환한다.
select min(salary),max(salary)
from employees;                 -- 2100   24000

select min(commission_pct), max(commission_pct)
from employees;                 -- 0.1    0.4

--group by와 그룹함수를 사용해서 데이터 집계하기
--직종별 직원수를 조회하기
--group by 절에 등장한 컬럼명은 조회가능하다.
select job_id, count(*)
from employees
group by job_id;

--입사년도별 사원 수 조회하기
select to_char(hire_date, 'yyyy'), count(*)
from employees
group by to_char(hire_date, 'yyyy')
order by 1;