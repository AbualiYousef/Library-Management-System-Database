-- Foreign Key Indexes on BookID and BorrowerID: 
-- These indexes improve join performance with the Books and Borrowers tables.
CREATE INDEX idx_loans_bookid ON Loans(BookID);
CREATE INDEX idx_loans_borrowerid ON Loans(BorrowerID);
-- Index on Date Borrowed and Date Returned: Useful for queries sorting or filtering by these dates.
CREATE INDEX idx_loans_dateborrowed ON Loans(DateBorrowed);
CREATE INDEX idx_loans_datereturned ON Loans(DateReturned);
-- Index on Email: Improves performance for checking the existence of an email during new borrower registration.
CREATE INDEX idx_borrowers_email ON Borrowers(Email);