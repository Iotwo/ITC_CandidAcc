CREATE TABLE `Candidates` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`fio` VARCHAR(255) NOT NULL,
	`sex` VARCHAR(255) NOT NULL,
	`birthdate` DATE NOT NULL,
	`phone` VARCHAR(255) NOT NULL,
	`email` VARCHAR(255),
	`school_id` INT,
	`grade_group` VARCHAR(255),
	`district_id` INT,
	`difficult_life_situation` INT,
	`disability` INT,
	`is_orphan` INT,
	`health_limitations` INT,
	`parent_1_id` INT,
	`parent_2_id` INT,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Documents` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`type_id` INT,
	`owner_id` INT NOT NULL,
	`series` VARCHAR(255) NOT NULL UNIQUE,
	`number` VARCHAR(255) NOT NULL UNIQUE,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Types` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`group_id` INT NOT NULL,
	`name` INT NOT NULL UNIQUE,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Type_groups` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(255) NOT NULL UNIQUE,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Preferred_subjects` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`candidate_id` INT NOT NULL,
	`subject_1_id` INT NOT NULL,
	`subject_2_id` INT NOT NULL,
	`subject_3_id` INT NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Educational_establishments` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`type_id` INT NOT NULL,
	`name` VARCHAR(255) NOT NULL UNIQUE,
	`address` VARCHAR(255) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Parents` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`fio` VARCHAR(255) NOT NULL,
	`phone_1` VARCHAR(255) NOT NULL,
	`phone_2` VARCHAR(255),
	`email` VARCHAR(255),
	PRIMARY KEY (`id`)
);

CREATE TABLE `Districts` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(255) NOT NULL UNIQUE,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Interviews` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`date` DATETIME NOT NULL,
	`candidate_id` INT NOT NULL,
	`interviewer_id` INT NOT NULL,
	`result_id` INT NOT NULL,
	`comment` VARCHAR(255),
	PRIMARY KEY (`id`)
);

CREATE TABLE `Mentors` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`fio` VARCHAR(255) NOT NULL,
	`phone` VARCHAR(255) NOT NULL,
	`birthdate` DATE,
	`email` VARCHAR(255),
	`education_id` INT,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Statuses` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`group_id` INT NOT NULL,
	`name` VARCHAR(255) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Students` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`candidate_id` INT NOT NULL,
	`interview_id` INT NOT NULL,
	`group_id` INT NOT NULL,
	`education_status_id` INT NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Study_directions` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(255) NOT NULL UNIQUE,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Programs` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(255) NOT NULL AUTO_INCREMENT,
	`type_id` INT NOT NULL,
	`direction_id` INT NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Rooms` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(255) UNIQUE,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Study_groups` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`program_id` INT,
	`cipher` VARCHAR(255) NOT NULL,
	`type_id` INT,
	`start_date` DATE NOT NULL,
	`end_date` DATE NOT NULL,
	`creation_order` VARCHAR(255),
	`expulsion_order` VARCHAR(255),
	PRIMARY KEY (`id`)
);

CREATE TABLE `Lessons` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`day_id` INT NOT NULL,
	`start_time` TIME NOT NULL,
	`room_id` INT NOT NULL,
	`mentor_id` INT NOT NULL,
	`group_id` INT NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Status_groups` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(255) NOT NULL UNIQUE,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Days_of_week` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`day_name` VARCHAR(255) NOT NULL UNIQUE,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Mentors_to_Programs` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`mentor_id` INT NOT NULL,
	`program_id` INT NOT NULL,
	PRIMARY KEY (`id`)
);

ALTER TABLE `Candidates` ADD CONSTRAINT `Candidates_fk0` FOREIGN KEY (`school_id`) REFERENCES `Educational_establishments`(`id`);

ALTER TABLE `Candidates` ADD CONSTRAINT `Candidates_fk1` FOREIGN KEY (`district_id`) REFERENCES `Districts`(`id`);

ALTER TABLE `Candidates` ADD CONSTRAINT `Candidates_fk2` FOREIGN KEY (`parent_1_id`) REFERENCES `Parents`(`id`);

ALTER TABLE `Candidates` ADD CONSTRAINT `Candidates_fk3` FOREIGN KEY (`parent_2_id`) REFERENCES `Parents`(`id`);

ALTER TABLE `Documents` ADD CONSTRAINT `Documents_fk0` FOREIGN KEY (`type_id`) REFERENCES `Types`(`id`);

ALTER TABLE `Documents` ADD CONSTRAINT `Documents_fk1` FOREIGN KEY (`owner_id`) REFERENCES `Candidates`(`id`);

ALTER TABLE `Types` ADD CONSTRAINT `Types_fk0` FOREIGN KEY (`group_id`) REFERENCES `Type_groups`(`id`);

ALTER TABLE `Preferred_subjects` ADD CONSTRAINT `Preferred_subjects_fk0` FOREIGN KEY (`candidate_id`) REFERENCES `Candidates`(`id`);

ALTER TABLE `Educational_establishments` ADD CONSTRAINT `Educational_establishments_fk0` FOREIGN KEY (`type_id`) REFERENCES `Types`(`id`);

ALTER TABLE `Interviews` ADD CONSTRAINT `Interviews_fk0` FOREIGN KEY (`candidate_id`) REFERENCES `Candidates`(`id`);

ALTER TABLE `Interviews` ADD CONSTRAINT `Interviews_fk1` FOREIGN KEY (`interviewer_id`) REFERENCES `Mentors`(`id`);

ALTER TABLE `Interviews` ADD CONSTRAINT `Interviews_fk2` FOREIGN KEY (`result_id`) REFERENCES `Statuses`(`id`);

ALTER TABLE `Mentors` ADD CONSTRAINT `Mentors_fk0` FOREIGN KEY (`education_id`) REFERENCES `Educational_establishments`(`id`);

ALTER TABLE `Statuses` ADD CONSTRAINT `Statuses_fk0` FOREIGN KEY (`group_id`) REFERENCES `Status_groups`(`id`);

ALTER TABLE `Students` ADD CONSTRAINT `Students_fk0` FOREIGN KEY (`candidate_id`) REFERENCES `Candidates`(`id`);

ALTER TABLE `Students` ADD CONSTRAINT `Students_fk1` FOREIGN KEY (`interview_id`) REFERENCES `Interviews`(`id`);

ALTER TABLE `Students` ADD CONSTRAINT `Students_fk2` FOREIGN KEY (`group_id`) REFERENCES `Study_groups`(`id`);

ALTER TABLE `Students` ADD CONSTRAINT `Students_fk3` FOREIGN KEY (`education_status_id`) REFERENCES `Statuses`(`id`);

ALTER TABLE `Programs` ADD CONSTRAINT `Programs_fk0` FOREIGN KEY (`type_id`) REFERENCES `Types`(`id`);

ALTER TABLE `Programs` ADD CONSTRAINT `Programs_fk1` FOREIGN KEY (`direction_id`) REFERENCES `Study_directions`(`id`);

ALTER TABLE `Study_groups` ADD CONSTRAINT `Study_groups_fk0` FOREIGN KEY (`program_id`) REFERENCES `Programs`(`id`);

ALTER TABLE `Study_groups` ADD CONSTRAINT `Study_groups_fk1` FOREIGN KEY (`type_id`) REFERENCES `Types`(`id`);

ALTER TABLE `Lessons` ADD CONSTRAINT `Lessons_fk0` FOREIGN KEY (`day_id`) REFERENCES `Days_of_week`(`id`);

ALTER TABLE `Lessons` ADD CONSTRAINT `Lessons_fk1` FOREIGN KEY (`room_id`) REFERENCES `Rooms`(`id`);

ALTER TABLE `Lessons` ADD CONSTRAINT `Lessons_fk2` FOREIGN KEY (`mentor_id`) REFERENCES `Mentors`(`id`);

ALTER TABLE `Lessons` ADD CONSTRAINT `Lessons_fk3` FOREIGN KEY (`group_id`) REFERENCES `Status_groups`(`id`);

ALTER TABLE `Mentors_to_Programs` ADD CONSTRAINT `Mentors_to_Programs_fk0` FOREIGN KEY (`mentor_id`) REFERENCES `Mentors`(`id`);

ALTER TABLE `Mentors_to_Programs` ADD CONSTRAINT `Mentors_to_Programs_fk1` FOREIGN KEY (`program_id`) REFERENCES `Programs`(`id`);





















