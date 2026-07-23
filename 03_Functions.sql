-- =============================================
-- SQL FUNCTIONS: Aggregate, String, Date, Math
-- Author: Christian James
-- =============================================

-- AGGREGATE FUNCTIONS
SELECT COUNT(*) AS total_students FROM STUDENTS;
SELECT SUM(SALARY) AS total_salary FROM STUDENTS;
SELECT AVG(SALARY) AS avg_salary FROM STUDENTS;
SELECT MAX(SALARY) AS highest_salary FROM STUDENTS;
SELECT MIN(SALARY) AS lowest_salary FROM STUDENTS;

-- GROUP BY with Aggregater
SELECT DEPARTMENT,
    COUNT(*) AS total_students,
    AVG(SALARY) AS avg_salary,
    MAX(SALARY) AS highest_salary,
    MIN(SALARY) AS lowest_salary
FROM STUDENTS
GROUP BY DEPARTMENT
ORDER BY avg_salary DESC;

-- HAVING clause
SELECT DEPARTMENT, AVG(SALARY) AS avg_salary
FROM STUDENTS
GROUP BY DEPARTMENT
HAVING AVG(SALARY) > 35000;

-- STRING FUNCTIONS
SELECT 
    NAME,
    UPPER(NAME) AS uppercase_name,
    LOWER(NAME) AS lowercase_name,
    LEN(NAME) AS name_length,
    SUBSTRING(NAME, 1, 3) AS short_name,
    CONCAT(NAME, ' from ', ADDRESS) AS full_detail,
    TRIM(NAME) AS trimmed_name
FROM STUDENTS;

-- DATE FUNCTIONS
SELECT 
    GETDATE() AS current_date,
    YEAR(GETDATE()) AS current_year,
    MONTH(GETDATE()) AS current_month,
    DAY(GETDATE()) AS current_day;

-- MATH FUNCTIONS
SELECT 
    SALARY,
    ROUND(SALARY, -3) AS rounded_salary,
    CEILING(SALARY/1000.0) AS ceiling_value,
    FLOOR(SALARY/1000.0) AS floor_value,
    ABS(SALARY - 40000) AS salary_difference
FROM STUDENTS;