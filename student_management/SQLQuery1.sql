CREATE DATABASE student_management;

USE student_management


CREATE TABLE students (
	id INT IDENTITY(1,1) PRIMARY KEY, 
	name NVARCHAR(255) NOT NULL, 
	email NVARCHAR(255) UNIQUE NOT NULL, 
	phone NVARCHAR(20),
	course NVARCHAR(255) NOT NULL
);

TRUNCATE TABLE students


SELECT * FROM students	


