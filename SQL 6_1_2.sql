--���ν��� ����1
execute update_salary(100);

--������Լ�1
--�������̵� ���޹޾Ƽ� �� ������ ������ ��ȯ�ϴ� �Լ�(Ŀ�̼��� ���Ե�)
CREATE or replace function GET_ANNUAL_SALARY
    (i_emp_id in number)        --�������̵� �Ű������� ���޹޴´�.
RETURN number               --�� �Լ��� ��ȯ���� ���ڰ��̴�.
    
IS
    v_salary        employees.salary%type;           --�޿�
    v_comm          employees.commission_pct%type;   --Ŀ�̼�
    v_annual_salary employees.salary%type;           --����
    
BEGIN
    --�������̵� �ش��ϴ� ������ �޿��� Ŀ�̼��� ��ȸ�ؼ� v_salary�� v_comm�� �����Ѵ�.
    select salary, nvl(commission_pct,0)
    INTO v_salary, v_comm
    from employees
    where employee_id = i_emp_id;
    
    --Ŀ�̼��� �ݿ��� ������ ����ؼ� ������ �����Ѵ�.
    v_annual_salary := v_salary * 12 + trunc(v_salary*v_comm);
    
    --������ ����� ���� ��ȯ�Ѵ�.
    return v_annual_salary;
 END;































































