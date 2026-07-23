-- =============================================
-- CTEs AND SUBQUERIES
-- Author: Christian James
-- =============================================

-- SIMPLE CTE
WITH avg_salary AS (
    SELECT AVG(SALARY) AS average FROM STUDENTS
)
SELECT NAME, SALARY, average AS company_avg
FROM STUDENTS, avg_salary
WHERE SALARY > average;

-- MULTIPLE CTEs
WITH 
high_earners AS (
    SELECT NAME, DEPARTMENT, SALARY
    FROM STUDENTS
    WHERE SALARY > 40000
),
dept_summary AS (
    SELECT DEPARTMENT, COUNT(*) AS total, AVG(SALARY) AS avg_sal
    FROM high_earners
    GROUP BY DEPARTMENT
)
SELECT * FROM dept_summary
ORDER BY avg_sal DESC;

-- CTE with Window Function
WITH ranked_students AS (
    SELECT NAME, DEPARTMENT, SALARY,
    DENSE_RANK() OVER (PARTITION BY DEPARTMENT ORDER BY SALARY DESC) AS rnk
    FROM STUDENTS
)
SELECT * FROM ranked_students
WHERE rnk <= 2;

-- Remove Duplicates using CTE
WITH duplicates AS (
    SELECT NAME,
    ROW_NUMBER() OVER (PARTITION BY NAME ORDER BY ROLL_NO) AS row_num
    FROM STUDENTS
)
SELECT * FROM duplicates WHERE row_num > 1;

-- RECURSIVE CTE: Number series
WITH numbers AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num + 1 FROM numbers
    WHERE num < 10
)
SELECT * FROM numbers;

-- SUBQUERIES
-- Single row subquery
SELECT NAME, AGE FROM STUDENTS
WHERE AGE = (SELECT MAX(AGE) FROM STUDENT);

-- Find second highest salary
SELECT MAX(SALARY) AS second_highest
FROM STUDENTS
WHERE SALARY < (SELECT MAX(SALARY) FROM STUDENT);

-- Multiple row subquery with IN
SELECT NAME, DEPARTMENT FROM STUDENTS
WHERE DEPARTMENT IN (
    SELECT DEPARTMENT FROM STUDENTS
    WHERE SALARY > 40000
);

--using ANY
--find student older than any student in agric
    SELECT name, age
   FROM STUDENTS 
      WHERE age > ANY(
       SELECT age FROM student
     WHERE Department='agric' 
        )

--using ALL
--find student older than all student in agric
  SELECT department, age
 FROM STUDENTS 
      WHERE age > ALL(
      SELECT age FROM student
    WHERE Department = 'agric'
        )

-- Subquery with EXISTS
SELECT NAME FROM STUDENTS s
WHERE EXISTS (
    SELECT 1 FROM STUDENTS s2
    WHERE s2.DEPARTMENT = s.DEPARTMENT
    AND s2.SALARY > 50000
);

-- Correlated Subquery
SELECT NAME, SALARY, DEPARTMENT
FROM STUDENT s1
WHERE SALARY > (
    SELECT AVG(SALARY)
    FROM STUDENTS s2
    WHERE s2.DEPARTMENT = s1.DEPARTMENT
);

-- AdventureWorks CTE Example
WITH top_earners AS (
    SELECT 
        e.BusinessEntityID,
        e.JobTitle,
        p.Rate,
        DENSE_RANK() OVER (PARTITION BY e.JobTitle ORDER BY p.Rate DESC) AS rnk
    FROM HumanResources.Employee e
    JOIN HumanResources.EmployeePayHistory p
    ON e.BusinessEntityID = p.BusinessEntityID
)
SELECT * FROM top_earners
WHERE rnk <= 3
ORDER BY JobTitle, rnk;