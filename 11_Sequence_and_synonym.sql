-- =============================================
-- SEQUENCES AND SYNONYMS
-- Author: Christian James
-- Description: Auto-number generation and aliases
-- =============================================

-- ==================
-- SEQUENCES
-- ==================

-- Basic Sequence
CREATE SEQUENCE student_seq
START WITH 1
INCREMENT BY 1;

-- Use sequence in INSERT
INSERT INTO STUDENTS (ROLL_NO, NAME, AGE, DEPARTMENT, SALARY)
VALUES (NEXT VALUE FOR student_seq, 'Christian', 25, 'Computer', 55000);

INSERT INTO STUDENTS (ROLL_NO, NAME, AGE, DEPARTMENT, SALARY)
VALUES (NEXT VALUE FOR student_seq, 'Grace', 22, 'Business', 42000);

-- Check current sequence value
SELECT current_value FROM sys.sequences
WHERE name = 'student_seq';

-- Sequence with custom options
CREATE SEQUENCE order_seq
START WITH 1000
INCREMENT BY 5
MINVALUE 1000
MAXVALUE 9999
NO CYCLE;

-- Descending sequence
CREATE SEQUENCE countdown_seq
START WITH 100
INCREMENT BY -1
MINVALUE 1;

-- Restart sequence from new value
ALTER SEQUENCE student_seq
RESTART WITH 50;

-- View all sequences
SELECT 
    name,
    start_value,
    increment,
    current_value
FROM sys.sequences;

-- Drop sequence
DROP SEQUENCE IF EXISTS countdown_seq;

-- IDENTITY vs SEQUENCE comparison
-- IDENTITY (simpler - built into column):
CREATE TABLE auto_student (
    ID      INT IDENTITY(1,1) PRIMARY KEY,
    NAME    VARCHAR(50)
);

INSERT INTO auto_student (NAME) VALUES ('James');
INSERT INTO auto_student (NAME) VALUES ('Mary');
SELECT * FROM auto_student;
-- ID generates automatically without specifying it

-- ==================
-- SYNONYMS
-- ==================

-- Create Synonym for long table name
CREATE SYNONYM EMP
FOR HumanResources.Employee;

-- Now use short name instead
SELECT * FROM EMP;

-- Synonym for EmployeeDepartmentHistory
CREATE SYNONYM HREDS
FOR HumanResources.EmployeeDepartmentHistory;

SELECT * FROM HREDS;

-- Synonym for EmailAddress table
CREATE SYNONYM EMAILS
FOR person.EmailAddress;

SELECT * FROM EMAILS;

-- Cross-database synonym
-- CREATE SYNONYM STU FOR OtherDatabase.dbo.STUDENT;

-- View all synonyms
SELECT 
    name AS synonym_name,
    base_object_name AS original_object
FROM sys.synonyms;

-- Drop synonym
DROP SYNONYM IF EXISTS EMP;

-- Synonym vs Alias comparison
-- Alias (temporary - only in one query):
SELECT NAME AS StudentName FROM STUDENT;

-- Synonym (permanent - works everywhere):
CREATE SYNONYM STU FOR dbo.STUDENTS;
SELECT * FROM STU; -- works in any query

