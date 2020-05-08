--������Լ� ����3
select get_total_salary from dual;

--������Լ�4
--������ �μ��� ���� �Ѿ��� ��ȯ�ϴ� �Լ�
CREATE or replace function GET_DEPT_TOTAL_SALARY
(i_dept_id in number)

RETURN number

IS
    v_salary        employees.salary%type;
    v_comm          employees.commission_pct%type;
    v_annual_salary employees.salary%type;
    v_total_salary  number :=0;
    
    --�Ķ���Ͱ� �ʿ��� Ŀ��
    --Ŀ�� ���࿡ �ʿ��� �Ķ���͸� �����Ѵ�.
    CURSOR emp_list(param_dept_id number) IS
    select salary, nvl(commission_pct,0) comm
    from employees
    where department_id = param_dept_id;
BEGIN
    --FOR���� ����ؼ� �Ķ���Ͱ� �ִ� Ŀ�� �����ϱ�
    FOR emp IN emp_list(i_dept_id) LOOP
        v_salary            := emp.salary;
        v_comm              := emp.comm;
        v_annual_salary     := v_salary*12 + trunc(v_salary*v_comm)*12;
        v_total_salary      := v_total_salary + v_annual_salary;
    END LOOP;
    
    RETURN v_total_salary;
END;
