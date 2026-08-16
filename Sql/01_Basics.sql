-- =============================================
-- SQL BASICS: CREATE, INSERT, SELECT, UPDATE, DELETE
-- Author: Christian James
-- Description: Foundational SQL operations
-- =============================================

-- Create Students Table
CREATE TABLE STUDENTS (
    ROLL_NO     INT PRIMARY KEY,
    NAME        VARCHAR(50) NOT NULL,
    ADDRESS     VARCHAR(50),
    PHONE       VARCHAR(20),
    AGE         INT CHECK (AGE >= 0),
    SEX         VARCHAR(10) CHECK (SEX IN ('male', 'female', 'Male', 'Female')),
    CITY        VARCHAR(50),
    DEPARTMENT  VARCHAR(50),
    SALARY      DECIMAL(10,2)
);

-- Insert Multiple Records
INSERT INTO STUDENTS (ROLL_NO, NAME, ADDRESS, PHONE, AGE, SEX, CITY, DEPARTMENT, SALARY)
VALUES
    (1, 'James',  'Nigeria',     'xxx', 20, 'male',   'Abuja',   'Agric',     45000),
    (2, 'Sam',    'Algeria',     'xxx', 16, 'male',   'Algiers', 'Business',  32000),
    (3, 'Musa',   'USA',         'xxx', 18, 'male',   'Houston', 'Computer',  55000),
    (4, 'Jane',   'Mexico',      'xxx', 13, 'Female', 'Mexico',  'Education', 28000),
    (5, 'John',   'Burkinafaso', 'xxx', 16, 'male',   'Dakar',   'Civil',     38000),
    (6, 'Peter',  'Burkinafaso', 'xxx', 16, 'male',   'Dakar',   'Food',      41000),
    (7, 'Mary',   'Ghana',       'xxx', 18, 'Female', 'Accra',   'Agric',     36000),
    (8, 'Harry',  'Kenya',       'xxx', 20, 'male',   'Nairobi', 'Computer',  62000);

-- View All Records
SELECT * FROM STUDENTS;

-- Select Specific Columns
SELECT NAME, AGE, DEPARTMENT FROM STUDENTS;

-- Filter with WHERE
SELECT NAME, AGE FROM STUDENTS
WHERE AGE > 16;

--Filter with group by
SELECT NAME, AGE FROM STUDENTS
GROUP BY NAME, AGE

-- Filter with Multiple Conditions
SELECT NAME, AGE, DEPARTMENT FROM STUDENTS
WHERE AGE > 15 AND DEPARTMENT = 'Agric';

-- Sort Results
SELECT NAME, AGE FROM STUDENTS
ORDER BY AGE DESC;

-- Update a Record
UPDATE STUDENTS
SET CITY = 'Lagos'
WHERE ROLL_NO = 1;

-- Update Multiple Columns
UPDATE STUDENTS
SET ADDRESS = 'Nigeria', CITY = 'Abuja'
WHERE ROLL_NO = 7;

-- Delete a Specific Record
BEGIN TRANSACTION;
DELETE FROM STUDENTS WHERE ROLL_NO = 8;
ROLLBACK; -- Undo delete for demonstration

--Delete specific Field
ALTER TABLE STUDENTS
DROP COLUMN PHONE
ROLLBACK; -- Undo delete for demonstration

--Renaming a table name
EXEC SP_RENAME
'old_table_name', 'new_table_name'

--Renaming a field
EXEC SP_RENAME
'table_name.old_column_name', 
'new_column_name', 'column'

--Adding a new field
ALTER TABLE STUDENTS
ADD FACULTY VARCHAR(67)

--Truncate a table(removes all recods while the structure remains)
TRUNCATE TABLE table_name

-- Top N Records
SELECT TOP 3 * FROM STUDENTS
ORDER BY SALARY DESC;

-- Pagination using OFFSET
SELECT * FROM STUDENTS
ORDER BY ROLL_NO
OFFSET 2 ROWS FETCH NEXT 3 ROWS ONLY;
