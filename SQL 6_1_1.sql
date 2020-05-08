--���ν���1
--���� ��ȣ ���޹޾Ƽ� �� ������ �޿��� �λ��Ű�� ���ν��� �ۼ��ϱ�
create or replace procedure update_salary
(i_emp_id in number) -- �Ű�����
IS 
    --���� �����Ѵ�.
    --����        ������ ������Ÿ��
    --           employees�� salary �÷��� ������Ÿ�԰� ������ ������Ÿ���� ���� ����
    v_emp_salary employees.salary%type;  --����� �޿�, v_emp_salary number;
    v_update_rate number(3,2);           --�޿� �λ��
BEGIN
    --SQL����, PL/SQL ������ �ۼ�
    
    --���޹��� �������̵� �ش��ϴ� ������ �޿��� ��ȸ�Ѵ�.
    --��ȸ�� ������ �޿��� ���ؼ� ������ v_emp_salary�� �����Ѵ�.
    select salary
    INTO v_emp_salary
    from employees
    where employee_id = i_emp_id;
    
    --������ �޿��� ���� �λ���� �����ϱ�
    --20000�޷� �̻�, 10%, 10000�޷� �̻� 15%, �� �� 20% �λ�
    IF v_emp_salary >= 20000 then v_update_rate := 0.1;
    ELSIF V_emp_salary >= 10000 then v_update_rate := 0.15;
    ELSE v_update_rate := 0.2;
    END IF;
    
    --�޿��� �λ��Ű��
    update employees
    set
        salary = salary + trunc(salary*v_update_rate)
    where
        employee_id = i_emp_id;
        
    --DB�� ���������� �ݿ���Ű��
    commit;
END;
    


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    




















