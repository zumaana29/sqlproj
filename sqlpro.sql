CREATE DATABASE IF NOT EXISTS StudentManagement;
USE StudentManagement;

DROP TABLE IF EXISTS Grades;
DROP TABLE IF EXISTS Enrollments;
DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Students;

CREATE TABLE Students (
    StudentID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    Department VARCHAR(50)
);

CREATE TABLE Courses (
    CourseID INT AUTO_INCREMENT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    Credits INT NOT NULL
);

CREATE TABLE Enrollments (
    EnrollmentID INT AUTO_INCREMENT PRIMARY KEY,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    Semester VARCHAR(10),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID) ON DELETE CASCADE,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON DELETE CASCADE
);

CREATE TABLE Grades (
    GradeID INT AUTO_INCREMENT PRIMARY KEY,
    EnrollmentID INT NOT NULL,
    Grade VARCHAR(2),
    FOREIGN KEY (EnrollmentID) REFERENCES Enrollments(EnrollmentID) ON DELETE CASCADE
);

INSERT INTO Students (Name, Email, Phone, Department) VALUES
('Alice Johnson', 'alice.johnson@example.com', '9876543210', 'Computer Science'),
('Bob Smith', 'bob.smith@example.com', '9123456780', 'Mechanical Engineering'),
('Charlie Brown', 'charlie.brown@example.com', '9988776655', 'Electrical Engineering');

INSERT INTO Courses (CourseName, Credits) VALUES
('Database Systems', 4),
('Data Structures', 3),
('Operating Systems', 4),
('Thermodynamics', 3);

INSERT INTO Enrollments (StudentID, CourseID, Semester) VALUES
(1, 1, 'Fall2025'),
(1, 2, 'Fall2025'),
(2, 4, 'Fall2025'),
(3, 1, 'Fall2025'),
(3, 3, 'Fall2025');

INSERT INTO Grades (EnrollmentID, Grade) VALUES
(1, 'A'),
(2, 'B+'),
(3, 'A-'),
(4, 'B'),
(5, 'A');

SELECT * FROM Students;

SELECT * FROM Courses;

SELECT c.CourseName, e.Semester
FROM Enrollments e
JOIN Courses c ON e.CourseID = c.CourseID
WHERE e.StudentID = 1;

SELECT s.Name, s.Email, e.Semester
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
WHERE e.CourseID = 1;

SELECT c.CourseName, e.Semester, g.Grade
FROM Enrollments e
JOIN Courses c ON e.CourseID = c.CourseID
LEFT JOIN Grades g ON e.EnrollmentID = g.EnrollmentID
WHERE e.StudentID = 1;

SELECT c.CourseName, COUNT(g.Grade) AS GradeCount
FROM Courses c
JOIN Enrollments e ON c.CourseID = e.CourseID
JOIN Grades g ON e.EnrollmentID = g.EnrollmentID
GROUP BY c.CourseName;
