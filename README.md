# PL/SQL: Collections, Records & GOTO — Student Performance Demo

## Overview
This project demonstrates PL/SQL **Collections** (associative arrays, nested tables), **Records** (user-defined record type), and a controlled use of **GOTO**.  
It is based on the lecture slides *PL/SQL Collections and Records* provided by the instructor.

## Problem statement
Create a PL/SQL routine that:
- Stores student marks using a **collection** (associative array).
- Builds per-student summaries using a **RECORD** type.
- Keeps all student summaries in a **nested table**.
- Uses a **GOTO** label to skip students with missing or invalid marks.
- Prints a student report and class statistics.

## Files
- `sql/student_report.sql` — main PL/SQL script.
- `docs/explanation.md` — documentation, design notes, and rubric.

## How to run
1. Open SQL*Plus, SQL Developer, or any Oracle tool.  
2. Enable `SERVEROUTPUT`:
   ```sql
   SET SERVEROUTPUT ON SIZE 1000000;
