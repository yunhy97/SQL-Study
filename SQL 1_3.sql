select first_name || ' ' || last_name name
from employees;

select substr('970715',3, 2)
from employees;

select *
from dual;

select instr('010-5610-9257','-')
from dual;

select substr('서울 동대문구',1,instr('서울 동대문구',' '))
from dual;

select street_address, substr(street_address,1,instr(street_address,' ')-1)
from locations;

select replace(first_name, 'a', 'A')
from employees;

--숫자 함수
--반올림하기
select
    round(1265.737,2) "2",    --소수점 2자리로 반올림해라
    round(1265.737,1) "1",    --소수점 1자리로 반올림해라
    round(1265.737,0) "0",    --일의 자리로 반올림해라
    round(1265.737) " ",      --일의 자리로 반올림해라
    round(1265.737,-1) "-1",  --십의 자리로 반올림해라
    round(1265.737,-2) "-2"   --백의 자리로 반올림해라
from dual;

--숫자값 버리기
select
    trunc(1265.737,2) "2",    --소수점 2자리까지만 남기고 버려라
    trunc(1265.737,1) "1",    --소수점 1자리까지만 남기고 버려라
    trunc(1265.737,0) "0",    --일의 자리까지만 남기고 버려라
    trunc(1265.737) " ",      --일의 자리까지만 남기고 버려라
    trunc(1265.737,-1) "-1",  --십의 자리까지만 남기고 버려라
    trunc(1265.737,-2) "-2"   --백의 자리까지만 남기고 버려라
from dual;

--직원들의 시급을 조회하기
--직원아이디, 이름, 직종아이디, 급여, 시급
--시급 = 급여*환율/(5*8) 시급은 원단위까지만 표시한다.
select employee_id
        , first_name
        , job_id, salary
        , trunc(salary*1220.40/(5*8)) time_salary
from employees
order by time_salary desc;

--나머지값 구하기
select mod(32,5)
from dual;

--날짜 함수
--현재 날짜와 시간정보 조회하기
select sysdate
from dual;

--직원아이디, 직원명, 입사일, 오늘까지 근무한 날짜
select employee_id
        , first_name
        , hire_date
        , trunc(sysdate - hire_date) hire_today
from employees;

--오늘, 3일전, 1주일전, 1개월전
select sysdate "지금"
        ,sysdate - 3 "3일 전"
        ,sysdate - 7 "1주일 전"
        ,sysdate - 30 "1달 전"
from dual;

--60번 부서에 소속된 사원들의 아이디, 이름, 입사일, 근무한 개월수를 조회하기
--개월수는 소숫점부분을 버린다.
select employee_id, first_name, hire_date, trunc(months_between(sysdate, hire_date)) month_hire
from employees
where department_id =60;

--오늘부터 3개월 뒤의 날짜,3개월 이전의 날짜는?
select sysdate today, add_months(sysdate,12) plus_month, add_months(sysdate, -3) minus_month
from dual;

--날짜 반올림하기,버리기
--시, 분, 초가 0으로 바뀐다.
select sysdate, round(sysdate), trunc(sysdate)
from dual;

--두 날짜간의 일 수 계산하기
--현재 날짜에 대해 TRUNC()함수로 시분초를 전부 0으로 만든 후 날짜 연산을 했다.
select employee_id
        , first_name
        , hire_date
        , sysdate - hire_date
        , trunc(sysdate) - hire_date
from employees;

--이번 달의 마지막 날 조회하기
select last_day(trunc(sysdate))
from dual;

select next_day(trunc(sysdate),'수요일')
from dual;

--오늘을 기준으로 다음 번 토요일
select next_day(trunc(sysdate),7)
from dual;

--오늘을 기준으로 다음 번 금요일
select next_day(trunc(sysdate),6)
from dual;

--오늘을 기준으로 다음 번 일요일
select next_day(trunc(sysdate),1)
from dual;

--변환 함수
--날짜를 문자로 변환하기
select to_char(sysdate, 'YYYY') 년
        , to_char(sysdate, 'MM') 월
        , to_char(sysdate, 'DD') 일
        , to_char(sysdate, 'DAY') 요일
        , to_char(sysdate, 'AM') "오전/오후"
        , to_char(sysdate, 'HH') "시간(12)"
        , to_char(sysdate, 'HH24') "시간(24)"
        , to_char(sysdate, 'MI') 분
        , to_char(sysdate, 'SS') 초
from dual;


-- 2003년도에 입사한 사원의 아이디, 이름, 입사일 조회하기
select employee_id
    , first_name
    , to_char(hire_date, 'mm')
from employees
where to_char(hire_date, 'YYYY') ='2003';

-- 입사일이 오늘 날짜와 같은 날짜에 입사한 직원의 아이디, 이름, 입사일을 조회하기
select employee_id
    , first_name
    , hire_date
from employees
where to_char(hire_date, 'mmdd') = to_char(sysdate, 'mmdd');

-- 특정날짜를 나타내는 문자를 날짜(DATE 타입)으로 변환하기
select to_date('2018-12-31', 'yyyy-mm-dd') + 1000
from dual;

-- 특정날짜를 나타내는 문자를 날짜로 변환해서 오늘까지의 일수, 개월수를 조회하기
select trunc(sysdate - to_date('1993-11-15', 'yyyy-mm-dd'))
    , months_between(trunc(sysdate) , to_date('1993-11-15', 'yyyy-mm-dd'))
from dual;

-- 2005-01-01 ~ 2005-03-31 사이에 입사한 사원의 아이디, 이름, 입사일, 직종아이디 조회하기
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
        
-- 2003년에 입사한 직원의 아이디. 이름, 입사일 조회
select employee_id
    , first_name
    , hire_date
from employees
where to_char(hire_date, 'yyyy') = '2003'             --지양
    order by hire_date;

    
select employee_id
    , first_name
    , hire_date
from employees
where hire_date >= to_date('20030101', 'yyyymmdd')             --지향
    and hire_date < to_date('20040101', 'yyyymmdd')
    order by hire_date;

    
-- 숫자를 천단위마다 구분자를 포함된 텍스트로 변환해서 조회하기
select to_char(10000, '0,000,000'), to_char(10000, '9,999,999')
from dual;

-- 숫자를 소숫점 2자리에서 반올림한 후 텍스트로 변환해서 조회하기
select to_char(123.456, '000.00'), to_char(123.456, '999.99')
from dual;

-- 문자를 숫자로 변환해서 사용하기
-- 급여가 15000달러 이상인 직원의 아이디, 이름, 급여를 조회하기
select employee_id, first_name, salary
from employees
-- where salary >= '15000';    // O
-- where salary >= '15,000';    // X
where salary >= TO_NUMBER('15,000', '99,999');      -- TO_NUMBER() 함수를 반드시 사용해야 하는 경우

-- NVL() 함수
select NVL(10, 1)   -- 10이 최종값이다
    , NVL(NULL, 1)  --  1이 최종값이다.
from dual;

-- 직원아이디, 이름, 급여, 커미션을 조회하기
-- 커미션 값이 NULL인 경우 0으로 조회한다.
select employee_id, first_name, salary, NVL(commission_pct,0)
from employees
order by employee_id;

-- 직원아이디, 이름, 실급여를 조회하기
-- 실급여 = 급여 + 급여*커미션
select employee_id, first_name, salary + salary*NVL(commission_pct,0)
from employees
order by employee_id;

-- 부서아이디, 부서명, 해당부서 관리자 아이디를 조회하기
-- 관리자 아이디가 NULL인 경우 '지정된 관리자 없음'으로 조회하기
select department_id, department_name, NVL(to_char(manager_id), '지정된 관리자 없음')
from departments;

-- 부서아이디, 부서명, 해당부서 관리자 아이디를 조회하기
-- 관리자 아이디가 NULL인 경우 100직원을 관리자로 지정한다.
select department_id, department_name, NVL(manager_id, 100)
from departments
order by department_id;

-- NVL2() 함수 사용하기
select NVL2(10,1,0)     -- 최종값은 1이다
    , NVL2(NULL,1,0)    -- 최종값은 0이다
from dual;

-- 직원아이디, 이름, 커미션 수령여부를 'YES', 'NO'로 조회하기
select employee_id, first_name, NVL2(commission_pct, 'YES', 'NO')
from employees
order by employee_id;

-- CASE ~ WHEN
-- 직원아이디, 이름, 급여, 급여등급 조회하기
-- 급여등급은 
-- 20000달러 이상   A
-- 10000달러 이상   B
--  5000달러 이상   C
-- 그 외           D
select employee_id, first_name, salary, 
CASE
    WHEN salary >= 20000 THEN 'A'
    WHEN salary >= 10000 THEN 'B'
    WHEN salary >= 5000 THEN 'C'
    ELSE 'D'
END as 등급
from employees
order by employee_id;

-- 직원아이디, 이름, 급여, 인상된 급여 조회하기
-- 인상률
-- 20000달러 이상   10%인상
-- 10000달러 이상   15%인상
--  5000달러 이상   20%인상
-- 그 외           25%인상
select employee_id
    , first_name
    , salary
    , CASE
        WHEN salary >= 20000 THEN salary + salary*0.1
        WHEN salary >= 10000 THEN salary + salary*0.15
        WHEN salary >= 5000 THEN salary + salary*0.2
        ELSE salary + salary*0.25
      END as 인상급여
from employees
order by employee_id;

-- 직원아이디, 이름, 급여, 인상된 급여를 조회하기
-- 인상률은
-- 소속부서가 50번 부서면 10% 인상
-- 소속부서가 80번 부서면 15% 인상
-- 그 외 부서는 5% 인상
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

-- DECODE() 함수를 사용해서 조회하기
-- 직원아이디, 이름, 급여, 급여 등급 조회하기
-- 인상률
-- 20000달러 이상   A
-- 10000달러 이상   B
--  5000달러 이상   C
-- 그 외           D
select employee_id
    , first_name
    , salary
    , DECODE(trunc(salary, -4), 20000, 'A'
                              , 10000, 'B'
                              , DECODE(round(salary, -4), 10000, 'C'
                                                               , 'D')) as 등급                           
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
















