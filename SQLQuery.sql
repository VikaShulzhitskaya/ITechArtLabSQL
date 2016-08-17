USE [Company]
GO
-- 1)	Получить все содержимое таблицы Employee
SELECT * 
FROM [dbo].[Employee]

--2)	Получить коды и названия должностей, чья минимальная зарплата не превышает 500
SELECT [JobID], 
	[JobName] 
FROM [dbo].[Job] 
WHERE [MinSalary]<=500

--3)	Получить среднюю заработную плату начисленную в январе 2015 года
SELECT AVG(EmployeeSalary) AS AverageSalary
FROM [dbo].[Salary] s
WHERE s.[SalaryMonth] = 1 AND s.[SalaryYear] = 2015

--4)	Получить имя самого старого работника, а также его возраст
SELECT e.[EmployeeFirstName], 
	DATEDIFF(YEAR,e.[EmployeeDateOfBirth],GETDATE()) AS Age 
FROM [dbo].[Employee] e
WHERE e.[EmployeeDateOfBirth] = (SELECT MIN([EmployeeDateOfBirth]) FROM [dbo].[Employee])

--5)	Найти фамилии работников, которым была начислена зарплата в январе 2015 года
SELECT e.[EmployeeLastName] 
FROM [dbo].[Employee] e 
WHERE e.[EmployeeID] IN
	(SELECT DISTINCT s.[EmployeeID] 
		FROM [dbo].[Salary] s 
		WHERE s.[SalaryMonth] = 1 AND s.[SalaryYear] = 2015
	)

--6)	Найти коды работников, зарплата которых в мае 2015 года снизилась по сравнению с каким-либо предыдущим месяцем этого же года
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

--7)	Получить информацию о кодах, названиях отделов и количестве работающих в этих отделах в настоящее время сотрудников
SELECT d.[DepartmentID], 
	d.[DepartmentName],
	(SELECT COUNT(EmployeeID) 
		FROM [dbo].[Career] c 
		WHERE c.[DismissalDate] is null 
			AND c.[DepartmentID] = d.[DepartmentID]
	) AS NumberOfEmployees 
FROM [dbo].[Department] d

--8)	Найти среднюю начисленную зарплату за 2015 год в разрезе работников
SELECT s.[EmployeeID],
	e.[EmployeeLastName],
	e.[EmployeeFirstName], 
	AVG(s.EmployeeSalary) AS AverageSalary 
FROM [dbo].[Salary] s 
JOIN [dbo].[Employee] e 
ON s.[EmployeeID] = e.[EmployeeID]
WHERE s.[SalaryYear] = 2015 
GROUP BY s.[EmployeeID], e.[EmployeeLastName],e.[EmployeeFirstName]

--9)	Найти среднюю зарплату за 2015 год в разрезе работников. Включать в результат только тех работников, начисления которым проводились не менее двух раз
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

--10)	Найти имена тех работников, начисленная зарплата которых за январь 2015 превысила 1000
SELECT e.[EmployeeLastName], 
	e.[EmployeeFirstName],
	s.[EmployeeSalary] AS Salary 
FROM [dbo].[Employee] e
JOIN [dbo].[Salary] s
ON e.[EmployeeID] = s.[EmployeeID]
WHERE s.[SalaryYear] = 2015 
	AND s.[SalaryMonth] = 1
	AND s.[EmployeeSalary] > 1000


--11)	Найти имена работников и стаж их непрерывной работы (на одной должности и в одном отделе). 
SELECT e.[EmployeeLastName],
	e.[EmployeeFirstName], 
	DATEDIFF(YEAR,c.[HireDate],ISNULL(c.[DismissalDate],GETDATE())) AS WorkExperience 
FROM [dbo].[Employee] e
JOIN [dbo].[Career] c 
ON c.[EmployeeID] = e.[EmployeeID]

--12)	Увеличить минимальную зарплату для всех должностей в 1.5 раза
UPDATE [dbo].[Job] SET [MinSalary] = [MinSalary]*1.5

--13)	Удалить из таблицы salary все записи за 2014 и более ранние годы

DELETE [dbo].[Salary] WHERE [SalaryYear] <= 2014