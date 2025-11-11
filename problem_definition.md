# Problem Definition: Employee Bonus Management System

## Business Scenario
ABC Corporation needs an automated PL/SQL system to manage employee bonuses and generate department performance reports. The system should handle variable department sizes and different bonus calculation scenarios.

## Technical Requirements

### 1. PL/SQL Records
- Create employee records containing: ID, Name, Salary, Department
- Use both table-based (%ROWTYPE) and user-defined records

### 2. Collections Implementation
- **Associative Array**: Store department summary statistics indexed by department name
- **Nested Table**: Store calculated bonuses for employees (dynamic sizing)
- **VARRAY**: Store fixed bonus multipliers for different performance tiers

### 3. GOTO Statement
- Implement controlled flow using GOTO for error handling
- Skip processing when no data is available
- Handle exceptional cases with labeled jumps

### 4. Specific Functionalities
- Calculate bonuses as percentage of salary
- Generate department-level summaries
- Handle empty departments gracefully
- Display individual and aggregated results

## Database Requirements
- Employees table with: employee_id, first_name, last_name, salary, department_id
- Sample data for testing multiple scenarios

## Expected Output
- Employee-wise bonus calculations
- Department summary reports
- Error messages for invalid departments
- Total calculations for salary and bonuses
