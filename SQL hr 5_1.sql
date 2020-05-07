select * 
from scott.contacts;

--��ȭ��ȣ �����ϱ�
update scott.contacts
set
    contact_tel = '010-1122-3333'
where
    contact_name = 'ȫ�浿';

--�̸������ϱ�, ��ü���� �������� �������
update scott.contacts
set
    contact_name = '������'
where
    contact_name = '������';


--scott.contacts�� ���� ���̺��� ���Ǿ �����ϱ�
create synonym contacts for scott.contacts;

select *
from contacts;

--�����ͻ���
--������� ��� ���̺� ���� ��ȸ
select * 
from user_tables;

--������� ��� �� ���� ��ȸ
select * 
from user_views;

--������� ��� ������ ���� ��ȸ
select *
from user_sequences;

--����� ���� ��ȸ
select * 
from user_users;

--���տ����� ����ϱ�
--��� ����� ���� �� ������ �ٹ��ߴ� ������ ��ȸ�ϱ�
--������� �ѹ����� ǥ���ϱ�
select employee_id, job_id      --���� �ٹ����� ���� ��ȸ�ϱ�
from employees
union
select employee_id, job_id      --������ �ٹ��ߴ� ���� ��ȸ�ϱ�
from job_history;

--��� ����� ���� �μ����̵�� ���� �ҼӺμ� ���̵� ��ȸ�ϱ�
select employee_id, department_id
from employees
union all
select employee_id, department_id
from job_history;

--���� �����ϴ� ������ ���� �������� �����ϰ� �ִ� ������ ���̵�� �������̵� ��ȸ�ϱ�
select employee_id, job_id
from employees
intersect
select employee_id, job_id
from job_history;

select a.employee_id, a.job_id
from employees a, job_history b
where a.employee_id = b.employee_id
and a.job_id = b.job_id;

--������ ����� ���� ���� ����� ���̵� ��ȸ�ϱ�
select employee_id
from employees
minus
select employee_id
from job_history;

--������ ����� ���� ���� ����� ���̵�, �̸��� ��ȸ�ϱ�
select a.employee_id, b.first_name
from (select employee_id
        from employees
        minus
        select employee_id
        from job_history) a, employees b
where a.employee_id = b.employee_id
order by 1;

--������ ����� ���� ���� ����� ���̵�, �̸�, ���� ����, �ҼӺμ����� ��ȸ�ϱ�
select a.employee_id, b.first_name, b.job_id, c.department_name
from (select employee_id
        from employees
        minus
        select employee_id
        from job_history) a, employees b, departments c
where a.employee_id = b.employee_id
and b.department_id = c.department_id;

--��� ����� ���� �� ������ �ٹ��ߴ� ������ ��ȸ�ϱ�
--������̵�, ����, �޿��� ��ȸ�ϱ�
select employee_id, job_id, salary
from employees
union
select employee_id, job_id, 0 
from job_history;
















