--11.Stored Procedure - Borrowed Books Report:
CREATE PROCEDURE sp_BorrowedBooksReport
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    -- Query to retrieve borrowed book details within the specified date range
    SELECT 
        b.title AS BookTitle,
        b.author AS Author,
        br.firstName + ' ' + br.lastName AS BorrowerName,
        l.dateBorrowed AS BorrowingDate
    FROM 
        Loans l
        INNER JOIN Books b ON l.bookId = b.bookId
        INNER JOIN Borrowers br ON l.borrowerId = br.borrowerId
    WHERE 
        l.dateBorrowed BETWEEN @StartDate AND @EndDate
    ORDER BY 
        BorrowingDate ASC;
END;

--Test the sp
EXEC sp_BorrowedBooksReport 
    @StartDate = '2024-01-01', 
    @EndDate = '2024-01-17';