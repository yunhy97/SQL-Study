--������Լ� ����1
select employee_id, first_name, salary, get_annual_salary(employee_id)
from employees
where department_id = 60;

--������Լ�2
--������ �μ��� �Ҽӵ� ������� ��ȯ�ϴ� �Լ�
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





































