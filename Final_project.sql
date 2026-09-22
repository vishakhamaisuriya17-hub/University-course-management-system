--Q1--
--Create/Insert--

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    BirthDate DATE,
    EnrollmentDate DATE
);

INSERT INTO Students VALUES
(1, 'John', 'Doe', 'john.doe@gmail.com', '2000-01-15', '2022-08-01'),
(2, 'Jane', 'Smith', 'jane.smith@gmail.com', '1999-05-25', '2021-08-01'),
(3, 'Rahul', 'Patel', 'rahul.patel@gmail.com', '2001-03-12', '2023-07-15'),
(4, 'Priya', 'Shah', 'priya.shah@gmail.com', '2000-11-20', '2024-06-10'),
(5, 'Amit', 'Mehta', 'amit.mehta@gmail.com', '1998-09-18', '2020-07-20'),
(6, 'Neha', 'Joshi', 'neha.joshi@gmail.com', '2002-02-14', '2025-07-01'),
(7, 'Ravi', 'Desai', 'ravi.desai@gmail.com', '1999-12-05', '2022-01-10'),
(8, 'Sneha', 'Patel', 'sneha.patel@gmail.com', '2001-07-22', '2023-01-15'),
(9, 'Karan', 'Sharma', 'karan.sharma@gmail.com', '2000-04-30', '2024-01-05'),
(10, 'Pooja', 'Verma', 'pooja.verma@gmail.com', '2002-10-11', '2025-01-20');


CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

INSERT INTO Departments VALUES
(1, 'Computer Science'),
(2, 'Mathematics'),
(3, 'Physics'),
(4, 'Chemistry'),
(5, 'Biology'),
(6, 'Commerce'),
(7, 'English'),
(8, 'Statistics'),
(9, 'Economics'),
(10, 'Information Technology');


CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    DepartmentID INT,
    Credits INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

INSERT INTO Courses VALUES
(101, 'Introduction to SQL', 1, 3),
(102, 'Data Structures', 1, 4),
(103, 'Calculus', 2, 4),
(104, 'Linear Algebra', 2, 3),
(105, 'Physics Fundamentals', 3, 4),
(106, 'Organic Chemistry', 4, 3),
(107, 'Biology Basics', 5, 3),
(108, 'Business Accounting', 6, 4),
(109, 'Statistics', 8, 3),
(110, 'Web Development', 10, 4);


CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    DepartmentID INT,
    Salary DECIMAL(10,2),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

INSERT INTO Instructors VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@univ.com', 1, 65000),
(2, 'Bob', 'Lee', 'bob.lee@univ.com', 2, 72000),
(3, 'Carol', 'Williams', 'carol.williams@univ.com', 1, 68000),
(4, 'David', 'Brown', 'david.brown@univ.com', 3, 60000),
(5, 'Emma', 'Davis', 'emma.davis@univ.com', 4, 62000),
(6, 'Frank', 'Miller', 'frank.miller@univ.com', 5, 58000),
(7, 'Grace', 'Wilson', 'grace.wilson@univ.com', 6, 67000),
(8, 'Henry', 'Moore', 'henry.moore@univ.com', 8, 75000),
(9, 'Ivy', 'Taylor', 'ivy.taylor@univ.com', 9, 70000),
(10, 'Jack', 'Anderson', 'jack.anderson@univ.com', 10, 64000);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

INSERT INTO Enrollments VALUES
(1, 1, 101, '2022-08-01'),
(2, 1, 102, '2022-08-02'),

(3, 2, 101, '2021-08-01'),
(4, 2, 102, '2021-08-02'),

(5, 3, 101, '2023-07-15'),
(6, 3, 103, '2023-07-16'),

(7, 4, 101, '2024-06-10'),
(8, 5, 101, '2020-07-20'),

(9, 6, 102, '2025-07-01'),
(10, 7, 102, '2022-01-10');

--Read--
SELECT * FROM Students;
SELECT * FROM Courses;
SELECT * FROM Instructors;
SELECT * FROM Enrollments;
SELECT * FROM Departments;

-- Q2
SELECT *
FROM Students
WHERE EnrollmentDate > '2022-12-31';


-- Q3
SELECT c.CourseID,
       c.CourseName,
       c.DepartmentID,
       c.Credits
FROM Courses c
JOIN Departments d
ON c.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Mathematics'
LIMIT 5;


-- Q4
SELECT c.CourseID,
       c.CourseName,
       COUNT(e.StudentID) AS NumberOfStudents
FROM Courses c
JOIN Enrollments e
ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName
HAVING COUNT(e.StudentID) > 2;


-- Q5
SELECT s.StudentID,
       s.FirstName,
       s.LastName
FROM Students s
JOIN Enrollments e
ON s.StudentID = e.StudentID
JOIN Courses c
ON e.CourseID = c.CourseID
WHERE c.CourseName IN ('Introduction to SQL', 'Data Structures')
GROUP BY s.StudentID, s.FirstName, s.LastName
HAVING COUNT(DISTINCT c.CourseName) = 2;


-- Q6
SELECT AVG(Credits) AS Average_Credits
FROM Courses;


-- Q7
SELECT MAX(i.Salary) AS Maximum_Salary
FROM Instructors i
JOIN Departments d
ON i.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Computer Science';


-- Q9
SELECT d.DepartmentID,
       d.DepartmentName,
       COUNT(i.InstructorID) AS NumberOfInstructors
FROM Departments d
LEFT JOIN Instructors i
ON d.DepartmentID = i.DepartmentID
GROUP BY d.DepartmentID, d.DepartmentName;


-- Q10
SELECT s.StudentID,
       s.FirstName,
       s.LastName,
       c.CourseID,
       c.CourseName
FROM Students s
INNER JOIN Enrollments e
ON s.StudentID = e.StudentID
INNER JOIN Courses c
ON e.CourseID = c.CourseID;


-- Q11
SELECT s.StudentID,
       s.FirstName,
       s.LastName,
       c.CourseID,
       c.CourseName
FROM Students s
LEFT JOIN Enrollments e
ON s.StudentID = e.StudentID
LEFT JOIN Courses c
ON e.CourseID = c.CourseID;


-- Q12
SELECT DISTINCT
       s.StudentID,
       s.FirstName,
       s.LastName
FROM Students s
JOIN Enrollments e
ON s.StudentID = e.StudentID
WHERE e.CourseID IN
(
    SELECT CourseID
    FROM Enrollments
    GROUP BY CourseID
    HAVING COUNT(StudentID) > 2
);


-- Q13
SELECT StudentID,
       FirstName,
       LastName,
       EnrollmentDate,
       extract(YEAR from EnrollmentDate) AS EnrollmentYear
FROM Students;


-- Q14
SELECT InstructorID,
       CONCAT(FirstName, ' ', LastName) AS InstructorName
FROM Instructors;


-- Q15
SELECT EnrollmentID,
       StudentID,
       CourseID,
       EnrollmentDate,
       COUNT(*) OVER (
           ORDER BY EnrollmentDate, EnrollmentID
       ) AS Running_Total
FROM Enrollments
ORDER BY EnrollmentDate, EnrollmentID;


-- Q16
SELECT 
    studentid,
    firstname,
    lastname,
    enrollmentdate,
    CASE 
        WHEN enrollmentdate < CURRENT_DATE - INTERVAL '4 years'
        THEN 'Senior'
        ELSE 'Junior'
    END AS student_status
FROM students;


