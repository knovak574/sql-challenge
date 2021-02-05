CREATE TABLE Titles(
	title_id VARCHAR NOT NULL,
	title VARCHAR NOT NULL,
	PRIMARY KEY (title_id)
	);

CREATE TABLE Employees (
	emp_no INTEGER NOT NULL,
	emp_title VARCHAR NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	sex VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no),
	FOREIGN KEY(emp_title) REFERENCES Titles (title_id)
	);
	
CREATE TABLE Salaries (
	emp_no INTEGER,
	salary INTEGER,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
	);
	
CREATE TABLE Departments (
	dept_no VARCHAR,
	dept_name VARCHAR,
	PRIMARY KEY (dept_no)
	);
	
CREATE TABLE dept_manager (
   dept_no VARCHAR   NOT NULL,
   emp_no INT   NOT NULL,
   FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
   FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
   PRIMARY KEY (dept_no, emp_no)
);

CREATE TABLE dept_emp (
   emp_no INT   NOT NULL,
   dept_no VARCHAR   NOT NULL,
   FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
   FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
   PRIMARY KEY (emp_no, dept_no)
);

SELECT * FROM Employees;
SELECT * FROM Salaries

-- query #1
SELECT Employees.emp_no, Employees.last_name, Employees.first_name, Employees.sex, Salaries.salary
FROM Salaries
INNER JOIN Employees ON
Employees.emp_no=Salaries.emp_no;

-- query #2
SELECT Employees.first_name,Employees.last_name,Employees.hire_date FROM Employees WHERE hire_date >='1986-01-01' AND hire_date<'1987-01-01';

-- query #3
SELECT dept_manager.dept_no, Departments.dept_name, dept_manager.emp_no, Employees.last_name, Employees.first_name
FROM dept_manager
INNER JOIN Departments ON
Departments.dept_no=dept_manager.dept_no
INNER JOIN Employees ON
Employees.emp_no=dept_manager.emp_no;

-- query #4
SELECT Employees.emp_no, Employees.last_name, Employees.first_name, Departments.dept_name
FROM Departments
CROSS JOIN Employees;
--Employees.emp_no=Departments.dept_name;

-- Query #5
SELECT first_name, last_name, sex FROM Employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--Query #6
SELECT Employees.emp_no, Employees.last_name, Employees.first_name, dept_emp.dept_no, Departments.dept_name
FROM Employees LEFT JOIN dept_emp
ON Employees.emp_no=dept_emp.emp_no
INNER JOIN Departments 
ON dept_emp.dept_no=Departments.dept_no
WHERE dept_name='Sales';

-- Query #7
SELECT Employees.emp_no, Employees.last_name, Employees.first_name, dept_emp.dept_no, Departments.dept_name
FROM Employees LEFT JOIN dept_emp
ON Employees.emp_no=dept_emp.emp_no
INNER JOIN Departments 
ON dept_emp.dept_no=Departments.dept_no
WHERE Departments.dept_name in('Sales', 'Development');

-- Query #8
SELECT last_name, COUNT(*) as last_name_count
FROM Employees
GROUP BY last_name
ORDER BY last_name_count DESC;
