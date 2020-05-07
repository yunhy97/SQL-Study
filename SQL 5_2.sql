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

select to_date('20200101', 'yyyymmdd') + level -1
from dual
connect by level <=31;

--�μ����̵�, �μ���, �ش�μ��� ������� ��ȸ�ϱ�
select outter.department_id, outter.department_name,
    (select count(*)
    from employees inner
    where inner.department_id = outter.department_id) cnt
from departments outter;









