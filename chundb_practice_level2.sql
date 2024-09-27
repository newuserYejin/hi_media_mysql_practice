use chundb;

select * from TB_DEPARTMENT; --  학과테이블
select * from TB_STUDENT; -- 학생테이블
select * from TB_PROFESSOR; -- 교수테이블
select * from TB_CLASS; -- 수업테이블
select * from TB_CLASS_PROFESSOR; -- 수업교수테이블
select * from TB_GRADE; -- 학점테이블

-- 1번
select 
	student_no as 학번,
    student_name as 이름,
    date(entrance_date) as 입학년도
from
	tb_student
where
	department_no = (
					select department_no
                    from tb_department
                    where department_name = '영어영문학과'
                    )
order by student_name;

-- 2번	(다시)
select
	professor_name, professor_ssn
from
	tb_professor
where
	length(professor_name) != 9;

select
	professor_name, professor_ssn
from
	tb_professor
where
	char_length(professor_name) != 3;

-- 3번

select
	professor_name as 교수이름,
	year(now()) - concat(19,substr(professor_ssn,1,2)) as 나이,
    professor_ssn,
    str_to_date(CONCAT('19', substr(professor_ssn, 1, 6)), '%Y%m%d') AS birth_date
from
	tb_professor
where
	substr(professor_ssn,8,1) = '1'
order by
	나이;

-- 4번
select
	substr(professor_name,2,char_length(professor_name)) as 이름
from
	tb_professor;

-- 5번
select 
	STUDENT_NO,
    STUDENT_NAME
from
	tb_studentss
where
	year(entrance_date) - CONCAT(if(substr(student_ssn, 1, 1) = '0', '20', '19'), substr(student_ssn, 1, 2))> 19;

-- 6번
SELECT
    CASE WEEKDAY('2022-12-25') 
        WHEN 0 THEN '월요일'
        WHEN 1 THEN '화요일'
        WHEN 2 THEN '수요일'
        WHEN 3 THEN '목요일'
        WHEN 4 THEN '금요일'
        WHEN 5 THEN '토요일'
        WHEN 6 THEN '일요일'
    END as name;

-- 7번

select
	round(avg(point),1) as 평점
from
	tb_grade
where
	student_no = 'A517178';

-- 9번
select
	department_no as 학과번호,
	count(*) as '학생수(명)'
from tb_student
group by department_no;

-- 10번

select count(*)
from tb_student
where coach_professor_no is null;

-- 11번

select
	substr(term_no,1,4) as 년도,
	round(avg(point),1) as '년도별 평점'
from
	tb_grade
where
	student_no = 'A112113'
group by 
	substr(term_no,1,4);

-- 12번 (다시)
select
	d.department_no as 학과코드명,
	count(s.student_no) as '휴학생 수'
from
	tb_department d left join tb_student s on d.department_no = s.department_no and s.absence_yn = 'Y'
group by d.department_no
order by d.department_no;

-- 13번
select
	duplicate_name.student_name,
	count(*)
from (
	select s1.student_name, s1.student_no
    from 
		tb_student s1
        join tb_student s2 on s1.student_name = s2.student_name
    where (
		s1.student_no != s2.student_no
        ) 
	) as duplicate_name
group by student_name
order by student_name;

-- 14번
select
	substr(term_no,1,4) as 년도,
    substr(term_no,5,2) as 학기,
	ifnull(round(avg(point),1),0) as 평점
from
	tb_grade
where
	student_no = 'A112113'
group by
	substr(term_no,1,4), substr(term_no,5,2)
with rollup;

