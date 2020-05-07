--1. ��� �������� ��� �������̵� ��ȸ�ϱ�
select distinct job_id
from employees;

--2. �޿��� 12,000�޷� �̻� �޴� ������ �̸��� �޿��� ��ȸ�ϱ�
select first_name, salary
from employees
where salary >= 12000;

--Ȯ��
--3. ������ȣ�� 176�� ������ ���� �μ����� �ٹ��ϴ� ������ ���̵�� �̸� �������̵� ��ȸ�ϱ�
select e.employee_id, e.first_name, e.job_id
from employees e, departments d, departments dd
where employee_id =176
and e.department_id = d.department_id
and dd.department_id = d.department_id;

--4. �޿��� 12,000�޷� �̻� 15,000�޷� ���� �޴� �������� ���� ���̵�� �̸��� �޿��� ��ȸ�ϱ�
select employee_id, first_name, salary
from employees
where salary >=12000 and salary<=15000;

--5. 2005�� 1�� 1�Ϻ��� 2005�� 6�� 30�� ���̿� �Ի��� ������ ���̵�, �̸�, �������̵�, �Ի����� ��ȸ�ϱ�
select employee_id, first_name, job_id, hire_date
from employees
where hire_date >= to_date('2005-01-01','yyyy-mm-dd')
and hire_date <= to_date('2005-06-30', 'yyyy-mm-dd');

--6. �޿��� 5,000�޷��� 12,000�޷� �����̰�, �μ���ȣ�� 20 �Ǵ� 50�� ������ �̸��� �޿��� ��ȸ�ϱ�
select first_name, salary
from employees
where salary between 5000 and 12000 
and department_id in(20,50);

--7. �����ڰ� ���� ������ �̸��� �������̵� ��ȸ�ϱ�
select first_name, job_id
from employees
where manager_id is null;

--8. Ŀ�̼��� �޴� ��� ������ �̸��� �޿�, Ŀ�̼��� �޿� �� Ŀ�̼��� ������������ �����ؼ� ��ȸ�ϱ�
select first_name, salary, commission_pct
from employees
where commission_pct is not null
order by salary desc, commission_pct desc;

--9. �̸��� 2��° ���ڰ� e�� ��� ������ �̸��� ��ȸ�ϱ�
select first_name
from employees
where first_name like '_e%';

--10. �������̵� ST_CLERK �Ǵ� SA_REP�̰� �޿��� 2,500�޷�, 3,500�޷�, 7,000�޷� �޴� ��� ������ �̸��� �������̵�, �޿��� ��ȸ�ϱ�
select first_name, job_id, salary
from employees
where job_id in('ST_CLERK', 'SA_REP')
and salary in(2500,3500,7000);

--11. ��� ������ �̸��� �Ի���, �ٹ� ���� ���� ����Ͽ� ��ȸ�ϱ�, �ٹ����� ���� ������ �ݿø��ϰ�, �ٹ��������� �������� ������������ �����ϱ�
select first_name, hire_date, round(months_between(sysdate, hire_date)) month_hire
from employees
order by month_hire;

--12. ������ �̸��� Ŀ�̼��� ��ȸ�ϱ�, Ŀ�̼��� ���� �ʴ� ������ '����'���� ǥ���ϱ�
select first_name, nvl(to_char(commission_pct),'����')
from employees;

--13. ��� ������ �̸�, �μ���ȣ, �μ��̸��� ��ȸ�ϱ�
select e.first_name, d.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id;

--14. 80���μ��� �Ҽӵ� ������ �̸��� �������̵�, ��������, �μ��̸��� ��ȸ�ϱ�
select e.first_name, j.job_id, j.job_title, d.department_name
from employees e, jobs j, departments d
where e.job_id = j.job_id
and e.department_id = d.department_id
and e.department_id = 80
order by first_name;

--15. Ŀ�̼��� �޴� ��� ������ �̸��� �������̵�, ��������, �μ��̸�, �μ������� ���ø��� ��ȸ�ϱ�
select e.first_name, j.job_id, j.job_title, d.department_name, l.city
from employees e, jobs j, departments d, locations l
where e.commission_pct is not null
and e.job_id = j.job_id
and e.department_id = d.department_id(+)
and d.location_id = l.location_id(+);

--16. ������ �������� �ΰ� �ִ� ��� �μ����̵�� �μ��̸��� ��ȸ�ϱ�
select d.department_id, d.department_name
from departments d, locations l, countries c, regions r
where d.location_id = l.location_id
and l.country_id = c.country_id
and c.region_id = r.region_id
and r.region_name = 'Europe';

--17. ������ �̸��� �ҼӺμ���, �޿�, �޿� ����� ��ȸ�ϱ�
select e.first_name, d.department_name, e.salary, g.gra
from employees e, departments d, job_grades g
where e.department_id = d.department_id
and e.salary >= g.lowest_sal and e.salary <= g.highest_sal;

--18. ������ �̸��� �ҼӺμ���, �ҼӺμ��� �����ڸ��� ��ȸ�ϱ�, 
--�ҼӺμ��� ���� ������ �ҼӺμ��� '����, �����ڸ� '����'���� ǥ���ϱ�
select e.first_name, nvl(d.department_name,'����'), nvl(em.first_name,'����')
from employees e, departments d, employees em
where e.department_id = d.department_id(+)
and d.manager_id = em.employee_id(+);

--19. ��� ����� �̸�, �������̵�, �޿�, �ҼӺμ����� ��ȸ�ϱ�
select e.first_name, e.job_id, e.salary, d.department_name
from employees e, departments d
where e.department_id = d.department_id;

--20. ��� ����� �̸�, �������̵�, ��������, �޿�, �ּұ޿�, �ִ�޿��� ��ȸ�ϱ�
select e.first_name, j.job_id, j.job_title, e.salary, g.lowest_sal, g.highest_sal
from employees e, jobs j, job_grades g
where e.job_id = j.job_id
and e.salary >= g.lowest_sal
and e.salary <= g.highest_sal;

--21. ��� ����� �̸�, �������̵�, ��������, �޿�, �ּұ޿��� ���� �޿��� ���̸� ��ȸ�ϱ�
select e.first_name, j.job_id, j.job_title, e.salary, e.salary-j.min_salary
from employees e, jobs j
where e.job_id = j.job_id;

--22. Ŀ�̼��� �޴� ��� ����� ���̵�, �μ��̸�, �ҼӺμ��� ������(���ø�)�� ��ȸ�ϱ�
select e.employee_id, d.department_id, d.department_name, l.city
from employees e, departments d, locations l
where e.commission_pct is not null
and e.department_id = d.department_id
and d.location_id = l.location_id;

--23. �̸��� A�� a�� �����ϴ� ��� ����� �̸��� ����, ��������, �޿�, �ҼӺμ����� ��ȸ�ϱ�
select e.first_name, j.job_id, j.job_title, e.salary, d.department_name
from employees e, jobs j, departments d
where (e.first_name like 'A%' or e.first_name like 'a%')
and e.job_id = j.job_id
and e.department_id = d.department_id;

--24. 30, 60, 90�� �μ��� �ҼӵǾ� �ִ� ����� �߿��� 100���� �����ϴ� ������� �̸�, ����, �޿�,
--    �޿������ ��ȸ�ϱ�
select first_name, job_id, salary, gra
from employees e, job_grades g
where e.department_id in(30,60,90)
and e.manager_id = 100
and e.salary >= g.lowest_sal and e.salary <= g.highest_sal;

--25. 80�� �μ��� �Ҽӵ� ������� �̸�, ����, ��������, �޿�, �ּұ޿�, �ִ�޿�, �޿����, 
--    �ҼӺμ����� ��ȸ�ϱ�
select e.first_name, j.job_id, j.job_title, e.salary, g.lowest_sal, g.highest_sal, g.gra, d.department_name
from employees e, jobs j, job_grades g, departments d
where e.department_id =80
and e.job_id = j.job_id
and e.department_id = d.department_id
and e.salary >= g.lowest_sal and e.salary <= g.highest_sal
order by e.first_name;

--26. ������߿��� �ڽ��� ��纸�� ���� �Ի��� ������� �̸�, �Ի���, ����� �̸�, ����� �Ի�����
--    ��ȸ�ϱ�
select e.first_name,e.hire_date, em.first_name, em.hire_date
from employees e, employees em
where e.manager_id = em.employee_id
and e.hire_date < em.hire_date;

--27. �μ����� IT�� �μ��� �ٹ��ϴ� ������� �̸���, ����, �޿�, �޿����, ����� �̸��� ������
--    ��ȸ�ϱ�
select e.first_name, e.job_id, e.salary, g.gra, em.first_name, em.job_id
from employees e, employees em, job_grades g, departments d
where e.employee_id = em.employee_id
and e.department_id = d.department_id
and e.salary >= g.lowest_sal and e.salary <= g.highest_sal
and d.department_name = 'IT';

--28. 'ST_CLERK'�� �ٹ��ϴٰ� �ٸ� �������� ������ ����� ���̵�, �̸�, ������ �μ���,
--     ���� ����, ���� �ٹ��μ����� ��ȸ�ϱ�
select e.employee_id, e.first_name, dh.department_name, e.job_id, d.department_name, h.employee_id
from employees e, departments d, job_history h, departments dh
where e.department_id = d.department_id
and e.job_id =h.job_id
and dh.department_id = h.department_id
and h.job_id = 'ST_CLERK';












