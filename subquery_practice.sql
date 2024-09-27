use employee;

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
  FROM EMPLOYEE E
 WHERE E.SALARY IN (SELECT MAX(E2.SALARY)
                      FROM EMPLOYEE E2
                     GROUP BY E2.DEPT_CODE
                   );

