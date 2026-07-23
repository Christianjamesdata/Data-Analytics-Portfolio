-- =============================================
-- WINDOW FUNCTIONS
-- Author: Christian James
-- =============================================

-- ROW_NUMBER: Unique row numbers
SELECT NAME, AGE, SALARY,
ROW_NUMBER() OVER (ORDER BY SALARY DESC) AS row_num
FROM STUDENTS;

-- RANK: Rank with gaps for ties
SELECT NAME, DEPARTMENT, SALARY,
RANK() OVER (ORDER BY DEPARTMENT DESC) AS salary_rank
FROM STUDENTS;

-- DENSE_RANK: Rank without gaps
SELECT NAME, DEPARTMENT, SALARY,
DENSE_RANK() OVER (ORDER BY SALARY DESC) AS dense_rank
FROM STUDENTS;

-- PARTITION BY: Rank within each department
SELECT NAME, DEPARTMENT, SALARY,
DENSE_RANK() OVER (PARTITION BY DEPARTMENT ORDER BY SALARY DESC) AS dept_rank
FROM STUDENTS;

-- Top earner per department
SELECT * FROM (
    SELECT NAME, DEPARTMENT, SALARY,
    DENSE_RANK() OVER (PARTITION BY DEPARTMENT ORDER BY SALARY DESC) AS dept_rank
    FROM STUDENTS
) ranked
WHERE dept_rank = 1;

-- Running Total
SELECT NAME, SALARY,
SUM(SALARY) OVER (ORDER BY ROLL_NO) AS running_total
FROM STUDENTS;

-- Moving Average
SELECT NAME, AGE,
AVG(AGE) OVER (ORDER BY ROLL_NO
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg
FROM STUDENTS;

-- LAG and LEAD
SELECT NAME, SALARY,
LAG(SALARY) OVER (ORDER BY SALARY) AS prev_salary,
LEAD(SALARY) OVER (ORDER BY SALARY) AS next_salary,
SALARY - LAG(SALARY) OVER (ORDER BY SALARY) AS salary_difference
FROM STUDENTS;

-- PERCENT_RANK
SELECT NAME, SALARY,
ROUND(PERCENT_RANK() OVER (ORDER BY SALARY) * 100, 2) AS percentile
FROM STUDENTS;

-- AdventureWorks Example
 --compare each employee salary to department average
SELECT
    e.BusinessEntityID,
    e.JobTitle,
    p.Rate,
    AVG(p.Rate) OVER (PARTITION BY e.JobTitle) AS avg_rate_per_title,
    p.Rate - AVG(p.Rate) OVER (PARTITION BY e.JobTitle) AS rate_difference,
    DENSE_RANK() OVER (PARTITION BY e.JobTitle ORDER BY p.Rate DESC) AS rank_in_title
FROM HumanResources.Employee e
JOIN HumanResources.EmployeePayHistory p
ON e.BusinessEntityID = p.BusinessEntityID;

-- Top 3 highest paid employees per dept
SELECT * FROM (
    SELECT
    e.BusinessEntityID,
    e.jobtitle,
    p.rate,
     DENSE_RANK() OVER (PARTITION BY e.jobtitle ORDER BY p.rate DESC) 
    AS salary_rank
 FROM HumanResources.Employee e
 JOIN HumanResources.EmployeePayHistory p
 ON  e.BusinessEntityID = p.BusinessEntityID) RANK
    WHERE salary_rank <=3

--find duplicate using ROW_NUMBER
SELECT * FROM (
    SELECT NAME, 
    ROW_NUMBER() OVER (PARTITION BY name ORDER BY name)
    as row_num
FROM student) duplicates
WHERE row_num >1