-- 14.SQL Stored Procedure with Temp Table:
DROP PROCEDURE IF EXISTS sp_GetOverdueBooksByBorrower;
GO
CREATE PROCEDURE sp_GetOverdueBooksByBorrower
AS
BEGIN
    -- Create a temporary table
    CREATE TABLE #OverdueBorrowers (
        borrowerId INT
    );

    -- Insert borrowers who have overdue books into the temporary table:
    INSERT INTO #OverdueBorrowers (borrowerId)
    SELECT DISTINCT l.borrowerId
    FROM Loans l
    WHERE l.dateReturned IS NULL AND l.dueDate < GETDATE();

    -- Select the overdue books for each borrower by joining the temp table with the Loans table
    SELECT 
        br.borrowerId,
        br.firstName + ' ' + br.lastName AS BorrowerName,
        b.bookId,
        b.title AS BookTitle,
        l.dueDate AS DueDate
    FROM #OverdueBorrowers obr
    JOIN Loans l ON obr.borrowerId = l.borrowerId
    JOIN Borrowers br ON obr.borrowerId = br.borrowerId -- Make sure to join Borrowers here
    JOIN Books b ON l.bookId = b.bookId
    WHERE l.dateReturned IS NULL AND l.dueDate < GETDATE();

    -- Drop the temporary table
    DROP TABLE #OverdueBorrowers;
END;

-- Test the sp:
EXEC sp_GetOverdueBooksByBorrower;
