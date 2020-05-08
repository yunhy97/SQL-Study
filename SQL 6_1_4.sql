--�μ����̵�, ����� ��ȸ�ϱ�
select a.department_id, b.department_name, a.cnt
from (select department_id, count(*) cnt
        from employees
        group by department_id) a, departments b
where a.department_id = b.department_id;

--������Լ� ����2
select department_id, department_name, get_emp_count(department_id)
from departments;

--������Լ�3
--������� ��ü ���� �Ѿ��� ����ϱ�
CREATE or replace function GET_TOTAL_SALARY
RETURN number

IS
    v_total_salary number := 0;
    v_salary            employees.salary%type;
    v_comm              employees.commission_pct%type;
    v_annual_salary     employees.salary%type;
    --Ŀ�� ����
    CURSOR emp_list IS
    select salary, nvl(commission_pct,0) comm
    from employees;
    
BEGIN
    --Ŀ���� for������ �����Ų��.
    --FOR ������ IN Ŀ���� LOOP
    --      ���๮;
    --END LOOP;
    FOR emp IN emp_list LOOP
        v_salary            := emp.salary;
        v_comm              := emp.comm;
        v_annual_salary     := v_salary*12 + trunc(v_salary*v_comm)*12;
        v_total_salary      := v_total_salary + v_annual_salary;
    END LOOP;
    RETURN v_total_salary;
END;