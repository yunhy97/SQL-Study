-- �μ����̺��� ��� �μ� ������ ��ȸ�ϱ�
select department_id, department_name, manager_id, location_id
from departments;

-- �μ����̺��� ��ġ���̵� 1700���� �ƴ� �μ� ���� ��ȸ�ϱ�
select department_id, department_name, manager_id, location_id
from departments
where location_id <> 1700;

-- 100����� �����ϴ� �μ����� ��ȸ�ϱ�
select department_id, department_name, manager_id, location_id
from departments
where manager_id =100;

-- �μ����� 'IT'�� �μ��� ���� ��ȸ�ϱ�
select department_id, department_name, manager_id, location_id
from departments
where department_name = 'IT';

-- ��ġ���̵� 1700���� ������ �ּ�, �����ȣ, ���ø�, �����ڵ带 ��ȸ�ϱ�
select street_address, postal_code, city, country_id
from locations
where location_id = 1700;

-- �ּұ޿��� 2000�̻� 5000������ ������ �������̵�, ��������, �ּұ޿�, �ִ�޿� ��ȸ�ϱ�
select job_id, job_title, min_salary, max_salary
from jobs
where min_salary >=2000 
and max_salary <= 5000;

-- �ִ�޿��� 20000���� �ʰ��ϴ� ������ ���̵�, ��������, �ּұ޿�, �ִ�޿� ��ȸ�ϱ�
select job_id, job_title, min_salary, max_salary
from jobs
where max_salary > 20000;

-- 100�������� �����ϴ� ����� ���̵�, �̸�, �μ����̵��� ��ȸ�ϱ�
select employee_id, first_name, department_id
from employees
where employee_id = 100;

-- 80�� �μ����� �ٹ��ϰ� �޿��� 8000�� �̻� �޴� ����� ���̵�, �̸�, �޿�, Ŀ�̼�����Ʈ ��ȸ�ϱ�
select employee_id, first_name, salary, commission_pct
from employees
where department_id = 80
and salary >= 8000;

-- ������ SA_REP�̰�, Ŀ�̼�����Ʈ�� 0.25�̻��� ����� ���̵�, �̸�, �޿�, Ŀ�̼�����Ʈ�� ��ȸ�ϱ�
select employee_id, first_name, salary, commission_pct
from employees
where job_id = 'SA_REP'
and commission_pct >= 0.25;

-- 80�� �μ��� �ٹ��ϰ�, �޿��� 10000�� �̻��� ����� ���̵�, �̸�, �޿�, ������ ��ȸ�ϱ�
-- ���� = (�޿� + �޿�*Ŀ�̼�)*12��
--������ ��Ī�� annual_salary��.
select employee_id, first_name, salary, (salary+salary*commission_pct)*12 as annual_salary
from employees
where department_id = 80
and salary >= 10000;

-- 80�� �μ��� �ٹ��ϰ�, 147�� �������� �����ϴ� ��� �߿��� Ŀ�̼��� 0.1�� ����� 
--������̵�, �̸�, ����, �޿�, Ŀ�̼�����Ʈ�� ��ȸ�ϱ�
select employee_id, first_name, job_id, commission_pct
from employees
where department_id = 80
and manager_id =147
and commission_pct = 0.1;

-- ������� �����ϴ� ������ �ߺ����� ��ȸ�ϱ�
select distinct employee_id
            , first_name
            , last_name
            , email
            , phone_number
            , hire_date
            , job_id
            , salary
            , commission_pct
            , manager_id
            , department_id
from employees;

-- ������� �Ҽӵ� �μ����̵� ��� ��ȸ�ϱ�
select department_id
from employees
where employee_id is not null;

-- �޿��� 12000�� �Ѵ� ����� �̸��� �޿��� ��ȸ�ϱ�
select first_name, salary
from employees
where salary >=12000;

-- �޿��� 5000�̻� 12000������ ����� �̸��� �޿��� ��ȸ�ϱ�
select first_name, salary
from employees
where salary between 5000 and 12000;

-- 2007�⿡ �Ի��� ����� ���̵�, �̸�, �Ի����� ��ȸ�ϱ�
select employee_id, first_name, hire_date
from employees
where hire_date = 07; --����

-- 20�� 50�� �μ��� �Ҽӵ� ����� �̸��� �μ���ȣ�� ��ȸ�ϰ�, �̸��� ���ĺ������� �����ؼ�  ��ȸ�ϱ�
select first_name, department_id
from employees
where department_id in (20, 50)
order by first_name;

-- �޿��� 5000�̻� 12000���ϰ�, 20���� 50�� �μ��� �Ҽӵ� ����� �̸��� �޿�, �μ���ȣ�� ��ȸ�ϱ�
select first_name, salary, department_id
from employees
where salary between 5000 and 12000
and department_id in(20, 50);

-- �����ڰ� ���� ����� �̸��� ����, �޿��� ��ȸ�ϱ�
select first_name, job_id, salary
from employees
where manager_id is null;

-- ������ 'SA_MAN'�̰ų� 'ST_MAN'�� �����߿��� �޿��� 8000�̻� �޴� ����� ���̵�, �̸�, ����, �޿��� ��ȸ�ϱ�
select employee_id, first_name, job_id, salary
from employees
where job_id in ('SA_MAN','ST_MAN')
and salary >= 8000;



