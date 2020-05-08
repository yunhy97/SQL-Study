--사용자함수 실행4
--부서아이디, 부서명, 부서에 소속된 사원수, 부서의 총 연봉 조회하기
select department_id, 
       department_name, 
       get_emp_count(department_id), 
       get_dept_total_salary(department_id)
from departments;