
# Bank Fraud Detection Project

## Project Overview

This project focuses on detecting fraudulent transactions within a banking dataset. The analysis leverages various attributes of transactions to identify patterns indicative of fraud. The dataset simulates transactions over a 30-day period, providing insights into the behaviors of legitimate and fraudulent activities.

## Dataset Description

The dataset consists of the following columns:

1. **step**: 
   - Represents the unit of time for transactions. Each step is equivalent to 1 hour. The total number of steps is 744, simulating 30 days.

2. **type**: 
   - Type of transaction:
     - **CASH-IN**: Depositing money into an account.
     - **CASH-OUT**: Withdrawing money from an account.
     - **DEBIT**: Direct withdrawal from an account.
     - **PAYMENT**: Payments made to merchants or for services.
     - **TRANSFER**: Transferring funds between accounts.

3. **amount**: 
   - Amount of money involved in the transaction, in local currency.

4. **nameOrig**: 
   - ID of the customer who initiated the transaction.

5. **oldbalanceOrg**: 
   - Balance of the origin account before the transaction.

6. **newbalanceOrig**: 
   - Balance of the origin account after the transaction.

7. **nameDest**: 
   - ID of the recipient account.

8. **oldbalanceDest**: 
   - Balance of the destination account before the transaction.

9. **newbalanceDest**: 
   - Balance of the destination account after the transaction.

10. **isFraud**: 
    - Target column for fraud detection. A value of `1` indicates a fraudulent transaction, while `0` indicates a legitimate transaction.

11. **isFlaggedFraud**: 
    - Indicates whether a transaction has been flagged as suspicious. Transactions flagged involve transfers exceeding `200,000`.
   
Here’s the complete report, including all the questions you worked on during your analysis:

---

# Fraud Detection in Transactions Report

## Overview
This report outlines the steps taken to analyze transaction data to detect fraudulent activities. The analysis focuses on different transaction types, amounts, and potential fraud indicators.

## Questions Explored

1. **What is the total number of transactions, and how many of these are fraudulent?**
   
2. **How many transactions are there for each type, and how many of these are flagged as fraudulent?**
   
3. **What are the average and maximum transaction amounts for the types `TRANSFER` and `CASH_OUT`, along with the count of fraudulent transactions for each?**
   
4. **Are there discrepancies in the balances of accounts involved in fraudulent transactions?**
   
5. **What are the details of the fraudulent transactions involving `CASH_OUT` and `TRANSFER` types, and how many unique accounts are involved?**
   
6. **How can we categorize transactions into ranges and analyze the fraud rates across different transaction sizes?**
   
7. **What is the relationship between transaction types and their amounts, and what is the percentage of fraudulent transactions for each category and type?**
   
8. **What if we don't know a specific step (e.g., step 212) in the analysis process? How can we identify the number of transactions for each type?**
   
9. **How many transactions occur at step 212 for each transaction type?**
   
10. **What are the transaction amounts for each categorized range, along with the count of fraudulent transactions?**
   
11. **How do transaction amounts relate to the number of fraudulent transactions?**

12. **What are the average, maximum, and minimum transaction amounts for different transaction types along with the count of fraudulent transactions for each?**

13. **What are the percentages of fraudulent transactions in each categorized amount range for different transaction types?**

14. **What is the breakdown of fraudulent transactions based on transaction type and amount category?**

## Conclusion
The analysis conducted provides insights into the patterns and anomalies in transaction data that may indicate fraudulent behavior. The structured approach to questioning has helped in systematically uncovering these insights, contributing to a better understanding of transaction fraud dynamics.

---

