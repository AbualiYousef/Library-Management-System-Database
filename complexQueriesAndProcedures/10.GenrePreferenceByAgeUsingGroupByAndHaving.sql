--10.Genre Preference by Age using Group By and Having:
WITH BorrowerAges AS (
    SELECT
        borrowerId,
        (DATEDIFF(YEAR, dateOfBirth, GETDATE()) / 10) * 10 AS AgeBracket
    FROM
        Borrowers
),
LoanGenres AS (
    SELECT
        ba.AgeBracket,
        b.genre,
        COUNT(*) AS GenreCount
    FROM
        BorrowerAges ba
        JOIN Loans l ON ba.borrowerId = l.borrowerId
        JOIN Books b ON l.bookId = b.bookId
    GROUP BY
        ba.AgeBracket,
        b.genre
),
RankedGenres AS (
    SELECT
        AgeBracket,
        genre,
        GenreCount,
        ROW_NUMBER() OVER (
            PARTITION BY AgeBracket 
            ORDER BY GenreCount DESC, genre ASC
        ) AS RowNum
    FROM
        LoanGenres
)
SELECT 
    CASE 
        WHEN AgeBracket = 0 THEN '0-10'
        WHEN AgeBracket = 10 THEN '11-20'
        WHEN AgeBracket = 20 THEN '21-30'
        WHEN AgeBracket = 30 THEN '31-40'
        WHEN AgeBracket = 40 THEN '41-50'
        WHEN AgeBracket = 50 THEN '51-60'
        WHEN AgeBracket >= 60 THEN '61+'
        ELSE 'Unknown'
    END AS AgeGroup,
    genre,
    GenreCount
FROM
    RankedGenres
WHERE
    RowNum = 1
ORDER BY
    AgeBracket;
