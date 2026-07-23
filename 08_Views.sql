-- =============================================
-- VIEWS
-- Author: Christian James
-- Description: Creating and managing SQL Views
-- =============================================

-- Simple View
GO
CREATE VIEW student_basic_info AS
SELECT NAME, AGE, DEPARTMENT, CITY
FROM STUDENTS;

-- Query the view
SELECT * FROM student_basic_info;

-- View with filter
GO
CREATE VIEW high_salary_students AS
SELECT NAME, DEPARTMENT, SALARY
FROM STUDENTS
WHERE SALARY > 40000;

SELECT * FROM high_salary_students;

-- View joining two tables
GO
CREATE VIEW student_department_view AS
SELECT s.NAME, s.AGE, s.SALARY, d.LOCATION
FROM STUDENTS s
INNER JOIN DEPARTMENT d ON s.DEPARTMENT = d.DEPT_NAME;

SELECT * FROM student_department_view;

-- View with aggregation
GO
CREATE VIEW department_summary AS
SELECT 
    DEPARTMENT,
    COUNT(*) AS total_students,
    AVG(SALARY) AS avg_salary,
    MAX(SALARY) AS highest_salary,
    MIN(SALARY) AS lowest_salary
FROM STUDENTS
GROUP BY DEPARTMENT;

SELECT * FROM department_summary
ORDER BY avg_salary DESC;

-- AdventureWorks View
GO
CREATE VIEW employee_pay_summary AS
SELECT 
    e.BusinessEntityID,
    e.JobTitle,
    p.Rate,
    AVG(p.Rate) OVER (PARTITION BY e.JobTitle) AS avg_rate_per_title
FROM HumanResources.Employee e
JOIN HumanResources.EmployeePayHistory p
ON e.BusinessEntityID = p.BusinessEntityID;

SELECT * FROM employee_pay_summary
ORDER BY Rate DESC;

-- Modify a View
GO
ALTER VIEW student_basic_info AS
SELECT NAME, AGE, DEPARTMENT, CITY, SALARY
FROM STUDENTS;

-- Drop a View
DROP VIEW IF EXISTS high_salary_students;

-- List all Views
SELECT * FROM INFORMATION_SCHEMA.VIEWS;