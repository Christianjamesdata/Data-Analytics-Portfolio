-- =============================================
-- TRIGGERS
-- Author: Christian James
-- =============================================

-- Create Audit Log Table
CREATE TABLE STUDENT_AUDIT (
    AUDIT_ID    INT IDENTITY(1,1) PRIMARY KEY,
    ROLL_NO     INT,
    NAME        VARCHAR(50),
    ACTION      VARCHAR(10),
    ACTION_DATE DATETIME DEFAULT GETDATE()
);

-- AFTER INSERT Trigger
GO
CREATE TRIGGER trg_AfterInsert
ON STUDENTS
AFTER INSERT
AS
BEGIN
    INSERT INTO STUDENT_AUDIT (ROLL_NO, NAME, ACTION)
    SELECT ROLL_NO, NAME, 'INSERT'
    FROM INSERTED;
    PRINT 'New student record inserted and logged.';
END;

-- AFTER UPDATE Trigger
GO
CREATE TRIGGER trg_AfterUpdate
ON STUDENTS
AFTER UPDATE
AS
BEGIN
    INSERT INTO STUDENT_AUDIT (ROLL_NO, NAME, ACTION)
    SELECT ROLL_NO, NAME, 'UPDATE'
    FROM INSERTED;
    PRINT 'Student record updated and logged.';
END;

-- AFTER DELETE Trigger
GO
CREATE TRIGGER trg_AfterDelete
ON STUDENTS
AFTER DELETE
AS
BEGIN
    INSERT INTO STUDENT_AUDIT (ROLL_NO, NAME, ACTION)
    SELECT ROLL_NO, NAME, 'DELETE'
    FROM DELETED;
    PRINT 'Student record deleted and logged.';
END;

-- Test the triggers
INSERT INTO STUDENT VALUES 
(9, 'TestStudent', 'Nigeria', 'xxx', 21, 'male', 'Lagos', 'Agric', 40000);

UPDATE STUDENTS SET CITY = 'Kano' WHERE ROLL_NO = 9;

DELETE FROM STUDENTS WHERE ROLL_NO = 9;

-- View audit log
SELECT * FROM STUDENT_AUDIT;