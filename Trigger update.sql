use WFADotNet
CREATE TABLE PastEmpData(
	EmpId int Primary key,
	EmpName varchar(20),
	EmpSalary float,
	EmpLeaving Date default getdate()
)
drop table PastEmpData
select * from EmployeeTable	

--Trigger for updating data	
alter TRIGGER trgUpdate on Employee
AFTER UPDATE
AS
DECLARE
@EmpId int,
@EmpName varchar(20),
@EmpSalary float,
@EmpLeaving datetime

BEGIN
SELECT @EmpId =EmpId,
	   @EmpName=EmpName,
	   @EmpSalary=Salary FROM inserted
	
INSERT INTO PastEmpData(EmpId,EmpName,EmpSalary)
				VALUES(@EmpId, @EmpName,@EmpSalary)
PRINT 'Using UPDATE in Trigger for PastEmpData' 
END
	
--To update values
UPDATE Employee SET Salary=2346.36, EmpName = 'geet' WHERE EmpId=4
SELECT * FROM PastEmpData
select * from Employee

INSERT INTO Employee VALUES('Harshu', 1526.36, 5)
INSERT INTO Employee VALUES('Nikita', 55426.36, 6)