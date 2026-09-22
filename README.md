# 🎓 University Course Management System

A relational database project built in **SQL** that models a complete **University Course Management System** — covering student records, departments, courses, instructors, and enrollments. This project demonstrates database design principles, data integrity through foreign key relationships, and a wide range of SQL querying techniques used in real-world academic data management.

---

## 📖 Table of Contents

- [Project Overview](#-project-overview)
- [Database Schema](#️-database-schema)
- [Entity Relationship Diagram](#-entity-relationship-diagram)
- [Tech Stack](#️-tech-stack)
- [Sample Data](#-sample-data)
- [Queries & Concepts Implemented](#-queries--concepts-implemented)
- [How to Run](#-how-to-run)
- [Project Structure](#-project-structure)
- [Sample Insights](#-sample-insights-you-can-derive)
- [Future Improvements](#-future-improvements)
- [Author](#-author)
- [License](#-license)

---

## 📌 Project Overview

This project simulates a real-world university database system that manages:

- **Students** — personal details, email, birth date, and enrollment date
- **Departments** — the various academic departments in the university
- **Courses** — course catalog linked to departments, with credit hours
- **Instructors** — faculty details linked to departments, including salary
- **Enrollments** — the bridge table tracking which students are enrolled in which courses, and when

The goal of this project is to demonstrate strong SQL fundamentals — from schema design and normalization to writing efficient queries involving joins, subqueries, aggregate functions, window functions, and conditional logic — solving problems that mirror real academic administration use cases (e.g., tracking enrollment trends, department staffing, and student progress).

---

## 🗂️ Database Schema

### `Students`
| Column | Type | Description |
|---|---|---|
| StudentID | INT (PK) | Unique student identifier |
| FirstName | VARCHAR(50) | Student's first name |
| LastName | VARCHAR(50) | Student's last name |
| Email | VARCHAR(100) | Student's email address |
| BirthDate | DATE | Student's date of birth |
| EnrollmentDate | DATE | Date the student first enrolled |

### `Departments`
| Column | Type | Description |
|---|---|---|
| DepartmentID | INT (PK) | Unique department identifier |
| DepartmentName | VARCHAR(100) | Name of the department |

### `Courses`
| Column | Type | Description |
|---|---|---|
| CourseID | INT (PK) | Unique course identifier |
| CourseName | VARCHAR(100) | Name of the course |
| DepartmentID | INT (FK) | References `Departments.DepartmentID` |
| Credits | INT | Number of credit hours for the course |

### `Instructors`
| Column | Type | Description |
|---|---|---|
| InstructorID | INT (PK) | Unique instructor identifier |
| FirstName | VARCHAR(50) | Instructor's first name |
| LastName | VARCHAR(50) | Instructor's last name |
| Email | VARCHAR(100) | Instructor's email address |
| DepartmentID | INT (FK) | References `Departments.DepartmentID` |
| Salary | DECIMAL(10,2) | Instructor's salary |

### `Enrollments`
| Column | Type | Description |
|---|---|---|
| EnrollmentID | INT (PK) | Unique enrollment record identifier |
| StudentID | INT (FK) | References `Students.StudentID` |
| CourseID | INT (FK) | References `Courses.CourseID` |
| EnrollmentDate | DATE | Date the student enrolled in that course |

---

## 🔗 Entity Relationship Diagram

```
Departments (1) ───< (many) Courses
Departments (1) ───< (many) Instructors
Students (1) ───< (many) Enrollments >─── (many) Courses
```

- One **Department** can have many **Courses** and many **Instructors**
- One **Student** can have many **Enrollments**
- One **Course** can have many **Enrollments**
- `Enrollments` acts as a **many-to-many bridge table** between `Students` and `Courses`

---

## ⚙️ Tech Stack

- **Language:** SQL (PostgreSQL-compatible syntax)
- **Database Concepts:** DDL, DML, Primary/Foreign Keys, Referential Integrity
- **Query Concepts:** Inner & Left Joins, Aggregate Functions, GROUP BY / HAVING, Subqueries, Window Functions, CASE Expressions, Date/String Functions

---

## 🧾 Sample Data

The database is pre-populated with sample records for demonstration and testing purposes:

| Table | Records |
|---|---|
| Students | 10 |
| Departments | 10 |
| Courses | 10 |
| Instructors | 10 |
| Enrollments | 10 |

This gives enough variety to meaningfully test joins, grouping, and filtering logic across departments, courses, and student activity.

---

## 🔍 Queries & Concepts Implemented

Each query below is written to solve a specific analytical or reporting question a university administrator might ask.

| # | Query Purpose | Concepts Used |
|---|---|---|
| Q2 | Find students who enrolled after Dec 31, 2022 | `WHERE`, date filtering |
| Q3 | List all courses offered by the Mathematics department | `JOIN`, `LIMIT` |
| Q4 | Find courses with more than 2 enrolled students | `JOIN`, `GROUP BY`, `HAVING` |
| Q5 | Find students enrolled in both "Intro to SQL" and "Data Structures" | Multi-table `JOIN`, `HAVING COUNT(DISTINCT ...)` |
| Q6 | Calculate the average number of credits across all courses | `AVG()` aggregate function |
| Q7 | Find the highest-paid instructor in Computer Science | `JOIN`, `MAX()` |
| Q9 | Count instructors per department (including departments with zero) | `LEFT JOIN`, `GROUP BY` |
| Q10 | List every student with the courses they are enrolled in | `INNER JOIN` (only matched records) |
| Q11 | List every student, including those with no enrollments | `LEFT JOIN` (all students, unmatched = NULL) |
| Q12 | Find distinct students enrolled in high-demand courses (3+ students) | Subquery in `WHERE IN`, `HAVING` |
| Q13 | Extract the enrollment year from each student's enrollment date | `EXTRACT(YEAR FROM ...)` |
| Q14 | Combine instructor first and last names into one field | `CONCAT()` |
| Q15 | Calculate a running total of enrollments ordered by date | Window function: `COUNT(*) OVER (ORDER BY ...)` |
| Q16 | Classify students as "Senior" or "Junior" based on enrollment date | `CASE WHEN`, `INTERVAL`, `CURRENT_DATE` |

### 💡 Highlighted Query Examples

**Running Total of Enrollments (Window Function)**
```sql
SELECT EnrollmentID, StudentID, CourseID, EnrollmentDate,
       COUNT(*) OVER (ORDER BY EnrollmentDate, EnrollmentID) AS Running_Total
FROM Enrollments
ORDER BY EnrollmentDate, EnrollmentID;
```

**Classifying Students by Tenure (CASE Expression)**
```sql
SELECT studentid, firstname, lastname, enrollmentdate,
       CASE 
           WHEN enrollmentdate < CURRENT_DATE - INTERVAL '4 years' THEN 'Senior'
           ELSE 'Junior'
       END AS student_status
FROM students;
```

**Students Enrolled in High-Demand Courses (Subquery)**
```sql
SELECT DISTINCT s.StudentID, s.FirstName, s.LastName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.CourseID IN (
    SELECT CourseID FROM Enrollments
    GROUP BY CourseID
    HAVING COUNT(StudentID) > 2
);
```

---

## 🚀 How to Run

1. **Clone the repository**
   ```bash
   git clone https://github.com/vishakhamaisuriya17-hub/University-course-management-system.git
   cd University-course-management-system
   ```

2. **Set up a database**
   Use PostgreSQL (recommended) or any SQL engine with minor syntax adjustments.
   ```bash
   createdb university_course_db
   Or Create database university_course_db
   ```

3. **Run the SQL script**
   Execute the script in order using `psql`, pgAdmin, or any SQL IDE:
   ```bash
   psql -d university_course_db -f university_course_management.sql
   ```
   This will:
   - Create all five tables with proper constraints
   - Insert sample data
   - Allow you to run the analytical queries (Q2–Q16) individually

4. **Explore the queries**
   Run each query section independently to explore different reporting scenarios.

---

## 📁 Project Structure

```
University-course-management-system/
│
├── university_course_management.sql   # Full schema, data, and queries
└── README.md                          # Project documentation
└── Final_project_outputs              # Query outputs
```

---

## 📈 Sample Insights You Can Derive

- 📊 Which courses have the highest enrollment demand
- 🏫 Department-wise distribution of instructors and staffing gaps
- 🎓 Students enrolled across multiple overlapping courses
- 💰 Salary trends and the highest earners by department
- 📅 Year-over-year enrollment growth using running totals
- 🧑‍🎓 Segmentation of students into Senior/Junior cohorts based on tenure

---

## 🔮 Future Improvements

- Add a `Grades` table to track student performance per course
- Add stored procedures/functions for common reporting tasks
- Build a normalized `CourseSchedule` table for semester-wise offerings
- Create a simple front-end (or admin panel) to visualize this data
- Add indexes and query performance benchmarking for larger datasets

---

## 👩‍💻 Author

**Vishakha Maisuriya**
🔗 [GitHub Profile](https://github.com/vishakhamaisuriya17-hub)

---

## 📄 License

This project is open-source and available for learning and educational purposes.
