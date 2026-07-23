-- =============================================
-- STORED PROCEDURES
-- Author: Christian James
-- =============================================

-- Simple Stored Procedure
GO
CREATE PROCEDURE GetAllStudents
AS
BEGIN
    SELECT * FROM STUDENTS
    ORDER BY ROLL_NO;
END;

EXEC GetAllStudents;

-- Procedure with Input Parameter
GO
CREATE PROCEDURE GetStudentByDepartment
    @Department VARCHAR(50)
AS
BEGIN
    SELECT NAME, AGE, SALARY
    FROM STUDENTS
    WHERE DEPARTMENT = @Department
    ORDER BY SALARY DESC;
END;

EXEC GetStudentByDepartment @Department = 'Agric';

-- Procedure with Multiple Parameters
GO
CREATE PROCEDURE GetStudentByAgeAndDept
    @MinAge INT,
    @Department VARCHAR(50)
AS
BEGIN
    SELECT NAME, AGE, SALARY, CITY
    FROM STUDENTS
    WHERE AGE >= @MinAge
    AND DEPARTMENT = @Department
    ORDER BY AGE;
END;

EXEC GetStudentByAgeAndDept @MinAge = 16, @Department = 'Computer';

-- Procedure with OUTPUT Parameter
GO
CREATE PROCEDURE GetDepartmentStats
    @Department VARCHAR(50),
    @AvgSalary DECIMAL(10,2) OUTPUT,
    @TotalStudents INT OUTPUT
AS
BEGIN
    SELECT 
        @AvgSalary = AVG(SALARY),
        @TotalStudents = COUNT(*)
    FROM STUDENTS
    WHERE DEPARTMENT = @Department;
END;

DECLARE @Avg DECIMAL(10,2), @Total INT;
EXEC GetDepartmentStats 
    @Department = 'Computer',
    @AvgSalary = @Avg OUTPUT,
    @TotalStudents = @Total OUTPUT;
SELECT @Avg AS AverageSalary, @Total AS TotalStudents;