-- database_setup.sql
-- Create and populate employees table for PL/SQL Collections demo

SET SERVEROUTPUT ON;

-- Drop table if exists (for clean setup)
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE employees CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

-- Create employees table
CREATE TABLE employees (
    employee_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    salary NUMBER,
    department_id NUMBER,
    hire_date DATE
);

-- Insert sample data
INSERT INTO employees VALUES (1, 'John', 'Doe', 5000, 10, DATE '2020-01-15');
INSERT INTO employees VALUES (2, 'Jane', 'Smith', 6000, 10, DATE '2019-03-20');
INSERT INTO employees VALUES (3, 'Michael', 'Johnson', 7500, 20, DATE '2018-07-10');
INSERT INTO employees VALUES (4, 'Sarah', 'Williams', 5500, 20, DATE '2021-02-28');
INSERT INTO employees VALUES (5, 'David', 'Brown', 8000, 20, DATE '2017-11-05');
INSERT INTO employees VALUES (6, 'Emily', 'Davis', 4800, 30, DATE '2022-06-15');
INSERT INTO employees VALUES (7, 'Robert', 'Miller', 6200, 30, DATE '2020-09-12');
INSERT INTO employees VALUES (8, 'Lisa', 'Wilson', 5800, 40, DATE '2021-12-01');

COMMIT;

-- Display inserted data
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== EMPLOYEES TABLE CREATED ===');
    DBMS_OUTPUT.PUT_LINE('Total employees inserted: ' || SQL%ROWCOUNT);
    
    FOR dept IN (SELECT department_id, COUNT(*) as emp_count 
                 FROM employees 
                 GROUP BY department_id 
                 ORDER BY department_id) 
    LOOP
        DBMS_OUTPUT.PUT_LINE('Department ' || dept.department_id || ': ' || dept.emp_count || ' employees');
    END LOOP;
END;
/
