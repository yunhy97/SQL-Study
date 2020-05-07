-- ���߿� �������� ����ϱ�
-- 'Karen'�� ���� ������ �����ϰ�, ���� �μ��� �ҼӵǾ��ִ� ����� ���̵�, �̸�, ����, �μ����̵� ��ȸ�ϱ�
select *
from employees
where (job_id, department_id) in (select job_id, department_id
                                  from employees
                                  where first_name = 'Karen');
                                  
-- �μ��� �ְ� �޿��� �޴� ����� ���̵�, �̸�, �޿�, �μ����̵� ��ȸ�ϱ�
select department_id, max(salary)
from employees
where department_id is not null
group by department_id;

select employee_id, first_name, job_id, salary, department_id
from employees
where (department_id, salary) in (select department_id, max(salary)
                                from employees
                                where department_id is not null
                                group by department_id)
order by employee_id;

--��Į�� �������� ����ϱ�
--��ü ��պ��� ���� �޿��� �޴� ����� ���̵�, �̸�, �޿�, ��ձ޿�, ��ձ޿����� ���̸� ��ȸ�ϱ�
select employee_id, first_name, salary,
    trunc((select avg(salary) from employees) - salary) salary_gap      --��Į�� �������� : 1��1��
from employees
where salary < (select avg(salary)
                from employees)
order by salary_gap;
                
--20000�޷� �̻��� ��� �޿��� 10%�� ���ʽ���, 10000�޷� �̻��� 15%, �� �ܴ� 20%��
--���ʽ��� �����Ϸ��� �Ѵ�. ���̵�, �̸�, �޿�, ���ʽ� ��ȸ�ϱ�
select employee_id, first_name, salary,
    case
        when salary >= 20000 then trunc((select avg(salary) from employees)*0.1)
        when salary >= 10000 then trunc((select avg(salary) from employees)*0.15)
        else trunc((select avg(salary) from employees)*0.2)
    end bonus
from employees;

--��ü ��ձ޿����� �޿��� ���� �޴� ����� �̸�, �޿��� ��ȸ�ϱ�
select first_name, salary
from employees
where salary > (select avg(salary)
                from employees);

--�ڽ��� �Ҽӵ� �ҼӺμ��� ��ձ޿����� ���� �޿��� �޴� ����� �̸�, �޿��� ��ȸ�ϱ�
select outter.first_name, outter.salary
from employees outter
where outter.commission_pct is null 
and outter.salary > (select avg(inner.salary)
                        from employees inner
                        where inner.department_id = outter.department_id);
--�ܺ� SQL���� ���� ����Ǿ ���� �����´�.(�ĺ���)
--�ĺ����� �ึ�� department_id���� �����ͼ� ���������� �����Ѵ�.
--���������� ������� ����ؼ� �ĺ����� �����Ѵ�.
--�ĺ����� ���� ���� ������ �ݺ��Ѵ�.

--exists ������ ����ϱ�
--���������� ������ �ִ� ������ ��ȸ�ϱ�
select *
from employees ���
where (select count(*)
        from employees ����
        where ����.manager_id = ���.employee_id) > 0;  --count() ��� ����õ

select *
from employees ���
where exists (select 1
                from employees ����
                where ����.manager_id = ���.employee_id);  --exists ��� ��õ
                
-- with ��
with 
dept_costs AS   --�μ��̸�, �μ��ѱ޿�
    (select B.department_name, sum(A.salary) as dept_total
    from employees A, departments B
    where A.department_id = B.department_id
    group by B.department_name),  --������ ���̺�
avg_cost AS     --�μ��� �� �޿��� ���� ��ձ޿�
    (select sum(dept_total)/count(*) as dept_avg
    from dept_costs)  --������ ���̺�
select *
from dept_costs
where dept_total > (select dept_avg     --�μ��ѱ޿��� ��ձ޿�
                    from avg_cost)
order by department_name;

--118�� ����� ��縦 ��ȸ�ϱ�
select employee_id, first_name, manager_id
from employees
start with employee_id = 118
connect by prior manager_id=employee_id;

--101�� ������ ��� ���� ��ȸ�ϱ�
select lpad(employee_id, level*4,' '), first_name, manager_id
from employees
start with employee_id = 101
connect by prior employee_id = manager_id;

--100(����)�� ������ �������� ��ȸ
select lpad(first_name, length(first_name) + level*5-5, ' ')
from employees
start with employee_id = 100
connect by prior employee_id = manager_id;

--100�� ��� �������� ��ȸ, connect by���� Neena�� ����(Neena�� ���ϵ� ����)
select lpad(first_name, length(first_name) + level*5-5, ' ')
from employees
start with employee_id = 100
connect by prior employee_id = manager_id
and first_name != 'Neena';

--100�� ��� �������� ��ȸ, where������ Neena�� ����(Neena�� ����), ����
select lpad(first_name, length(first_name) + level*5-5, ' ')
from employees
where first_name != 'Neena'
start with employee_id = 100
connect by prior employee_id = manager_id;

--100�� �������� ��ȸ�ϱ�
select lpad(first_name, length(first_name) + level*5-5, ' ')
from employees
start with employee_id = 100
connect by prior employee_id = manager_id 
and level <= 2;

--2020/01/01 ~ 2020/12/31��¥ �����
select to_date('2020/01/01','yyyy/mm/dd') + level-1
from dual
connect by level <= 366;

--2005�⵵ ���� �Ի��� ���� ����
select to_char(hire_date, 'yyyy-mm'), count(*)
from employees
where to_char(hire_date, 'yyyy') ='2003'
group by to_char(hire_date, 'yyyy-mm')
order by 1;

with 
months as 
   (select '2003-' || 
        case 
            when level < 10 then '0' || level
            else to_char(level)
        end mon
    from dual
    connect by level <= 12),
month_emp_count as
    (select to_char(hire_date, 'yyyy-mm') mon, count(*) cnt
     from employees
     where to_char(hire_date, 'yyyy') ='2003'
     group by to_char(hire_date, 'yyyy-mm'))
select A.mon,nvl(B.cnt,0)
from months A, month_emp_count B
where A.mon = B.mon(+)
order by 1;

























