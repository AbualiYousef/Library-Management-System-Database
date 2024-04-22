--1. List of Borrowed Books: Retrieve all books borrowed by a specific borrower, including those currently unreturned.

declare @BorrowerId int = 7;
SELECT Books.title, Books.author, Loans.dateBorrowed, Loans.dueDate
FROM Loans
JOIN Books ON Loans.bookId = Books.bookId
WHERE Loans.borrowerId = @BorrowerId;
