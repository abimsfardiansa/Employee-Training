-- Employee Table
CREATE TABLE Employee (
    Id INT,
    EmployeeId VARCHAR(10) UNIQUE NOT NULL,
    FullName VARCHAR(100) NOT NULL,
    BirthDate DATE NOT NULL,
    Address VARCHAR(500)
);

INSERT INTO Employee (Id, EmployeeId, FullName, BirthDate, Address)
VALUES 
(1, '10105001', 'Ali Anton', '1982-08-19', 'Jakarta Utara'),
(2, '10105002', 'Rara Siva', '1982-01-01', 'Mandalika'),
(3, '10105003', 'Rini Aini', '1982-02-20', 'Sumbawa Besar'),
(3, '10105004', 'Budi', '1982-02-22', 'Mataram Kota');

SELECT * FROM Employee

-------------------------------------------------------------------
-- Position History Table--
CREATE TABLE PositionHistory (
    Id INT PRIMARY KEY,
    PosId VARCHAR(10) NOT NULL,
    PosTitle VARCHAR(100) NOT NULL,
    EmployeeId VARCHAR(10) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL
);

INSERT INTO PositionHistory (Id, PosId, PosTitle, EmployeeId, StartDate, EndDate)
VALUES 
(1, '50000', 'IT Manager', '10105001', '2022-01-01', '2022-02-28'),
(2, '50001', 'IT Sr. Manager', '10105001', '2022-03-01', '2022-12-31'),
(3, '50002', 'Programmer Analyst', '10105002', '2022-01-01', '2022-02-28'),
(4, '50003', 'Sr. Programmer Analyst', '10105002', '2022-03-01', '2022-12-31'),
(5, '50004', 'IT Admin', '10105003', '2022-01-01', '2022-02-28'),
(6, '50005', 'IT Secretary', '10105003', '2022-03-01', '2022-12-31');

SELECT * FROM PositionHistory



SELECT 
    E.EmployeeId,
    E.FullName,
    E.BirthDate,
    E.Address,
    PH.PosId,
    PH.PosTitle,
    PH.EmployeeId,
    CONVERT(VARCHAR, PH.StartDate, 106)AS StartDate,
    --PH.StartDate AS PositionStartDate,
    CONVERT(VARCHAR, PH.EndDate, 106)AS EndDate
    --PH.EndDate AS PositionEndDate
FROM 
    Employee E
JOIN 
    (SELECT 
         *,
         ROW_NUMBER() OVER (PARTITION BY EmployeeId ORDER BY EndDate DESC) AS RowNum
     FROM 
         PositionHistory) PH ON E.EmployeeId = PH.EmployeeId
WHERE 
    PH.RowNum = 1;
   
   

