import pandas as pd


data = pd.read_csv("transactions.csv")

print("\n===== TRANSACTION ANALYSIS =====")

print("\nAll Transactions:")
print(data)


# Total deposits

deposits = data[
    data["Type"] == "Deposit"
]

total_deposit = deposits["Amount"].sum()

print("\nTotal Deposits:")
print("₹", total_deposit)


# Total withdrawals

withdrawals = data[
    data["Type"] == "Withdraw"
]

total_withdraw = withdrawals["Amount"].sum()

print("\nTotal Withdrawals:")
print("₹", total_withdraw)


# Number of transactions

print("\nTotal Transactions:")
print(len(data))


# Average transaction

print("\nAverage Transaction:")
print("₹", data["Amount"].mean())


# Highest transaction

print("\nHighest Transaction:")
print("₹", data["Amount"].max())


# Account-wise transactions

print("\nTransactions by Account:")

print(
    data.groupby("Account Number")["Amount"].sum()
)