--���̺��� ��� ���� �����ϱ�
--������� ���� ��ȸ�ϱ�
select * 
from employees;

--�μ����� ���� ��ȸ�ϱ�
select * 
from departments;

--���̺��� ���� �����ؼ� ����ȸ��
--������̵�, �����, �������̵�, �޿� ��ȸ�ϱ�
select employee_id, job_id, salary
from employees;

--�������̵�, ������ �ּұ޿�, �ִ�޿� ��ȸ�ϱ�
select job_id, min_salary, max_salary
from jobs;

--�������̵�, ���ø�, �ּ� ��ȸ�ϱ�
select location_id, city, street_address
from locations;

--������̵�, �����, �Ի��� ��ȸ�ϱ�
select employee_id,first_name, hire_date
from employees;

--�����ڸ� �̿��ϱ�,��Ī ����ϱ�
--������̵�, ����, �޿�, ������ ��ȸ�ϱ�
select employee_id, job_id, salary, (salary*12) AS year_money
from employees;

--������̵�, ����, �޿�, �ñ��� ��ȸ�ϱ�, �ñ��� �޿�/(5*8)-> �ݿø�
select employee_id ������̵�, job_id ����, salary �޿�, round(salary/(5*8)) AS �ñ�
from employees;

--���� �����ؼ� ��ȸ�ϱ�
--60�� �μ����� �ٹ��ϴ� ����� ���̵�, �̸�, ����, �μ����̵� ��ȸ�ϱ�
select employee_id, first_name || ' ' || last_name name, job_id, salary, department_id
from employees
where department_id = 60;

--�޿��� 5000�޷� ���Ϸ� �޴� ������̵�, �̸�, ����, �޿��� ��ȸ�ϱ�
select employee_id, first_name, job_id, salary
from employees
where salary <= 5000;

--100�� �������� �����ϴ� ������ ���̵�, �̸� ��ȸ�ϱ�
select employee_id, first_name
from employees
where manager_id = 100;

--100�� ����� �μ�����ڷ� ������ �μ��� ���̵�, �μ����� ��ȸ�ϱ�
select department_id, department_name
from departments
where manager_id = 100;

--���� �ִ� �޿��� 15000�޷� �̻�Ǵ� ������ ���̵�, ��������, �ִ�޿� ��ȸ�ϱ�
select job_id, job_title, max_salary
from jobs
where max_salary >= 15000;

--�ñ��� 100�޷� �̻�޴� ������ ���̵�, �̸� �������̵�, �޿�, �ñ��� ��ȸ�ϱ�
select employee_id, first_name, job_id, salary, round(salary/(5*8)) as time_salary
from employees
where round(salary/(5*8)) >= 100;

--�̸��� Neena�� ����� �������̵�, �̸�, �̸���, ��ȭ��ȣ�� ��ȸ�ϱ�
select employee_id, first_name, email, phone_number
from employees
where first_name = 'Neena';

--Ŀ�̼��� nulll�� ������ �������̵�, �̸�, �������̵�, �ҼӺμ� ���̵� ��ȸ�ϱ�
select employee_id, first_name, job_id, department_id
from employees
where commission_pct is null;

--Ŀ�̼��� nulll�� �ƴ� ������ �������̵�, �̸�, �������̵�, �ҼӺμ� ���̵� ��ȸ�ϱ�
select employee_id, first_name, job_id, department_id
from employees
where commission_pct is not null;

--�ҼӺμ��� �������� ���� ������ ���̵�, �̸�, �Ի��� ��ȸ�ϱ�
select employee_id, first_name, hire_date
from employees
where department_id is null;

--�μ�����ڰ� �������� ���� �μ��� ���̵�, �μ����� ��ȸ�ϱ�
select department_id, department_name
from departments
where manager_id is null;

--�μ� ����ڰ� ������ �μ��� �μ����̵�, �μ���, ����� �������̵� ��ȸ�ϱ�
select department_id, department_name, manager_id
from departments
where manager_id is not null;

--between A and B ����ϱ�
--�޿��� 2000�̻� 3000���Ϸ� �޴� ����� ���̵�, �̸�, ����, �޿��� ��ȸ�ϱ�
select employee_id, first_name, job_id, salary
from employees
where salary between 2000 and 3000;

--in(��1, ��2, ��3, ...) ����ϱ�
--10�� �μ��� 20�� �μ��� �Ҽӵ� ����� ���̵�, �̸�, �ҼӺμ� ���̵� ��ȸ�ϱ�
select employee_id, first_name, department_id
from employees
where department_id in(10, 20);  

--50, 60, 70, 80�� �μ��� �Ҽӵ��� ���� ����� ���̵�, �̸�, �ҼӺμ� ���̵� ��ȸ�ϱ�
select employee_id, first_name, department_id
from employees
where department_id not in(50, 60, 70, 80);  

--�������̵� JP, US�� ������ ��ġ���̵�, �ּ�, �������̵� ��ȸ�ϱ�
select location_id, street_address
from locations
where country_id in('JP', 'US');

--������ �������̵� AD_PRES�̰ų� AD_VP�� ������ ���̵�, �̸�, ������ ��ȸ�ϱ�
select employee_id, first_name, job_id
from employees
where job_id in('AD_PRES','AD_VP');

--50�� Ȥ�� 60�� �μ��� �ٹ��� ���� �ִ� ����� ���̵�, �ٹ�������, �ٹ��������� ��ȸ�ϱ�
select employee_id, start_date, end_date
from job_history
where department_id in(50, 60);

--101���̳� 102�� ������ ���� ������ ����� ���̵�, �̸�, �Ŵ������̵� ��ȸ�ϱ�
select employee_id, first_name, manager_id
from employees
where manager_id in(101, 102);

--�������̵� **_MAN�� ������ ���̵�, �̸�, �������̵�, �޿��� ��ȸ�ϱ�
select employee_id, first_name, job_id, salary
from employees
where job_id like'%MAN';

--�̸��� 'A'�� �����ϴ� ������ �̸��� ���� ��ȸ�ϱ�
select first_name, last_name
from employees
where first_name like 'A%';

--�̸��� 'A'�� �����ϰ� �̸��� �ױ����� ������ �̸��� ���� ��ȸ�ϱ�
select first_name, last_name
from employees
where first_name like 'A___';

--�̸��� 'e'�� ���Ե� ������ �̸��� ���� ��ȸ�ϱ�
select first_name
from employees
where first_name like '%e%';

--�� �����ڸ� ����ؼ� 2�� �̻����� ������ �����ϴ� ���� ��ȸ�ϱ�
--80�� �μ����� ���ϴ� ���� �� �޿��� 3000 �̸��� ��� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
select employee_id, first_name, salary
from employees
where department_id = 50 
and salary < 3000;

--50�� �μ����� ���ϴ� ���� �� ������ �Ŵ����� ������ �������̵�, �̸�, �������̵�, �޿��� ��ȸ�ϱ�
select employee_id, first_name, job_id, salary
from employees
where department_id = 50
and job_id like '%MAN';

--50�� �μ����� ���ϰ� �޿��� 2500�� ���Ϸ� �ް�, �ڽ��� �Ŵ����� 121���� ������ ���̵�, �̸�, �Ի���, �޿�, �������̵� ��ȸ�ϱ�
select employee_id, first_name, hire_date, salary, job_id
from employees
where department_id = 50 
and salary <=2500 
and manager_id = 121;

--50���̳� 60�� �μ��� �Ҽӵ� ���� �߿��� �̸��� 'A;�� �����ϴ� ������ ���̵�, �̸�, �μ����̵� ��ȸ�ϱ�
select employee_id, first_name, department_id
from employees
where department_id in (50,60) -- (department_id=50 or department_id= 60)or��and�� ���� ������ or�� �ݵ�� ��ȣ�� ������ߵ�
and first_name like 'A%';

--Ŀ�̼��� �޴� ���� �߿��� �޿��� 10000�޷� �̻� �޴� ������ ���̵�, �̸�, ����, �Ի���, �޿�, ������ ��ȸ�ϱ�
--���� = �޿�*4*12 + �޿�*Ŀ�̼�*4*12
select employee_id, first_name, job_id, hire_date, salary, (salary*4*12+salary*commission_pct*4*12) as year_salary
from employees
where commission_pct is not null 
and salary >= 10000;

--����
select employee_id, first_name, job_id, hire_date, salary, employees.department_id, department_name
from employees, departments
where employees.department_id = departments.department_id
and employees.department_id = 50 and salary >=5000;

--�����ϱ�
--60�� �μ��� �Ҽӵ� ������� ���̵�, �̸�, �޿�, �Ի����� ��ȸ�ϱ�
--�̸������� �������� �����ϱ�
select employee_id, first_name, hire_date, salary
from employees
where department_id = 60
order by first_name;  --asc ����

--60�� �μ��� �Ҽӵ� ������� ���̵�, �̸�, �޿�, �Ի����� ��ȸ�ϱ�
--�̸������� �������� �����ϱ�
select employee_id, first_name, hire_date, salary
from employees
where department_id = 60
order by first_name desc;

--60�� �μ��� �Ҽӵ� ������� ���̵�, �̸�, �޿�, ����,�Ի����� ��ȸ�ϱ�
--���� �������� �����ϱ�
select employee_id, first_name, hire_date, salary, (salary*4*12) as year_salary
from employees
where department_id = 60
order by 5;   --asc ����, �÷��� ������ ����ؼ� ����

--60�� �μ��� �Ҽӵ� ������� ���̵�, �̸�, �޿�, ����,�Ի����� ��ȸ�ϱ�
--���� �������� �����ϱ�
select employee_id, first_name, hire_date, salary, (salary*4*12) as year_salary
from employees
where department_id = 60
order by salary*4*12;   --��������� ��� 

--60�� �μ��� �Ҽӵ� ������� ���̵�, �̸�, �޿�, ����,�Ի����� ��ȸ�ϱ�
--���� �������� �����ϱ�
select employee_id, first_name, hire_date, salary, (salary*4*12) as year_salary
from employees
where department_id = 60
order by year_salary;   --��Ī���� ���, ��õ

--�������
--select������ ������ ��Ī�� where������ ����� �� ����.
--select������ ������ ��Ī�� order by�������� ����� �� �ִ�.
select employee_id, first_name, hire_date, salary, (salary*4*12) as year_salary
from employees
where department_id = 50
and year_salary >= 200000   --��Ī�� ����� �� ����. �о���� ������ from-where-select-order by�̴�
order by year_salary;

--50�� �μ����� �ٹ��ϴ� �������� �̸�, �޿��� ��ȸ�ϰ�
--�޿������� �������� �����ϰ�, ���� �޿��� �����ϸ� �̸������� �������� �����ϱ�
select first_name, salary
from employees
where department_id = 50
order by salary desc, first_name asc;   --�ʹ� ���� ���Ŀ�Ҹ� ���� �ʴ´�.

--������ �Լ� �� �����Լ� ����ϱ�
--����� ���̵�, �̸��� ��ȸ�ϱ�(�̸��� �빮�ڷ� ǥ��)
select employee_id
        , upper(first_name)
        , lower(first_name)
        , length(first_name)
        , concat(first_name, last_name)
        , lpad(first_name, 10, '#')
        , rpad(first_name, 10, '@')
from employees;
