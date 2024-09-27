use chundb;

-- 1번
select
	STUDENT_NAME as '학생 이름',
	STUDENT_ADDRESS as 주소지
from 
	tb_student
order by
	STUDENT_NAME;

-- 2 번
select 
	STUDENT_NAME,
    STUDENT_SSN
from tb_student
where ABSENCE_YN = 'Y'
order by 
	substr(STUDENT_SSN,1,1),
    substr(student_ssn,2,1) desc;

-- 3번
select 
	student_name as 학생이름,
    student_no as 학번,
    student_address as '거주지 주소',
    entrance_date
from
	tb_student
where
	year(entrance_date) >= 2020
    and (student_address like '강원%' || student_address like '경기%')
order by
	student_name;

-- 4번
select
	*
from
	tb_professor
where
	department_no = (
					select department_no
                    from tb_department
                    where department_name = '법학과'
                    )
order by
	substr(professor_ssn,1,2);

















