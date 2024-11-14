-- Customer Table
CREATE TABLE Customer (
    Cust_Email VARCHAR(255) PRIMARY KEY NOT NULL,
    Cust_Name TEXT NOT NULL,
    Cust_Password TEXT NOT NULL,
    Cust_Birthdate DATE NOT NULL,
    Cust_Phone TEXT NOT NULL
);

-- Customer Address Table
CREATE TABLE Customer_Address (
    Addr_ID INTEGER PRIMARY KEY NOT NULL,
    Cust_Email VARCHAR(255) NOT NULL,
    Addr_BuildingName TEXT,
    Addr_BuildingNumber TEXT,
    Addr_Street TEXT NOT NULL,
    Addr_City TEXT NOT NULL,
    Addr_Country TEXT NOT NULL,
    Addr_Postcode TEXT NOT NULL,
    FOREIGN KEY (Cust_Email) REFERENCES Customer(Cust_Email),
    CHECK (
        (Addr_BuildingName IS NOT NULL OR Addr_BuildingNumber IS NOT NULL) AND 
        NOT (Addr_BuildingName IS NULL AND Addr_BuildingNumber IS NULL)
    )
);

-- Delivery Address Table
CREATE TABLE Delivery_Address (
    Delivery_Addr_ID INTEGER PRIMARY KEY NOT NULL,
    Delivery_Addr_BuildingName TEXT,
    Delivery_Addr_BuildingNumber TEXT,
    Delivery_Addr_Street TEXT NOT NULL,
    Delivery_Addr_City TEXT NOT NULL,
    Delivery_Addr_Country TEXT NOT NULL,
    Delivery_Addr_Postcode TEXT NOT NULL,
    CHECK (
        (Delivery_Addr_BuildingName IS NOT NULL OR Delivery_Addr_BuildingNumber IS NOT NULL) AND 
        NOT (Delivery_Addr_BuildingName IS NULL AND Delivery_Addr_BuildingNumber IS NULL)
    )
);

-- Payment Method Table
CREATE TABLE Payment_Method (
    Payment_ID INTEGER PRIMARY KEY NOT NULL,
    Cust_Email VARCHAR(255) NOT NULL,
	Payment_Type TEXT NOT NULL,
    FOREIGN KEY (Cust_Email) REFERENCES Customer(Cust_Email)
);

-- Credit/Debit Card Table
CREATE TABLE CreditDebit_Card (
    Payment_ID INTEGER PRIMARY KEY NOT NULL,
    Card_Number TEXT UNIQUE NOT NULL,
    Name_On_Card TEXT NOT NULL,
    Expiry_Date DATE NOT NULL,
    Verification_Code TEXT NOT NULL,
    Is_Default_Payment INTEGER NOT NULL,
    FOREIGN KEY (Payment_ID) REFERENCES Payment_Method(Payment_ID)
);

-- Gift Card Table
CREATE TABLE Gift_Card (
    Payment_ID INTEGER PRIMARY KEY NOT NULL,
    Serial_Number TEXT UNIQUE NOT NULL,
    Expiry_Date DATE NOT NULL,
    Total_Amount_Loaded REAL NOT NULL,
    Current_Balance REAL NOT NULL,
    FOREIGN KEY (Payment_ID) REFERENCES Payment_Method(Payment_ID)
);


-- Product Table
CREATE TABLE Product (
    Prod_Number TEXT PRIMARY KEY NOT NULL,
    Prod_Name TEXT NOT NULL,
    Prod_Brand TEXT NOT NULL,
    Prod_Description TEXT NOT NULL,
    Prod_Warranty INTEGER NOT NULL,
    Prod_Stock INTEGER NOT NULL,
    Prod_Dimensions TEXT NOT NULL,
    Prod_Weight REAL NOT NULL,
    Prod_Colour TEXT NOT NULL,
    Prod_Price REAL NOT NULL,
    Category_ID INTEGER NOT NULL,
    FOREIGN KEY (Category_ID) REFERENCES Category(Category_ID)
);

-- Category Table
CREATE TABLE Category (
    Category_ID INTEGER PRIMARY KEY NOT NULL,
    Category_Name TEXT NOT NULL,
    Category_Description TEXT NOT NULL
);

-- Customer Order Table
CREATE TABLE Customer_Order (
    Order_Number TEXT PRIMARY KEY NOT NULL,
    Order_Date DATE NOT NULL,
    Order_Subtotal REAL NOT NULL,
    Order_GrandTotal REAL NOT NULL,
    Cust_Email VARCHAR(255) NOT NULL,
    Payment_ID INTEGER NOT NULL,
    FOREIGN KEY (Cust_Email) REFERENCES Customer(Cust_Email),
    FOREIGN KEY (Payment_ID) REFERENCES Payment_Method(Payment_ID)
);

-- Order Details Table
CREATE TABLE Order_Details (
    Order_Number TEXT NOT NULL,
    Prod_Number TEXT NOT NULL,
    Quantity INTEGER NOT NULL,
    Price_At_Purchase REAL NOT NULL,
    FOREIGN KEY (Order_Number) REFERENCES Customer_Order(Order_Number),
    FOREIGN KEY (Prod_Number) REFERENCES Product(Prod_Number)
);

-- Delivery Table
CREATE TABLE Delivery (
    Delivery_Track_Number TEXT PRIMARY KEY NOT NULL,    
    Delivery_Date DATE NOT NULL,                        
    Delivery_Status TEXT NOT NULL,                      
    Order_Number TEXT NOT NULL,                         
    Delivery_Addr_ID INTEGER NOT NULL,                  
    FOREIGN KEY (Order_Number) REFERENCES Customer_Order(Order_Number),
    FOREIGN KEY (Delivery_Addr_ID) REFERENCES Delivery_Address(Delivery_Addr_ID)
);


-- Return Table
CREATE TABLE Return (
    Return_Ticket_Number TEXT PRIMARY KEY NOT NULL,
    Return_Start_Date DATE NOT NULL,
    Return_Due_Date DATE NOT NULL,
    Return_Amount REAL NOT NULL,
    Return_Status TEXT NOT NULL,
    Order_Number TEXT NOT NULL,
    FOREIGN KEY (Order_Number) REFERENCES Customer_Order(Order_Number)
);

-- Return Details Table
CREATE TABLE "Return Details" (
    Return_Ticket_Number TEXT NOT NULL,
    Prod_Number TEXT NOT NULL,
    Quantity_Returned INTEGER NOT NULL,
    Reason_For_Return TEXT NOT NULL,
    FOREIGN KEY (Return_Ticket_Number) REFERENCES Return(Return_Ticket_Number),
    FOREIGN KEY (Prod_Number) REFERENCES Product(Prod_Number)
);

-- Review Table
CREATE TABLE Review (
    Review_Number TEXT PRIMARY KEY NOT NULL,  -- Changed to TEXT since it has letters and numbers
    Review_Date DATE NOT NULL,
    Review_Text TEXT NOT NULL,
    Review_Ranking INTEGER NOT NULL CHECK (Review_Ranking BETWEEN 1 AND 5),
    Cust_Email VARCHAR(255) NOT NULL,
    Prod_Number TEXT NOT NULL,
    FOREIGN KEY (Cust_Email) REFERENCES Customer(Cust_Email),
    FOREIGN KEY (Prod_Number) REFERENCES Product(Prod_Number)
);

-- Basket Table
CREATE TABLE Basket (
    Basket_Number TEXT PRIMARY KEY NOT NULL,
    Cust_Email VARCHAR(255) NOT NULL,
    FOREIGN KEY (Cust_Email) REFERENCES Customer(Cust_Email)
);

-- Basket Details Table
CREATE TABLE "Basket Details" (
    Basket_Number TEXT NOT NULL,
    Prod_Number TEXT NOT NULL,
    Quantity INTEGER NOT NULL,
    FOREIGN KEY (Basket_Number) REFERENCES Basket(Basket_Number),
    FOREIGN KEY (Prod_Number) REFERENCES Product(Prod_Number)
);

-- Review Table
CREATE TABLE Review (
    Review_Number TEXT PRIMARY KEY NOT NULL,  
    Review_Date DATE NOT NULL,            
    Review_Text TEXT NOT NULL,                
    Review_Ranking INTEGER NOT NULL CHECK (Review_Ranking BETWEEN 1 AND 5),  
    Cust_Email VARCHAR(255) NOT NULL,       
    Prod_Number TEXT NOT NULL,               
    FOREIGN KEY (Cust_Email) REFERENCES Customer(Cust_Email), 
    FOREIGN KEY (Prod_Number) REFERENCES Product(Prod_Number)  
