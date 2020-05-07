create table sample_school_departments (
    department_no number(10,0) not null,
    department_name varchar2(70) not null
);

create table sample_school_professors (
    professor_no number(10,0) not null,
    professor_name varchar2(50) not null,
    professor_position varchar2(50),
    department_no number(10,0),
    professor_registered_date date default sysdate,
    constraint professors_departmentno_fk foreign key (department_no) references sample_school_departments (department_no)
);

create table sample_school_students (
    student_no number(10,0) primary key,
    student_name varchar2(50) not null,
    student_level number(10,0) not null,
    department_no number(10,0),
    student_registered_date date default sysdate,
    constraint students_departmentno_fk foreign key (department_no) references sample_school_departments (department_no)
);

create table sample_school_subjects (
    subject_no number(10,0) primary key,
    subject_name varchar2(100) not null,
    department_no number(10,0),
    subject_registered_date date default sysdate,
    constraint subjects_departmentno_fk foreign key (department_no) references sample_school_departments (department_no)
);

create table sample_school_courses (
    course_no number(10,0) primary key,
    course_name varchar2(100) not null,
    subject_no number(10,0) constraint course_subjectno_fk references sample_school_subjects (subject_no),
    professor_no number(10,0) constraint course_professorno_fk references sample_school_professors (professor_no),
    course_student_num number(10,0) default 0,
    course_isfinished char(2) default 'N',
    course_registered_date date default sysdate
);

create table sample_school_course_history (
    history_no number(10,0) primary key,
    course_no number(10,0) constraint course_history_courseno_fk references sample_school_courses (course_no),
    student_no number(10,0) constraint course_history_studentno_fk references sample_school_students (student_no),
    history_iscancle char(2) default 'N',
    history_ispassed char(2) default 'N',
    history_score number(10,0) default 0,
    history_registered_date date default sysdate
);

create sequence sample_departments_seq start with 10000 nocache;
create sequence sample_professers_seq start with 20000 nocache;
create sequence sample_students_seq start with 30000 nocache;
create sequence sample_subjects_seq start with 40000 nocache;
create sequence sample_courses_seq start with 50000 nocache;
create sequence sample_history_seq start with 60000 nocache;

commit;

insert into sample_school_departments
values
(sample_departments_seq.nextval, '정보통신과');

insert into sample_school_departments
values
(sample_departments_seq.nextval, '전자공학과');

insert into sample_school_departments
values
(sample_departments_seq.nextval, '문예창작과');

insert into sample_school_departments
values
(sample_departments_seq.nextval, '연기예술과');

insert into sample_school_departments
values
(sample_departments_seq.nextval, '기계공학과');

insert into sample_school_professors
values
(sample_professers_seq.nextval, '곽땡땡', '정교수', 10000, sysdate);

insert into sample_school_professors
values
(sample_professers_seq.nextval, '이금금', '정교수', 10000, sysdate);

insert into sample_school_professors
values
(sample_professers_seq.nextval, '김주요', '정교수', 10001, sysdate);

insert into sample_school_professors
values
(sample_professers_seq.nextval, '김글', '정교수', 10002, sysdate);

insert into sample_school_professors
values
(sample_professers_seq.nextval, '박두희', '부교수', 10002, sysdate);

insert into sample_school_professors
values
(sample_professers_seq.nextval, '한음악', '부교수', 10003, sysdate);

insert into sample_school_professors
values
(sample_professers_seq.nextval, '이기상', '정교수', 10004, sysdate);

insert into sample_school_students
values
(sample_students_seq.nextval, '윤하영', 4, 10000, sysdate);

insert into sample_school_students
values
(sample_students_seq.nextval, '김정통', 2, 10000, sysdate);

insert into sample_school_students
values
(sample_students_seq.nextval, '박신입', 1, 10001, sysdate);

insert into sample_school_students
values
(sample_students_seq.nextval, '김이학', 2, 10002, sysdate);

insert into sample_school_students
values
(sample_students_seq.nextval, '한석우', 4, 10003, sysdate);

insert into sample_school_students
values
(sample_students_seq.nextval, '윤별', 4, 10004, sysdate);

insert into sample_school_subjects
values
(sample_subjects_seq.nextval, '디지털공학개론', 10000, sysdate);

insert into sample_school_subjects
values
(sample_subjects_seq.nextval, '전자회로공학', 10001, sysdate);

insert into sample_school_subjects
values
(sample_subjects_seq.nextval, '문학문법개론', 10002, sysdate);

insert into sample_school_subjects
values
(sample_subjects_seq.nextval, '연기발성기초', 10003, sysdate);

insert into sample_school_subjects
values
(sample_subjects_seq.nextval, '기계역학이론', 10004, sysdate);

insert into sample_school_courses
values
(sample_courses_seq.nextval, '디지털공학A', 40000, 20000, 20, 'N', sysdate);
insert into sample_school_courses
values
(sample_courses_seq.nextval, '디지털공학B', 40000, 20001, 20, 'N', sysdate);
insert into sample_school_courses
values
(sample_courses_seq.nextval, '발성기초A', 40004, 20005, 30, 'N', sysdate);

commit;