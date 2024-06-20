/*  1) Create a database named employee, 
then import data_science_team.csv proj_table.csv 
and emp_record_table.csv into the employee database 
from the given resources.*/
create database Employee;

/* 2) Create an ER diagram for the given employee database.*/
-- Was created

/*  3) Write a query to fetch 
EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT 
from the employee record table, and
make a list of employees and details of their department.*/
create view Employees_and_details_of_their_department
 as select emp_id,first_name,LAST_NAME, GENDER,DEPt 
 from emp_record_table;
 
 /* 4) Write a query to fetch
 EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING
 if the EMP_RATING is: 
less than two
greater than four 
between two and four*/
select emp_id,first_name,last_name,gender,dept,emp_rating from emp_record_table where EMP_RATING < 2;
select emp_id,first_name,last_name,gender,dept,emp_rating from emp_record_table where EMP_RATING > 4;
select emp_id,first_name,last_name,gender,dept,emp_rating from emp_record_table where EMP_RATING between 2 and 4;

/* 5) Write a query to concatenate 
the FIRST_NAME and the LAST_NAME of employees in the Finance department 
from the employee table and 
then give the resultant column alias as NAME.*/

select first_name,last_name,concat(first_name," ",last_name) as 'Name',Dept 
from emp_record_table where Dept = 'Finance';

/* 6) Write a query to list only those employees who have someone reporting to them. 
Also, show the number of reporters (including the President).*/
select
    e1.FIRST_NAME, e1.LAST_NAME, COUNT(e2.EMP_ID) AS Number_of_Reporters
from emp_record_table e1
JOIN emp_record_table e2 ON e1.EMP_ID = e2.MANAGER_ID
group by e1.FIRST_NAME,e1.LAST_NAME
having COUNT(e2.EMP_ID) > 0;

/* 7) Write a query to list down 
all the employees from the healthcare and finance departments
 using union. Take data from the employee record table.*/
 
 select * from emp_record_table where Dept = 'Healthcare'
 union
 select * from emp_record_table where Dept = 'finance'
 order by dept;
 
/* 8) Write a query to list down employee details such as
 EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept.
 Also include the respective employee rating along 
 with the max emp rating for the department.*/
 
 select e.emp_id,e.first_name,e.last_name,e.dept,e.emp_rating,m.max_rating
 from emp_record_table e join 
 (select dept,max(emp_rating) max_rating from emp_record_table group by dept) m 
 on e.dept=m.dept
 order by e.dept;

/* 9) Write a query to calculate the minimum and the maximum salary of the employees
 in each role. Take data from the employee record table.*/
 
 Select Distinct ROLE,max(salary) Max_Salary,min(salary) Min_Salary from emp_record_table
 group by role;
 
 /* 10) Write a query to assign ranks to each employee based on their experience. 
 Take data from the employee record table.*/
select Emp_id,first_name,last_name,exp,
rank() over(ORDER BY exp DESC) RK
from emp_record_table;

/*  11) Write a query to create a view that displays employees in various countries 
whose salary is more than six thousand. 
Take data from the employee record table.*/

create view cUSTOM_vIEW as select eMP_ID,FIRST_NAME,LAST_NAME,SALARY,COUNTRY 
from emp_record_table
where SALARY > 6000;

select * from CUSTOM_VIEW;

/*  12) Write a nested query to find employees with experience of more than ten years. Take data from the employee record table.*/
/*COULD HAVE BEEN DONE IN A VERY SIMPLE WAY*/

select * from emp_record_table where EXP > (select EXP from emp_record_table where EXP =20)/2 ;

/* 13) Write a query to create a stored procedure to retrieve the details of the employees whose experience is more than three years.
 Take data from the employee record table.*/
/*REATE DEFINER=`root`@`localhost` PROCEDURE `Store`()
BEGIN
SELECT * FROM EMP_RECORD_TABLE WHERE EXP > 3 ;
END*/

call store;

/* 14) Write a query using stored functions in the project table to check whether
the job profile assigned to each employee in the data science team matches the organization’s set standard.
The standard being:

For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST',
For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST',
For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST',
For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST',

For an employee with the experience of 12 to 16 years assign 'MANAGER'.*/


/*CREATE DEFINER=`root`@`localhost` FUNCTION `Getjobprofile`(Exp Int) RETURNS varchar(50) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
  DECLARE jobProfile VARCHAR(50);
    IF exp <= 2 THEN
        SET jobProfile = 'JUNIOR DATA SCIENTIST';
    ELSEIF exp > 2 AND exp <= 5 THEN
        SET jobProfile = 'ASSOCIATE DATA SCIENTIST';
    ELSEIF exp > 5 AND exp <= 10 THEN
        SET jobProfile = 'SENIOR DATA SCIENTIST';
    ELSEIF exp > 10 AND exp <= 12 THEN
        SET jobProfile = 'LEAD DATA SCIENTIST';
    ELSEIF exp > 12 AND exp <= 16 THEN
        SET jobProfile = 'MANAGER';
    END IF;
    RETURN jobProfile;
RETURN 1;
END*/

select emp_id,first_name,last_name,exp,Getjobprofile(Exp) as JobProfile from data_science_team;


/*  15) Create an index to improve the cost and performance of the query to
 find the employee whose FIRST_NAME is ‘Eric’ in the employee table 
 after checking the execution plan.*/
 
 Create index idx_first_name on emp_record_table (first_name);
 select * from emp_record_table where first_name = 'Eric';
 
 /* 16 )Write a query to calculate the bonus for all the employees, 
 based on their ratings and salaries (Use the formula: 5% of salary * employee rating).*/
 
 select emp_id,first_name,last_name,Gender,role,dept,exp,salary,emp_rating, CONCAT('$ ',0.05*salary*emp_rating) as Bonus from emp_record_table;
 
 /* 17) Write a query to calculate the average salary distribution based on the continent and country. 
 Take data from the employee record table.*/
 
select Continent, Country, avg(SALARY) as AverageSalaryByCountry, (select avg(salary) from emp_record_table where Continent = e.Continent) as AvgSalaryByContinent
from emp_record_table e
group by  Continent,country
order by Continent;

 
 
 
 


