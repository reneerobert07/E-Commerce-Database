-- Question 6 Creating a trigger for a customer trying to open a new return when they already have a pending return
CREATE TRIGGER prevent_multiple_pending_returns
BEFORE INSERT ON Return
FOR EACH ROW
BEGIN
    -- Prevent inserting a new return if there is already a pending return for the same order
    SELECT 
        CASE
            WHEN EXISTS (
                SELECT 1 
                FROM Return 
                WHERE Order_Number = NEW.Order_Number
                AND Return_Status = 'Pending'
            )
            THEN
                RAISE(ABORT, 'A pending return already exists for this order.')
        END;
END;

-- Question 6 Inserting a new query to pass the trigger.
INSERT INTO Return (Return_Ticket_Number, Return_Start_Date, Return_Due_Date, Return_Amount, Return_Status, Order_Number)
VALUES ('R005', '2024-11-25', '2024-12-05', 60.00, 'Pending', 'O789');

-- Question 6 Inserting a new query to violate the trigger.
INSERT INTO Return (Return_Ticket_Number, Return_Start_Date, Return_Due_Date, Return_Amount, Return_Status, Order_Number)
VALUES ('R002', '2024-11-30', '2024-12-10', 50.00, 'Pending', 'O789');