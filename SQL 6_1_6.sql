--������Լ� ����4
--�μ����̵�, �μ���, �μ��� �Ҽӵ� �����, �μ��� �� ���� ��ȸ�ϱ�
select department_id, 
       department_name, 
       get_emp_count(department_id), 
       get_dept_total_salary(department_id)
from departments;