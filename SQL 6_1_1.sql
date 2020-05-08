--프로시저1
--직원 번호 전달받아서 그 직원의 급여를 인상시키는 프로시저 작성하기
create or replace procedure update_salary
(i_emp_id in number) -- 매개변수
IS 
    --변수 정의한다.
    --변수        변수의 데이터타입
    --           employees의 salary 컬럼의 데이터타입과 동일한 데이터타입을 변수 선언
    v_emp_salary employees.salary%type;  --사원의 급여, v_emp_salary number;
    v_update_rate number(3,2);           --급여 인상률
BEGIN
    --SQL문장, PL/SQL 구문을 작성
    
    --전달받은 직원아이디에 해당하는 직원의 급여를 조회한다.
    --조회된 직원의 급여를 위해서 선언한 v_emp_salary에 대입한다.
    select salary
    INTO v_emp_salary
    from employees
    where employee_id = i_emp_id;
    
    --직원의 급여에 따라서 인상률을 결정하기
    --20000달러 이상, 10%, 10000달러 이상 15%, 그 외 20% 인상
    IF v_emp_salary >= 20000 then v_update_rate := 0.1;
    ELSIF V_emp_salary >= 10000 then v_update_rate := 0.15;
    ELSE v_update_rate := 0.2;
    END IF;
    
    --급여를 인상시키기
    update employees
    set
        salary = salary + trunc(salary*v_update_rate)
    where
        employee_id = i_emp_id;
        
    --DB에 영구적으로 반영시키기
    commit;
END;
    


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    




















