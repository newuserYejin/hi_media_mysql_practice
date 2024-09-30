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

-- 5번
select student_no, point
from tb_grade
where 
	term_no = 202202
	and class_no = 'C3118100'
order by
	point desc;

-- 6번
select 
	s.student_no
    , s.student_name
    , d.department_name
from tb_student s
	join tb_department d on s. department_no = d.department_no
order by s.student_name;

-- 7번
select 
	c.class_name
    , d.department_name
from tb_department d
	join tb_class c on c.department_no = d.department_no
order by d.department_name;

-- 8번
select
	c.class_name,
    p.professor_name
from tb_class_professor cp
	join tb_professor p on cp.PROFESSOR_NO = p.PROFESSOR_NO
    join tb_class c on c.class_no = cp.class_no 
order by c.class_name;

-- 9번
select
	c.class_name
    -- p.professor_name
from tb_department d
	join tb_professor p on d.department_no = p.department_no
    join tb_class_professor cp on cp.professor_no = p.professor_no
    join tb_class c on c.class_no =cp.class_no
where
	d.category='인문사회';

-- 수업에 각각에 매칭되는 교수를 찾는것이 아니라 수업에 대해서만 category를 파악하기 때문에
-- 해당 수업의 department가 인문사회에 속하면 그 과의 교수가 해당과목을 모두 진행하는걸로 출력되기 때문에 오답
select
	c.class_name
    , p.professor_name
from tb_class c
	join tb_department d on c.department_no = d.department_no
    join tb_professor p on p.department_no = d.department_no
where
	d.category='인문사회';

-- 10번
select
	g.student_no as 학번,
    s.student_name as '학생 이름',
    round(avg(g.point),1) as 전체_평점
from tb_grade g
	join tb_class c on g.class_no = c.class_no
    join tb_department d on d.DEPARTMENT_NO = c.DEPARTMENT_NO
    join tb_student s on g.student_no = s.student_no
where
	department_name = '음악학과'
group by g.student_no
order by 전체_평점 desc;

-- 확인 결과 신광현은 4.5가 맞음
select
	*,
    s.student_name
from tb_grade g
	join tb_student s on g.student_no = s.student_no
where g.student_no = 'A612052';

-- 11번

select
	d.department_name as 학과이름,
    s.student_name as 학생이름,
    p.professor_name as 지도교수이름
from
	tb_student s
    join tb_professor p on s.coach_professor_no = p.professor_no
    join tb_department d on d.department_no = s.department_no
where
	s.student_no = 'A313047';

-- 12번
select
	s.student_name,
    g.term_no as term_name
from
	tb_grade g
    join tb_class c on c.class_no = g.class_no
    join tb_student s on g.student_no = s.student_no 
where
	substr(g.term_no,1,4) = 2022
    and c.class_name = '인간관계론';

-- 13번	(내꺼에 학과에는 B가 없는데 출력 예시는 뭐지...)
select
	c.class_name
    , d.department_name
from
	tb_class c
    join tb_department d on c.department_no = d.department_no
    left join tb_class_professor cp on cp.class_no = c.class_no
where
	d.category = '예체능'
    and cp.professor_no is null
order by class_name;

-- 14번 (null 값을 살릴때는 그냥 join 아니고 left join 이나 right join)
select
	s.student_name as 학생이름
    , ifnull(p.professor_name,'지도교수 미지정')
from
	tb_department d
    join tb_student s on s.department_no = d.department_no
    left join tb_professor p on s.coach_professor_no = p.professor_no
where
	d.department_name = '서반아어학과';

-- 15 번 (예시랑 개수 안 맞음)
select
	s.student_no as  학번
	, s.student_name as 이름
    , d.department_name as 학과이름
    , round(avg(point),1) as 평점
    , s.ABSENCE_YN
from
	tb_student s
    join tb_grade g on s.student_no = g.student_no
    join tb_department d on d.department_no = s.department_no
where
	s.ABSENCE_YN != 'Y'
group by
	s.student_no, s.student_name, d.department_name
having
    round(avg(point),1) >= 4.0
order by 
	s.student_no;

-- 16번(1번// 뭔가 값이 다름)
select
	c.class_no
    , c.class_name
    , avg(g.point)
from
	tb_department d
    join tb_class c on c.department_no = d.department_no
    join tb_grade g on g.class_no = c.class_no
where
	d.department_name = '환경조경학과'
    and c.class_type like '전공%'
group by
	g.class_no;

-- 17번 (2번)
select
	student_name
    , student_address
from
	tb_student 
where
	department_no = (
					select department_no
                    from tb_student
					where student_name = '최경희'
					)
order by
	student_name;




-- 18번(3번)

with avg_table as (
	select
		s.student_no,
		s.student_name,
		avg(g.point) as avg_point
	from tb_grade g
		join tb_student s on g.student_no = s.student_no
	where
		s.department_no = (
							select department_no
							from tb_department
							where department_name = '국어국문학과'
						)
	group by g.student_no
)
select
	student_no,
    avg_point,
    student_name
from 
	avg_table
where
	avg_point = (select max(avg_point) from avg_table);

-- 2번 join
with avg_table as (
	select
		s.student_no ,
		avg(g.point) as avg_point
	from tb_grade g
		join tb_student s on g.student_no = s.student_no
	where
		s.department_no = (
							select department_no
							from tb_department
							where department_name = '국어국문학과'
						)
	group by g.student_no
)
select
	s.student_no,
	s.student_name,
    at.avg_point
from tb_student s
	join avg_table at on at.student_no = s.student_no
where
	at.avg_point = (select max(avg_point) from avg_table);

-- 테스트
select
	s.student_name,
    avg(g.point)
from tb_student s
	join tb_grade g on s.student_no = g.student_no
group by
	g.student_no
having
	avg(g.point) = 3.83333;



-- 19번 (4번)
select
	d.department_name as '꼐열 학과명',
    round(avg(g.point),1) as '전공평점'
from
	tb_department d
    join tb_class c on d.department_no = c.department_no
    join tb_grade g on c.class_no = g.class_no
where
	d.category = (select
						category
					from
						tb_department
					where
						department_name='환경조경학과'
					)
group by
	d.department_no
order by
	department_name;





