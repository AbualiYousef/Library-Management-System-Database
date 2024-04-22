--5.Stored Procedure - Add New Borrowers:
CREATE OR ALTER PROCEDURE PROCEDURE sp_AddNewBorrower
    @FirstName VARCHAR(255),
    @LastName VARCHAR(255),
    @Email VARCHAR(255),
    @DateOfBirth DATE,
    @MembershipDate DATE
AS
BEGIN
    IF EXISTS (SELECT Borrowers.borrowerId FROM Borrowers WHERE email = @Email)
    BEGIN
        SELECT 'Error: A borrower with this email already exists.' AS ErrorMessage;
    END
    ELSE
    BEGIN
        INSERT INTO Borrowers
        VALUES (@FirstName, @LastName, @Email, @DateOfBirth, @MembershipDate);
        SELECT SCOPE_IDENTITY() AS NewBorrowerID;
    END
END;

-- Test the procedure by executing it
EXEC sp_AddNewBorrower 
    @FirstName = 'John',
    @LastName = 'Doe',
    @Email = 'john.doe@example.com',
    @DateOfBirth = '1990-05-15',
    @MembershipDate = '2023-04-15';