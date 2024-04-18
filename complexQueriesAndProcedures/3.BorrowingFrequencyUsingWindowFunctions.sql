--3.Borrowing Frequency using Window Functions:
SELECT Borrowers.borrowerId, Borrowers.firstName, Borrowers.lastName, COUNT(Loans.borrowerId) AS TotalLoans,
       RANK() OVER (ORDER BY COUNT(Loans.borrowerId) DESC) AS BorrowerRank
FROM Borrowers
LEFT JOIN Borrowers ON Loans.borrowerId = Borrowers.borrowerId
GROUP BY Borrowers.borrowerId, Borrowers.firstName, Borrowers.lastName;
