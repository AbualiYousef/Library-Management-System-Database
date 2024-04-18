--9.Author Popularity using Aggregation:

SELECT
    b.author,
    COUNT(l.loanId) AS BorrowingCount,
    RANK() OVER (ORDER BY COUNT(l.loanId) DESC) AS AuthorRank
FROM
    Books b
    LEFT JOIN Loans l ON b.bookId = l.bookId
GROUP BY
    b.author