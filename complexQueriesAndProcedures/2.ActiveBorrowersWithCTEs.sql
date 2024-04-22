--2.Active Borrowers with CTEs:
WITH ActiveBorrowers AS (
    SELECT borrowerId, COUNT(*) AS TotalLoans
    FROM Loans
    WHERE dateReturned IS NULL
    GROUP BY borrowerId
    HAVING COUNT(*) >= 2
)
SELECT Borrowers.*, ActiveBorrowers.TotalLoans
FROM ActiveBorrowers
JOIN Borrowers ON ActiveBorrowers.borrowerId = Borrowers.borrowerId;