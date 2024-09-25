use employee;

-- 1. 직급이 대리(J6)이면서 아시아 지역(L1,L2,L3 -> department와 연결되어 있음)에 근무하는 직원 조회
-- 사번, 이름, 직급명, 부서명, 근무지역명, 급여를 조회하세요
-- (조회시에는 모든 컬럼에 테이블 별칭을 사용하는 것이 좋다.)
-- (사용 테이블 : job, department, location, employee)

select e.EMP_ID
	  ,e.EMP_NAME
      ,j.JOB_NAME
      ,d.DEPT_TITLE
      ,l.LOCAL_NAME
      ,e.SALARY
from 
	  employee e
      join department d on e.DEPT_CODE = d.DEPT_ID
      join job j on e.JOB_CODE = j.JOB_CODE
      join location l on d.LOCATION_ID = l.LOCAL_CODE
where (
	 j.JOB_NAME = '대리' and l.LOCAL_NAME like ('ASIA%')
	);


-- 2. 주민번호가 70년대 생이면서 성별이 여자이고, 
--    성이 전씨인 직원들의 사원명, 주민번호, 부서명, 직급명을 조회하시오.
-- (사용 테이블 : employee, department, job)

select 
	e.EMP_NAME
	,e.EMP_NO
    ,d.DEPT_TITLE
    ,j.JOB_NAME
from employee e
	join department d on e.DEPT_CODE = d.DEPT_ID
    join job j on j.JOB_CODE = e.JOB_CODE
where (
	e.EMP_NO like '7%'
    and e.EMP_NO like '%-2%'
    and e.EMP_NAME like '전%'
    );

-- 3. 이름에 '형'자가 들어가는 직원들의
-- 사번, 사원명, 직급명을 조회하시오.
-- (사용 테이블 : employee, job)

select 
	e.EMP_ID
    ,e.EMP_NAME
    ,d.DEPT_TITLE
from employee e 
	join department d on e.DEPT_CODE = d.DEPT_ID
where (
	e.EMP_NAME like '%형%'
    );

-- 4. 해외영업팀에 근무하는 사원명, 
--    직급명, 부서코드, 부서명을 조회하시오.
-- (사용 테이블 : employee, department, job)

select
	e.EMP_NAME
    , j.JOB_NAME
    , d.DEPT_ID
    , d.DEPT_TITLE
from employee e
	join department d on e.DEPT_CODE = d.DEPT_ID
    join job j on e.JOB_CODE = j.JOB_CODE
where d.DEPT_TITLE like '해외영업%';

-- 5. 보너스포인트를 받는 직원들의 사원명, 
--    보너스포인트, 부서명, 근무지역명을 조회하시오.
-- (사용 테이블 : employee, department, location)

select 
	e.EMP_NAME
    , e.BONUS
    , d.DEPT_TITLE
    , l.LOCAL_NAME
from employee e
	join department d on e.DEPT_CODE = d.DEPT_ID
    join location l on d.LOCATION_ID = l.LOCAL_CODE
where e.BONUS is not null;

-- 6. 부서코드가 D2인 직원들의 사원명, 
--    직급명, 부서명, 근무지역명을 조회하시오.
-- (사용 테이블 : employee, job, department, location)

select 
	e.EMP_NAME,
    j.JOB_NAME,
    d.DEPT_TITLE,
    l.LOCAL_NAME
from employee e
	join department d on e.DEPT_CODE = d.DEPT_ID
    join job j on e.JOB_CODE = j.JOB_CODE
    join location l on d.LOCATION_ID = l.LOCAL_CODE
where
	e.DEPT_CODE = 'D2';

-- 7. 본인 급여 등급의 최소급여(MIN_SAL)를 초과하여 급여를 받는 직원들의
--    사원명, 직급명, 급여, 보너스포함 연봉을 조회하시오.
--    연봉에 보너스포인트를 적용하시오.
-- (사용 테이블 : employee, job, sal_grade)

select
	e.EMP_NAME
    , j.JOB_NAME
    , e.SALARY
    , concat(e.SALARY * 12 + round(e.SALARY * IFNULL( e.BONUS, 0 ),4),'원') as '보너스포함 연봉'
from employee e
	join job j on e.JOB_CODE = j.JOB_CODE
where ( 
		e.SALARY > (
					select sal.MIN_SAL
                    from sal_grade sal
                    where sal.SAL_LEVEL = e.SAL_LEVEL
                    )
        );

select * from employee;

-- 8. 한국(KO)과 일본(JP)에 근무하는 직원들의 
--    사원명, 부서명, 지역명, 국가명을 조회하시오.

select 
	e.EMP_NAME
    , d.DEPT_TITLE
    , l.LOCAL_NAME
    , n.NATIONAL_NAME
from employee e
	join department d on e.DEPT_CODE = d.DEPT_ID
    join location l on l.LOCAL_CODE = d.LOCATION_ID
    join nation n on n.NATIONAL_CODE = l.NATIONAL_CODE
where (
		n.NATIONAL_CODE = 'KO'
        or n.NATIONAL_CODE = 'JP'
		);