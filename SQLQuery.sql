USE [Company]
GO
-- 1)	Получить все содержимое таблицы Employee
SELECT * 
FROM [dbo].[Employee]

--2)	Получить коды и названия должностей, чья минимальная зарплата не превышает 500
SELECT [JobID], 
	[Name] 
FROM [dbo].[Job] 
WHERE [MinSalary] <= 500

--3)	Получить среднюю заработную плату начисленную в январе 2015 года
SELECT AVG(EmployeeSalary) AS AverageSalary
FROM [dbo].[Salary] s
WHERE s.[Month] = 1 AND s.[Year] = 2015

--4)	Получить имя самого старого работника, а также его возраст
SELECT e.[FirstName], 
	DATEDIFF(YEAR, e.[DateOfBirth], GETDATE()) AS Age 
FROM [dbo].[Employee] e
WHERE e.[DateOfBirth] = (SELECT MIN([DateOfBirth]) FROM [dbo].[Employee])

--5)	Найти фамилии работников, которым была начислена зарплата в январе 2015 года
SELECT e.[LastName] 
FROM [dbo].[Employee] e 
WHERE e.[EmployeeId] IN
	(SELECT DISTINCT s.[EmployeeId] 
		FROM [dbo].[Salary] s 
		WHERE s.[Month] = 1 AND s.[Year] = 2015
	)

--6)	Найти коды работников, зарплата которых в мае 2015 года снизилась по сравнению с каким-либо предыдущим месяцем этого же года
SELECT s.[EmployeeId] 
FROM [dbo].[Salary] s 
WHERE s.[Month] = 5 
	AND s.[Year] = 2015 
	AND s.[EmployeeSalary] < ANY
		(SELECT sl.[EmployeeSalary] 
			FROM [dbo].[Salary] sl 
			WHERE s.EmployeeId = sl.EmployeeId
				AND sl.[Year] = 2015 
				AND sl.[Month] < 5 
		)

--7)	Получить информацию о кодах, названиях отделов и количестве работающих в этих отделах в настоящее время сотрудников
SELECT d.[DepartmentId], 
	d.[Name],
	(SELECT COUNT(EmployeeId) 
		FROM [dbo].[Career] c 
		WHERE c.[DismissalDate] is null 
			AND c.[DepartmentId] = d.[DepartmentId]
	) AS NumberOfEmployees 
FROM [dbo].[Department] d

--8)	Найти среднюю начисленную зарплату за 2015 год в разрезе работников
SELECT s.[EmployeeId],
	e.[LastName],
	e.[FirstName], 
	AVG(s.EmployeeSalary) AS AverageSalary 
FROM [dbo].[Salary] s 
JOIN [dbo].[Employee] e 
ON s.[EmployeeId] = e.[EmployeeId]
WHERE s.[Year] = 2015 
GROUP BY s.[EmployeeId], e.[LastName], e.[FirstName]

--9)	Найти среднюю зарплату за 2015 год в разрезе работников. Включать в результат только тех работников, начисления которым проводились не менее двух раз
SELECT s.[EmployeeId],
	e.[LastName],
	e.[FirstName], 
	AVG(s.EmployeeSalary) AS AverageSalary 
FROM [dbo].[Salary] s 
JOIN [dbo].[Employee] e 
ON s.[EmployeeId] = e.[EmployeeId]
WHERE s.[Year] = 2015 
GROUP BY s.[EmployeeId], e.[LastName], e.[FirstName]
HAVING COUNT(s.[Month]) >= 2

--10)	Найти имена тех работников, начисленная зарплата которых за январь 2015 превысила 1000
SELECT e.[LastName], 
	e.[FirstName],
	s.[EmployeeSalary] AS Salary 
FROM [dbo].[Employee] e
JOIN [dbo].[Salary] s
ON e.[EmployeeId] = s.[EmployeeId]
WHERE s.[Year] = 2015 
	AND s.[Month] = 1
	AND s.[EmployeeSalary] > 1000


--11)	Найти имена работников и стаж их непрерывной работы (на одной должности и в одном отделе). 
SELECT e.[LastName],
	e.[FirstName], 
	DATEDIFF(YEAR, c.[HireDate], ISNULL(c.[DismissalDate], GETDATE())) AS WorkExperience 
FROM [dbo].[Employee] e
LEFT JOIN [dbo].[Career] c 
ON c.[EmployeeId] = e.[EmployeeId]

--12)	Увеличить минимальную зарплату для всех должностей в 1.5 раза
UPDATE [dbo].[Job] SET [MinSalary] = [MinSalary]*1.5

--13)	Удалить из таблицы salary все записи за 2014 и более ранние годы

DELETE [dbo].[Salary] WHERE [Year] <= 2014