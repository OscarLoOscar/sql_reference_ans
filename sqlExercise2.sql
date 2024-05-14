use exer1 ;

CREATE TABLE WORKER (
  WORKER_ID INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
  FIRST_NAME CHAR(25),
  LAST_NAME CHAR(25),
  SALARY NUMERIC(15),
  JOINING_DATE DATETIME,
  DEPARTMENT CHAR(25)
);

-- inesrt data to worker
INSERT INTO WORKER 
  (FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
    ('Monika', 'Arora', 100000, '21-02-20 09:00:00', 'HR'),
    ('Niharika', 'Verma', 80000, '21-06-11 09:00:00', 'Admin'),
    ('Vishal', 'Singhal', 300000, '21-02-20 09:00:00', 'HR'),
    ('Mohan', 'Sarah', 300000, '12-03-19 09:00:00', 'Admin'),
    ('Amitabh', 'Singh', 500000, '21-02-20 09:00:00', 'Admin'),
    ('Vivek', 'Bhati', 490000, '21-06-11 09:00:00', 'Admin'),
    ('Vipul', 'Diwan', 200000, '21-06-11 09:00:00', 'Account'),
    ('Satish', 'Kumar', 75000, '21-01-20 09:00:00', 'Account'),
    ('Geetika', 'Chauhan', 90000, '21-04-11 09:00:00', 'Admin');

SELECT * FROM WORKER;
SELECT * FROM BONUS;
-- create table bonus
CREATE TABLE BONUS (
  WORKER_REF_ID INTEGER,
  BONUS_AMOUNT NUMERIC(10),
  BONUS_DATE DATETIME,
  FOREIGN KEY (WORKER_REF_ID) REFERENCES Worker(WORKER_ID)
);

-- Task 1 
SELECT WORKER_ID , FIRST_NAME 
FROM WORKER;


INSERT INTO BONUS
(WORKER_REF_ID , BONUS_AMOUNT , BONUS_DATE)VALUES
(6,32000,'2021-11-02'),
(6,20000,'2022-11-02'),
(5,21000,'2021-11-02'),
(9,30000,'2021-11-02'),
(8,4500,'2022-11-02');
SELECT * FROM BONUS;

-- Task 1: insert data into table BONUS
-- Vivek, with amount 32000 and bonus date 2021 Nov 02
-- Vivek, with amount 20000 and bonus date 2022 Nov 02
-- Amitabh, with amount 21000 and bonus date 2021 Nov 02
-- Geetika, with amount 30000 and bonus date 2021 Nov 02
-- Satish, with amount 4500 and bonus date 2022 Nov 02

-- Task 2: -- 49000
-- Write an SQL query to show the second highest salary among all workers.
SELECT  MAX(SALARY)
FROM WORKER 
WHERE SALARY NOT IN(
 SELECT MAX(SALARY)
FROM WORKER )
;

SELECT * FROM WORKER
ORDER BY SALARY DESC
LIMIT 1 
OFFSET 1;
-- Task 3:
-- Write an SQL query to print the name of employees having the highest salary in each department.


SELECT w1.FIRST_NAME,w1.SALARY , MAX_SALARY_IN_EACH_DEPARTMENT.DEPARTMENT
FROM WORKER w1, 
(SELECT DEPARTMENT , MAX(SALARY)AS MAX_SALARY  -- the highest salary in each department
FROM WORKER
GROUP BY DEPARTMENT) MAX_SALARY_IN_EACH_DEPARTMENT
WHERE  w1.DEPARTMENT = MAX_SALARY_IN_EACH_DEPARTMENT.DEPARTMENT
AND w1.SALARY = MAX_SALARY_IN_EACH_DEPARTMENT.MAX_SALARY;

-- Task 4:
-- Write an SQL query to fetch the list of employees with the same salary.

SELECT w1.FIRST_NAME , w1.LAST_NAME , w1.SALARY
FROM WORKER w1 ,
(SELECT SALARY FROM WORKER
GROUP BY SALARY 
HAVING COUNT(SALARY)>1) AS SAME_SALARY
WHERE w1.SALARY = SAME_SALARY.SALARY;
; 

-- Task 5:
-- Write an SQL query to find the worker names with salaries + bonus in 2021

SELECT w1.FIRST_NAME , w1.LAST_NAME , w1.SALARY AS BASE_SALARY ,IFNULL(BONUS_TABLE.BONUS,0) AS SALARY_WITH_BONUS_IN_2021
FROM WORKER w1 ,
(SELECT WORKER_REF_ID ,SUM(BONUS_AMOUNT) AS BONUS , DATE_FORMAT("2021-01-01","%Y")
FROM BONUS
GROUP BY WORKER_REF_ID) AS BONUS_TABLE
WHERE w1.WORKER_ID = BONUS_TABLE.WORKER_REF_ID;

-- Task 6 (Please complete Task 1-5 first):
-- Your actions: Delete all the records in table WORKER
-- Question: Study the reason why the data cannot be deleted
SELECT * FROM BONUS;
TRUNCATE BONUS;
SELECT * FROM BONUS;

-- Error Code: 1701. Cannot truncate a table referenced in a foreign key constraint (`exer1`.`BONUS`, CONSTRAINT `bonus_ibfk_1`)
ALTER TABLE BONUS DROP FOREIGN KEY BONUS_IBFK_1;

TRUNCATE WORKER;
SELECT * FROM WORKER;

-- Task 7 (Please complete Task 6 first):
-- Your action: Drop table WORKER
-- Question: Study the reason why the table cannot be dropped
DROP TABLE WORKER;