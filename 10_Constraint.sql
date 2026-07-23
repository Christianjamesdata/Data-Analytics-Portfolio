-- =============================================
-- CONSTRAINTS
-- Author: Christian James
-- Description: Demonstrating all SQL Constraints
-- =============================================

-- Create table with ALL constraints
CREATE TABLE EMPLOYEE (
    EMP_ID      INT CONSTRAINT pk_emp PRIMARY KEY,
    NAME        VARCHAR(50) NOT NULL,
    EMAIL       VARCHAR(100) CONSTRAINT uq_email UNIQUE,
    AGE         INT CONSTRAINT chk_age CHECK (AGE >= 18),
    SALARY      DECIMAL(10,2) CONSTRAINT chk_salary CHECK (SALARY > 0),
    DEPT_ID     INT,
    COUNTRY     VARCHAR(30) CONSTRAINT df_country DEFAULT 'Nigeria',
    CONSTRAINT fk_dept FOREIGN KEY (DEPT_ID) 
    REFERENCES DEPARTMENT(DEPT_ID)
);

-- PRIMARY KEY constraint
CREATE TABLE PRODUCTS (
    PRODUCT_ID   INT PRIMARY KEY,
    PRODUCT_NAME VARCHAR(50) NOT NULL
);

-- FOREIGN KEY — parent must exist first
CREATE TABLE ORDERS (
    ORDER_ID  INT PRIMARY KEY,
    EMP_ID    INT,
    PRODUCT_ID INT,
    CONSTRAINT fk_emp FOREIGN KEY (EMP_ID) 
        REFERENCES EMPLOYEE(EMP_ID),
    CONSTRAINT fk_product FOREIGN KEY (PRODUCT_ID) 
        REFERENCES PRODUCTS(PRODUCT_ID)
);

-- Add constraint to existing table
ALTER TABLE STUDENT
ADD CONSTRAINT chk_student_age CHECK (AGE >= 0);

ALTER TABLE STUDENT
ADD CONSTRAINT df_student_country DEFAULT 'Nigeria' FOR ADDRESS;

-- Add UNIQUE constraint
ALTER TABLE STUDENT
ADD CONSTRAINT uq_student_phone UNIQUE (PHONE);

-- View all constraints
SELECT 
    CONSTRAINT_NAME,
    CONSTRAINT_TYPE,
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'STUDENT';

-- Drop a constraint
ALTER TABLE STUDENT
DROP CONSTRAINT chk_student_age;

-- Test CHECK constraint
-- This will fail because age is negative:
INSERT INTO EMPLOYEE (EMP_ID, NAME, EMAIL, AGE, SALARY, DEPT_ID)
VALUES (1, 'Christian', 'christian@email.com', -5, 50000, 1);

-- This will succeed:
INSERT INTO EMPLOYEE (EMP_ID, NAME, EMAIL, AGE, SALARY, DEPT_ID)
VALUES (1, 'Christian', 'christian@email.com', 25, 50000, 1);

-- Test DEFAULT constraint
INSERT INTO EMPLOYEE (EMP_ID, NAME, EMAIL, AGE, SALARY, DEPT_ID)
VALUES (2, 'James', 'james@email.com', 22, 45000, 1);
-- COUNTRY will automatically be 'Nigeria'

SELECT * FROM EMPLOYEE;