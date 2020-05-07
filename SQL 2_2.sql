--��������(��ü����)
--101�� ����� �̸�, ����, �ڽ��� ����̸��� ��ȸ�ϱ�
select e.first_name "������", e.job_id "������ ����", em.first_name "����� �̸�"
from employees e, employees em
where e.employee_id = 101
and e.manager_id = em.employee_id;

--60�� �μ��� �ٹ����� ����� ���̵�, �̸�, ����� ����, ����� �̸�, ����� ����, 
--�μ����̵�, �μ���, �μ������� ���̵�, �μ������� �̸��� ��ȸ�ϱ�
select e.employee_id �������̵�, e.first_name �����̸�, e.job_id ��������
        , em.first_name ����̸�, em.job_id �������
        , d.department_id �����μ����̵�, d.department_name �����μ���, d.manager_id �μ������ھ��̵�
        , emm.first_name �μ��������̸�
from employees e, employees em, departments d, employees emm
where d.department_id = 60
and e.manager_id = em.employee_id       --������ ��簣�� ��������
and e.department_id = d.department_id   --������ �μ����� ��������
and emm.employee_id = d.manager_id;     --�μ��� �μ������ڰ��� ��������

--��������
--�μ����̵�, �μ���, �μ������ھ��̵�, �μ������� �̸� ��ȸ�ϱ�
select d.department_id, d.department_name, d.manager_id, e.first_name
from departments d, employees e
where d.manager_id = e.employee_id(+)
order by department_id;

--��� ������ �̸�, �޿�, �������̵�, �ҼӺμ����� ��ȸ�ϱ�
select e.first_name, e.salary, e.job_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+)
order by e.employee_id;

--������ �Լ� ����ϱ�
--employees�� ��� ���� ���� ��ȸ�ϱ�
select count(*)
from employees;

--50�� �μ����� ���ϴ� ������ ���� ��ȸ�ϱ�
select count(*)
from employees
where department_id = 50;

--Ŀ�̼��� �޴� ������ ���� ��ȸ�ϱ�
select count(commission_pct)  --�÷��� �����ϸ� �ش� �÷��� ���� null�� �ƴ� �͸� ī��Ʈ�Ѵ�.
from employees;

--Ŀ�̼��� �޴� ������ ���� ��ȸ�ϱ�
select count(*)
from employees
where commission_pct is not null;

--������ �߿��� �ְ�޿�, �����޿��� �޴� ������ �޿��� ��ȸ�ϱ�
select max(salary), min(salary)
from employees;

--�ְ�޿��� �޴� ����� �̸��� �ְ�޿��� ��ȸ�ϱ�
--���� ���� ���� ����.
select first_name, max(salary)  --����: �׷��Լ��� �׷��Լ��� �ƴ� ǥ������ ���� ����� �� ����.
from employees;

select first_name, salary
from employees
where salary = (select max(salary)
                from employees);
                
--��ȸ�� ���� ������ ���ϱ�
--count(*) : ��ȸ�� ��� ���� ������ ��ȯ�Ѵ�.
--count(�÷���) : �ش� �÷��� ���� null�� �ƴ� ���� ������ ��ȯ�Ѵ�.
--count(distinct �÷���) : �ش� �÷��� ���� ���� �ߺ��� ���� 1���� ī��Ʈ�ؼ� ���� ������ ��ȯ�Ѵ�.
select count(*)
from employees;                 --107

select count(job_id)
from employees;                 --107

select count(distinct job_id)
from employees;                 --19

select count(distinct to_char(hire_date, 'yyyy'))
from employees;                 --8

--��ȸ�� ���� Ư�� �÷��� ���� �հ踦 ���ϱ�
--sum(�÷���) : �ش� �÷��� �� �߿��� null�� ������ ������ �հ踦 ��ȯ�Ѵ�.
select sum(salary)              --��ü ������� �޿� �Ѿ�
from employees;                 --691416

select sum(commission_pct)      --��ü ������� Ŀ�̼ǿ� ���� �հ�, Ŀ�̼� ���� null�� ���� ��꿡 ���Ե��� ����
from employees;                 --7.8

--��ȸ�� ���� Ư�� �÷��� ���� ����� ���ϱ�
--avg(�÷���) : �ش� �÷��� �� �߿��� null�� ������ ���� ���� ��鿡 ���� ��հ��� ��ȯ�Ѵ�.
select trunc(avg(salary))       --��ü �������� �޿� ���
from employees;                 --6461

select trunc(avg(commission_pct),2) --��ü ������� Ŀ�̼ǿ� ���� ���, Ŀ�̼� ���� null�� ���� ��꿡 ���Ե��� ����
from employees;                 --0.22

--��ȸ�� ���� Ư�� �÷��� ���� �ִ밪, �ּҰ� ���ϱ�
--min(�÷���) : �ش� �÷��� �� �߿��� null�� ������ ���� ���� ���� ��ȯ�Ѵ�.
--max(�÷���) : �ش� �÷��� �� �߿��� null�� ������ ���� ū ���� ��ȯ�Ѵ�.
select min(salary),max(salary)
from employees;                 -- 2100   24000

select min(commission_pct), max(commission_pct)
from employees;                 -- 0.1    0.4

--group by�� �׷��Լ��� ����ؼ� ������ �����ϱ�
--������ �������� ��ȸ�ϱ�
--group by ���� ������ �÷����� ��ȸ�����ϴ�.
select job_id, count(*)
from employees
group by job_id;

--�Ի�⵵�� ��� �� ��ȸ�ϱ�
select to_char(hire_date, 'yyyy'), count(*)
from employees
group by to_char(hire_date, 'yyyy')
order by 1;