--프로시저 실행1
execute update_salary(100);

--사용자함수1
--직원아이디를 전달받아서 그 직원의 연봉을 반환하는 함수(커미션이 포함된)
CREATE or replace function GET_ANNUAL_SALARY
    (i_emp_id in number)        --직원아이디를 매개변수로 전달받는다.
RETURN number               --이 함수의 반환값은 숫자값이다.
    
IS
    v_salary        employees.salary%type;           --급여
    v_comm          employees.commission_pct%type;   --커미션
    v_annual_salary employees.salary%type;           --연봉
    
BEGIN
    --직원아이디에 해당하는 직원의 급여와 커미션을 조회해서 v_salary와 v_comm에 저장한다.
    select salary, nvl(commission_pct,0)
    INTO v_salary, v_comm
    from employees
    where employee_id = i_emp_id;
    
    --커미션이 반영된 연봉을 계산해서 변수에 대입한다.
    v_annual_salary := v_salary * 12 + trunc(v_salary*v_comm);
    
    --변수에 저장된 값을 반환한다.
    return v_annual_salary;
 END;































































