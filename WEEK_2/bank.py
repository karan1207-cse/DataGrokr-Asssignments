import csv
from datetime import datetime


class BankAccount:

    def __init__(self, name, account_number, balance=0):
        self.name = name
        self.account_number = account_number
        self.balance = balance
        self.transactions = []

    def deposit(self, amount):

        if amount > 0:
            self.balance += amount

            self.transactions.append([
                self.account_number,
                "Deposit",
                amount,
                datetime.now().strftime("%Y-%m-%d")
            ])

            print("Money deposited successfully.")

        else:
            print("Invalid amount.")

    def withdraw(self, amount):

        if amount <= 0:
            print("Invalid amount.")

        elif amount > self.balance:
            print("Insufficient balance.")

        else:
            self.balance -= amount

            self.transactions.append([
                self.account_number,
                "Withdraw",
                amount,
                datetime.now().strftime("%Y-%m-%d")
            ])

            print("Money withdrawn successfully.")

    def show_balance(self):

        print("\nAccount Holder:", self.name)
        print("Account Number:", self.account_number)
        print("Balance: ₹", self.balance)

    def show_transactions(self):

        print("\nTransaction History")

        if len(self.transactions) == 0:
            print("No transactions.")

        else:
            for transaction in self.transactions:
                print(transaction)


def save_transactions(accounts):

    with open(
        "transactions.csv",
        "w",
        newline=""
    ) as file:

        writer = csv.writer(file)

        writer.writerow([
            "Account Number",
            "Type",
            "Amount",
            "Date"
        ])

        for account in accounts:

            for transaction in account.transactions:
                writer.writerow(transaction)

    print("\nTransactions saved to CSV.")