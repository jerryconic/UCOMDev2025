USE master;

USE master;
IF EXISTS(SELECT * FROM sys.databases WHERE name = 'ChooseCourse')
BEGIN
	ALTER DATABASE ChooseCourse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE ChooseCourse;
END

CREATE DATABASE ChooseCourse
GO
USE ChooseCourse;

CREATE TABLE dbo.Student
(
student_id int CONSTRAINT PK_Student PRIMARY KEY,
student_name nvarchar(20) NOT NULL,
email nvarchar(50) NOT NULL
);

CREATE TABLE dbo.ChooseCourse
(
choose_id int CONSTRAINT PK_ChooseCourse PRIMARY KEY,
student_id int,
course_id int
);

CREATE TABLE dbo.Course
(
coruse_id int CONSTRAINT PK_Course PRIMARY KEY,
course_year smallint,
course_semister tinyint,
subject_id int,
room_id int,
professor_id int
);

CREATE TABLE dbo.Subject
(
subject_id int CONSTRAINT PK_Subject PRIMARY KEY,
subject_name nvarchar(20) NOT NULL,
grade decimal(2, 1)
);

CREATE TABLE dbo.Classroom
(
room_id int CONSTRAINT PK_Classroom PRIMARY KEY,
room_name nvarchar(20),
floor_no tinyint
);

CREATE TABLE dbo.Professor
(
professor_id int CONSTRAINT PK_Professor PRIMARY KEY,
professor_name nvarchar(20) NOT NULL
);

GO
-------------------------------------------
ALTER TABLE dbo.Student
ADD CONSTRAINT UQ_Student_email
UNIQUE(email);
GO

ALTER TABLE dbo.ChooseCourse ADD CONSTRAINT
	FK_ChooseCourse_Student FOREIGN KEY(student_id) 
	REFERENCES dbo.Student(student_id) 
		ON UPDATE  NO ACTION 
		ON DELETE  NO ACTION 
GO

-----------------------------------------

--Check Course(course_year BETWEEN 2000 AND 2100)
ALTER TABLE dbo.Course
ADD CONSTRAINT CK_Course_course_year
CHECK(course_year BETWEEN 2000 AND 2100);
GO

--Check Course(course_semister IN (1, 2))

--Check dbo.Subject(grade BETWEEN 0 AND 4)

--Check dbo.Classroom(floor_no BETWEEN 1 AND 20)


--Foreign Key dbo.ChooseCourse => dbo.Course

--Foreign Key dbo.Course => dbo.Subject

--Foreign Key dbo.Course => dbo.Classroom

--Foreign Key dbo.Course => dbo.Professor
