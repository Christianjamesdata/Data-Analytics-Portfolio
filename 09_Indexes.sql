-- =============================================
-- INDEXES
-- Author: Christian James
-- Description: Creating and managing SQL Indexes
-- =============================================

-- View existing indexes on STUDENTS table
EXEC sp_helpindex 'STUDENTS';

-- Non-Clustered Index on NAME column
CREATE INDEX idx_student_name
ON STUDENTS (NAME);

-- Non-Clustered Index on DEPARTMENT
CREATE INDEX idx_student_department
ON STUDENTS (DEPARTMENT);

-- Composite Index on multiple columns
CREATE INDEX idx_dept_salary
ON STUDENTS (DEPARTMENT, SALARY);

-- Unique Index on a column
CREATE UNIQUE INDEX idx_unique_phone
ON STUDENTS (PHONE);

-- Query that uses the index automatically
SELECT * FROM STUDENTS
WHERE NAME = 'James';

-- Query filtering by department (uses idx_student_department)
SELECT * FROM STUDENTS
WHERE DEPARTMENT = 'Computer'
ORDER BY SALARY DESC;

-- Force SQL Server to use a specific index
SELECT * FROM STUDENTS WITH (INDEX(idx_student_name))
WHERE NAME = 'James';

-- AdventureWorks Index example
CREATE INDEX idxHRM ON
HumanResources.Employee (JobTitle);

-- Query using the index
SELECT * FROM HumanResources.Employee
WHERE JobTitle = 'Senior Tool Designer';

-- View all indexes on Employee table
EXEC sp_helpindex 'HumanResources.Employee';

-- Drop an Index
DROP INDEX STUDENTS.idx_student_name;

-- View all indexes in database
SELECT 
    t.name AS table_name,
    i.name AS index_name,
    i.type_desc AS index_type
FROM sys.indexes i
JOIN sys.tables t ON i.object_id = t.object_id
WHERE i.name IS NOT NULL
ORDER BY t.name;