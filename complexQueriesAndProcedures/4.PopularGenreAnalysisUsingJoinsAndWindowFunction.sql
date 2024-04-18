--4.Popular Genre Analysis using Joins and Window Functions:
DECLARE @Month INT=4;
DECLARE @Year INT=2022;
SELECT genre, COUNT(*) AS TotalLoans, 
       RANK() OVER (ORDER BY COUNT(*) DESC) AS GenreRank
FROM Loans
JOIN Books ON Loans.bookId = Books.bookId
WHERE MONTH(dateBorrowed) = @Month AND YEAR(dateBorrowed) = @Year
GROUP BY genre;