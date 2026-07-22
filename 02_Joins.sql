-- =============================================
-- SQL JOINS
-- Author: Christian James
-- Description: Demonstrating all types of SQL joins
-- =============================================

-- Create Department Table for JOIN practice
CREATE TABLE DEPARTMENT (
    DEPT_ID     INT PRIMARY KEY,
    DEPT_NAME   VARCHAR(50),
    LOCATION    VARCHAR(50)
);

INSERT INTO DEPARTMENT VALUES
    (1, 'Agric',     'Block A'),
    (2, 'Business',  'Block B'),
    (3, 'Computer',  'Block C'),
    (4, 'Education', 'Block D'),
    (5, 'Civil',     'Block E');

-- INNER JOIN: Returns only matching rows
SELECT s.NAME, s.AGE, d.DEPT_NAME, d.LOCATION
FROM STUDENTS s
INNER JOIN DEPARTMENT d ON s.DEPARTMENT = d.DEPT_NAME;

-- LEFT JOIN: All students even without department match
SELECT s.NAME, s.AGE, d.DEPT_NAME
FROM STUDENTS s
LEFT JOIN DEPARTMENT d ON s.DEPARTMENT = d.DEPT_NAME;

-- RIGHT JOIN: All departments even without students
SELECT s.NAME, d.DEPT_NAME, d.LOCATION
FROM STUDENTS s
RIGHT JOIN DEPARTMENT d ON s.DEPARTMENT = d.DEPT_NAME;

-- FULL OUTER JOIN: Everything from both tables
SELECT s.NAME, d.DEPT_NAME
FROM STUDENTS s
FULL OUTER JOIN DEPARTMENT d ON s.DEPARTMENT = d.DEPT_NAME;

-- SELF JOIN: Find students in the same city
SELECT s1.NAME AS Student1, s2.NAME AS Student2, s1.CITY
FROM STUDENTS s1
JOIN STUDENTS s2
ON s1.CITY = s2.CITY
AND s1.ROLL_NO <> s2.ROLL_NO;

-- JOIN with AdventureWorks
SELECT 
    e.BusinessEntityID,
    e.JobTitle,
    edh.DepartmentID,
    p.Rate
FROM HumanResources.Employee e
INNER JOIN HumanResources.EmployeeDepartmentHistory edh
    ON e.BusinessEntityID = edh.BusinessEntityID
INNER JOIN HumanResources.EmployeePayHistory p
    ON e.BusinessEntityID = p.BusinessEntityID
ORDER BY p.Rate DESC;

--JOINS with condition
    SELECT s.age, h.ModifiedDate
FROM STUDENT s
INNER JOIN HREDS h
ON s.BusinessEntityID = h.BusinessEntityID 
WHERE s.age>18
