use DotNetAssignment

--TblCustomer (CustomerID, Name, DOB, City) 

--TblAccount (CustomerID, AccountNumber, AccountTypeCode, 

-- DateOpened, Balance) 

--TblAccountType (TypeCode, TypeDesc) 


--The date opened should have default value as the system date. 

--AccountNumber is the primary key of the TblAccount and CustomerID and AccountTypeCode are foreign keys in the TblAccount 

--Make use of following script to insert records in these tables.
create table TblCustomer(
CustomerId varchar(20)not null primary key,
Name varchar(20),
DOB date,
City varchar(20))

create table TblAccountType(
TypeCode int not null primary key,
TypeDesc varchar(20)
)
create table TblAccount(
CustomerId varchar(20) foreign key references TblCustomer(CustomerId)
,AccountNumber varchar(20) not null primary key
,AccountTypeCode int foreign key references TblAccountType(TypeCode)
,DateOpened date not null default current_timestamp,
Balance float)

--insert values

insert into tblCustomer values ('123456', 'David Letterman', '04-Apr-1949', 'Hartford'); 
insert into tblCustomer values ('123457', 'Barry Sanders', '12-Dec-1967','Detroit'); 
insert into tblCustomer values ('123458', 'Jean-Luc Picard', '9-Sep-1940', 'San Francisco'); 
insert into tblCustomer values ('123459', 'Jerry Seinfeld', '23-Nov-1965','New York City'); 
insert into tblCustomer values ('123460', 'Fox Mulder', '05-Nov-1962', 'Langley'); 
insert into tblCustomer values ('123461', 'Bruce Springsteen', '29-Dec-1960','Camden'); 
insert into tblCustomer values ('123462', 'Barry Sanders', '05-Aug-1974','Martha''s Vineyard'); 
insert into tblCustomer values ('123463', 'Benjamin Sisko', '23-Nov-1955','San Francisco'); 
insert into tblCustomer values ('123464', 'Barry Sanders', '19-Mar-1966','Langley'); 
insert into tblCustomer values ('123465', 'Martha Vineyard', '19-Mar-1963','Martha''s Vineyard'); 

insert into tblAccountType values (1, 'Checking'); 
insert into tblAccountType values (2, 'Saving'); 
insert into tblAccountType values (3, 'Money Market'); 
insert into tblAccountType values (4, 'Super Checking'); 

insert into tblAccount values('123456', '123456-1', 1, '04-Apr-1993', 2200.33); 
insert into tblAccount values('123456', '123456-2', 2, '04-Apr-1993', 12200.99); 
insert into tblAccount values('123457', '123457-1', 3, '01-JAN-1998', 50000.00); 
insert into tblAccount values ('123458', '123458-1', 1, '19-FEB-1991', 9203.56); 
insert into tblAccount values('123459', '123459-1', 1, '09-SEP-1990', 9999.99);
insert into tblAccount values('123459', '123459-2', 1, '12-MAR-1992', 5300.33); 
insert into tblAccount values('123459', '123459-3', 2, '12-MAR-1992', 17900.42);
insert into tblAccount values('123459', '123459-4', 3, '09-SEP-1998', 500000.00); 
insert into tblAccount values('123460', '123460-1', 1, '12-OCT-1997', 510.12); 
insert into tblAccount values('123460', '123460-2', 2, '12-OCT-1997', 3412.33); 
insert into tblAccount values('123461', '123461-1', 1, '09-MAY-1978', 1000.33); 
insert into tblAccount values('123461', '123461-2', 2, '09-MAY-1978', 32890.33); 
insert into tblAccount values('123461', '123461-3', 3, '13-JUN-1981', 51340.67); 
insert into tblAccount values('123462', '123462-1', 1, '23-JUL-1981', 340.67); 
insert into tblAccount values('123462', '123462-2', 2, '23-JUL-1981', 5340.67); 
insert into tblAccount values ('123463', '123463-1', 1, '1-MAY-1998', 513.90); 
insert into tblAccount values('123463', '123463-2', 2, '1-MAY-1998', 1538.90); 
insert into tblAccount values('123464', '123464-1', 1, '19-AUG-1994', 1533.47); 
insert into tblAccount values('123464', '123464-2', 2, '19-AUG-1994', 8456.47); 


--1)Print customer id and balance of customers who have at least $5000 in any of their accounts.
select CustomerId,Balance from TblAccount where Balance>=5000

--2)Print names of customers whose names begin with a ‘B’.  
select Name from TblCustomer where Name='B%';

--3)Print all the cities where the customers of this bank live.
select City from TblCustomer

--4)Use IN [and NOT IN] clauses to list customers who live in [and don’t live in] San Francisco or Hartford.  
select Name,City from TblCustomer where City in('San Francisco','Hartford')
select Name,City from TblCustomer where City not in('San Francisco','Hartford')

--5)-5. Show name and city of customers whose names contain the letter 'r' and 
--who live in Langley. 
SELECT Name,City FROM TblCustomer WHERE Name LIKE '%r%' AND City IN ('Langley')

--6)How many account types does the bank provide?  
select COUNT(TypeCode) as NoOfAccountType from TblAccountType

--7)Show a list of accounts and their balance for account numbers that end in '-1'  
select CustomerId,Balance,AccountNumber from TblAccount where AccountNumber like'%-1'

--8)Show a list of accounts and their balance for accounts opened on or after July 1, 1990.
select AccountNumber,Balance from TblAccount where DateOpened=convert(date,'July 1 1990')
select AccountNumber,Balance from TblAccount where DateOpened='1990-07-01'

--9)If all the customers decided to withdraw their money, how much cash would the bank need? 
select sum(Balance) as CashNeededToBankWhenAllCustomerWithdraw from TblAccount

--10)List account number(s) and balance in accounts held by ‘David Letterman’.
select AccountNumber,Balance from TblAccount where CustomerId in(select CustomerId from TblCustomer where Name='David Letterman')

--11)List the name of the customer who has the largest balance (in any account).  
select Name from TblCustomer where CustomerId in(select CustomerId from TblAccount where Balance in(select Max(Balance) from TblAccount))

--12)List customers who have a ‘Money Market’ account. 
select AccountNumber from TblAccount where AccountTypeCode in(select TypeCode from TblAccountType where TypeDesc='Money Market')

--13)Produce a listing that shows the city and the number of people who live in that city.  
select city,count(city) from TblCustomer group by City

--14)Produce a listing showing customer name, the type of account they hold and the balance in that account.   (Make use of Joins) 
select Name,AccountTypeCode,Balance from 
TblCustomer join TblAccount 
on TblCustomer.CustomerId=TblAccount.CustomerId

--15)Produce a listing that shows the customer name and the number of accounts they hold.(Make use of Joins) 
SELECT c1.Name, Count(a1.AccountNumber) As AccountHolder
FROM TblCustomer c1 JOIN TblAccount a1
ON c1.CustomerId=a1.CustomerId
GROUP BY Name

--16) Produce a listing that shows an account type and the average balance in accounts of that type.(Make use of Joins) 
SELECT a2.TypeDesc, Avg(a1.Balance) AS AverageBalance
FROM TblAccount a1 JOIN TblAccountType a2
ON a1.AccountTypeCode=a2.TypeCode
GROUP BY a2.TypeDesc


select * from TblAccountType 
select * from TblAccount
select * from TblCustomer
-----------------------------------------------------------------------------------------------
--Built in fuction of sql date,math,string
select CustomerId,AccountNumber,DateOpened from TblAccount where DateOpened>'1993-04-04' order by DateOpened desc

select AccountNumber,Balance,CustomerId from TblAccount where DateOpened=convert(date,'Feb 19 1991')
---------------------------------------------------------
--math
select Abs(-2) --non negative val,abs val
select ACOS(1) --cosine
select ATAN(2)--ret arc of tan
select CEILING(1.23) --smallest int val not less than x
select EXP(2)--exponential
select floor(1.23)--larget int val not greater than x
select POWER(2,2)--power
select ROUND(1.23,1)--round
select SQUARE(24)
----------------------------------------------------------
--string
select ASCII('2')
select CONCAT('Nishi','Patel')
select CONCAT_WS(',','Nishi','Patel')
select LEFT('nishipatel',4)
select LEN('NishiPatel')
select LOWER('Nishi')
select UPPER('Nishi')
select LTRIM(' NishiPatel')
select REPLACE('Nishu','u','i')
select REVERSE('Nishi')

