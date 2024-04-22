--7.Database Function - Book Borrowing Frequency:

CREATE FUNCTION fn_BookBorrowingFrequency (@BookID INT)
RETURNS INT
AS
BEGIN
    RETURN( 
		SELECT COUNT(*)
		FROM Loans
		WHERE bookId = @BookID
	);
END;


SELECT dbo.fn_BookBorrowingFrequency(1) AS BorrowingFrequency;
