-- Employee Database Analysis
-- PostgreSQL

CREATE DATABASE employee_analysis;

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department_id INT,
    salary NUMERIC(10,2),
    joining_date DATE,
    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
);

INSERT INTO departments VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Sales'),
(5, 'Marketing');

INSERT INTO employees VALUES
(101, 'Arun', 1, 45000, '2022-04-10'),
(102, 'Priya', 1, 55000, '2023-06-15'),
(103, 'Rahul', 1, 65000, '2024-01-20'),
(104, 'Sneha', 1, 40000, '2025-03-12'),
(105, 'Karthik', 1, 72000, '2021-08-05'),
(106, 'Divya', 1, 52000, '2025-07-19'),

(107, 'Vijay', 2, 85000, '2022-02-11'),
(108, 'Anjali', 2, 95000, '2023-04-25'),
(109, 'Ramesh', 2, 75000, '2024-09-15'),
(110, 'Meena', 2, 105000, '2025-01-08'),
(111, 'Sanjay', 2, 90000, '2021-11-30'),
(112, 'Keerthi', 2, 68000, '2025-08-10'),
(113, 'Ajay', 2, 110000, '2026-02-14'),

(114, 'Lakshmi', 3, 60000, '2022-07-21'),
(115, 'Manoj', 3, 70000, '2023-12-05'),
(116, 'Deepak', 3, 80000, '2024-05-18'),
(117, 'Nisha', 3, 55000, '2025-04-22'),
(118, 'Varun', 3, 90000, '2021-03-17'),
(119, 'Pooja', 3, 75000, '2026-06-09'),

(120, 'Bala', 4, 48000, '2022-10-13'),
(121, 'Swathi', 4, 58000, '2023-02-28'),
(122, 'Mohan', 4, 62000, '2024-11-19'),
(123, 'Gokul', 4, 45000, '2025-05-16'),
(124, 'Harini', 4, 70000, '2021-09-08'),
(125, 'Dinesh', 4, 52000, '2026-03-11'),

(126, 'Yamini', 5, 65000, '2022-05-14'),
(127, 'Abinaya', 5, 75000, '2023-08-23'),
(128, 'Suresh', 5, 55000, '2024-07-30'),
(129, 'Fathima', 5, 85000, '2025-02-17'),
(130, 'Naveen', 5, 60000, '2021-12-12'),
(131, 'Riya', 5, 90000, '2026-09-02');

-- Q1. Find employees earning more than 50,000.

SELECT employee_name, salary
FROM employees
WHERE salary > 50000;


-- Q2. Find the highest-paid employee in each department.

SELECT 
    d.department_name,
    e.employee_name,
    e.salary
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
WHERE e.salary = (
    SELECT MAX(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
);


-- Q3. Calculate the average salary of each department.

SELECT 
    d.department_name,
    AVG(e.salary) AS average_salary
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
GROUP BY d.department_name;


-- Q4. Find employees who joined in the last 2 years.

SELECT 
    employee_name,
    joining_date
FROM employees
WHERE joining_date >= CURRENT_DATE - INTERVAL '2 years';


-- Q5. Find employees earning more than the company average.

SELECT 
    employee_name,
    salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);


-- Q6. Count employees in each department.

SELECT 
    d.department_name,
    COUNT(e.employee_id) AS employee_count
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
GROUP BY d.department_name;


-- Q7. Find departments with more than 5 employees.

SELECT 
    d.department_name,
    COUNT(e.employee_id) AS employee_count
FROM departments d
JOIN employees e
    ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING COUNT(e.employee_id) > 5;


-- Q8. Rank employees based on salary.

SELECT 
    employee_name,
    salary,
    RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;


-- Q9. Find the second-highest salary.

SELECT MAX(salary) AS second_highest_salary
FROM employees
WHERE salary < (
    SELECT MAX(salary)
    FROM employees
);


-- Q10. Calculate total salary expenditure by department.

SELECT 
    d.department_name,
    SUM(e.salary) AS total_salary
FROM departments d
JOIN employees e
    ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY total_salary DESC;
