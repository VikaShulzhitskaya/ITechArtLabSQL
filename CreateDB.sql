CREATE DATABASE Company
GO

USE Company
GO

CREATE TABLE Department(
	DepartmentID int NOT NULL PRIMARY KEY IDENTITY(1,1),
	DepartmentName nvarchar(100) NOT NULL,
	DepartmentAddress nvarchar(100)NOT NULL
)

CREATE TABLE Employee(
	EmployeeID int NOT NULL PRIMARY KEY IDENTITY(1,1),
	EmployeeLastName nvarchar(100) NOT NULL,
	EmployeeFirstName nvarchar(100) NOT NULL,
	EmployeeDateOfBirth date NOT NULL
)

CREATE TABLE Job(
	JobID int NOT NULL PRIMARY KEY IDENTITY(1,1),
	JobName nvarchar(100) NOT NULL,
	MinSalary money NULL
)

CREATE TABLE Career(
	CareerID int NOT NULL PRIMARY KEY IDENTITY(1,1),
	EmployeeID int NOT NULL,
	JobID int NOT NULL,
	DepartmentID int NOT NULL,
	HireDate date NOT NULL,
	DismissalDate date NULL
)

ALTER TABLE Career ADD CONSTRAINT FK_Career_EmployeeID
FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)

ALTER TABLE Career ADD CONSTRAINT FK_Career_JobID
FOREIGN KEY (JobID) REFERENCES Job(JobID)

ALTER TABLE Career ADD CONSTRAINT FK_Career_DepartmentID
FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)

CREATE TABLE Salary(
	SalaryID int NOT NULL PRIMARY KEY IDENTITY(1,1),
	EmployeeID int NOT NULL,
	SalaryMonth int NOT NULL,
	SalaryYear int NOT NULL,
	EmployeeSalary money NOT NULL
)

ALTER TABLE Salary ADD CONSTRAINT FK_Salary_EmployeeID
FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)

ALTER TABLE Salary
ADD CONSTRAINT chk_SalaryMonth CHECK (SalaryMonth>0 AND SalaryMonth<13)

ALTER TABLE Salary
ADD CONSTRAINT chk_SalaryYear CHECK (SalaryYear>2002 AND SalaryYear<2016)

INSERT INTO Department(DepartmentName, DepartmentAddress)
VALUES('D1', 'Room 1101'),
	('D11', 'Room 1102'),
	('D2', 'Room 1201'),
	('D3', 'Room 1301'),
	('D4', 'Room 1401')

INSERT INTO Employee(EmployeeLastName, EmployeeFirstName, EmployeeDateOfBirth)
VALUES('Ivanov','Ivan','19600502'),
	('Petrov','Peter','19830626'),
	('Sidorov','Viktor','19571213'),
	('Kotova','Svetlana','19910322'),
	('Medvedeva','Alena','19871124')

INSERT INTO Job(JobName, MinSalary)
VALUES('Chief Engineer',700),
	('Technologist',500),
	('Operator',450),
	('Mechanic',400),
	('Software developer',1200),
	('HR Director',1500)

INSERT INTO Career(DepartmentID, EmployeeID, JobID, HireDate, DismissalDate)
VALUES(1,1,6,'20030204',null),
	(1,2,5,'20140401',null),
	(4,3,4,'20050911',null),
	(4,4,1,'20030115','20150610'),
	(4,5,3,'20120206','20150910')

INSERT INTO Salary(EmployeeID, SalaryMonth, SalaryYear, EmployeeSalary)
VALUES(1,1,2015,1500),
	(1,2,2015,1500),
	(1,3,2015,1500),
	(1,4,2015,1650),
	(1,5,2015,1670),
	(1,6,2015,1700),
	(1,7,2015,1700),
	(2,1,2015,1200),
	(2,2,2015,1250),
	(2,3,2015,1300),
	(2,4,2015,1350),
	(2,5,2015,1500),
	(3,1,2015,400),
	(3,12,2014,400),
	(3,11,2014,400),
	(4,1,2015,700),
	(4,2,2015,700),
	(4,3,2015,700),
	(4,4,2015,700),
	(4,5,2015,500),
	(5,1,2015,450),
	(5,2,2015,450),
	(5,3,2015,470),
	(5,4,2015,470),
	(5,5,2015,470),
	(5,6,2015,470)

