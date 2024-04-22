-- BONUS:Weekly peak days: 

WITH LoanCounts AS (
    SELECT 
        DATENAME(weekday, dateBorrowed) AS LoanDay,
        COUNT(*) AS LoanCount
    FROM 
        Loans
    GROUP BY 
        DATENAME(weekday, dateBorrowed)
),
TotalLoans AS (
    SELECT 
        SUM(LoanCount) AS TotalLoanCount
    FROM 
        LoanCounts
)

SELECT TOP 3
    LC.LoanDay,
    LC.LoanCount,
    CAST((LC.LoanCount * 100.0 / TL.TotalLoanCount) AS DECIMAL(5, 2)) AS LoanPercentage
FROM 
    LoanCounts LC,
    TotalLoans TL
ORDER BY 
    LoanPercentage DESC;