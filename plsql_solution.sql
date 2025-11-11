-- database_setup.sql (You might need this if you create a test table)
-- CREATE TABLE employees (
--     employee_id NUMBER PRIMARY KEY,
--     first_name VARCHAR2(50),
--     last_name VARCHAR2(50),
--     salary NUMBER,
--     department_id NUMBER
-- );
-- INSERT INTO employees VALUES (1, 'John', 'Doe', 5000, 10);
-- INSERT INTO employees VALUES (2, 'Jane', 'Smith', 6000, 10);
-- ... etc.

-- plsql_solution.sql
SET SERVEROUTPUT ON;
DECLARE
    -- 1. Define a RECORD type for an employee
    TYPE emp_record IS RECORD (
        emp_id employees.employee_id%TYPE,
        emp_name VARCHAR2(100),
        salary employees.salary%TYPE
    );
    
    -- 2. Define a NESTED TABLE type for bonuses
    TYPE bonus_list IS TABLE OF NUMBER;
    
    -- 3. Define an ASSOCIATIVE ARRAY for the department summary
    TYPE dept_summary_type IS TABLE OF VARCHAR2(200) INDEX BY VARCHAR2(50);
    
    -- 4. Define a VARRAY for bonus multipliers
    TYPE multiplier_array IS VARRAY(3) OF NUMBER;
    
    -- Variable Declarations
    v_employee emp_record;
    v_bonuses bonus_list := bonus_list(); -- Initialize the nested table
    v_summary dept_summary_type;
    v_multipliers multiplier_array := multiplier_array(0.1, 0.15, 0.2);
    v_dept_id NUMBER := 10; -- Target department ID
    
    -- Cursor to get employees from a department
    CURSOR emp_cursor IS
        SELECT employee_id, first_name || ' ' || last_name, salary
        FROM employees
        WHERE department_id = v_dept_id;
        
    -- Counter for the nested table
    v_index NUMBER := 1;
    v_total_bonus NUMBER := 0;
    v_total_salary NUMBER := 0;
BEGIN
    -- Check if the department has any employees
    SELECT COUNT(*) INTO v_index FROM employees WHERE department_id = v_dept_id;
    IF v_index = 0 THEN
        GOTO no_data_found; -- 5. Using the GOTO statement
    END IF;
    
    -- Initialize the nested table (extend it)
    v_bonuses.EXTEND(v_index); -- You might need a more dynamic way to handle this
    
    -- Reset counter
    v_index := 1;
    
    -- Main Logic Loop
    FOR emp_rec IN emp_cursor LOOP
        -- Populate the record (implicit via cursor FOR loop)
        
        -- Populate the NESTED TABLE (bonus calculation)
        v_bonuses(v_index) := emp_rec.salary * v_multipliers(1); -- Using 1st multiplier from VARRAY
        
        -- Display individual employee bonus
        DBMS_OUTPUT.PUT_LINE('Employee: ' || emp_rec.emp_name || 
                             ', Bonus: ' || v_bonuses(v_index));
        
        -- Accumulate totals for the summary
        v_total_salary := v_total_salary + emp_rec.salary;
        v_total_bonus := v_total_bonus + v_bonuses(v_index);
        
        v_index := v_index + 1;
    END LOOP;
    
    -- Populate the ASSOCIATIVE ARRAY (department summary)
    v_summary('Department_ID') := 'Department ' || v_dept_id;
    v_summary('Total_Employees') := 'Total Employees: ' || (v_index - 1);
    v_summary('Total_Salary') := 'Total Salary: ' || v_total_salary;
    v_summary('Total_Bonus') := 'Total Bonus: ' || v_total_bonus;
    
    -- Display the summary
    DBMS_OUTPUT.PUT_LINE('--- Department Summary ---');
    DBMS_OUTPUT.PUT_LINE(v_summary('Department_ID'));
    DBMS_OUTPUT.PUT_LINE(v_summary('Total_Employees'));
    DBMS_OUTPUT.PUT_LINE(v_summary('Total_Salary'));
    DBMS_OUTPUT.PUT_LINE(v_summary('Total_Bonus'));
    
    -- Exit point to skip the main logic if GOTO was used
    <<end_of_report>>
    DBMS_OUTPUT.PUT_LINE('--- Report Finished ---');
    RETURN;
    
    -- Label for the GOTO jump
    <<no_data_found>>
    DBMS_OUTPUT.PUT_LINE('Error: No employees found in department ' || v_dept_id);
    GOTO end_of_report;
    
END;
/
