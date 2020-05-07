--1. �޿��� 5000�̻� 12000������ ����� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
select employee_id, first_name, salary
from employees
where salary between 5000 and 12000;

--2. ������� �Ҽӵ� �μ��� �μ����� �ߺ����� ��ȸ�ϱ�
select distinct department_name
from departments d, employees e
where e.department_id = d.department_id;

--3. 2007�⿡ �Ի��� ����� ���̵�, �̸�, �Ի����� ��ȸ�ϱ�
select employee_id, first_name, hire_date
from employees
where to_char(hire_date,'yyyy') = '2007';

--4. �޿��� 5000�̻� 12000�����̰�, 20���� 50�� �μ��� �Ҽӵ� ����� ���̵�, �̸�, �޿�, �ҼӺμ����� 
--   ��ȸ�ϱ�
select e.employee_id, e.first_name, e.salary, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and e.salary between 5000 and 12000
and e.department_id in(20,50);

--5. 100�������� �����ϴ� ����� ���̵�, �̸�, �޿�, �޿������ ��ȸ�ϱ�
select e.employee_id, e.first_name, e.salary, g.gra
from employees e, job_grades g
where e.salary>=g.lowest_sal and e.salary <= g.highest_sal
and e.manager_id = 100
order by employee_id;

--6. 80�� �μ��� �ҼӵǾ� �ְ�, 80�� �μ��� ��ձ޿����� ���� �޿��� �޴� ����� ���̵�, �̸�, 
--   �޿��� ��ȸ�ϱ�
select employee_id, first_name, salary
from employees
where department_id = 80
and salary < (select avg(salary)
                        from employees
                        where department_id = 80
                        group by department_id);

--7. 50�� �μ��� �Ҽӵ� ��� �߿��� �ش� ������ �ּұ޿����� 2�� �̻��� �޿��� �޴� ����� ���̵�, 
--   �̸�, �޿��� ��ȸ�ϱ�
select e.employee_id, e.first_name, e.salary
from employees e, jobs j
where e.department_id = 50
and j.min_salary*2 <= e.salary
and e.job_id = j.job_id
order by e.employee_id;

--8. ����� �߿��� �ڽ��� ��纸�� ���� �Ի��� ����� ���̵�, �̸�, �Ի���, ����� �̸�, 
--   ����� �Ի����� ��ȸ�ϱ�
select e.employee_id, e.first_name, e.hire_date, ee.first_name, ee.hire_date
from employees e, employees ee
where e.employee_id = ee.manager_id
and e.hire_date < ee.hire_date;

--?9. Steven King�� ���� �μ����� �ٹ��ϴ� ����� ���̵�� �̸��� ��ȸ�ϱ�
select employee_id, first_name
from (select employee_id, first_name, department_id
        from employees
        where first_name = 'Steven King') a, departments d
where a.department_id = d.department_id;

--10. �����ں� ������� ��ȸ�ϱ�, ������ ���̵�, ������� ����Ѵ�. ������ ���̵������ �������� ����
select manager_id, count(*)
from employees
group by manager_id
order by manager_id asc;

--11. Ŀ�̼��� �޴� ����� ���̵�, �̸�, �޿�, Ŀ�̼��� ��ȸ�ϱ�
select employee_id, first_name, salary, commission_pct
from employees
where commission_pct is not null;

--12. �޿��� ���� ���� �޴� ��� 3���� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
select num, employee_id, first_name, salary
from (select row_number() over(order by salary desc) num,employee_id, salary, first_name
        from employees)
where num <=3;

--?13. 'Ismael'�� ���� �ؿ� �Ի��߰�, ���� �μ��� �ٹ��ϴ� ����� ���̵�, �̸�, �Ի����� ��ȸ�ϱ�
select employee_id, first_name, hire_date
from employees;

--14. 'Renske'���� ����޴� ����� ���̵�� �̸�, �޿�, �޿� ����� ��ȸ�ϱ�
select e.employee_id, e.first_name, e.salary, g.gra
from employees e, job_grades g, employees ee
where e.salary >= g.lowest_sal and e.salary <= g.highest_sal
and e.employee_id = ee.manager_id
and ee.first_name = 'Renske';

--15. ������̺��� �޿��� �������� �޿������ ��ȸ���� ��, �޿���޺� ������� ��ȸ�ϱ�
select g.gra, count(*)
from employees e, job_grades g
where  g.lowest_sal <= e.salary and e.salary >= g.highest_sal
group by g.gra;

--16. �Ի��ڰ� ���� ���� �⵵�� �� �ؿ� �Ի��� ������� ��ȸ�ϱ�
select hire_date, count(*)
from employees
where to_char(hire_date,'yyyy') = (select min(to_char(hire_date,'yyyy'))
                                     from employees)
group by hire_date;

--17. �����ں� ������� ��ȸ���� �� �������ϴ� ������� 10���� �Ѵ� �������� ���̵�� ������� ��ȸ�ϱ�
select manager_id, count(*)
from employees
group by manager_id
having count(*) > 10;

--18. 'Europe'�������� �ٹ����� ����� ���̵�, �̸�, �ҼӺμ���, ������ ���ø�, �����̸��� ��ȸ�ϱ�
select e.employee_id, e.first_name, d.department_name, l.city, c.country_name
from employees e, departments d, locations l, countries c, regions r
where e.department_id = d.department_id
and d.location_id = l.location_id
and c.country_id = l.country_id
and r.region_id = c.region_id
and r.region_name = 'Europe'
order by employee_id;

--19. ��ü ����� ������̵�, �̸�, �޿�, �ҼӺμ����̵�, �ҼӺμ���, ����� �̸��� ��ȸ�ϱ�
select e.employee_id, e.first_name, e.salary, d.department_id, d.department_name, ee.first_name
from employees e, employees ee, departments d
where e.employee_id = ee.manager_id
and e.department_id = d.department_id;

--?20. 50�� �μ��� �ٹ����� ������� �޿��� 500�޷� �λ��Ű��

--21. ����� ���̵�, �̸�, �޿�, ���ʽ��� ��ȸ�ϱ�,
--    ���ʽ��� 20000�޷� �̻��� �޿��� 10%, 10000�޷� �̻��� �޿��� 15%, �� �ܴ� �޿��� 20%�� �����Ѵ�.
select employee_id, first_name, salary
    , CASE
        when salary >= 20000 then salary+salary*0.1
        when salary >= 10000 then salary+salary*0.15
        else salary+salary*0.2
    END as ���ʽ�
from employees
order by employee_id;

--?X22. �ҼӺμ����� �Ի����� ������, �� ���� �޿��� �޴� ����� �̸�, �Ի���, �ҼӺμ���, �޿��� ��ȸ�ϱ�
select first_name, hire_date, department_name, salary;

--23. �μ��� ��ձ޿��� ��ȸ���� �� �μ��� ��ձ޿��� 10000�޷� ������ �μ��� ���̵�, �μ���, ��ձ޿���
--    ��ȸ�ϱ� (��ձ޿��� �Ҽ��� 1�ڸ������� ǥ��)

--24. ����� �߿��� �ڽ� �����ϰ� �ִ� ������ �ִ�޿��� ������ �޿��� �޴� ����� ���̵�, �̸�, �޿���
--    ��ȸ�ϱ�

----25. �м��Լ��� ����ؼ� ������� �޿������� �����ϰ�, ������ �ο����� �� 6~10��° ���ϴ� ����,
--    ����� ���̵�, �̸�, �޿�, �޿������ ��ȸ�ϱ�
select num, e.employee_id, e.first_name, e.salary, g.gra
from (select row_number() over(order by salary asc) num, employee_id, first_name, salary
        from employees) e, job_grades g
where  g.lowest_sal <= e.salary and e.salary >= g.highest_sal
and num <=6;









