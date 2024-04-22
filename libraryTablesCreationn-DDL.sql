CREATE TABLE Books(
    bookId INT PRIMARY KEY IDENTITY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) NOT NULL UNIQUE,
    publishedDate DATE NOT NULL,
    genre VARCHAR(255) NOT NULL,
    shelfLocation VARCHAR(10) NOT NULL,
    currentStatus VARCHAR(10) NOT NULL CHECK(currentStatus IN ('Available', 'Borrowed'))
);

CREATE TABLE Borrowers(
    borrowerId INT PRIMARY KEY IDENTITY,
    firstName VARCHAR(255) NOT NULL,
    lastName VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL CHECK(email LIKE '%@%.%'),
    dateOfBirth DATE NOT NULL,
    membershipDate DATE NOT NULL
);

CREATE TABLE Loans(
    loanId INT PRIMARY KEY IDENTITY,
    dateBorrowed DATE NOT NULL,
    dueDate DATE NOT NULL,
    dateReturned DATE,
	bookId INT FOREIGN KEY REFERENCES books(bookId),
    borrowerId INT FOREIGN KEY REFERENCES borrowers(borrowerId)
);

CREATE TABLE AuditLog (
    auditLogID INT PRIMARY KEY IDENTITY,
    bookID INT NOT NULL,
    statusChange VARCHAR(50) NOT NULL,
    changeDate DATETIME DEFAULT GETDATE()
);