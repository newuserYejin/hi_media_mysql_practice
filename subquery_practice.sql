use employee;

-- 1번
select *
from employee
where 
	dept_code = (
				select dept_code
                from employee
                where emp_name = '노옹철'
                );

-- 2번
select 
	EMP_ID,
    EMP_NAME,
    JOB_CODE,
    SALARY
from employee
where
	salary > (
			select avg(salary) from employee
            );
            
-- 3번
select 
	EMP_ID,
    EMP_NAME,
    JOB_CODE,
    SALARY
from employee
where
	salary > (
			select
				salary
			from
				employee
			WHERE
				EMP_NAME = '노옹철'
            );
            
-- 4번
SELECT 
	EMP_ID
    , EMP_NAME
    , JOB_CODE
    , DEPT_CODE
    , SALARY
    , HIRE_DATE
FROM
	EMPLOYEE
WHERE
	SALARY = (
				SELECT MIN(SALARY)
                FROM EMPLOYEE
                );

-- 5번
select
	e.emp_name,
    e.job_code,
    e.dept_code,
    e.salary
from
	employee e,
    ( 
		select dept_code,max(salary) as max_salary
		from employee
		GROUP BY DEPT_CODE
    ) as m 
where (
		e.dept_code = m.dept_code
        and e.salary = m.max_salary
		);
        
SELECT
	E.EMP_NAME
    , E.JOB_CODE
    , E.DEPT_CODE
    , E.SALARY
FROM
	EMPLOYEE E,
	(
	SELECT
		E.DEPT_CODE AS DD, 
        MAX(E.SALARY) AS MAX_S
	FROM
		EMPLOYEE E
	GROUP BY
		E.DEPT_CODE
    ) AS MAXLIST
WHERE
	E.DEPT_CODE = MAXLIST.DD
    AND E.SALARY = MAXLIST.MAX_S;
        
-- 6번
select 
	e.emp_id as 사번
    , e.emp_name as 이름
    , d.dept_title as 부서명
    , j.job_name
    , '관리자' as 구분
from
	employee e
    left join department d on e.dept_code = d.dept_id
    join job j on e.job_code = j.job_code
where
	emp_id in (
				select distinct manager_id
                from employee
                where manager_id is not null
                )
union
select 
	e.emp_id as 사번
    , e.emp_name as 이름
    , d.dept_title as 부서명
    , j.job_name
    , '직원' as 구분
from
	employee e
    left join department d on e.dept_code = d.dept_id
    join job j on e.job_code = j.job_code
where
	emp_id not in (
				select distinct manager_id
                from employee
                where manager_id is not null
                );

-- 7번

select
	e.emp_id,
    e.emp_name,
    e.job_code,
    avg_list.job_code,
    avg_list.avg_salary as 평균,
    e.salary as 급여
from
    (
		select
			job_code,
            round(avg(salary),-5) as avg_salary
		from employee
		group by job_code
	) as avg_list,
	employee e
    join job j on e.job_code = j.job_code
where
	e.job_code = avg_list.job_code
	and e.salary = avg_list.avg_salary;

-- 8번
select
	e.emp_name as 이름,
    j.job_name as 직급,
    d.dept_title as 부서,
    e.hire_date as 입사일
from employee e
	join job j on e.job_code = j.job_code
    join department d on e.dept_code = d.dept_id
where
	e.ent_date is null
	and (e.dept_code,e.job_code) in (
								select
									dept_code
									, job_code
								from
									employee
								where
									ent_date is not null
									and substr(emp_no,8,1) in (2,4)
								);
			
-- 9번
select
	d.dept_id
    , d.dept_title
    , top_three.avgSalary as 평균급여
from
	department d
    join (
        select dept_code, avg(salary) as avgSalary
		from employee
		group by dept_code
		order by avg(salary) desc
		limit 3
    ) as top_three
	on d.dept_id = top_three.dept_code;

-- 10번
select
	emp_name
    , salary
    , DENSE_RANK() OVER(ORDER BY 	salary desc) AS 순위
from
	employee
order by
	salary desc;

-- 11번
	
select
	d.dept_title
    , dept_salary.sumSalary
from
	department d
    join (
			select
				dept_code,
				sum(salary) as sumSalary
			from
				employee
			group by
				dept_code
			) as dept_salary
	on d.dept_id = dept_salary.dept_code
where
	dept_salary.sumSalary > (
							select sum(salary) * 0.2
                            from employee
                            )
	





