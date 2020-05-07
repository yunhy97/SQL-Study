--������ �׷��� ����
--group by ���� ����ϸ� ���̺��� ������ ���� �׷����� ����� 
--�׷�� �����͸� ������ �� �ִ�.
--�ҼӺμ��� �������� ��ȸ�ϱ�, ��, �ҼӺμ��� �������� ���� ������ �����Ѵ�.
select count(*), department_id
from employees
where department_id is not null
group by department_id;

--�����ں� �ڽ��� �����ϴ� �������� ��ȸ�ϱ�. ��, �����ڰ� �������� ���� ������ �����Ѵ�.
--�����ھ��̵�, �������� ��ȸ�Ѵ�.
select manager_id, count(*)
from employees e
where manager_id is not null
group by manager_id;

--�μ��� �������� ��ȸ�ϱ�. ��, �μ��� �������� ���� ����� ����
select d.department_name, count(*)
from employees e, departments d
where d.department_id = e.department_id
group by d.department_name;

--���ú� �������� ��ȸ�ϱ�
--���ø� , ������
select l.city, count(*)
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
group by l.city;

--���ú�, �μ��� �������� ��ȸ�ϱ�
--���ø�, �μ���, �������� ��ȸ�ϱ�
select l.city, d.department_name, count(*)
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
group by l.city, d.department_name
order by 1, 2;

--having �� ����ؼ� �׷��� �����ϱ�
--�޿��� ������� ��ȸ���� ��, �������� 10�� �̻��� �޿��� ������ ������ ��ȸ�ϱ�
select trunc(salary, -3) salary, count(*)
from employees
group by trunc(salary,-3)
having count(*)>=10
order by salary;

--�μ��� ��ձ޿� ��ȸ�ϱ�
--�μ���� �μ��� ��ձ޿��� ��ȸ�Ѵ�. ��ձ޿��� �Ҽ������ϴ� ������.
--��ձ޿��� 5000�޷� �̸��� �μ��� ��ȸ�ϱ�
select d.department_name, trunc(avg(e.salary))
from employees e, departments d
where e.department_id=d.department_id
group by d.department_name
having avg(e.salary)<5000
order by department_name;

--�׷��Լ��� ��ø
--�μ����� �������� ��ȸ���� �� ���� ���� ������� ����ΰ�?
select max(count(*))
from employees
group by department_id;

--�޿� ��޺� ������� ��ȸ�ϱ�
--�޿���ް� �����, ��ձ޿��� ǥ���Ѵ�.
select g.gra, count(*), trunc(avg(salary))
from job_grades g, employees e
where e.salary >= g.lowest_sal and e.salary <= g.highest_sal
group by g.gra
order by 1;

--��������
--�̸��� Neena�� ����� ���� �ؿ� �Ի��� ������� �̸�, �Ի����� ��ȸ�ϱ�
select first_name, hire_date
from employees
where to_char(hire_date, 'yyyy') = (select to_char(hire_date,'yyyy')
                                                    from employees
                                                    where first_name='Neena');

--Stephen�� ���� ������ ���� �ϴ� �������� ���̵�� �̸�, �޿��� ��ȸ�ϱ�
select employee_id, first_name, salary
from employees
where job_id = (select job_id
                from employees
                where first_name ='Stephen');

--Mozhe�� ���� ������ �����ϰ�, Mozhe�� �޿����� �޿��� ���� �޴� ������ ���̵�� �̸�, �޿��� ��ȸ�ϱ�
select employee_id, first_name, salary
from employees
where job_id=(select job_id
                from employees
                where first_name = 'Mozhe')
and salary > (select salary
                from employees
                where first_name = 'Mozhe');

--��ü ������ ��ձ޿����� ���� �޿��� �޴� �������� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
select employee_id, first_name, salary
from employees
where salary < (select avg(salary)
                from employees);
                
--���� ���� �޿��� �޴� �������� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
select employee_id, first_name, salary
from employees
where salary = (select min(salary)
                from employees);

--�μ��� ������� ��ȸ���� �� ������� ���� ���� �μ��� ���̵�� ������� ��ȸ�ϱ�
select department_id, count(*)
from employees
group by department_id 
having count(*) = (select max(count(*))
                    from employees
                    group by department_id);

--with ���� ����ؼ� �ߺ� ����Ǵ� �����۾��� �� ���� ����ǰ� �� �� �ִ�.
--������ ���༺���� ����Ų��.
with deptcnt
as(select department_id, count(*) cnt
    from employees
    group by department_id)
select department_id, cnt
from deptcnt
where cnt = (select max(cnt)
            from deptcnt);

--������ ��������
--50�� �μ��� �ٹ��ߴ� ���� �ִ� ����� ���̵�, �̸�,����, �ҼӺμ����̵� ��ȸ�ϱ�
select employee_id, first_name, job_id, department_id
from employees
where employee_id in (select employee_id
                    from job_history
                    where department_id = 50);
                    
--������ �������� ���, ������ Ȱ���ؼ� ��ȸ�ϱ�
select e.employee_id, e.first_name, e.job_id, e.department_id
        , h.job_id, h.department_id
from employees e, job_history h
where e.employee_id = h.employee_id
and h.department_id = 50;
                    
--Seattle�� ��ġ�ϰ� �ִ� �μ��� ������ �������̵�, �̸��� ��ȸ�ϱ�
--1. Seattle�� location_id�� ��ȸ�ϱ�
--2. �� location_id�� ������ �ִ� �μ��� manager_id�� ��ȸ�ϱ�
--3. �� manager_id�� �ش��ϴ� �������̵�, �̸��� ��ȸ�ϱ�
select employee_id, first_name
from employees
where employee_id in (select manager_id
                        from departments
                        where location_id = (select location_id
                                            from locations
                                            where city = 'Seattle'));
                    
select e.employee_id ,e.first_name
from employees e, departments d, locations l
where e.employee_id = d.manager_id
and d.location_id = l.location_id
and l.city = 'Seattle';
                    
                    
                    
                    
                    
                    