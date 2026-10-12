-- ============================================================
-- Assignment: UniversityDB - Relational Database using MySQL
-- Purpose: Create tables, insert sample data, and answer 10 queries
-- ============================================================

CREATE DATABASE IF NOT EXISTS UniversityDB;
USE UniversityDB;

-- Drop child table before parent tables so the script can be rerun.
DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Departments;

-- 1. Create Departments table (parent table)
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE
);

-- 2. Create Students table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Age INT NOT NULL CHECK (Age >= 16),
    DepartmentID INT NOT NULL,
    CONSTRAINT fk_students_department
        FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
);

-- 3. Create Courses table (each row represents one course enrollment)
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    StudentID INT NOT NULL,
    CONSTRAINT fk_courses_student
        FOREIGN KEY (StudentID)
        REFERENCES Students(StudentID)
);

-- Insert at least 5 departments
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'Computer Science'),
(2, 'Information Technology'),
(3, 'Mathematics'),
(4, 'Business Administration'),
(5, 'Electronics');

-- Insert at least 5 students
INSERT INTO Students (StudentID, Name, Age, DepartmentID) VALUES
(101, 'Alice Johnson', 20, 1),
(102, 'Bob Smith', 22, 1),
(103, 'Charlie Brown', 21, 2),
(104, 'Diana Prince', 23, 3),
(105, 'Ethan Hunt', 20, 4),
(106, 'Farah Khan', 24, 1),
(107, 'George Miller', 22, 5),
(108, 'Hannah Lee', 19, 2);

-- Insert at least 5 course/enrollment records.
-- A student may appear more than once to represent multiple courses.
INSERT INTO Courses (CourseID, CourseName, StudentID) VALUES
(201, 'Artificial Intelligence', 101),
(202, 'Data Science Fundamentals', 101),
(203, 'Database Management Systems', 102),
(204, 'Big Data Analytics', 102),
(205, 'Artificial Intelligence', 103),
(206, 'Data Visualization', 106),
(207, 'Machine Learning', 106),
(208, 'Web Development', 104),
(209, 'Business Analytics', 105),
(210, 'Data Structures', 107);

-- ============================================================
-- QUERY 1 (a): Retrieve all student details with department names
-- ============================================================
SELECT
    s.StudentID,
    s.Name,
    s.Age,
    s.DepartmentID,
    d.DepartmentName
FROM Students AS s
INNER JOIN Departments AS d
    ON s.DepartmentID = d.DepartmentID
ORDER BY s.StudentID;

-- ============================================================
-- QUERY 2 (b): Students enrolled in 'Artificial Intelligence'
-- ============================================================
SELECT DISTINCT s.Name
FROM Students AS s
INNER JOIN Courses AS c
    ON s.StudentID = c.StudentID
WHERE c.CourseName = 'Artificial Intelligence'
ORDER BY s.Name;

-- ============================================================
-- QUERY 3 (c): Count students in each department (including zero)
-- ============================================================
SELECT
    d.DepartmentName,
    COUNT(s.StudentID) AS StudentCount
FROM Departments AS d
LEFT JOIN Students AS s
    ON d.DepartmentID = s.DepartmentID
GROUP BY d.DepartmentID, d.DepartmentName
ORDER BY d.DepartmentID;

-- ============================================================
-- QUERY 4 (d): Courses taken by Alice Johnson
-- ============================================================
SELECT c.CourseName
FROM Students AS s
INNER JOIN Courses AS c
    ON s.StudentID = c.StudentID
WHERE s.Name = 'Alice Johnson'
ORDER BY c.CourseName;

-- ============================================================
-- QUERY 5 (e): Students enrolled in more than one course
-- ============================================================
SELECT
    s.StudentID,
    s.Name,
    COUNT(c.CourseID) AS CourseCount
FROM Students AS s
INNER JOIN Courses AS c
    ON s.StudentID = c.StudentID
GROUP BY s.StudentID, s.Name
HAVING COUNT(c.CourseID) > 1
ORDER BY s.StudentID;

-- ============================================================
-- QUERY 6 (f): Average age of students in each department
-- ============================================================
SELECT
    d.DepartmentName,
    ROUND(AVG(s.Age), 2) AS AverageAge
FROM Departments AS d
LEFT JOIN Students AS s
    ON d.DepartmentID = s.DepartmentID
GROUP BY d.DepartmentID, d.DepartmentName
ORDER BY d.DepartmentID;

-- ============================================================
-- QUERY 7 (g): Department(s) with the most students (handles ties)
-- ============================================================
WITH DepartmentCounts AS (
    SELECT
        d.DepartmentID,
        d.DepartmentName,
        COUNT(s.StudentID) AS StudentCount
    FROM Departments AS d
    LEFT JOIN Students AS s
        ON d.DepartmentID = s.DepartmentID
    GROUP BY d.DepartmentID, d.DepartmentName
)
SELECT DepartmentName, StudentCount
FROM DepartmentCounts
WHERE StudentCount = (SELECT MAX(StudentCount) FROM DepartmentCounts);

-- ============================================================
-- QUERY 8 (h): Students NOT enrolled in any course
-- ============================================================
SELECT s.StudentID, s.Name
FROM Students AS s
LEFT JOIN Courses AS c
    ON s.StudentID = c.StudentID
WHERE c.CourseID IS NULL
ORDER BY s.StudentID;

-- ============================================================
-- QUERY 9 (i): Students with total number of courses
-- Includes students with zero courses
-- ============================================================
SELECT
    s.StudentID,
    s.Name,
    COUNT(c.CourseID) AS TotalCourses
FROM Students AS s
LEFT JOIN Courses AS c
    ON s.StudentID = c.StudentID
GROUP BY s.StudentID, s.Name
ORDER BY s.StudentID;

-- ============================================================
-- QUERY 10 (j): Computer Science students taking a course with 'Data'
-- in the course name
-- ============================================================
SELECT DISTINCT s.StudentID, s.Name, c.CourseName
FROM Students AS s
INNER JOIN Departments AS d
    ON s.DepartmentID = d.DepartmentID
INNER JOIN Courses AS c
    ON s.StudentID = c.StudentID
WHERE d.DepartmentName = 'Computer Science'
  AND c.CourseName LIKE '%Data%'
ORDER BY s.StudentID, c.CourseName;

-- ============================================================
-- Optional validation checks
-- ============================================================
SELECT COUNT(*) AS DepartmentRecords FROM Departments;
SELECT COUNT(*) AS StudentRecords FROM Students;
SELECT COUNT(*) AS CourseEnrollmentRecords FROM Courses;
