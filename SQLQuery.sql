USE [Company]
GO
-- �������� ��� ���������� ������� Employee
SELECT * 
FROM [dbo].[Employee]

--�������� ���� � �������� ����������, ��� ����������� �������� �� ��������� 500
SELECT [JobID], 
	[JobName] 
FROM [dbo].[Job] 
WHERE [MinSalary]<=500

--�������� ������� ���������� ����� ����������� � ������ 2015 ����
SELECT AVG(EmployeeSalary) AS AverageSalary
FROM [dbo].[Salary] s
WHERE s.[SalaryMonth] = 1 AND s.[SalaryYear] = 2015

--�������� ��� ������ ������� ���������, � ����� ��� �������
SELECT e.[EmployeeFirstName], 
	DATEDIFF(YEAR,e.[EmployeeDateOfBirth],GETDATE()) AS Age 
FROM [dbo].[Employee] e
WHERE e.[EmployeeDateOfBirth] = (SELECT MIN([EmployeeDateOfBirth]) FROM [dbo].[Employee])

--����� ������� ����������, ������� ���� ��������� �������� � ������ 2015 ����
SELECT e.[EmployeeLastName] 
FROM [dbo].[Employee] e 
WHERE e.[EmployeeID] IN
	(SELECT DISTINCT s.[EmployeeID] 
		FROM [dbo].[Salary] s 
		WHERE s.[SalaryMonth] = 1 AND s.[SalaryYear] = 2015
	)

--����� ���� ����������, �������� ������� � ��� 2015 ���� ��������� �� ��������� � �����-���� ���������� ������� ����� �� ����
SELECT s.[EmployeeID] 
FROM [dbo].[Salary] s 
WHERE s.[SalaryMonth] = 5 
	AND s.[SalaryYear] = 2015 
	AND s.[EmployeeSalary] < ANY
		(SELECT sl.EmployeeSalary 
			FROM [dbo].[Salary] sl 
			WHERE s.EmployeeID = sl.EmployeeID
				AND sl.[SalaryYear] = 2015 
				AND sl.[SalaryMonth]<5 
		)

--�������� ���������� � �����, ��������� ������� � ���������� ���������� � ���� ������� � ��������� ����� �����������
SELECT d.[DepartmentID], 
	d.[DepartmentName],
	(SELECT COUNT(EmployeeID) 
		FROM [dbo].[Career] c 
		WHERE c.[DismissalDate] is null 
			AND c.[DepartmentID] = d.[DepartmentID]
	) AS NumberOfEmployees 
FROM [dbo].[Department] d

--����� ������� ����������� �������� �� 2015 ��� � ������� ����������
SELECT s.[EmployeeID],
	e.[EmployeeLastName],
	e.[EmployeeFirstName], 
	AVG(s.EmployeeSalary) AS AverageSalary 
FROM [dbo].[Salary] s 
JOIN [dbo].[Employee] e 
ON s.[EmployeeID] = e.[EmployeeID]
WHERE s.[SalaryYear] = 2015 
GROUP BY s.[EmployeeID], e.[EmployeeLastName],e.[EmployeeFirstName]

--����� ������� �������� �� 2015 ��� � ������� ����������. �������� � ��������� ������ ��� ����������, ���������� ������� ����������� �� ����� ���� ���
SELECT s.[EmployeeID],
	e.[EmployeeLastName],
	e.[EmployeeFirstName], 
	AVG(s.EmployeeSalary) AS AverageSalary 
FROM [dbo].[Salary] s 
JOIN [dbo].[Employee] e 
ON s.[EmployeeID] = e.[EmployeeID]
WHERE s.[SalaryYear] = 2015 
GROUP BY s.[EmployeeID], e.[EmployeeLastName],e.[EmployeeFirstName]
HAVING COUNT(s.[SalaryMonth]) >= 2

--����� ����� ��� ����������, ����������� �������� ������� �� ������ 2015 ��������� 1000
SELECT e.[EmployeeLastName], 
	e.[EmployeeFirstName],
	s.[EmployeeSalary] AS Salary 
FROM [dbo].[Employee] e
JOIN [dbo].[Salary] s
ON e.[EmployeeID] = s.[EmployeeID]
WHERE s.[SalaryYear] = 2015 
	AND s.[SalaryMonth] = 1
	AND s.[EmployeeSalary] > 1000


--����� ����� ���������� � ���� �� ����������� ������ (�� ����� ��������� � � ����� ������). 
SELECT e.[EmployeeLastName],
	e.[EmployeeFirstName], 
	DATEDIFF(YEAR,c.[HireDate],ISNULL(c.[DismissalDate],GETDATE())) AS WorkExperience 
FROM [dbo].[Employee] e
JOIN [dbo].[Career] c 
ON c.[EmployeeID] = e.[EmployeeID]

--��������� ����������� �������� ��� ���� ���������� � 1.5 ����
UPDATE [dbo].[Job] SET [MinSalary] = [MinSalary]*1.5

--������� �� ������� salary ��� ������ �� 2014 � ����� ������ ����

DELETE [dbo].[Salary] WHERE [SalaryYear] <= 2014