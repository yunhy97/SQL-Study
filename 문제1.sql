CREATE table categories(
    category_no number(10) primary key,
    category_name varchar2(50) not null,
    category_top_no number(10) not null,
    constraint fk_category_no foreign key(category_top_no)
    references categories(category_no)
);
create table products (
    product_no number(10) primary key,
    product_name varchar2(100),
    category_no number(10) not null,
    product_price number(10) check (product_price > 0),
    product_registered_date date default sysdate,
    constraint fk_pro_category_no foreign key(category_no)
    references categories(category_no)
);

create table libraries (
    customer_no number(10) primary key,
    customer_name varchar2(50) not null,
    customer_tel varchar2(100) not null,
    customer_email varchar2(100) unique,
    customer_point number(10) default 0,
    customer_registered_date date default sysdate
);

select employee_id, first_name, last_name, job_id, salary
from employees
where department_id = 90;

select employee_id, first_name, last_name, job_id, salary, commission_pct
from employees
where commission_pct is not null;

select employee_id, first_name, last_name, hire_date
from employees
where to_char(hire_date, 'YYYY') = '2007';
-------------------------------------------------------------------------------------------------------------
select employee_id, first_name, last_name, job_id, salary, (salary + salary * commission_pct)+ 12 year_money
from employees;

select job_id, count(*)
from employees
group by job_id
order by count(*) desc;

create or replace view employees_view
as
    select a.employee_id, a.first_name, a.salary, a.hire_date, 
           c.job_id, c.job_title, 
           b.department_id, 
           d.city
    from employees a, departments b, jobs c, locations d
    where a.department_id = b.department_id
    and a.job_id = c.job_id
    and b.location_id = d.location_id;

select employee_id, first_name, salary
    , case 
        when salary >= 20000 then salary*0.1
        when salary >= 15000 then salary*0.07
        when salary >= 10000 then salary*0.05
        when salary >= 5000  then salary*0.03
        else salary*0.01
      end tax
from employees
order by employee_id;
        
select employee_id, first_name, job_id, salary
from employees
where salary > (select avg(salary)
                from employees);
                
select first_name, cnt
from employees a ,(select count(*) cnt, manager_id
        from employees 
        group by manager_id) b
where a.employee_id = b.manager_id;

select a.job_id, b.employee_id
from employees a, (select employee_id
                    from employees
                    minus
                    select employee_id
                    from job_history) b
where a.employee_id = b.employee_id;

create or replace procedure update_salary
(i_dept_id in number)
IS

BEGIN
    update employees
    set
        salary = salary + trunc(salary*0.05)
    where
        department_id = i_dept_id;
        
    commit;
END;

execute update_salary(50);
------------------------------------------------------------------------------------
select num, employee_id, first_name, salary
from (select row_number() over(order by salary desc) num,employee_id, salary, first_name
        from employees)
where num >=6 and num <= 10;

select rownum, employee_id, first_name, job_id, salary
from (select employee_id, first_name, job_id, salary
from employees
order by salary desc)
where rownum <= 5;

select A.department_id, A.department_name, B.cnt
from departments A, (select rownum ranking, department_id ,cnt
                    from (select department_id, count(*) cnt
                            from employees
                            group by department_id
                            order by cnt desc)
                    where rownum <= 2) B
where A.department_id = B.department_id;