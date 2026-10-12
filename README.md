# UniversityDB — MySQL Assignment

## Objective
Create a relational database named `UniversityDB`, define three related tables, insert sample data, and answer the ten assignment questions using SQL.

## Files
- `UniversityDB_Assignment.sql` — complete runnable SQL script.
- `README.md` — project overview and execution/submission instructions.
- `screenshots/` — save your own screenshots of executed queries here before submission.

## Database design
- `Departments`: one row per department.
- `Students`: each student references one department through `DepartmentID`.
- `Courses`: each row represents a course enrollment; `StudentID` references the student enrolled in that course.

### Relationships
- One department can have many students (one-to-many).
- One student can have many course enrollment records (one-to-many).

> For this assignment's required structure, `Courses` contains `CourseID`, `CourseName`, and `StudentID`. In a larger production database, course definitions and student enrollments would usually be separated into their own tables.

## How to run
1. Install MySQL Server and MySQL Workbench, if not already installed.
2. Open MySQL Workbench and connect to your local MySQL Server.
3. Open `UniversityDB_Assignment.sql` in a query tab (File → Open SQL Script).
4. Execute the whole script using the lightning-bolt **Execute** button.
5. Confirm that the final validation queries show 5 departments, 8 students, and 10 course-enrollment records.
6. Run each numbered query separately if you need a clean result grid for screenshots.

The script drops and recreates the three assignment tables each time it runs. Do not use it in a database containing data you need to keep.

## Assignment questions covered
1. Student details with department names.
2. Students enrolled in Artificial Intelligence.
3. Student count by department.
4. Courses taken by Alice Johnson.
5. Students enrolled in more than one course.
6. Average student age by department.
7. Department(s) with the most students.
8. Students not enrolled in any course.
9. Each student and total course count, including zero.
10. Computer Science students taking a course whose name contains `Data`.

## Screenshot checklist
Save screenshots in the `screenshots/` folder. Capture the SQL query and its result grid together where possible.

- `01_create_tables.png` — successful database/table creation or schema view.
- `02_sample_data.png` — sample data validation counts.
- `03_query_a.png` through `12_query_j.png` — one screenshot for each of the ten questions.
- Ensure names, query text, and result rows are readable. Do not fabricate screenshots; capture them from your own MySQL execution.

## GitHub submission
1. Create a new public repository named `UniversityDB-MySQL-Assignment` (or another clear name).
2. Upload `UniversityDB_Assignment.sql` and `README.md`.
3. Create a `screenshots` folder in the repository and upload your genuine result screenshots.
4. Check that the SQL file opens correctly on GitHub.
5. Copy the repository URL and send it to your mentor.

## Notes
- The script uses a common table expression (`WITH`) in Query 7, supported by MySQL 8.0 and later.
- Query 3 and Query 6 use `LEFT JOIN`, so departments with no students still appear.
- Query 8 uses `LEFT JOIN ... IS NULL` to find students without enrollments.
