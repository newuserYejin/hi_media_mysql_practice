use employee;

select * from employee;

-- EMPLOYEE 테이블에서 직원들의 주민번호를 조회하여
-- 사원명, 생년, 생월, 생일을 각각 분리하여 조회
-- 단, 컬럼의 별칭은 사원명, 생년, 생월, 생일로 한다.

select
	e.EMP_NAME,
    concat('19',substr(e.EMP_NO,1,2),'년' )as 생년,
    concat(
		if(
			substr(e.EMP_NO,3,1) =0 
			,substr(e.EMP_NO,4,1)
			,substr(e.EMP_NO,3,2)
		) , '월'
    )as 생월,
    concat(
		if(
			substr(e.EMP_NO,5,1) =0 
			,substr(e.EMP_NO,6,1)
			,substr(e.EMP_NO,5,2)
		) , '일'
    )as 생일
from
	employee e;

-- 날짜 데이터에서 사용할 수 있다.
-- 직원들의 입사일에도 입사년도, 입사월, 입사날짜를 분리 조회

select
	e.EMP_NAME,
    year(e.HIRE_DATE) as 입사년도,
    month(e.HIRE_DATE) as 입사월,
    day(e.HIRE_DATE) as 입사날짜,
    substring(e.EMP_NO,3,2)
from employee e;

-- WHERE 절에서 함수 사용도 가능하다.
-- 여직원들의 모든 컬럼 정보를 조회

select *
from employee e
where substr(e.EMP_NO,8,1) in (2,4);

-- 함수 중첩 사용 가능 : 함수안에서 함수를 사용할 수 있음
-- EMPLOYEE 테이블에서 사원명, 주민번호 조회
-- 단, 주민번호는 생년월일만 보이게 하고, '-'다음의 값은
-- '*'로 바꿔서 출력

select 
	e.EMP_NAME,
    insert(e.EMP_NO,8,7,repeat('*',7)) as 주민번호
from employee e;


-- EMPLOYEE 테이블에서 사원명, 이메일,
-- @이후를 제외한 아이디 조회

select 
	EMP_NAME,
    EMAIL,
    left(EMAIL,locate('@',EMAIL)-1) as 아이디
from employee;


-- EMPLOYEE 테이블에서 사원의 이름, 입사일, 입사후 6개월이
-- 되는 날짜를 조회

select
	EMP_NAME,
	HIRE_DATE,
    date_add(HIRE_DATE, interval 6 Month) as 6개월후
from employee;

-- EMPLOYEE 테이블에서 근무 년수가 20년 이상인 직원 조회

select
	*
from employee
where
	timestampdiff(year,HIRE_DATE,now()) >= 20;

-- EMPLOYEE 테이블에서 사원명, 입사일, 
-- 입사한 월의 근무일수를 조회하세요

select 
	EMP_NAME,
    HIRE_DATE,
    last_day(HIRE_DATE) - HIRE_DATE
from employee;


-- EMPLOYEE 테이블에서 직원의 이름, 입사일, 근무년수를 조회
-- 단, 근무년수는 현재년도 - 입사년도로 조회

select
	EMP_NAME,
    HIRE_DATE,
    timestampdiff(year,HIRE_DATE,now()) as 근무년수
from employee;

-- EMPLOYEE 테이블에서 사번이 홀수인 직원들의 정보 모두 조회 (mod)

select
	*
from employee
where 
	EMP_ID % 2 = 1;