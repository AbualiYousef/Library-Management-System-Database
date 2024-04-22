--8.Overdue Analysis: List all books overdue by more than 30 days with their associated borrowers.

SELECT b.*,bo.*,
    DATEDIFF(DAY, l.dueDate, GETDATE()) AS DaysOverdue
FROM 
    Loans l
    JOIN Books b ON l.bookId = b.bookId
    JOIN Borrowers bo ON l.borrowerId = bo.borrowerId
WHERE 
    l.dateReturned IS NULL AND 
    DATEDIFF(DAY, l.dueDate, GETDATE()) > 30;
