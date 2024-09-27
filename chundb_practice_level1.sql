use chundb;

select * from TB_DEPARTMENT; --  학과테이블
select * from TB_STUDENT; -- 학생테이블
select * from TB_PROFESSOR; -- 교수테이블
select * from TB_CLASS; -- 수업테이블
select * from TB_CLASS_PROFESSOR; -- 수업교수테이블
select * from TB_GRADE; -- 학점테이블

select
	department_name as "학과 명",
    category as "계열"
from TB_DEPARTMENT;


-- 2번
select
    concat(d.department_name,"의 정원은 ", d.capacity," 명 입니다.") as '학과별 정원'
from tb_department d;

-- 3번

select
	s.student_name
from 
	tb_student s
where 
	s.department_no = (
						select department_no
                        from tb_department
                        where department_name = '국어국문학과'
						)
	and s.ABSENCE_YN = 'Y'
    and substr(s.student_ssn,8,1) in(2,4);

-- 4번
select
	STUDENT_NAME
from
	tb_student
where
	student_no in ('A513079', 'A513090', 'A513091', 'A513110', 'A513119')
order by student_name desc;


-- 5번
select
	d.department_name,
    d.CATEGORY
from tb_department d
where capacity between 20 and 30;

-- 6번

select 
	PROFESSOR_NAME
from
	tb_professor
where
	department_no is null;

-- 7번
select
	*
from
	tb_student
where	
	department_no is null;

-- 8번

select
	CLASS_NO
from 
	tb_class
where
	preattending_class_no is not null;

-- 9번

select
	distinct category
from
	tb_department
order by
	category;

-- 10번

select 
	STUDENT_NO ,
    STUDENT_NAME ,
    STUDENT_SSN
from
	tb_student
where
	year(entrance_date) = 2019
    and substr(student_address,1,2) = "전주"
    and absence_yn = 'N'
order by
	student_name;








