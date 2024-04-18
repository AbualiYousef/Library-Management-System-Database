--6.Database Function - Calculate Overdue Fees
drop function if exists fn_CalculateOverdueFees;
go
CREATE FUNCTION fn_CalculateOverdueFees (@LoanID INT)
RETURNS MONEY
AS
BEGIN
    DECLARE @DateBorrowed DATE;
    DECLARE @DueDate DATE;
    DECLARE @DateReturned DATE;
    DECLARE @OverdueDays INT;
    DECLARE @OverdueFee MONEY = 0;

    -- Retrieve loan dates
    SELECT @DateBorrowed = dateBorrowed, @DueDate = dueDate, @DateReturned = dateReturned
    FROM Loans
    WHERE loanId = @LoanID;

    -- Calculate overdue days
    IF @DateReturned IS NULL
        SET @DateReturned = GETDATE();

    SET @OverdueDays = DATEDIFF(DAY, @DueDate, @DateReturned);

    -- Calculate fees based on the overdue days
    IF @OverdueDays > 0
    BEGIN
        IF @OverdueDays <= 30
            SET @OverdueFee = @OverdueDays * 1.00;
        ELSE
            SET @OverdueFee = (30 * 1.00) + ((@OverdueDays - 30) * 2.00);
    END

    RETURN @OverdueFee;
END;



--Test the function:
SELECT dbo.fn_CalculateOverdueFees(1) AS OverdueFee;