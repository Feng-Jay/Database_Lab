
-- Create the database first.

CREATE DATABASE employees;


-- 按照实验报告要求编写SQL语句

-- 3
-- 用SQL创建关系表
CREATE TABLE employees (
	emp_no INT,
	birth_date DATE,
	first_name CHAR(30),
	last_name CHAR(30),
	gender CHAR(1),
	hire_date DATE
);

CREATE TABLE titles(
	emp_no INT,
	title CHAR(30),
	from_date DATE,
	to_date DATE
);

CREATE TABLE salaries(
	emp_no INT,
	salary INT,
	from_date DATE,
	to_date DATE
);

CREATE TABLE departments(
	dept_no CHAR(10),
	dept_name CHAR(30)
);

CREATE TABLE dept_emp(
	emp_no INT,
	dept_no CHAR(10),
	from_date DATE,
	to_date DATE
);

CREATE TABLE dept_manager(
	dept_no CHAR(10),
	emp_no INT,
	from_date DATE,
	to_date DATE
);

-- 测试创建的空表
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM titles;
SELECT * FROM salaries;

-- 4
COPY employees from 'D:\grade2\db_lab\lab01_student\data_employees.txt'
	with(FORMAT text, DELIMITER ',');
COPY titles from 'D:\grade2\db_lab\lab01_student\data_titles.txt'
	with(FORMAT text, DELIMITER ',');
COPY salaries from 'D:\grade2\db_lab\lab01_student\data_salaries.txt'
	with(FORMAT text, DELIMITER ',');
COPY departments from 'D:\grade2\db_lab\lab01_student\data_departments.txt'
	with(FORMAT text, DELIMITER ',');
COPY dept_emp from 'D:\grade2\db_lab\lab01_student\data_dept_emp.txt'
	with(FORMAT text, DELIMITER ',');
COPY dept_manager from 'D:\grade2\db_lab\lab01_student\data_dept_manager.txt'
	with(FORMAT text, DELIMITER ',');
-- 测试导入数据之后的表
SELECT COUNT(*) FROM employees;
SELECT COUNT(*) FROM departments;
SELECT COUNT(*) FROM dept_emp;
SELECT COUNT(*) FROM dept_manager;
SELECT COUNT(*) FROM titles;
SELECT COUNT(*) FROM salaries;

-- 5.1
SELECT * 
FROM employees
LIMIT 10;

-- 5.2
SELECT emp_no, birth_date,gender, hire_date
FROM employees
WHERE first_name='Peternela' AND last_name='Anick';

-- 5.3
SELECT emp_no, first_name, last_name, birth_date
FROM employees
WHERE birth_date>='1961-07-15'::DATE AND birth_date <= '1961-07-20'::DATE;

-- 5.4
SELECT *
FROM employees
WHERE first_name LIKE'Peter%' OR last_name LIKE 'Peter%';

-- 5.5
SELECT max(salary) as max_salary
FROM salaries

-- 5.6
SELECT dept_no, COUNT(dept_no) AS dept_emp_count 
FROM dept_emp 
GROUP BY dept_no;

-- 5.7
SELECT employees.emp_no, dept_emp.dept_no, dept_emp.from_date
FROM dept_emp, employees
WHERE employees.emp_no = dept_emp.emp_no AND employees.first_name='Peternela' AND employees.last_name='Anick';

-- 5.8
SELECT Aemployees.emp_no, Bemployees.emp_no, Aemployees.first_name, Aemployees.last_name
FROM employees AS Aemployees, employees AS Bemployees
WHERE Aemployees.first_name = Bemployees.first_name AND Aemployees.last_name = Bemployees.last_name 
AND Aemployees.emp_no != Bemployees.emp_no;

-- 5.9
(SELECT employees.emp_no
FROM employees
WHERE employees.first_name='Margo' AND employees.last_name='Anily')
UNION
(SELECT employees.emp_no
FROM employees
WHERE employees.birth_date='1959-10-30'AND employees.hire_date='1989-09-12');

-- 5.10
SELECT dept_name 
FROM departments
WHERE dept_no=(
	SELECT dept_emp.dept_no
	FROM dept_emp
	WHERE dept_emp.emp_no=(
		SELECT employees.emp_no
		FROM employees
		WHERE employees.first_name='Margo' AND employees.last_name='Anily'
	)
);
		
-- 5.11
SELECT departments.dept_name
FROM 
(employees JOIN dept_emp
ON employees.emp_no=dept_emp.emp_no)
JOIN departments
ON dept_emp.dept_no = departments.dept_no

WHERE employees.first_name='Margo' AND employees.last_name='Anily';

-- 5.12
SELECT emp_no, first_name, last_name
FROM employees
WHERE NOT EXISTS (--query有部门没去过的employees
	SELECT * 
	FROM dept_emp
	WHERE NOT EXISTS(
		SELECT *
		FROM departments
		WHERE employees.emp_no=dept_emp.emp_no
		AND departments.dept_no=dept_emp.dept_no
	)
);

-- 5.13
SELECT dept_emp.dept_no, MAX(departments.dept_name) AS dept_name, COUNT(dept_emp.dept_no) AS dept_num_count
FROM departments, dept_emp
WHERE departments.dept_no = dept_emp.dept_no
GROUP BY dept_emp.dept_no HAVING COUNT(emp_no) > 50000;


-- 5.14
INSERT INTO employees(emp_no,birth_date,first_name,last_name,gender,hire_date)
VALUES(10000, '1981-10-1', 'Jimmy', 'Lin', 'M', '2011-12-8');

-- 5.15
UPDATE employees 
SET first_name='Jim'
WHERE emp_no=10000;

-- 5.16
DELETE FROM employees
WHERE emp_no=10000;

-- 5.17
INSERT INTO employees(emp_no,birth_date,first_name,last_name,gender,hire_date)
VALUES(10001, '1981-10-01', 'Jimmy', 'Lin','M', '2011-12-08');

-- 5.18
DELETE FROM employees
WHERE emp_no=10001;
