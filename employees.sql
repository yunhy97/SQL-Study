select A.employee_id, A.first_name, A.last_name, A.email, A.phone_number,
        A.hire_date, A.job_id, A.salary, A.commission_pct, 
        C.employee_id manager_id, C.first_name manager_first_name, C.last_name manager_last_name,
        B.department_id, B.department_name
from(select employee_id, first_name, last_name, email, phone_number, 
            hire_date, job_id, salary, commission_pct, manager_id, department_id,
            row_number() over (order by employee_id asc) rownumber
    from employees) A, departments B, employees C
where A.rownumber >=1 and A.rownumber <=20
and A.department_id = B.department_id(+)
and A.manager_id = C.employee_id(+);

select count(*)
from employees;

create table sample_files(
    file_no number(5) primary key,
    file_title varchar2(200) not null,
    file_name varchar2(300) not null,
    file_create_date date default sysdate
);

create sequence sample_file_seq nocache;