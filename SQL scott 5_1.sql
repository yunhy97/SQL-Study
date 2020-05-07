create table contacts (
    contact_name varchar2(100) not null,
    contact_tel varchar2(50) not null,
    contact_email varchar2(256),
    contact_create_date date default sysdate
);

insert into contacts (contact_name, contact_tel, contact_email)
values ('ȫ�浿', '010-1234-5678', 'hong@gmail.com');

insert into contacts (contact_name, contact_tel, contact_email)
values ('������', '010-6789-3433', 'kim@naver.com');

commit;

--HR ����ڿ��� CONTACTS�� ���� ��ü���� �ο��ϱ�
grant select
on contacts
to hr;

--HR ����ڿ��� CONTACTS�� ���� ��ü���� �ο��ϱ�
grant update (contact_tel, contact_email)
on contacts
to hr;


select *
from role_sys_privs;




CREATE TABLE SCHOOL_COURSES
(
	COURSE_NO number(4,0) NOT NULL,
	SUBJECT_NO number(4,0) NOT NULL,
	PROF_NO number(4,0) NOT NULL,
	COURSE_NAME varchar2(200) NOT NULL,
	COURSE_QUOTA number(3,0) DEFAULT 30,
	COURSE_REG_CNT number(3,0) DEFAULT 0,
	COURSE_CANCEL_CNT number(3,0) DEFAULT 0,
	COURSE_CLOSE char(1) DEFAULT 'N',
	COURSE_CREATE_DATE date DEFAULT SYSDATE,
	PRIMARY KEY (COURSE_NO)
);


CREATE TABLE SCHOOL_COURSE_REGISTERATIONS
(
	REG_NO number(5,0) NOT NULL,
	STUD_NO number(4,0) NOT NULL,
	COURSE_NO number(4,0) NOT NULL,
	REG_CANCELED char(1) DEFAULT 'N',
	REG_COMPLETED char(1) DEFAULT 'N',
	REG_SCORE number(2,1),
	REG_CREATE_DATE date DEFAULT SYSDATE,
	PRIMARY KEY (REG_NO),
	CONSTRAINT COURSE_REG_UK UNIQUE (STUD_NO, COURSE_NO)
);


CREATE TABLE SCHOOL_DEPT
(
	DEPT_NO number(4,0) NOT NULL,
	DEPT_NAME varchar2(100) NOT NULL,
	PRIMARY KEY (DEPT_NO)
);


CREATE TABLE SCHOOL_PROFESSORS
(
	PROF_NO number(4,0) NOT NULL,
	PROF_NAME varchar2(100) NOT NULL,
	PROF_POSITION varchar2(50),
	PROF_CREATE_DATE date DEFAULT SYSDATE,
	DEPT_NO number(4,0) NOT NULL,
	PRIMARY KEY (PROF_NO)
);


CREATE TABLE SCHOOL_STUDENTS
(
	STUD_NO number(4,0) NOT NULL,
	STUD_NAME varchar2(100) NOT NULL,
	STUD_GRADE number(1) NOT NULL,
	STUD_CREATE_DATE date DEFAULT SYSDATE,
	DEPT_NO number(4,0) NOT NULL,
	PRIMARY KEY (STUD_NO)
);


CREATE TABLE SCHOOL_SUBJECTS
(
	SUBJECT_NO number(4,0) NOT NULL,
	SUBJECT_NAME varchar2(200) NOT NULL,
	SUBJECT_CREATE_DATE date DEFAULT SYSDATE,
	DEPT_NO number(4,0) NOT NULL,
	PRIMARY KEY (SUBJECT_NO)
);


ALTER TABLE SCHOOL_COURSE_REGISTERATIONS
	ADD FOREIGN KEY (COURSE_NO)
	REFERENCES SCHOOL_COURSES (COURSE_NO)
;


ALTER TABLE SCHOOL_PROFESSORS
	ADD FOREIGN KEY (DEPT_NO)
	REFERENCES SCHOOL_DEPT (DEPT_NO)
;


ALTER TABLE SCHOOL_STUDENTS
	ADD FOREIGN KEY (DEPT_NO)
	REFERENCES SCHOOL_DEPT (DEPT_NO)
;


ALTER TABLE SCHOOL_SUBJECTS
	ADD FOREIGN KEY (DEPT_NO)
	REFERENCES SCHOOL_DEPT (DEPT_NO)
;


ALTER TABLE SCHOOL_COURSES
	ADD FOREIGN KEY (PROF_NO)
	REFERENCES SCHOOL_PROFESSORS (PROF_NO)
;


ALTER TABLE SCHOOL_COURSE_REGISTERATIONS
	ADD FOREIGN KEY (STUD_NO)
	REFERENCES SCHOOL_STUDENTS (STUD_NO)
;


ALTER TABLE SCHOOL_COURSES
	ADD FOREIGN KEY (SUBJECT_NO)
	REFERENCES SCHOOL_SUBJECTS (SUBJECT_NO)
;

create sequence school_dept_seq start with 10 increment by 10 nocache;
create sequence school_prof_seq start with 1000 increment by 1 nocache;
create sequence school_student_seq start with 5000 increment by 10 nocache;
create sequence school_subject_seq start with 100 increment by 10 nocache;
create sequence school_course_seq start with 100 increment by 1 nocache;
create sequence school_course_reg_seq start with 1 increment by 1 nocache;

--�������� ���̺�
create or replace view school_courses_view
as 
    select a.course_no,         --������ȣ
            a.course_name,      --������
            a.course_quota,     --���� ����
            a.course_reg_cnt,   --�����û�ο�
            a.course_close,    --��������
            b.subject_no,       --�����ȣ
            b.subject_name,     --�����
            c.prof_no,          --��米����ȣ
            c.prof_name,        --��米����
            d.dept_no,          --�����а���ȣ
            d.dept_name,        --�����а���
            a.course_create_date--�����
    from school_courses a, school_subjects b, school_professors c, school_dept d
    where a.subject_no = b.subject_no
    and a.prof_no = c.prof_no
    and b.dept_no = d.dept_no;

--�������� ������ ����
select *
from school_courses_view
where course_no = ?;

--�а��� �������� ����
select * 
from school_courses_view
where dept_no = ?;

--������ �������� ����
select *
from school_courses_view
where prof_no = ?;

--�������� ���� ���� ����
select *
from school_courses_view
where course_close = 'N';




























