CREATE DATABASE Company
GO

USE Company
GO

CREATE TABLE Department(
	DepartmentId int NOT NULL PRIMARY KEY IDENTITY(1,1),
	Name nvarchar(100) NOT NULL,
	Address nvarchar(100)NOT NULL
)

CREATE TABLE Employee(
	EmployeeId int NOT NULL PRIMARY KEY IDENTITY(1,1),
	LastName nvarchar(100) NOT NULL,
	FirstName nvarchar(100) NOT NULL,
	DateOfBirth date NOT NULL
)

CREATE TABLE Job(
	JobId int NOT NULL PRIMARY KEY IDENTITY(1,1),
	Name nvarchar(100) NOT NULL,
	MinSalary money NULL
)

CREATE TABLE Career(
	CareerId int NOT NULL PRIMARY KEY IDENTITY(1,1),
	EmployeeId int NOT NULL,
	JobId int NOT NULL,
	DepartmentId int NOT NULL,
	HireDate date NOT NULL,
	DismissalDate date NULL
)
GO

ALTER TABLE Career ADD CONSTRAINT FK_Career_EmployeeId
FOREIGN KEY (EmployeeId) REFERENCES Employee(EmployeeId)

ALTER TABLE Career ADD CONSTRAINT FK_Career_JobId
FOREIGN KEY (JobId) REFERENCES Job(JobId)

ALTER TABLE Career ADD CONSTRAINT FK_Career_DepartmentId
FOREIGN KEY (DepartmentId) REFERENCES Department(DepartmentId)

CREATE TABLE Salary(
	SalaryId int NOT NULL PRIMARY KEY IDENTITY(1,1),
	EmployeeId int NOT NULL,
	Month int NOT NULL,
	Year int NOT NULL,
	EmployeeSalary money NOT NULL
)

ALTER TABLE Salary ADD CONSTRAINT FK_Salary_EmployeeId
FOREIGN KEY (EmployeeId) REFERENCES Employee(EmployeeId)

ALTER TABLE Salary
ADD CONSTRAINT chk_Month CHECK (Month>0 AND Month<13)

ALTER TABLE Salary
ADD CONSTRAINT chk_Year CHECK (Year>2002 AND Year<2016)

INSERT INTO Department(Name, Address)
VALUES('D1', 'Room 1101'),
	('D11', 'Room 1102'),
	('D2', 'Room 1201'),
	('D3', 'Room 1301'),
	('D4', 'Room 1401')

INSERT INTO Employee(LastName, FirstName, DateOfBirth)
VALUES('Ivanov','Ivan','19600502'),
	('Petrov','Peter','19830626'),
	('Sidorov','Viktor','19571213'),
	('Kotova','Svetlana','19910322'),
	('Medvedeva','Alena','19871124')

INSERT INTO Job(Name, MinSalary)
VALUES('Chief Engineer',700),
	('Technologist',500),
	('Operator',450),
	('Mechanic',400),
	('Software developer',1200),
	('HR Director',1500)

INSERT INTO Career(DepartmentId, EmployeeId, JobId, HireDate, DismissalDate)
VALUES(1,1,6,'20030204',null),
	(1,2,5,'20140401',null),
	(4,3,4,'20050911',null),
	(4,4,1,'20030115','20150610'),
	(4,5,3,'20120206','20150910')

INSERT INTO Salary(EmployeeId, Month, Year, EmployeeSalary)
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

