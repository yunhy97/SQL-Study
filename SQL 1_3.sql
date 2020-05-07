select first_name || ' ' || last_name name
from employees;

select substr('970715',3, 2)
from employees;

select *
from dual;

select instr('010-5610-9257','-')
from dual;

select substr('���� ���빮��',1,instr('���� ���빮��',' '))
from dual;

select street_address, substr(street_address,1,instr(street_address,' ')-1)
from locations;

select replace(first_name, 'a', 'A')
from employees;

--���� �Լ�
--�ݿø��ϱ�
select
    round(1265.737,2) "2",    --�Ҽ��� 2�ڸ��� �ݿø��ض�
    round(1265.737,1) "1",    --�Ҽ��� 1�ڸ��� �ݿø��ض�
    round(1265.737,0) "0",    --���� �ڸ��� �ݿø��ض�
    round(1265.737) " ",      --���� �ڸ��� �ݿø��ض�
    round(1265.737,-1) "-1",  --���� �ڸ��� �ݿø��ض�
    round(1265.737,-2) "-2"   --���� �ڸ��� �ݿø��ض�
from dual;

--���ڰ� ������
select
    trunc(1265.737,2) "2",    --�Ҽ��� 2�ڸ������� ����� ������
    trunc(1265.737,1) "1",    --�Ҽ��� 1�ڸ������� ����� ������
    trunc(1265.737,0) "0",    --���� �ڸ������� ����� ������
    trunc(1265.737) " ",      --���� �ڸ������� ����� ������
    trunc(1265.737,-1) "-1",  --���� �ڸ������� ����� ������
    trunc(1265.737,-2) "-2"   --���� �ڸ������� ����� ������
from dual;

--�������� �ñ��� ��ȸ�ϱ�
--�������̵�, �̸�, �������̵�, �޿�, �ñ�
--�ñ� = �޿�*ȯ��/(5*8) �ñ��� ������������ ǥ���Ѵ�.
select employee_id
        , first_name
        , job_id, salary
        , trunc(salary*1220.40/(5*8)) time_salary
from employees
order by time_salary desc;

--�������� ���ϱ�
select mod(32,5)
from dual;

--��¥ �Լ�
--���� ��¥�� �ð����� ��ȸ�ϱ�
select sysdate
from dual;

--�������̵�, ������, �Ի���, ���ñ��� �ٹ��� ��¥
select employee_id
        , first_name
        , hire_date
        , trunc(sysdate - hire_date) hire_today
from employees;

--����, 3����, 1������, 1������
select sysdate "����"
        ,sysdate - 3 "3�� ��"
        ,sysdate - 7 "1���� ��"
        ,sysdate - 30 "1�� ��"
from dual;

--60�� �μ��� �Ҽӵ� ������� ���̵�, �̸�, �Ի���, �ٹ��� �������� ��ȸ�ϱ�
--�������� �Ҽ����κ��� ������.
select employee_id, first_name, hire_date, trunc(months_between(sysdate, hire_date)) month_hire
from employees
where department_id =60;

--���ú��� 3���� ���� ��¥,3���� ������ ��¥��?
select sysdate today, add_months(sysdate,12) plus_month, add_months(sysdate, -3) minus_month
from dual;

--��¥ �ݿø��ϱ�,������
--��, ��, �ʰ� 0���� �ٲ��.
select sysdate, round(sysdate), trunc(sysdate)
from dual;

--�� ��¥���� �� �� ����ϱ�
--���� ��¥�� ���� TRUNC()�Լ��� �ú��ʸ� ���� 0���� ���� �� ��¥ ������ �ߴ�.
select employee_id
        , first_name
        , hire_date
        , sysdate - hire_date
        , trunc(sysdate) - hire_date
from employees;

--�̹� ���� ������ �� ��ȸ�ϱ�
select last_day(trunc(sysdate))
from dual;

select next_day(trunc(sysdate),'������')
from dual;

--������ �������� ���� �� �����
select next_day(trunc(sysdate),7)
from dual;

--������ �������� ���� �� �ݿ���
select next_day(trunc(sysdate),6)
from dual;

--������ �������� ���� �� �Ͽ���
select next_day(trunc(sysdate),1)
from dual;

--��ȯ �Լ�
--��¥�� ���ڷ� ��ȯ�ϱ�
select to_char(sysdate, 'YYYY') ��
        , to_char(sysdate, 'MM') ��
        , to_char(sysdate, 'DD') ��
        , to_char(sysdate, 'DAY') ����
        , to_char(sysdate, 'AM') "����/����"
        , to_char(sysdate, 'HH') "�ð�(12)"
        , to_char(sysdate, 'HH24') "�ð�(24)"
        , to_char(sysdate, 'MI') ��
        , to_char(sysdate, 'SS') ��
from dual;


-- 2003�⵵�� �Ի��� ����� ���̵�, �̸�, �Ի��� ��ȸ�ϱ�
select employee_id
    , first_name
    , to_char(hire_date, 'mm')
from employees
where to_char(hire_date, 'YYYY') ='2003';

-- �Ի����� ���� ��¥�� ���� ��¥�� �Ի��� ������ ���̵�, �̸�, �Ի����� ��ȸ�ϱ�
select employee_id
    , first_name
    , hire_date
from employees
where to_char(hire_date, 'mmdd') = to_char(sysdate, 'mmdd');

-- Ư����¥�� ��Ÿ���� ���ڸ� ��¥(DATE Ÿ��)���� ��ȯ�ϱ�
select to_date('2018-12-31', 'yyyy-mm-dd') + 1000
from dual;

-- Ư����¥�� ��Ÿ���� ���ڸ� ��¥�� ��ȯ�ؼ� ���ñ����� �ϼ�, �������� ��ȸ�ϱ�
select trunc(sysdate - to_date('1993-11-15', 'yyyy-mm-dd'))
    , months_between(trunc(sysdate) , to_date('1993-11-15', 'yyyy-mm-dd'))
from dual;

-- 2005-01-01 ~ 2005-03-31 ���̿� �Ի��� ����� ���̵�, �̸�, �Ի���, �������̵� ��ȸ�ϱ�
select employee_id
    , first_name
    , hire_date
    , job_id
from employees
where hire_date >= to_date('2005-01-01','yyyy-mm-dd')
and hire_date <= to_date('2005-03-31', 'yyyy-mm-dd')
order by hire_date;

select employee_id
    , first_name
    , hire_date
    , job_id
from employees
where hire_date between to_date('2005-01-01','yyyy-mm-dd')
                        and to_date('2005-03-01', 'yyyy-mm-dd')
        order by hire_date;
        
-- 2003�⿡ �Ի��� ������ ���̵�. �̸�, �Ի��� ��ȸ
select employee_id
    , first_name
    , hire_date
from employees
where to_char(hire_date, 'yyyy') = '2003'             --����
    order by hire_date;

    
select employee_id
    , first_name
    , hire_date
from employees
where hire_date >= to_date('20030101', 'yyyymmdd')             --����
    and hire_date < to_date('20040101', 'yyyymmdd')
    order by hire_date;

    
-- ���ڸ� õ�������� �����ڸ� ���Ե� �ؽ�Ʈ�� ��ȯ�ؼ� ��ȸ�ϱ�
select to_char(10000, '0,000,000'), to_char(10000, '9,999,999')
from dual;

-- ���ڸ� �Ҽ��� 2�ڸ����� �ݿø��� �� �ؽ�Ʈ�� ��ȯ�ؼ� ��ȸ�ϱ�
select to_char(123.456, '000.00'), to_char(123.456, '999.99')
from dual;

-- ���ڸ� ���ڷ� ��ȯ�ؼ� ����ϱ�
-- �޿��� 15000�޷� �̻��� ������ ���̵�, �̸�, �޿��� ��ȸ�ϱ�
select employee_id, first_name, salary
from employees
-- where salary >= '15000';    // O
-- where salary >= '15,000';    // X
where salary >= TO_NUMBER('15,000', '99,999');      -- TO_NUMBER() �Լ��� �ݵ�� ����ؾ� �ϴ� ���

-- NVL() �Լ�
select NVL(10, 1)   -- 10�� �������̴�
    , NVL(NULL, 1)  --  1�� �������̴�.
from dual;

-- �������̵�, �̸�, �޿�, Ŀ�̼��� ��ȸ�ϱ�
-- Ŀ�̼� ���� NULL�� ��� 0���� ��ȸ�Ѵ�.
select employee_id, first_name, salary, NVL(commission_pct,0)
from employees
order by employee_id;

-- �������̵�, �̸�, �Ǳ޿��� ��ȸ�ϱ�
-- �Ǳ޿� = �޿� + �޿�*Ŀ�̼�
select employee_id, first_name, salary + salary*NVL(commission_pct,0)
from employees
order by employee_id;

-- �μ����̵�, �μ���, �ش�μ� ������ ���̵� ��ȸ�ϱ�
-- ������ ���̵� NULL�� ��� '������ ������ ����'���� ��ȸ�ϱ�
select department_id, department_name, NVL(to_char(manager_id), '������ ������ ����')
from departments;

-- �μ����̵�, �μ���, �ش�μ� ������ ���̵� ��ȸ�ϱ�
-- ������ ���̵� NULL�� ��� 100������ �����ڷ� �����Ѵ�.
select department_id, department_name, NVL(manager_id, 100)
from departments
order by department_id;

-- NVL2() �Լ� ����ϱ�
select NVL2(10,1,0)     -- �������� 1�̴�
    , NVL2(NULL,1,0)    -- �������� 0�̴�
from dual;

-- �������̵�, �̸�, Ŀ�̼� ���ɿ��θ� 'YES', 'NO'�� ��ȸ�ϱ�
select employee_id, first_name, NVL2(commission_pct, 'YES', 'NO')
from employees
order by employee_id;

-- CASE ~ WHEN
-- �������̵�, �̸�, �޿�, �޿���� ��ȸ�ϱ�
-- �޿������ 
-- 20000�޷� �̻�   A
-- 10000�޷� �̻�   B
--  5000�޷� �̻�   C
-- �� ��           D
select employee_id, first_name, salary, 
CASE
    WHEN salary >= 20000 THEN 'A'
    WHEN salary >= 10000 THEN 'B'
    WHEN salary >= 5000 THEN 'C'
    ELSE 'D'
END as ���
from employees
order by employee_id;

-- �������̵�, �̸�, �޿�, �λ�� �޿� ��ȸ�ϱ�
-- �λ��
-- 20000�޷� �̻�   10%�λ�
-- 10000�޷� �̻�   15%�λ�
--  5000�޷� �̻�   20%�λ�
-- �� ��           25%�λ�
select employee_id
    , first_name
    , salary
    , CASE
        WHEN salary >= 20000 THEN salary + salary*0.1
        WHEN salary >= 10000 THEN salary + salary*0.15
        WHEN salary >= 5000 THEN salary + salary*0.2
        ELSE salary + salary*0.25
      END as �λ�޿�
from employees
order by employee_id;

-- �������̵�, �̸�, �޿�, �λ�� �޿��� ��ȸ�ϱ�
-- �λ����
-- �ҼӺμ��� 50�� �μ��� 10% �λ�
-- �ҼӺμ��� 80�� �μ��� 15% �λ�
-- �� �� �μ��� 5% �λ�
select employee_id
    , first_name
    , salary
    , CASE
        WHEN department_id = 50 THEN salary*1.1
        WHEN department_id = 80 THEN salary*1.15
        ELSE salary*1.05
      END INCRESED_SALARY
from employees
order by employee_id;

select employee_id
    , first_name
    , salary
    , CASE department_id
        WHEN 50 THEN salary*1.1
        WHEN 80 THEN salary*1.15
        ELSE salary*1.05
      END INCRESED_SALARY
from employees
order by employee_id;

select employee_id
    , first_name
    , salary
    , DECODE(department_id, 50, salary*1.1,
                            80, salary*1.15,
                                salary*1.05) INCRESED_SALARY
from employees
order by employee_id;

-- DECODE() �Լ��� ����ؼ� ��ȸ�ϱ�
-- �������̵�, �̸�, �޿�, �޿� ��� ��ȸ�ϱ�
-- �λ��
-- 20000�޷� �̻�   A
-- 10000�޷� �̻�   B
--  5000�޷� �̻�   C
-- �� ��           D
select employee_id
    , first_name
    , salary
    , DECODE(trunc(salary, -4), 20000, 'A'
                              , 10000, 'B'
                              , DECODE(round(salary, -4), 10000, 'C'
                                                               , 'D')) as ���                           
from employees
order by employee_id;

select employee_id
    , first_name
    , salary
    , DECODE(trunc(salary, -4), 20000, 'A'
                              , 10000, 'B'
                              , DECODE(trunc(salary/5000)*5000, 5000, 'C'
                                                            , 'D')) SALARY_GRADE                  
from employees
order by employee_id;
















