-- ��� ���̺��� ��� ���̵�, �̸�(first name), �޿��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES;

-- �μ����̺��� �μ����̵�, �μ��� ��ȸ�ϱ�
SELECT DEPARTMENT_ID, DEPARTMENT_NAME
FROM DEPARTMENTS;

-- ����̵�, ��Ÿ��Ʋ�� ��ȸ�ϱ�
SELECT JOB_ID, JOB_TITLE
FROM JOBS;

--�����̸� ��ȸ�ϱ�
SELECT COUNTRY_NAME
FROM COUNTRIES;

--������̵�, �̸�, �޿�, ������ ��ȸ�ϱ�
--������̵��� ��Ī�� ID, �̸��� NAME, �޿��� SAL, ������ ANN_SAL�� �����ϱ�
SELECT EMPLOYEE_ID ID, FIRST_NAME NAME, SALARY SAL, (SALARY*12) AS ANN_SAL
FROM EMPLOYEES;

--������̵�, �̸�, �޿�, 10%�λ�� �޿��� ��ȸ�ϱ�
--������̵��� ��Ī�� ID, �̸��� NAME, �޿��� SAL, 10%�λ�� �޿��� INCREMENT SALARY�� �����ϱ�
SELECT EMPLOYEE_ID ID, FIRST_NAME NAME, SALARY SAL, (SALARY+(SALARY*0.1)) AS "INCREMENT SALARY"
FROM EMPLOYEES;

--NULL ���� �ִ� �÷� ��ȸ�ϱ�
--�μ����̵�, �μ���, �μ������ ���̵� ��ȸ�ϱ�
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID
FROM DEPARTMENTS;

--������̵�, �̸�, �޿�, Ŀ�̼�,Ŀ�̼��� ���Ե� �޿� ��ȸ�ϱ�
--Ŀ�̼��� ���Ե� �޿��� �޿� + �޿� * Ŀ�̼�
SELECT EMPLOYEE_ID, (FIRST_NAME ||' '|| LAST_NAME) NAME, SALARY, COMMISSION_PCT, SALARY+SALARY*COMMISSION_PCT
FROM EMPLOYEES;

--�ߺ������ ��ȸ�ϱ�
--������� �����ϰ� �ִ� ������ ���� ��ȸ�ϱ�
SELECT DISTINCT JOB_ID 
FROM EMPLOYEES;

--60�� �μ��� �ٹ��ϴ� ����� ���̵�, �̸�, ����, �޿�, �μ����̵� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

--�޿��� 15000�޷� �̻� �޴� ����� ���̵�, �̸�, ����, �޿��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE SALARY >= 15000;
