--사용자함수 실행1
select employee_id, first_name, salary, get_annual_salary(employee_id)
from employees
where department_id = 60;

--사용자함수2
--지정된 부서에 소속된 사원수를 반환하는 함수
CREATE or replace function GET_EMP_COUNT
(i_dept_id in number)

RETURN number

IS
    v_emp_count number(3,0);
BEGIN
    select count(*)
    INTO v_emp_count
    from employees
    where department_id = i_dept_id;
    
    RETURN v_emp_count;
END;





































