create database bank;
use bank;

CREATE TABLE transactions (
    step INT,
    type VARCHAR(20),
    amount DECIMAL(15 , 2 ),
    nameOrig VARCHAR(20),
    oldbalanceOrg DECIMAL(15 , 2 ),
    newbalanceOrig DECIMAL(15 , 2 ),
    nameDest VARCHAR(20),
    oldbalanceDest DECIMAL(15 , 2 ),
    newbalanceDest DECIMAL(15 , 2 ),
    isFraud TINYINT,
    isFlaggedFraud TINYINT
);

SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/PS_20174392719_1491204439457_log.csv"
INTO TABLE transactions 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

SELECT 
    COUNT(*)
FROM
    transactions; -- checks every row as been imported

SELECT 
    *
FROM
    transactions; -- checks the data
    
DESCRIBE transactions;

-- 1. Count Total Transactions, Fraudulent Transactions, and Flagged Transactions

SELECT 
    COUNT(*) AS Total_Transactions,
    SUM(isFraud) AS Total_Fraudulent_Transactions,
    SUM(isFlaggedFraud) AS Total_Flagged_Transactions
FROM
    transactions;
    
-- 2. Distribution of Transaction Types
-- The total count of each transaction type (e.g., CASH-IN, CASH-OUT, TRANSFER, etc.).
-- The count of fraudulent transactions for each type.

SELECT 
    type,
    COUNT(type) AS no_of_transaction,
    SUM(isfraud) AS fradulent_transaction
FROM
    transactions
GROUP BY type;

-- 3. Fraud Analysis by Transaction Amount
-- The average transaction amount for each type.
-- The maximum transaction amount for each type.
-- The number of fraudulent transactions for TRANSFER and CASH_OUT types.

SELECT 
    type,
    AVG(amount) AS avg_amount,
    MAX(amount) AS max_transaction,
    SUM(isfraud) AS fradulent_transaction
FROM
    transactions
WHERE
    type = 'TRANSFER' OR type = 'CASH_OUT'
GROUP BY type;

-- 4. Identify Anomalous Balances in Fraudulent Transactions
-- Write a SQL query to find fraudulent TRANSFER and CASH_OUT transactions where:
-- The sender’s new balance (newbalanceOrig) doesn’t match the transaction (oldbalanceOrg - amount).
-- Or, the recipient’s new balance (newbalanceDest) doesn’t match (oldbalanceDest + amount).

SELECT 
    *
FROM
    transactions
WHERE
    isfraud = 1
        AND type IN ('CASH_OUT' , 'TRANSFER')
        AND (newbalanceorig <> (oldbalanceorg - amount)
        OR newbalancedest <> (oldbalancedest + amount));

-- 5.Frequent Anomalous Accounts 
-- Write a query to identify accounts (nameOrig and nameDest) that appear most frequently among these 4,897 anomalous fraudulent transactions. 

with fradulent_transaction as
(
select * from transactions
where isfraud = 1
and
type in ('CASH_OUT','TRANSFER')
and
( newbalanceorig <> (oldbalanceorg-amount) or newbalancedest <> (oldbalancedest+amount))
)
select nameorig,count(nameorig) as no_of_transaction,namedest,count(namedest) as no_of_money_recieved
from fradulent_transaction
group by nameorig,namedest
order by no_of_transaction desc,no_of_money_recieved desc;

-- 6.Analyze Transaction Amounts
-- Task: Write a SQL query to calculate the average and maximum transaction amounts for the fraudulent CASH_OUT and TRANSFER transactions, grouped by the nameOrig account.

SELECT 
    nameOrig,
    AVG(amount) AS avg_amount,
    MAX(amount) AS max_amount
FROM
    transactions
WHERE
    isFraud = 1
        AND type IN ('CASH_OUT' , 'TRANSFER')
        AND amount > 0
GROUP BY nameOrig
ORDER BY max_amount DESC;

-- 7.Analyze Transaction Patterns
-- Task: Let's investigate how fraudulent transactions are distributed over time.

SELECT 
    step, COUNT(*) AS no_of_fraudulent_transactions
FROM
    transactions
WHERE
    isFraud = 1
GROUP BY step
ORDER BY step;

-- 9.Find the Time with the Highest Number of Fraudulent Transactions

SELECT 
    step, COUNT(*) AS no_of_fraudulent_transactions
FROM
    transactions
WHERE
    isFraud = 1
GROUP BY step
ORDER BY no_of_fraudulent_transactions DESC
LIMIT 1;

-- 10.Analyze Transaction Types for the Most Fraudulent Step 
-- 
select step,type,count(type) as no_of_times
from transactions
where step = '212'
and type IN ('CASH_OUT' , 'TRANSFER')
group by type;

-- Analyze Transaction Amounts for Fraudulent Transactions at Step 212

SELECT 
    type,
    AVG(amount) AS avg_amount,
    MAX(amount) AS max_amount,
    MIN(amount) AS min_amount
FROM
    transactions
WHERE
    step = '212'
        AND type IN ('CASH_OUT' , 'TRANSFER')
GROUP BY type;

-- 11. Investigate the Relationship Between Transaction Amounts and Fraud

SELECT 
    CASE
        WHEN amount BETWEEN 0 AND 50000 THEN '0-50000'
        WHEN amount BETWEEN 50000 AND 200000 THEN '50k-200k'
        WHEN amount BETWEEN 200000 AND 500000 THEN '200k-500k'
        ELSE '>500k'
    END AS amount_cat,
    AVG(amount) AS avg_amount,
    MAX(amount) AS max_transaction,
    MIN(amount) AS min_transaction,
    SUM(isfraud) AS no_of_frauds
FROM
    transactions
WHERE
    isfraud = 1
GROUP BY amount_cat
ORDER BY no_of_frauds DESC;

-- Can you find out how many fraudulent transactions were there for each type (CASH_OUT, TRANSFER, CASH_IN, etc.)? 
-- What is the percentage of fraudulent transactions compared to the total transactions for each type?

SELECT 
    CASE
        WHEN amount BETWEEN 0 AND 50000 THEN '0-50k'
        WHEN amount BETWEEN 50000 AND 200000 THEN '50k-200k'
        WHEN amount BETWEEN 200000 AND 500000 THEN '200k-500k'
        ELSE '>500k'
    END AS amount_cat,type,
    SUM(isfraud) AS no_of_frauds
FROM
    transactions
WHERE
    isfraud = 1
GROUP BY amount_cat,type
ORDER BY amount_cat;

-----

WITH total_transactions AS (
    SELECT 
        type,
        COUNT(*) AS total_count
    FROM 
        transactions
    GROUP BY 
        type
)

SELECT 
    CASE
        WHEN amount BETWEEN 0 AND 50000 THEN '0-50000'
        WHEN amount BETWEEN 50000 AND 200000 THEN '50k-200k'
        WHEN amount BETWEEN 200000 AND 500000 THEN '200k-500k'
        ELSE '>500k'
    END AS amount_cat,
    t.type,
    SUM(t.isfraud) AS no_of_frauds,
    tt.total_count,
    (SUM(t.isfraud) * 100.0 / tt.total_count) AS fraud_percentage
FROM 
    transactions t
JOIN 
    total_transactions tt ON t.type = tt.type
WHERE 
    t.isfraud = 1
GROUP BY 
    amount_cat, t.type, tt.total_count
ORDER BY 
    amount_cat;













