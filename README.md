
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

