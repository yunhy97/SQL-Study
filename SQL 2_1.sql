select employees.employee_id, employees.first_name, employees.job_id, departments.department_id
from employees, departments 
where employees.department_id = departments.department_id;

--�����ϱ�
--�޿��� 5000�޷� �޴� ����� ���̵�, �̸�, �������̵�, �ҼӺμ����̵�, �ҼӺμ����� ��ȸ�ϱ�
select employee_id, first_name, job_id, department_id
from employees
where salary = 3000;

select *
from employees, departments --������ ���̺��� ����
where employees.salary = 3000     --��ȸ������ ����
and employees.department_id = departments.department_id; -- �������� ����

--�޿��� 15000�޷� �̻� ���� ������
--�������̵�, �̸�, �޿�, �������̵�, ��������, ���������޿�, ���� �ְ�޿� ��ȸ�ϱ�
select a.employee_id, a.first_name ,a.salary ,a.employee_id, 
        b.job_id, b.job_title, b.min_salary, b.max_salary
from employees a, jobs b 
where a.salary >= 15000
and a.job_id = b.job_id;

--�μ������ڰ� ������ �μ���
--�μ����̵�, �μ���, ���ø�, �����ȣ, �ּ� ��ȸ�ϱ�
select a.department_id, a.department_name, b.city, b.postal_code, b.street_address 
from departments a, locations b
where a.manager_id is not null
and a.location_id = b.location_id
order by a.department_id asc;

--������ ������ �μ��� 
--�μ����̵�, �μ���, �����ھ��̵�, ������ �̸��� ��ȸ�ϱ�
select a.department_id, a.department_name, a.manager_id,b.employee_id, b.first_name
from departments a, employees b 
where a.manager_id is not null
and a.manager_id = b.employee_id; 

--3�� �̻��� ���̺� �����ϱ�
-- �޿��� 12000�̻� ���� �����
--������̵�,�̸�,�޿�,�������̵�,��������,�ҼӺμ����̵�,�ҼӺμ����� ��ȸ�ϱ�
select a.employee_id, a.salary
        , b.job_id, b.job_title
        , c.department_id, c.department_name
from employees a, jobs b, departments c
where a.salary >= 12000
and a.job_id = b.job_id
and a.department_id = c.department_id;

--�μ� �����ڰ� ������ �μ��� 
--�μ����̵�, �μ���, �������� �������̵�, ������, ��ġ ���̵�, ���ø�, �ּ� ��ȸ�ϱ�
select a.department_id, a.department_name
        , b.manager_id, b.first_name
        , c.location_id, c.city, c.street_address
from departments a, employees b, locations c 
where a.manager_id is not null
and a.manager_id = b.employee_id
and a.location_id = c.location_id;

--�μ� �����ڰ� ������ �μ���
--�μ����̵�, �μ���, ��ġ ���̵�, ���ø�, �ּ�, �������̵�, ������ ��ȸ�ϱ�
select a.department_id, a.department_name
        , b.location_id, b.city, b.street_address
        , c.country_id, c.country_name 
from departments a, locations b, countries c
where a.manager_id is not null 
and a.location_id = b.location_id
and b.country_id = c.country_id;

--Seattle���� �ٹ��ϴ�
--Seattle�� ������ �μ����� �ٹ��ϴ� ������ ���̵�, �̸�, ����,�ҼӺμ� ���̵�, �ҼӺμ����� ��ȸ�ϱ�
select b.employee_id, b.first_name, b.job_id, c.department_id, c.department_name
from locations a, employees b, departments c 
where a.city = 'Seattle'
and a.location_id = c.location_id
and b.department_id = c.department_id
order by b.employee_id;

--���� ���� �̷¿���
--�������̵�, �����̸�, ����������, ����������, �������̵�, ��������, �ҼӺμ����̵�, �μ��� ��ȸ�ϱ�
select h.employee_id, e.first_name, h.start_date, h.end_date, j.job_id, j.job_title, d.department_id, d.department_name
from job_history h, employees e, jobs j, departments d
where h.employee_id = e.employee_id
and h.job_id = j.job_id
and h.department_id = d.department_id
order by h.employee_id asc, h.start_date asc;

--job_grades ���̺� �����ϱ�
create table job_grades (
    gra         char(2)     primary key,
    lowest_sal  number(6,0) not null,
    highest_sal number(6,0) not null
);

insert into job_grades values('A', 1000, 2999);
insert into job_grades values('B', 3000, 5999);
insert into job_grades values('C', 6000, 9999);
insert into job_grades values('D', 10000, 14999);
insert into job_grades values('E', 15000, 24999);
insert into job_grades values('F', 25000, 40000);

commit;

--�� ����
-- 50�� �μ��� �Ҽӵ� ������ �޿� ����� ��ȸ�ϱ�
--�������̵�, �̸�, �޿�, �޿� ���
select e.employee_id, e.first_name, g.lowest_sal, e.salary, g.highest_sal, g.gra
from employees e, job_grades g
where e.department_id = 50
and e.salary >= g.lowest_sal and e.salary <= g.highest_sal
order by e.employee_id asc;

select e.employee_id, e.first_name, e.salary, g.gra
from employees e, job_grades g
where e.salary between g.lowest_sal and g.highest_sal
order by e.employee_id asc;

--������ �����޿��� ��� ��ȸ�ϱ�
--�������̵�, ��������, ���������޿�, �޿����, �����ְ�޿�, �޿����
--������ ���̺��� ������ ����� �� �ִ�. -> �ٸ� ��Ī�� ����ؼ� ���
select j.job_id, j.job_title, j.min_salary, g.gra min_salary_gra, j.max_salary, jg.gra max_salary_gra
from jobs j, job_grades g, job_grades jg
where j.min_salary >= g.lowest_sal and j.min_salary <= g.highest_sal 
and j.max_salary >= jg.lowest_sal and j.max_salary <= jg.highest_sal
order by j.job_id asc;










