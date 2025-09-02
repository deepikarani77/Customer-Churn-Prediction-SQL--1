-- Project Title: Customer Churn Prediction – SQL Workflow

# 1. DQL – Data Query Language (Retrieve Data)
-- Goal: Find insights from churned customers.

use customer_churn_db;

-- Retrieve all customers who churned with high monthly charges
SELECT 
    customerID, gender, tenure, MonthlyCharges, Contract, Churn
FROM
    customer_churn
WHERE
    Churn = 'Yes' AND MonthlyCharges > 80
ORDER BY MonthlyCharges DESC;

--  This shows which customers are leaving despite paying high bills.

# 2. DDL – Data Definition Language (Define Schema)
-- Goal: Normalize data by creating separate tables. Example: Customers and Contracts.

-- Create Customers table
CREATE TABLE Customers (
    customerID VARCHAR(20) PRIMARY KEY,
    gender VARCHAR(10),
    SeniorCitizen INT,
    Partner VARCHAR(10),
    Dependents VARCHAR(10),
    tenure INT,
    MonthlyCharges DECIMAL(10,2),
    TotalCharges DECIMAL(10,2),
    Churn VARCHAR(10)
);

-- Create Contracts table
CREATE TABLE Contracts (
    ContractID INT AUTO_INCREMENT PRIMARY KEY,
    customerID VARCHAR(20),
    Contract VARCHAR(50),
    PaymentMethod VARCHAR(50),
    PaperlessBilling VARCHAR(10),
    FOREIGN KEY (customerID) REFERENCES Customers(customerID)
);

-- This ensures clean data structure for analysis.

# 3. DML – Data Manipulation Language (Modify Data)
-- Goal: Insert, update, and delete records.

-- Insert a new customer
INSERT INTO Customers (customerID, gender, SeniorCitizen, Partner, Dependents, tenure, MonthlyCharges, TotalCharges, Churn)
VALUES ('C9001', 'Female', 0, 'Yes', 'No', 12, 85.50, 1026.00, 'No');

-- Update churn status for a specific customer
UPDATE Customers
SET Churn = 'Yes'
WHERE customerID = 'C9001';

-- Delete a customer record
DELETE FROM Customers
WHERE customerID = 'C9001';

-- This shows your ability to handle data changes.

# 4. DCL – Data Control Language (Access Control)
-- Goal: Manage permissions.

-- Grant read-only access to analyst
GRANT SELECT ON Customers TO analyst_user;

-- Revoke access if needed
REVOKE SELECT ON Customers FROM analyst_user;

-- This demonstrates data security and controlled access.

# 5. TCL – Transaction Control Language (Ensure Safety)
-- Goal: Make safe updates using transactions.

-- Start transaction
BEGIN;

-- Update churn values for long-tenure customers
UPDATE Customers
SET Churn = 'No'
WHERE tenure > 60;

-- Rollback if wrong
ROLLBACK;

-- Commit if correct
COMMIT;

-- This prevents mistakes from corrupting the database.









