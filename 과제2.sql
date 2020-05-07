-- 1.  �ý����� ���� ��¥�� �ð� ��ȸ�ϱ� (dual ���)
select sysdate
from dual;

-- 2.  �޿��� 5000�޷� �̻�ް�, 2005�⿡ �Ի��� ������ ���̵�, �̸�, �޿�, �Ի����� ��ȸ�ϱ�
select employee_id, first_name, salary, hire_date
from employees
where salary >= 5000
and to_char(hire_date, 'YYYY') = '2005';
--hire_date >= to_date('2005/01/01','yyyy/mm/dd')
--and hire_date < to_date('2006/01/01', 'yyyy/mm/dd')'

-- 3.  �̸��� e�� E�� ���Ե� ���� �߿��� �޿��� 10000�޷� �̻� �޴� ������ ���̵�, �̸�, �޿��� ��ȸ�ϱ�
select employee_id, first_name, salary
from employees
where (first_name like'%e%'
or first_name like '%E%')
and salary >= 10000;

-- 4.  �Ի�⵵�� ������� 4���� �Ի��� �������� ���̵�, �̸�, �Ի����� ��ȸ�ϱ�
select employee_id, first_name, hire_date
from employees
where to_char(hire_date,'mm') = '04';

-- 5.  2006�� ��ݱ�(1/1 ~ 6/30)�� �Ի��� �������� ���̵�, �̸�, �Ի��� ��ȸ�ϱ�
select employee_id, first_name, hire_date
from employees
where hire_date >= to_date('2006-01-01','yyyy-mm-dd')
and hire_date <= to_date('2006-06-30', 'yyyy-mm-dd');

-- 6.  50�� �μ��� �Ҽӵ� �������� �޿��� 13%�λ��Ű���� �Ѵ�.
--     �������̵�, �̸�, ���� �޿�, �λ�� �޿��� ��ȸ�ϱ�
--     �λ�� �޿��� �Ҽ��� ���ϴ� ������.
select employee_id, first_name, salary, trunc(salary+(salary*0.13))
from employees
where department_id = 50;
-- 7.  50�� �μ��� �Ҽӵ� �������� �޿��� ��ȸ�Ϸ��� �Ѵ�.
--     ���� ���̵�, �̸�, �޿� �׸���, �޿� 1000�޷��� *�� �ϳ��� ǥ���϶�.
--     120 Matthew 8000 ********
--     122 Shanta  6500 ******
select employee_id, first_name, salary, lpad('*',(salary/1000),'*')
from employees
where department_id = 50;

-- 8.  �����ڰ� �����Ǿ� ���� �ʴ� �μ��� 
--     �μ����̵�, �μ���, ��ġ���̵�, ���ø�, �ּҸ� ��ȸ�ϱ�
select d.department_id, d.department_name, l.location_id, l.city, l.street_address
from departments d,locations l
where d.manager_id is null
and d.location_id = l.location_id
order by department_id asc;

-- 9.  90�� �μ��� �Ҽӵ� ������ �������̵�, �̸�, ����, �޿��� ��ȸ�ϱ�
select employee_id, first_name, job_id, salary
from employees
where department_id = 90;

-- 10. 100�� ������ �μ������ڷ� ������ �μ��� �Ҽӵ� ������ �������̵�, �̸�, ����, �޿��� ��ȸ�ϱ�
select e.employee_id, e.first_name, e.job_id, e.salary
from employees e, departments d 
where d.manager_id = 100
and e.department_id = d.department_id;

-- 11. 10, 20, 30�� �μ��� �Ҽӵ� �������� �������̵�, �̸�, �޿�, �޿������ ��ȸ�ϱ�
select e.employee_id, e.first_name, e.salary, g.gra
from employees e, job_grades g
where department_id in(11,10,20,30)
and e.salary >= g.lowest_sal and e.salary <= g.highest_sal;

-- 12. �������� ���������� �������� �� �ڽ��� �����ϰ� �ִ� ������ �����޿��� �ް� �ִ�
--     ������ ���̵�, �̸�, �޿�, �������̵�, ���������޿��� ��ȸ�ϱ�
select e.employee_id, e.first_name, e.salary, j.job_id, j.min_salary
from employees e, jobs j
where e.job_id=j.job_id
and e.salary = j.min_salary;

-- 13. Ŀ�̼��� �޴� �������� �������̵�, �̸�, Ŀ�̼�, �޿�, �������̵�, ��������, �޿�, �ҼӺμ� ���̵�, �μ����� ��ȸ�ϱ�
select e.employee_id, e.first_name, e.commission_pct, e.salary, j.job_id, j.job_title, d.department_id, d.department_name
from employees e, jobs j, departments d
where commission_pct is not null
and e.job_id = j.job_id
and e.department_id = d.department_id
order by employee_id asc;

-- 14. 'Canada'���� �ٹ��ϰ� �ִ� ������ ���̵�, �̸�, �ҼӺμ� ���̵�, �ҼӺμ���, ��ġ ���̵�, ���ø�, �ּҸ� ��ȸ�ϱ�
select e.employee_id, e.first_name, d.department_id, d.department_name, l.location_id, l.city, l.street_address
from employees e, departments d, locations l, countries c
where c.country_name = 'Canada'
and e.department_id = d.department_id
and d.location_id = l.location_id
and c.country_id = l.country_id;

-- 15. ��� ������ �������̵�, �̸�, �������̵�, ��������, �޿�, �޿����, �ҼӺμ� ���̵�, �ҼӺμ���, ���ø��� ��ȸ�ϱ�
select e.employee_id, e.first_name, j.job_id, j.job_title, e.salary, g.gra, d.department_id, d.department_name, l.city
from employees e, departments d, jobs j, job_grades g, locations l
where e.job_id = j.job_id
and e.department_id = d.department_id
and d.location_id = l.location_id
and e.salary >= g.lowest_sal and e.salary <= g.highest_sal;

-- 16. �޿��� 5000�޷� ���Ϸ� �޴� �������� ���̵�, �̸�, ����, �ҼӺμ� ���̵�, �ҼӺμ���, �ҼӺμ� ������ �������̵�, 
--     �ҼӺμ� ������ �����̸��� ��ȸ�ϱ�
select e.employee_id, e.first_name, e.job_id, d.department_id, d.department_name, d.manager_id, ee.first_name
from employees e, departments d, employees ee
where e.salary <= 5000
and e.department_id = d.department_id
and ee.employee_id = d.manager_id
order by e.employee_id;

-- 17. 'Asia'������ �������� �ΰ� �ִ� �μ��� ���̵�, �μ���, �μ������� �̸��� ��ȸ�ϱ�
select d.department_id, d.department_name, e.first_name
from departments d, locations l, countries c, regions r, employees e
where e.employee_id = d.manager_id
and d.location_id = l.location_id
and l.country_id = c.country_id
and c.region_id = r.region_id
and r.region_name = 'Asia';

-- 18. 101�� ������ �ٹ��ߴ� �μ����� �ٹ����� ������ ���̵�, �̸�, �μ����̵�, �μ����� ��ȸ�ϱ�
select distinct e.employee_id, e.first_name, d.department_id, d.department_name
from employees e, departments d , job_history h
where e.department_id = d.department_id
and d.department_id = h.department_id
and h.employee_id = 101;

-- 19. �����߿��� �ڽ��� �����ϰ� �ִ� ������ �ְ�޿� 50%�̻��� �޿��� �ް� �ִ� 
--     ������ ���̵�, �̸�, �޿�, �������̵�, ���� �ְ�޿��� ��ȸ�ϱ�
select e.employee_id, e.first_name, e.salary, j.job_id, j.max_salary
from employees e, jobs j
where e.job_id = j.job_id
and e.salary >= j.max_salary/2;

-- 20. �̱�(US)�� ��ġ�ϰ� �ִ� �μ��� ���̵�, �̸�, ��ġ��ȣ, ���ø�, �ּҸ� ��ȸ�ϱ� 
select d.department_id, e.first_name, l.location_id, l.city, l.street_address
from departments d, locations l, employees e
where d.department_id = e.department_id
and d.location_id = l.location_id
and l.country_id = 'US'
order by d.department_id asc;