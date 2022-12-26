CREATE TABLE "public.Candidates" (
	"id" serial NOT NULL,
	"fio" VARCHAR(255) NOT NULL,
	"sex" VARCHAR(255) NOT NULL,
	"birthdate" DATE NOT NULL,
	"phone" VARCHAR(255) NOT NULL,
	"email" VARCHAR(255),
	"school_id" integer,
	"grade_group" VARCHAR(255),
	"district_id" integer,
	"difficult_life_situation" integer,
	"disability" integer,
	"is_orphan" integer,
	"health_limitations" integer,
	"parent_1_id" integer,
	"parent_2_id" integer,
	CONSTRAINT "Candidates_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Documents" (
	"id" serial NOT NULL,
	"type_id" integer,
	"owner_id" integer NOT NULL,
	"series" VARCHAR(255) NOT NULL UNIQUE,
	"number" VARCHAR(255) NOT NULL UNIQUE,
	CONSTRAINT "Documents_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Types" (
	"id" serial NOT NULL,
	"group_id" integer NOT NULL,
	"name" integer NOT NULL UNIQUE,
	CONSTRAINT "Types_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Type_groups" (
	"id" serial NOT NULL,
	"name" VARCHAR(255) NOT NULL UNIQUE,
	CONSTRAINT "Type_groups_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Preferred_subjects" (
	"id" serial NOT NULL,
	"candidate_id" integer NOT NULL,
	"subject_1_id" integer NOT NULL,
	"subject_2_id" integer NOT NULL,
	"subject_3_id" integer NOT NULL,
	CONSTRAINT "Preferred_subjects_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Educational_establishments" (
	"id" serial NOT NULL,
	"type_id" integer NOT NULL,
	"name" VARCHAR(255) NOT NULL UNIQUE,
	"address" VARCHAR(255) NOT NULL,
	CONSTRAINT "Educational_establishments_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Parents" (
	"id" serial NOT NULL,
	"fio" VARCHAR(255) NOT NULL,
	"phone_1" VARCHAR(255) NOT NULL,
	"phone_2" VARCHAR(255),
	"email" VARCHAR(255),
	CONSTRAINT "Parents_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Districts" (
	"id" serial NOT NULL,
	"name" VARCHAR(255) NOT NULL UNIQUE,
	CONSTRAINT "Districts_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Interviews" (
	"id" serial NOT NULL,
	"date" DATETIME NOT NULL,
	"candidate_id" integer NOT NULL,
	"interviewer_id" integer NOT NULL,
	"result_id" integer NOT NULL,
	"comment" VARCHAR(255),
	CONSTRAINT "Interviews_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Mentors" (
	"id" serial NOT NULL,
	"fio" VARCHAR(255) NOT NULL,
	"phone" VARCHAR(255) NOT NULL,
	"birthdate" DATE,
	"email" VARCHAR(255),
	"education_id" integer,
	CONSTRAINT "Mentors_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Statuses" (
	"id" serial NOT NULL,
	"group_id" integer NOT NULL,
	"name" VARCHAR(255) NOT NULL,
	CONSTRAINT "Statuses_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Students" (
	"id" serial NOT NULL,
	"candidate_id" integer NOT NULL,
	"interview_id" integer NOT NULL,
	"group_id" integer NOT NULL,
	"education_status_id" integer NOT NULL,
	CONSTRAINT "Students_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Study_directions" (
	"id" serial NOT NULL,
	"name" VARCHAR(255) NOT NULL UNIQUE,
	CONSTRAINT "Study_directions_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Programs" (
	"id" serial NOT NULL,
	"name" serial(255) NOT NULL,
	"type_id" integer NOT NULL,
	"direction_id" integer NOT NULL,
	CONSTRAINT "Programs_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Rooms" (
	"id" serial NOT NULL,
	"name" VARCHAR(255) UNIQUE,
	CONSTRAINT "Rooms_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Study_groups" (
	"id" serial NOT NULL,
	"program_id" integer,
	"cipher" VARCHAR(255) NOT NULL,
	"type_id" integer,
	"start_date" DATE NOT NULL,
	"end_date" DATE NOT NULL,
	"creation_order" VARCHAR(255),
	"expulsion_order" VARCHAR(255),
	CONSTRAINT "Study_groups_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Lessons" (
	"id" serial NOT NULL,
	"day_id" integer NOT NULL,
	"start_time" TIME NOT NULL,
	"room_id" integer NOT NULL,
	"mentor_id" integer NOT NULL,
	"group_id" integer NOT NULL,
	CONSTRAINT "Lessons_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Status_groups" (
	"id" serial NOT NULL,
	"name" VARCHAR(255) NOT NULL UNIQUE,
	CONSTRAINT "Status_groups_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Days_of_week" (
	"id" serial NOT NULL,
	"day_name" VARCHAR(255) NOT NULL UNIQUE,
	CONSTRAINT "Days_of_week_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Mentors_to_Programs" (
	"id" serial NOT NULL,
	"mentor_id" integer NOT NULL,
	"program_id" integer NOT NULL,
	CONSTRAINT "Mentors_to_Programs_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



ALTER TABLE "Candidates" ADD CONSTRAINT "Candidates_fk0" FOREIGN KEY ("school_id") REFERENCES "Educational_establishments"("id");
ALTER TABLE "Candidates" ADD CONSTRAINT "Candidates_fk1" FOREIGN KEY ("district_id") REFERENCES "Districts"("id");
ALTER TABLE "Candidates" ADD CONSTRAINT "Candidates_fk2" FOREIGN KEY ("parent_1_id") REFERENCES "Parents"("id");
ALTER TABLE "Candidates" ADD CONSTRAINT "Candidates_fk3" FOREIGN KEY ("parent_2_id") REFERENCES "Parents"("id");

ALTER TABLE "Documents" ADD CONSTRAINT "Documents_fk0" FOREIGN KEY ("type_id") REFERENCES "Types"("id");
ALTER TABLE "Documents" ADD CONSTRAINT "Documents_fk1" FOREIGN KEY ("owner_id") REFERENCES "Candidates"("id");

ALTER TABLE "Types" ADD CONSTRAINT "Types_fk0" FOREIGN KEY ("group_id") REFERENCES "Type_groups"("id");


ALTER TABLE "Preferred_subjects" ADD CONSTRAINT "Preferred_subjects_fk0" FOREIGN KEY ("candidate_id") REFERENCES "Candidates"("id");

ALTER TABLE "Educational_establishments" ADD CONSTRAINT "Educational_establishments_fk0" FOREIGN KEY ("type_id") REFERENCES "Types"("id");



ALTER TABLE "Interviews" ADD CONSTRAINT "Interviews_fk0" FOREIGN KEY ("candidate_id") REFERENCES "Candidates"("id");
ALTER TABLE "Interviews" ADD CONSTRAINT "Interviews_fk1" FOREIGN KEY ("interviewer_id") REFERENCES "Mentors"("id");
ALTER TABLE "Interviews" ADD CONSTRAINT "Interviews_fk2" FOREIGN KEY ("result_id") REFERENCES "Statuses"("id");

ALTER TABLE "Mentors" ADD CONSTRAINT "Mentors_fk0" FOREIGN KEY ("education_id") REFERENCES "Educational_establishments"("id");

ALTER TABLE "Statuses" ADD CONSTRAINT "Statuses_fk0" FOREIGN KEY ("group_id") REFERENCES "Status_groups"("id");

ALTER TABLE "Students" ADD CONSTRAINT "Students_fk0" FOREIGN KEY ("candidate_id") REFERENCES "Candidates"("id");
ALTER TABLE "Students" ADD CONSTRAINT "Students_fk1" FOREIGN KEY ("interview_id") REFERENCES "Interviews"("id");
ALTER TABLE "Students" ADD CONSTRAINT "Students_fk2" FOREIGN KEY ("group_id") REFERENCES "Study_groups"("id");
ALTER TABLE "Students" ADD CONSTRAINT "Students_fk3" FOREIGN KEY ("education_status_id") REFERENCES "Statuses"("id");


ALTER TABLE "Programs" ADD CONSTRAINT "Programs_fk0" FOREIGN KEY ("type_id") REFERENCES "Types"("id");
ALTER TABLE "Programs" ADD CONSTRAINT "Programs_fk1" FOREIGN KEY ("direction_id") REFERENCES "Study_directions"("id");


ALTER TABLE "Study_groups" ADD CONSTRAINT "Study_groups_fk0" FOREIGN KEY ("program_id") REFERENCES "Programs"("id");
ALTER TABLE "Study_groups" ADD CONSTRAINT "Study_groups_fk1" FOREIGN KEY ("type_id") REFERENCES "Types"("id");

ALTER TABLE "Lessons" ADD CONSTRAINT "Lessons_fk0" FOREIGN KEY ("day_id") REFERENCES "Days_of_week"("id");
ALTER TABLE "Lessons" ADD CONSTRAINT "Lessons_fk1" FOREIGN KEY ("room_id") REFERENCES "Rooms"("id");
ALTER TABLE "Lessons" ADD CONSTRAINT "Lessons_fk2" FOREIGN KEY ("mentor_id") REFERENCES "Mentors"("id");
ALTER TABLE "Lessons" ADD CONSTRAINT "Lessons_fk3" FOREIGN KEY ("group_id") REFERENCES "Status_groups"("id");



ALTER TABLE "Mentors_to_Programs" ADD CONSTRAINT "Mentors_to_Programs_fk0" FOREIGN KEY ("mentor_id") REFERENCES "Mentors"("id");
ALTER TABLE "Mentors_to_Programs" ADD CONSTRAINT "Mentors_to_Programs_fk1" FOREIGN KEY ("program_id") REFERENCES "Programs"("id");





















