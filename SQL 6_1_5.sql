--사용자함수 실행3
select get_total_salary from dual;

--사용자함수4
--지정된 부서의 연봉 총액을 반환하는 함수
CREATE or replace function GET_DEPT_TOTAL_SALARY
(i_dept_id in number)

RETURN number

IS
    v_salary        employees.salary%type;
    v_comm          employees.commission_pct%type;
    v_annual_salary employees.salary%type;
    v_total_salary  number :=0;
    
    --파라미터가 필요한 커서
    --커서 실행에 필요한 파라미터를 정의한다.
    CURSOR emp_list(param_dept_id number) IS
    select salary, nvl(commission_pct,0) comm
    from employees
    where department_id = param_dept_id;
BEGIN
    --FOR문을 사용해서 파라미터가 있는 커서 실행하기
    FOR emp IN emp_list(i_dept_id) LOOP
        v_salary            := emp.salary;
        v_comm              := emp.comm;
        v_annual_salary     := v_salary*12 + trunc(v_salary*v_comm)*12;
        v_total_salary      := v_total_salary + v_annual_salary;
    END LOOP;
    
    RETURN v_total_salary;
END;
