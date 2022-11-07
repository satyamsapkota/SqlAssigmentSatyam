
/* 1.   Create a new Schema and keep the schema for all the sql exam. 
Name of the schema would be ‘zorba_sql_exam’. Make sure this schema will only be used for this table creation purpose.
 2.   Create 2 tables: Write Create and insert statement for below tables with primary key and foreign key syntax.
 Department: column as (dept_id(PK), dept_name, dept_location)
    Employees : column as (emp_id(PK) , emp_name, job_name, manager_id, hire_date, salary, commission, dept_id(FK))
Sample data below
Department:
-----------
dep_id |  dep_name  | dep_locationdepartment
--------+------------+--------------
   1001 | FINANCE    | SYDNEY
   2001 | AUDIT      | MELBOURNE
   3001 | MARKETING  | PERTH
   4001 | PRODUCTION | BRISBANE
Employees:
----------
emp_id | emp_name | job_name | hire_date | salary  | dep_id
--------+----------+-----------+------------+------------+---------
  68319 | KAYLING | PRESIDENT |   1991-11-18 | 6000.00 | 1001
  66928 | BLAZE    | MANAGER   |    1991-05-01 | 2750.00 | 3001
  67832 | CLARE    | MANAGER   |    1991-06-09 | 2550.00 | 1001
  65646 | JONAS    | MANAGER   |   1991-04-02 | 2957.00 | 2001
  67858 | SCARLET | ANALYST   |    1997-04-19 | 3100.00 |2001       
  
3. Add Not null constraints on dep_name and job_name column.
4.  Add Check constraints on dept_location as location can’t be other than ‘SYDNEY’, ‘MELBOURNE’, ‘PERTH’, ‘BRISBANE’.
5.  Fetch employee information of those whose name contains ‘LA’ in any position.
6.  Fetch employee information and average salary based on department id and average salary more than 2000.
7.  Fetch employee information whose hire date after 1991-05-03 and sum of the salary based on department id.
8.  Fetch employee details of whom job name is Manager, hire date before 1st May, 1991 and salary is more than 2800.

  */

/* create table Department ( dept_id int (20) primary key, dept_name char (20) , dept_location char (20)); */
create table Department ( dept_id int (20) , dept_name char (20) , dept_location char (20), primary key(dept_id)); 
/*create table Department ( dept_id int (20) , dept_name char (20) , dept_location char (20), constraint dept_id_pk primary key(dept_id)); */
drop table Department;
select  *  from  Department;


/* Employees : column as (emp_id(PK) , emp_name, job_name, manager_id, hire_date, salary, commission, dept_id(FK))*/
 create table Employees (emp_id int (20) primary key , emp_name char (20), job_name char (20) , manager_id int (10), hire_date date  ,
 salary int (20), commission int (20), dept_id int (20), foreign key (dept_id) references department(dept_id)); 

select * from employees;

insert into department( dept_id, dept_name, dept_location) values 
( 1001, 'FINANCE' , 'SYDNEY' ),
(  2001, 'AUDIT' , 'MELBOURNE'),
( 3001, 'MARKETING', 'PERTH'),
(4001,  'PRODUCTION', 'BRISBANE');

alter table employees modify hire_date datetime; 
alter table employees modify salary double(20,2);

insert into Employees ( emp_id,emp_name, job_name, hire_date, salary, dept_id) values  
(68319,'KAYLING', 'PRESIDENT', '1991-11-18', 6000.00, 1001),
(66928, 'BLAZE', 'MANAGER', '1991-05-01', 2750.00, 3001),
(67832, 'CLARE', 'MANAGER', '1991-06-09', 2550.00, 1001),
(65646, 'JONAS', 'MANAGER', '1991-04-02', 2957.00, 2001),
(67858, 'SCARLET', 'ANALYST', '1997-04-19', 3100.00, 2001);   
   
/*3. Add Not null constraints on dep_name and job_name column.*/

alter table department modify dept_name char(20) not null; 
alter table employees modify job_name char (20) not null;

/*Add Check constraints on dept_location as location can’t be other than 
‘SYDNEY’, ‘MELBOURNE’, ‘PERTH’, ‘BRISBANE’.*/

alter table department add constraint location check (dept_location
 in ('SYDNEY', 'MELBOURNE', 'PERTH', 'BRISBANE'));

insert into department  values (5001, 'Audit', 'Sydney');
insert into department  values (6002, 'Audit', 'Texas');
delete from department where dept_id = 6002;

/* 7   Fetch employee information of those whose name contains ‘LA’ in any position. */
select * from employees where emp_name like '%la%';


/* Fetch employee information and average salary based on
 department id and average salary more than 2000.*/

select avg(salary) as Average_Salary, dept_id from employees 
group by dept_id having Average_Salary > 2000;

/* Fetch employee information whose hire date after 1991-05-03 
and sum of the salary based on department id. */

select sum(salary), emp_id, emp_name, job_name, manager_id, hire_date 
from employees where  hire_date > '1991-05-03' group by dept_id;

/* 8. Fetch employee details of whom job name is Manager, hire date 
before 1st May, 1991 and salary is more than 2800.*/

select * from employees where job_name = 'Manager' AND hire_date < '1991-05-01'
and salary > 2800;


/* 11-06-2022 exam */

/*. 1 */
ALTER TABLE employees
  ADD manager_id int(10);
  ALTER TABLE employees 
  ADD commission decimal(7,2);
  

/*. 3 */
create table Salary_grade (
      id_grade primary key
     NOT NULL auto increasement
     );


/*. 4 */
insert into salary_grade ( grade, min_salary, max_salary) values  
(1, 800, 1300),
(2, 1301, 1500),
(3, 1501, 2100),
(4, 2101, 3100),
(5, 3101, 9999);



/*. 5 */
SELECT *
FROM employees
WHERE salary >
    (SELECT salary
     FROM employees
     WHERE emp_name = 'JONAS');
     
/*. 6 */
SELECT *
FROM employees
WHERE job_name =
    (SELECT job_name
     FROM employees
     WHERE emp_name = 'FRANK');




/*. 7 */
SELECT *
FROM employees e,
     department d
WHERE d.dep_id = 2001
  AND e.dep_id = d.dep_id
  AND e.job_name IN
    (SELECT e.job_name
     FROM employees e,
          department d
     WHERE e.dep_id = d.dep_id
       AND d.dep_id =1001);



/*. 8 */
SELECT *
FROM employees
WHERE hire_date <
    (SELECT hire_date
     FROM employees
     WHERE emp_name = 'ADELYN');









