# Bank Account Project

This is a simple Python bank account management project. It allows a user to
create accounts, add or withdraw money, check balances, and view transactions.
The transaction details can also be saved in a CSV file for later use.

## Features

- Create and manage bank accounts
- Deposit money into an account
- Withdraw money when sufficient balance is available
- Check the account holder's balance
- View transaction history
- Save transactions to `transactions.csv`
- Display helpful messages for invalid amounts and insufficient balance

## Project Files

- `main.py` - Starts the bank account application.
- `bank.py` - Contains the `BankAccount` class and account operations.
- `analysis.py` - Provides transaction analysis functionality.
- `transactions.csv` - Stores saved transaction records.
- `requirements.txt` - Lists the project dependencies.

## How To Run

Open a terminal in this folder and run:

```bash
python main.py
```

Follow the prompts shown in the terminal to create an account and perform
banking operations.

## Example Operations

The application can perform operations such as:

```text
Deposit: 1000
Withdraw: 250
Current balance: 750
```

After transactions are saved, they are written to `transactions.csv` with the
account number, transaction type, amount, and date.