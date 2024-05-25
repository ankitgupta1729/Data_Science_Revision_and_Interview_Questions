use [FFA_Chartering_DEV];

-------------------------------------------------------------------------------------------------------------

-- drop table Customers;

--------------------------------------------------------------------------------------------------------------

create table Customers (CustomerID int primary key, CustomerName varchar(20), City varchar(20));
insert into Customers(CustomerID,CustomerName,City) values (1,'ankit','kanpur'),(2,'kiio','pathankoat') 
select * from Customers;
select [CustomerID],[City] from Customers 
insert into Customers(CustomerID,CustomerName,City) values (3,'arpit','kanpur'),(4,'kiio','delhi')

---------------------------------------------------------------------------------------------------------------

select * from Customers;
select distinct CustomerName,City from Customers;
select distinct CustomerName from Customers;
select CustomerName,sum(CustomerID) sum_ids from Customers where CustomerName='kiio' group by CustomerName
select * from Customers order by CustomerName,City
select * from Customers order by City ASC,CustomerName Desc
select * from Customers where CustomerName='kiio' and  City like '%h%'
select * from Customers where not CustomerName='ankit' or  City like '_e%i'
select * from Customers where CustomerName='kiio' and  City not like '%e%'
select * from Customers where CustomerID not between 2 and 3
select * from Customers where CustomerID not in (2,3)
select CustomerName from Customers where City is not null

--------------------------------------------------------------------------------------------------------

update Customers set CustomerName='Summi' where CustomerName='arpit'
update Customers set CustomerName='Summi', City='Hathras' where CustomerID=3
select * from Customers

----------------------------------------------------------------------------------------------------------

delete from Customers where CustomerID=3
select * from Customers
delete Customers
select * from Customers
--drop table Customers
truncate table Customers

----------------------------------------------------------------------------------------------------------------------

select * from Customers;

select top 2 * from Customers order by City;

select CustomerName, sum(CustomerID) from Customers group by CustomerName having CustomerName='kiio'

select CustomerName, count(CustomerName) from Customers group by CustomerName having CustomerName='kiio'

select CustomerName, avg(CustomerID) from Customers group by CustomerName having CustomerName='kiio'

select CustomerName, max(CustomerID) [Maximum Customer ID Value] from Customers group by CustomerName having CustomerName='kiio'

--------------------------------------------------------------------------------------------------------------------------

select * from Customers where CustomerName like '%' -- % means zero or more than zero characters searching 

select * from Customers where CustomerName like 'k%'

select * from Customers where CustomerName like '%[o]%'

select * from Customers where CustomerName like '[k-o]%'

select * from Customers where CustomerName like '[^k-o]%'

--------------------------------------------------------------------------------------------------------------

-- second max customer id

select CustomerName, CustomerID from Customers where CustomerID not in (select max(CustomerID) from Customers) order by CustomerID desc 

-----------------------------------------------------------------------------------------------------------------

select CustomerID+5 as "New Customer ID" from Customers

select CustomerID+5 as "New Customer ID", CustomerName+' and '+City as "CustomerName and City Name" from Customers


--------------------------------------------------------------------------------------------------------------

create table Orders (CustomerID int primary key, ProductName varchar(20), ProductID varchar(20));

insert into Orders values (5,'Washing Machine', 567),(6,'TV', 768),(7,'Radio', 786),(8,'Computer', 987)


select * from Orders

select * from Customers


-- joins

select C.CustomerID,C.CustomerName,O.CustomerID,O.ProductName from Customers C inner join Orders O on C.CustomerID=O.CustomerID

select C.CustomerID,C.CustomerName,O.CustomerID,O.ProductName from Customers C right join Orders O on C.CustomerID=O.CustomerID

select C.CustomerID,C.CustomerName,O.CustomerID,O.ProductName from Customers C left join Orders O on C.CustomerID=O.CustomerID

select C.CustomerID,C.CustomerName,O.CustomerID,O.ProductName from Customers C full outer join Orders O on C.CustomerID=O.CustomerID

select C1.CustomerID,C1.CustomerName,C2.CustomerID,C2.City from Customers C1 inner join Customers C2 on C1.CustomerID=C2.CustomerID

select C.CustomerID,C.CustomerName,O.CustomerID,O.ProductName from Customers C cross join Orders O

---------------------------------------------------------------------------------------------------------------------------------

-- union,intersection

select CustomerID from Customers where CustomerID not IN (2,4)
union all 
select CustomerID from Customers where CustomerID not IN (1,3) 

select CustomerID from Customers where CustomerID not IN (2,4)
union  
select CustomerID from Customers where CustomerID IN (1,3)

select CustomerID from Customers where CustomerID not IN (3,4)
intersect
select CustomerID from Customers where CustomerID IN (1,3)

--------------------------------------------------------------------------------------------------------------

select * from Customers
select City,sum(CustomerID) Sum_ID from Customers group by City having City <> 'kanpur' order by Sum_ID desc 

--------------------------------------------------------------------------------------------------------------

-- The EXISTS operator is used to test for the existence of any record in a subquery.

-- The EXISTS operator returns TRUE if the subquery returns one or more records.

select * from Customers where exists (select * from Customers where City='kanpur')
select * from Customers where not exists (select * from Customers where City='lucknow')

----------------------------------------------------------------------------------------------------------------
select *  from Customers where CustomerID= ANY(select CustomerID from Customers where CustomerName='kiio') 

select *  from Customers where CustomerID= ALL(select CustomerID from Customers where CustomerName='kiio') 

-----------------------------------------------------------------------------------------------------------------

-- insert recrds from one table to another table even if it is not existed or existed but dulpcate records are ignored.

select * into [New Customers] from Customers

-- select * into New_Customers in 'backup.mdb' from Customers

select * from [New Customers]

select * into [New Customer] from Customers where CustomerName='kiio'

------------------------------------------------------------------------------------------------------------------

-- copy the data from one table to another table which should be existed already

select * into new_customers from Customers where CustomerName='kiio'

insert into new_customers select * from Customers

select * from new_customers

-------------------------------------------------------------------------------------------------------------------

-- CASE Expression

-- when both cases are true then both statements executed and else statement executed where when condition is false

-- only one column name can be put in all the when conditions

select *, 
case
when CustomerName='kiio' then 'this is kiio'
when CustomerName='ankit' then 'this is me'
else 'this is arpit'
end as Msg
from Customers

select *,case when CustomerID in (1,2) then 'this is me' end as msg into experiment  from Customers

select * from experiment order by (case when msg is null then CustomerName else City end) Desc  
-- (how to do ascending and descending on two different columns here)

------------------------------------------------------------------------------------------------------------------

select ISNULL(msg,'this is not null') as Message from experiment

select COALESCE(msg,'this is not null') as Message from experiment

-------------------------------------------------------------------------------------------------------------------

-- Stored Procedure

-- A stored procedure is a prepared SQL code that you can save, so the code can be reused over and over again.

-- You can also pass parameters to a stored procedure

create procedure second_max_id 
as 
select CustomerName, CustomerID from Customers where CustomerID not in (select max(CustomerID) from Customers) order by CustomerID desc;

exec second_max_id

-- with parameters

create procedure kiio_fetch @name nvarchar(30), @city nvarchar(30)
as
select * from Customers where CustomerName=@name and City=@city;

exec kiio_fetch @name='kiio', @city='pathankoat'

------------------------------------------------------------------------------------------------------------------------------------

-- CREATE DATABASE databasename;

-- DROP DATABASE databasename;

-- SHOW DATABASES;

--  to create a full back up of an existing SQL database:

-- BACKUP DATABASE databasename TO DISK = 'filepath';

-- A differential back up only backs up the parts of the database that have changed since the last full database backup.

-- BACKUP DATABASE databasename TO DISK = 'filepath' WITH DIFFERENTIAL;

------------------------------------------------------------------------------------------------------------------------------------

create table customers_copy as select * from Customers;

------------------------------------------------------------------------------------------------------------------------

-- add column

alter table Customers
add Email nvarchar(30); 

select * from Customers

--alter table Customers rename column Email to New_Email

--------------------------------------------------------------------------------

-- renaming column

EXEC sp_rename 'Customers.Email', 'New_Email', 'column'

---------------------------------------------------------------------------------

-- drop column

alter table Customers
drop column New_Email

select * from Customers

-- add column

alter table Customers
add DoB date

-------------------------------------------------------------------------------------

CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    CONSTRAINT PK_Person PRIMARY KEY (ID,LastName)
);

ALTER TABLE Persons
ADD PRIMARY KEY (ID);

ALTER TABLE Persons
ADD CONSTRAINT PK_Person PRIMARY KEY (ID,LastName);

ALTER TABLE Persons
DROP PRIMARY KEY;

ALTER TABLE Persons
DROP CONSTRAINT PK_Person;

-----------------------------------------------------------------------------------


CREATE TABLE Orders (
    OrderID int NOT NULL,
    OrderNumber int NOT NULL,
    PersonID int,
    PRIMARY KEY (OrderID),
    CONSTRAINT FK_PersonOrder FOREIGN KEY (PersonID)
    REFERENCES Persons(PersonID)
);


CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),    Age int,
    City varchar(255),
    CONSTRAINT CHK_Person CHECK (Age>=18 AND City='Sandnes')
);

CREATE TABLE Orders (
    ID int NOT NULL,
    OrderNumber int NOT NULL,
    OrderDate date DEFAULT GETDATE()
);

ALTER TABLE Persons
ALTER City SET DEFAULT 'Sandnes';

ALTER TABLE Persons
ALTER City DROP DEFAULT;

--------------------------------------------------------------------------------------------------------------

CREATE INDEX idx_lastname
ON Persons (LastName);


DROP INDEX index_name ON table_name;

ALTER TABLE table_name
DROP INDEX index_name;


------------------------------------------------------------------------------------------------------------------

CREATE TABLE Persons (
    Personid int NOT NULL AUTO_INCREMENT,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    PRIMARY KEY (Personid)
);

-- To let the AUTO_INCREMENT sequence start with another value, use the following SQL statement:

ALTER TABLE Persons AUTO_INCREMENT=100;

--------------------------------------------------------------------------------------------------------------------

CREATE VIEW myview AS
SELECT CustomerName, City
FROM Customers

select * from myview

drop view myview

--------------------------------------------------------------------------------------------------------------------

------------------------------------------------ Advanced SQL ------------------------------------------------------

-- Rank

create table Students(StudentID nvarchar(30),Marks int, constraint pk_constraint primary key (StudentID))

insert into Students values ('st01',68),('st02',65),('st03',78),('st04',68)

select * from Students

select  *, rank() over(order by Marks desc) as [Rank],dense_rank() over(order by Marks desc) as [Dense Rank],
ROW_NUMBER() over (order by Marks desc) as [Row Number] from Students

create table Company(ID nvarchar(30),Department nvarchar(30),Salary int, constraint pk_constraint1 primary key (ID))

insert into Company values ('dt01','Sales',1000),('dt02','IT',1500),('dt03','Sales',2000),('dt04','Sales',1700),('dt05','IT',1800),('dt06','Accounts',1200),('dt07','Accounts',1100)

select * from Company

select *, rank() over(partition by Department order by Salary desc) as rnk  from Company

select * from (select *, rank() over(partition by Department order by Salary desc) as rnk  from Company) as a where a.rnk=1

---------------------------------------------------------------------------------------------------------------------

-- Rows between clause

create table Sales(ID nvarchar(30),Date date,Sales int, constraint pk_constraint2 primary key (ID))

insert into Sales values (1,'2022-06-22',603),(2,'2022-06-21',478),(3,'2022-06-20',679),(4,'2022-06-19',443),(5,'2022-06-18',540),
(6,'2022-06-17',740),(7,'2022-06-16',850),(8,'2022-06-15',604),(9,'2022-06-14',339),(10,'2022-06-13',905)

select * from Sales

SELECT convert(datetime, '23/10/2016', 103)

select *, sum(Sales) over (order by Date rows between 2 preceding and 2 following) as total_sales from Sales

select 905+339+850+740+604

select *, sum(Sales) over (order by Date rows between unbounded preceding and unbounded following) as total_sales from Sales

select sum(Sales) from Sales

select *, sum(Sales) over (order by Date rows between unbounded preceding and current row) as total_sales from Sales

select * from Company

select *, sum(Salary) over(partition by Department order by ID rows between unbounded preceding and current row) [total salary]
from Company

---------------------------------------------------------------------------------------------------------------------------------

-- First Value, Last Value and Nth Value

select * from Company

select *, FIRST_VALUE(Salary) over (partition by Department order by ID desc) from Company

select *, FIRST_VALUE(Salary) over (partition by Department order by ID desc) - Salary diff_salary from Company

select *, LAST_VALUE(Salary) over (partition by Department order by ID desc rows between unbounded preceding and unbounded following)
as [Last Value] from Company

--select *,nth_value(Salary) over (partition by Department order by ID) nth_day_sales from Company

----------------------------------------------------------------------------------------------------------------------------------

-- Partition

select * from Customers

select *,count(CustomerID) over (partition by CustomerName,City) TotalIDs from Customers

---------------------------------------------------------------------------------------------------------------------

-- Moving Average/ Rolling Mean/ Rolling Average

select * from Sales

select *, AVG(Sales) over (order by Date rows between 3 preceding and current row) as three_days_moving_average from Sales

select (905+339+604)/3

--------------------------------------------------------------------------------------------------------------------------

-- Lead and Lag

select * from Company

select *, lead(Salary) over (partition by Department order by ID) as Lead_Salary from Company


select * from (select *, lead(Salary) over (partition by Department order by ID) as Lead_Salary from Company) a 
where a.Lead_Salary is NOT NULL


select *, b.Salary-b.Lead_Salary as diff_salary from (select * from (select *, lead(Salary) over 
(partition by Department order by ID) as Lead_Salary from Company) a where a.Lead_Salary is NOT NULL) b

-- precentage value

select *, (Salary/sum(Salary) over (partition by Department order by ID rows between unbounded preceding and unbounded following))*100 as percentage_value from Company
--(float division is not done)

select *, (Cast(Salary as float)/sum(Salary) over (partition by Department order by ID rows between unbounded preceding and unbounded following))*100 as percentage_value from Company
--(float division is not done)

select cast(1200 as float)/cast(2300 as float)

select Cast(Salary as float) from Company

SELECT CAST(1 AS float) / CAST(3 AS float)

select *, sum(Salary) over (partition by Department order by ID) as sum_value from Company

select *, sum(Salary) over (partition by Department order by ID rows between unbounded preceding and unbounded following)
as sum_value from Company

-- increment or decrement in succeeding rows

select *,
case 
when diff_lead>0 then 1 
else 0
end as polarity from
(select * from (select *, lead(Salary) over (partition by Department order by ID)- Salary as diff_lead from Company) a
where a.diff_lead is not null) b
-----------------------------------------------------------------------------------------------------------------------------------

-- Nth value and ntile

select * from Company

--select *, nth_value(Salary,2) over (partition by Department order by Salary desc) as second_max from Company
--(will not work in ssms, try some online editor)

-- ntile is used for grouping based on number of rows in a particular group. 

-- for example, if we have 12 rows in a dataset and we want a group of 3 rows, so we will have 4 groups.

select *, NTILE(2) over (partition by Department  order by ID) group_number from Company

--------------------------------------------------------------------------------------------------------------------------------------

-- cross join works even there is no common column by using cartestian product.

-- select a.*,b.* from table a, table2 b

-- Non-Equi Join is used when we have to apply join condition other than "=" like <,>,!=

-- order of execution: where --> group by --> having --> order by --> limit

--------------------------------------------------------------------------------------------------------------------------------------

-- ISNULL and NULLIF

-- BOTH ARE OPPOSITE (isnull ==> makes null to non-null and ifnull makes non-null to null)

select *, lead(Salary) over (partition by Department order by ID) as Lead_Salary into null_table from Company

select * from null_table

select *, ISNULL(Lead_Salary,0) new_lead_salary from null_table 

select *, nullif(Lead_Salary,1100)+nullif(Lead_Salary,1700) from  null_table

--------------------------------------------------------------------------------------------------------------------------------------

-- Difference between 2 timestamps

create table time_diff(timing1 time primary key, timing2 time)
insert into time_diff values('15:51:00','16:51:00'),('15:52:00','16:16:21')
select * from time_diff

select *, DATEDIFF(SECOND,timing1,timing2) as diff_seconds from time_diff

select *, DATEDIFF(SECOND,timing1,timing2)/3600 as diff_hrs,
(DATEDIFF(SECOND,timing1,timing2)%3600)/60 as diff_minutes,
(DATEDIFF(SECOND,timing1,timing2)%3600)%60 as diff_seconds from time_diff


select *, concat(DATEDIFF(SECOND,timing1,timing2)/3600, ' hr(s) ',
(DATEDIFF(SECOND,timing1,timing2)%3600)/60, ' minutes ',
(DATEDIFF(SECOND,timing1,timing2)%3600)%60, ' seconds ') [difference in time] from time_diff

-----------------------------------------------------------------------------------------------------------------------------------

select MONTH(Date) month_in_date from Sales

-----------------------------------------------------------------------------------------------------------------------------------

-- List Aggregate and String Aggregate


create table quantity(custid nvarchar(30),orderid nvarchar(30),item nvarchar(30),quantity int)
insert into quantity values ('c1','1','mouse',2),('c1','1','keyboard',2),('c1','1','headphone',2),('c1','1','laptop',2),
('c1','1','pendrive',3)

select * from quantity

select string_agg(item,',') summary from quantity
select a.custid,string_agg(detail,',')summary from (select custid,concat(item,'-',quantity) as detail from quantity) a group by custid

---------------------------------------------------------------------------------------------------------------------------------------

-- CTEs (Common Table Expressions)

--  CTEs (temporary table) is a small subset of the dataset for usability.

-- RUN both simultaneously
with CTE1 as (select CustomerName from Customers)
select * from CTE1

--------------------------------------------------------------------------------------------------------------------------------------

-- pivot 


create table Customer(cust_id int, cust_first_name nvarchar(30),cust_last_name nvarchar(30))
insert into Customer values(1,'Henry','Brown'),(2,'James','Williams'),(3,'Jack','Taylor')

create table Order1(order_id int, Date date,cid int, amount int)
insert into Order1 values (1,'2020-08-05',1,4922),(1,'2020-08-04',2,7116),(3,'2020-08-03',3,1206)

select * from Order1

select * from Customer

-- Total orders by each customer

-- run both simultaneously
select * from (select order_id, cid from Order1) a 
pivot(count(order_id) for cid in ([1],[2],[3])) pivot_data

-- Total order by each customer by year    

select * from (select order_id, cid,year(Date) yr from Order1) a
pivot(count(order_id) for cid in ([1],[2],[3])) pivot_data

-- joining both tables:

select * from 
(select a.order_id, concat(b.cust_first_name, ' ' ,b.cust_last_name) full_name,year(a.Date) yr from
Order1 a inner join  Customer b on a.cid = b.cust_id) b
pivot(count(order_id) for full_name in ([Henry Brown], [James Williams], [Jack Taylor])) pivot_data

------------------------------------------------------------------------------------------------------------------------------

-- Recursive CTEs

select datename(DW,0)
--Monday (0 is used for monday, 1 is used for tuesday...)

with cte_numbers(n, weekday)

as (

select 0,datename(dw,0)

union all

select n+1, datename(dw,n+1) from cte_numbers where n<6
)
select weekday from cte_numbers;

---------------------------------------------------------------------------------------------------------------------------

-- See more interview questions at the end of summary file

----------------------------------------------------------------------------------------------------------------------------

create table email(ename nvarchar(30), email nvarchar(30),primary key (email))

insert into email values ('ankit','ankit@gmail.com'),('kiio','kiio@gmail.com')

-- the left(str,n) picks n number of characters from the starting and
-- the right(str,n) picks n number of characters from the end

-- Get the name before the @ sign in email id:

select left(email,charindex('@',email)-1) from email

select CHARINDEX('t','ankit@gmail.com')

-- Get the domain name after the @ sign in email id:

select RIGHT(email,len(email)-CHARINDEX('@',email)) from email

-----------------------------------------------------------------------------------------------------------------------

-- update tablename set name= 

create table country(name nvarchar(30), state nvarchar(30))
insert into country values ('n1','AS'),('n2','BR'),('n3','GA'),('n4','GJ'),('n5','HR')

update country set state=
case when state='AS' then 'ASSAM'
when state='BR' then 'BIHAR'
when state='GA' then 'GOA'
when state='GJ' then 'GUJARAT' 
when state='HR' then 'HARYANA'
end;
select * from country

-- (when more than one condition are satisfied for an input then first condition will be executed, so sequence matters here)

--------------------------------------------------------------------------------------------------------------------------------

-- for date difference, use datediff() function

--------------------------------------------------------------------------------------------------------------------------------

drop table Company
drop table country
drop table Customer
drop table Customers
drop table email
drop table experiment
drop table [New Customer]
drop table [New Customers]
drop table new_customers
drop table null_table
drop table Order1
drop table Orders
drop table Persons
drop table quantity
drop table Sales
drop table Students
drop table time_diff