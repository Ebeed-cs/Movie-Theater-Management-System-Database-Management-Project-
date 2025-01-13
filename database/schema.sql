-- Create Database
CREATE DATABASE CinemaDatabase;
GO 
USE CinemaDatabase;
GO

-- Create Theater Table First
CREATE TABLE Theater (
    TheaterID CHAR(3) NOT NULL PRIMARY KEY,
    TheaterName VARCHAR(20) NOT NULL,
    Address VARCHAR(100) NOT NULL
);
GO

-- Create Customer Table
CREATE TABLE Customer (
    CustomerId CHAR(10) NOT NULL PRIMARY KEY,
    CustomerName VARCHAR(20) NOT NULL,
    Email NVARCHAR(50) NOT NULL,
    Phone CHAR(10) NULL,
    THId CHAR(3) NULL,
    FOREIGN KEY (THId) REFERENCES Theater(TheaterID)
);
GO
-- Create Employee Table
CREATE TABLE Employee (
    EmpID CHAR(10) NOT NULL PRIMARY KEY,
    Age CHAR(2) NOT NULL,
    EmpName NVARCHAR(50) NOT NULL,
    TId CHAR(3) NOT NULL,
    ServiceYears CHAR(2) NOT NULL,
	SpNb char(10)  ,
    FOREIGN KEY (TId) REFERENCES Theater(TheaterID)
);

GO

ALTER TABLE Employee 
ADD FOREIGN KEY (SpNb) REFERENCES Employee(EmpID)

GO

-- Create Hall Table
CREATE TABLE Hall (
    HallNumber CHAR(2) NOT NULL,
    TheaterID CHAR(3) NOT NULL,
    SeatType VARCHAR(10) NOT NULL,
    NumberOfSeats CHAR(3) NOT NULL,
    PRIMARY KEY (HallNumber, TheaterID),
    FOREIGN KEY (TheaterID) REFERENCES Theater(TheaterID)
);
GO

-- Create Show Table
CREATE TABLE Show (
    ShowNumber CHAR(10) NOT NULL PRIMARY KEY,
    Language VARCHAR(15) NOT NULL,
    Show NVARCHAR(50) NULL,
    StartTime TIME NOT NULL
);
GO

-- Create Movie Table
CREATE TABLE Movie (
    MovieId CHAR(10) NOT NULL PRIMARY KEY,
    MovieType VARCHAR(15) NOT NULL,
    Director VARCHAR(20) NULL,
    MovieName VARCHAR(50) NOT NULL,
    Actors VARCHAR(20) NULL,
	ShowPresentsMovie CHAR(10) 
	FOREIGN KEY (ShowPresentsMovie) REFERENCES Show(ShowNumber)
);
GO



-- Create Ticket Table
CREATE TABLE Ticket (
    TicketNb CHAR(10) NOT NULL PRIMARY KEY,
    MovieTime TIME NOT NULL,
    MovieDate DATE NOT NULL,
    Price INT NULL, 
    SeatNum CHAR(3) NOT NULL,
    EId CHAR(10) NULL,
    ShowNb CHAR(10) NULL,
    CusId CHAR(10) NULL,
    DOP DATE NOT NULL,
	TNb CHAR(10) ,
	Cid INT ,
    FOREIGN KEY (EId) REFERENCES Employee(EmpID),
    FOREIGN KEY (ShowNb) REFERENCES Show(ShowNumber),
    FOREIGN KEY (CusId) REFERENCES Customer(CustomerId)
);
GO

-- Insert data 
INSERT INTO Theater (TheaterID, TheaterName, Address) VALUES
('T01', 'Grand Theater', '123 Main St, Springfield'),
('T02', 'Downtown Cinema', '456 Elm St, Shelbyville'),
('T03', 'Royal Palace', '789 King St, Capital City');

INSERT INTO Customer (CustomerId, CustomerName, Email, Phone, THId) VALUES
('CUST00001', 'John Doe', 'johndoe@example.com', '1234567890', 'T01'),
('CUST00002', 'Jane Smith', 'janesmith@example.com', '0987654321', 'T02'),
('CUST00003', 'Alice Brown', 'alicebrown@example.com', NULL, 'T03');

INSERT INTO Employee (EmpID, Age, EmpName, TId, ServiceYears, SpNb) VALUES
('EMP000001', '25', 'Michael Johnson', 'T01', '3', NULL),
('EMP000002', '30', 'Sarah Connor', 'T02', '5', NULL),
('EMP000003', '35', 'James Bond', 'T03', '10', 'EMP000001');

INSERT INTO Hall (HallNumber, TheaterID, SeatType, NumberOfSeats) VALUES
('01', 'T01', 'Standard', '200'),
('02', 'T02', 'VIP', '150'),
('03', 'T03', 'Luxury', '100');

INSERT INTO Show (ShowNumber, Language, Show, StartTime) VALUES
('SHOW00001', 'English', 'Evening Show', '18:00:00'),
('SHOW00002', 'French', 'Morning Show', '10:00:00'),
('SHOW00003', 'Spanish', 'Late Night Show', '22:00:00');

INSERT INTO Movie (MovieId, MovieType, Director, MovieName, Actors, ShowPresentsMovie) VALUES
('MOVIE0001', 'Action', 'John Wick', 'Chapter 4', 'Keanu Reeves', 'SHOW00001'),
('MOVIE0002', 'Comedy', 'Wes Anderson', 'The French Dispatch', 'Timothée Chalamet', 'SHOW00002'),
('MOVIE0003', 'Horror', 'Jordan Peele', 'Get Out', 'Daniel Kaluuya', 'SHOW00003');

INSERT INTO Ticket (TicketNb, MovieTime, MovieDate, Price, SeatNum, EId, ShowNb, CusId, DOP, TNb, Cid) VALUES
('TICKET001', '18:30:00', '2024-12-30', 15, 'A01', 'EMP000001', 'SHOW00001', 'CUST00001', '2024-12-27', 'TICKET002', 1),
('TICKET002', '10:15:00', '2024-12-31', 20, 'B05', 'EMP000002', 'SHOW00002', 'CUST00002', '2024-12-26', NULL, 2),
('TICKET003', '22:45:00', '2024-12-29', 18, 'C12', 'EMP000003', 'SHOW00003', 'CUST00003', '2024-12-25', NULL, 3);

-- select all to each table to view the data 
SELECT * FROM Theater;
SELECT * FROM Customer;
SELECT * FROM Employee;
SELECT * FROM Hall;
SELECT * FROM Show;
SELECT * FROM Movie;
SELECT * FROM Ticket;


GO 

CREATE PROCEDURE InsertCustomer
    @CustomerId CHAR(10),
    @CustomerName VARCHAR(20),
    @Email NVARCHAR(50),
    @Phone CHAR(10),
    @THId CHAR(3)
AS
BEGIN
    BEGIN TRY
        INSERT INTO Customer (CustomerId, CustomerName, Email, Phone, THId)
        VALUES (@CustomerId, @CustomerName, @Email, @Phone, @THId);
        
        PRINT 'Customer inserted successfully';
    END TRY
    BEGIN CATCH
        PRINT 'Error: '
    END CATCH
END;

GO
EXEC InsertCustomer 
    @CustomerId = 'CUST00004',
    @CustomerName = 'Bob Marley',
    @Email = 'bobmarley@example.com',
    @Phone = '1122334455',
    @THId = 'T02';



CREATE PROCEDURE UpdateCustomer
    @CustomerId CHAR(10),
    @CustomerName VARCHAR(20) = NULL,
    @Email NVARCHAR(50) = NULL,
    @Phone CHAR(10) = NULL,
    @THId CHAR(3) = NULL
AS
BEGIN
    BEGIN TRY
        UPDATE Customer
        SET 
            CustomerName = ISNULL(@CustomerName, CustomerName),
            Email = ISNULL(@Email, Email),
            Phone = ISNULL(@Phone, Phone),
            THId = ISNULL(@THId, THId)
        WHERE CustomerId = @CustomerId;

        PRINT 'Customer updated successfully';
    END TRY
    BEGIN CATCH
        PRINT 'Error: '
    END CATCH
END;
GO

EXEC UpdateCustomer 
    @CustomerId = 'CUST00004',
    @CustomerName = 'Jane Doe',
    @Email = 'janedoe@example.com',
    @Phone = '9988776655',
    @THId = 'T03';



-- Procedure to insert a new Employee
CREATE PROCEDURE InsertEmployee
    @EmpID CHAR(10),
    @Age CHAR(2),
    @EmpName NVARCHAR(50),
    @TId CHAR(3),
    @ServiceYears CHAR(2),
    @SpNb CHAR(10) -- Optional, if there is a supervisor
AS
BEGIN
    INSERT INTO Employee (EmpID, Age, EmpName, TId, ServiceYears, SpNb)
    VALUES (@EmpID, @Age, @EmpName, @TId, @ServiceYears, @SpNb);
END;
GO

-- Inserting a new employee
EXEC InsertEmployee 
    @EmpID = 'EMP000004',
    @Age = '28',
    @EmpName = 'Lara Croft',
    @TId = 'T01',
    @ServiceYears = '4',
    @SpNb = NULL;

-- Procedure to update Employee information
CREATE PROCEDURE UpdateEmployeeData
    @EmpID CHAR(10), -- Employee ID to identify which employee to update
    @Age CHAR(2),
    @EmpName NVARCHAR(50),
    @TId CHAR(3),
    @ServiceYears CHAR(2),
    @SpNb CHAR(10) -- Optional supervisor ID
AS
BEGIN
  BEGIN TRY 
    UPDATE Employee
    SET 
        Age = @Age,
        EmpName = @EmpName,
        TId = @TId,
        ServiceYears = @ServiceYears,
        SpNb = @SpNb
    WHERE EmpID = @EmpID;
	PRINT 'employee updated successfully';
    END TRY
	BEGIN CATCH 
	PRINT 'Error: '
	END CATCH 

END;
GO

-- Updating employee data
EXEC UpdateEmployeeData 
    @EmpID = 'EMP000002',
    @Age = '26',
    @EmpName = 'Michael Johnson Updated',
    @TId = 'T02',
    @ServiceYears = '4',
    @SpNb = 'EMP000002'; -- Setting a new supervisor


-- delete employee

ALTER PROCEDURE DeleteEmployee
    @EmpID CHAR(10)
AS
BEGIN
    -- Check if the Employee with the given ID exists
    IF NOT EXISTS (SELECT * FROM Employee WHERE EmpID = @EmpID)
    BEGIN
        PRINT 'ERROR: Employee not found'
        RETURN -1
    END

    -- Delete related records in the Ticket table
    DELETE FROM Ticket
    WHERE EId = @EmpID;

    -- Delete the Employee record
    DELETE FROM Employee 
    WHERE EmpID = @EmpID;
END

-- Test the stored procedure
SELECT * FROM Employee;
EXEC DeleteEmployee 'EMP000001 ';
SELECT * FROM Employee;

