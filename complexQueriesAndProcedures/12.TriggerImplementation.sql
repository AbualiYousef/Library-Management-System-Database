--12.Trigger Implementation
DROP TRIGGER IF EXISTS trg_BookStatusChange;
GO
CREATE TRIGGER trg_BookStatusChange ON Books
AFTER UPDATE
AS
BEGIN
	DECLARE @BookID INT;
    DECLARE @OldStatus VARCHAR(50);
    DECLARE @NewStatus VARCHAR(50);
	DECLARE @StatusChange VARCHAR(100);
 IF UPDATE(currentStatus)
    BEGIN
        SELECT @BookID = i.bookId, @OldStatus = d.currentStatus, @NewStatus = i.currentStatus
        FROM inserted i
        JOIN deleted d ON i.bookId = d.bookId;

        IF (@OldStatus <> @NewStatus)
        BEGIN
			SET @StatusChange = 'Status changed from ' + @OldStatus + ' to ' + @NewStatus;
            INSERT INTO AuditLog
            VALUES (@BookID, @StatusChange, GETDATE());
        END
    END
END;

-- Example to update a book's status to 'Borrowed'
UPDATE Books
SET currentStatus = 'Borrowed'
WHERE bookId = 1 AND currentStatus = 'Available';

-- Example to update a book's status to 'Available'
UPDATE Books
SET currentStatus = 'Available'
WHERE bookId = 1 AND currentStatus = 'Borrowed';

-- Check the AuditLog:
SELECT * FROM AuditLog;
