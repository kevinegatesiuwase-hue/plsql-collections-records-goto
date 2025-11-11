# Technical Documentation

## PL/SQL Concepts Demonstrated

### 1. Records
**Purpose**: Store related data fields as a single unit
- **User-defined Record**: `emp_record` custom type with employee fields
- **Table-based Record**: `emp_table_rec` based on employees table structure
- **Usage**: Organized data handling for employee information

### 2. Collections

#### Associative Array
- **Type**: `dept_summary_type INDEX BY VARCHAR2(50)`
- **Purpose**: Store department summary with string keys for easy access
- **Characteristics**: Unbounded, sparse, in-memory only
- **Usage**: Key-value pairs for summary statistics ('Total_Salary', 'Employee_Count')

#### Nested Table
- **Type**: `bonus_list TABLE OF NUMBER`
- **Purpose**: Dynamic list of employee bonuses
- **Characteristics**: Dynamically sizable, starts dense, can become sparse
- **Usage**: Store calculated bonuses for variable number of employees

#### VARRAY
- **Type**: `multiplier_array VARRAY(5) OF NUMBER`
- **Purpose**: Fixed list of bonus multipliers
- **Characteristics**: Fixed upper bound, always dense, stored in-line
- **Usage**: Predefined bonus rates (10%, 15%, 20%, etc.)

### 3. GOTO Statement
**Purpose**: Controlled flow transfer for error handling
- **Implementation**: Jump to `department_empty` label when no employees found
- **Best Practice**: Used sparingly for forward jumps and error handling
- **Benefit**: Cleanly skip main logic when preconditions aren't met

### 4. Program Flow
1. **Initialization**: Declare types and variables
2. **Validation**: Check department has employees using GOTO
3. **Processing**: Calculate bonuses using cursor FOR loop
4. **Aggregation**: Build department summary in associative array
5. **Output**: Display results and available multipliers

## Key Features
- **Flexible Department Selection**: Change `v_dept_id` to test different scenarios
- **Comprehensive Error Handling**: Exception block for database errors
- **Structured Output**: Clear formatting for readability
- **Multiple Collection Types**: Demonstrates practical use cases for each type

## Testing Scenarios
- **Department 10**: 2 employees - normal operation
- **Department 20**: 3 employees - normal operation  
- **Department 99**: No employees - GOTO demonstration
- **Various multipliers**: VARRAY shows different bonus tiers
