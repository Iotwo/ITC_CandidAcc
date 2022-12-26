CREATE TABLE Candidates (
	id integer PRIMARY KEY AUTOINCREMENT,
	fio string,
	sex string,
	birthdate date,
	phone string,
	email string,
	school_id integer,
	grade_group string,
	district_id integer,
	difficult_life_situation integer,
	disability integer,
	is_orphan integer,
	health_limitations integer,
	parent_1_id integer,
	parent_2_id integer
);

CREATE TABLE Documents (
	id integer PRIMARY KEY AUTOINCREMENT,
	type_id integer,
	owner_id integer,
	series string,
	number string
);

CREATE TABLE Types (
	id integer PRIMARY KEY AUTOINCREMENT,
	group_id integer,
	name integer
);

CREATE TABLE Type_groups (
	id integer PRIMARY KEY AUTOINCREMENT,
	name string
);

CREATE TABLE Preferred_subjects (
	id integer PRIMARY KEY AUTOINCREMENT,
	candidate_id integer,
	subject_1_id integer,
	subject_2_id integer,
	subject_3_id integer
);

CREATE TABLE Educational_establishments (
	id integer PRIMARY KEY AUTOINCREMENT,
	type_id integer,
	name string,
	address string
);

CREATE TABLE Parents (
	id integer PRIMARY KEY AUTOINCREMENT,
	fio string,
	phone_1 string,
	phone_2 string,
	email string
);

CREATE TABLE Districts (
	id integer PRIMARY KEY AUTOINCREMENT,
	name string
);

CREATE TABLE Interviews (
	id integer PRIMARY KEY AUTOINCREMENT,
	date datetime,
	candidate_id integer,
	interviewer_id integer,
	result_id integer,
	comment string
);

CREATE TABLE Mentors (
	id integer PRIMARY KEY AUTOINCREMENT,
	fio string,
	phone string,
	birthdate date,
	email string,
	education_id integer
);

CREATE TABLE Statuses (
	id integer PRIMARY KEY AUTOINCREMENT,
	group_id integer,
	name string
);

CREATE TABLE Students (
	id integer PRIMARY KEY AUTOINCREMENT,
	candidate_id integer,
	interview_id integer,
	group_id integer,
	education_status_id integer
);

CREATE TABLE Study_directions (
	id integer PRIMARY KEY AUTOINCREMENT,
	name string
);

CREATE TABLE Programs (
	id integer PRIMARY KEY AUTOINCREMENT,
	name string PRIMARY KEY AUTOINCREMENT,
	type_id integer,
	direction_id integer
);

CREATE TABLE Rooms (
	id integer PRIMARY KEY AUTOINCREMENT,
	name string
);

CREATE TABLE Study_groups (
	id integer PRIMARY KEY AUTOINCREMENT,
	program_id integer,
	cipher string,
	type_id integer,
	start_date date,
	end_date date,
	creation_order string,
	expulsion_order string
);

CREATE TABLE Lessons (
	id integer PRIMARY KEY AUTOINCREMENT,
	day_id integer,
	start_time time,
	room_id integer,
	mentor_id integer,
	group_id integer
);

CREATE TABLE Status_groups (
	id integer PRIMARY KEY AUTOINCREMENT,
	name string
);

CREATE TABLE Days_of_week (
	id integer PRIMARY KEY AUTOINCREMENT,
	day_name string
);

CREATE TABLE Mentors_to_Programs (
	id integer PRIMARY KEY AUTOINCREMENT,
	mentor_id integer,
	program_id integer
);





















