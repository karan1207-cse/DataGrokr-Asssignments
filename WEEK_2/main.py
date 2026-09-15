from bank import BankAccount, save_transactions


accounts = []


while True:

    print("\n===== BANK ACCOUNT SYSTEM =====")
    print("1. Create Account")
    print("2. Deposit")
    print("3. Withdraw")
    print("4. Check Balance")
    print("5. Transaction History")
    print("6. Save and Exit")

    choice = input("Enter choice: ")

    # Create Account
    if choice == "1":

        name = input("Enter name: ")
        account_number = input("Enter account number: ")

        balance = float(
            input("Enter initial balance: ₹")
        )

        account = BankAccount(
            name,
            account_number,
            balance
        )

        accounts.append(account)

        print("Account created successfully.")

    # Deposit
    elif choice == "2":

        account_number = input(
            "Enter account number: "
        )

        amount = float(
            input("Enter amount: ₹")
        )

        for account in accounts:

            if account.account_number == account_number:
                account.deposit(amount)
                break

        else:
            print("Account not found.")

    # Withdraw
    elif choice == "3":

        account_number = input(
            "Enter account number: "
        )

        amount = float(
            input("Enter amount: ₹")
        )

        for account in accounts:

            if account.account_number == account_number:
                account.withdraw(amount)
                break

        else:
            print("Account not found.")

    # Balance
    elif choice == "4":

        account_number = input(
            "Enter account number: "
        )

        for account in accounts:

            if account.account_number == account_number:
                account.show_balance()
                break

        else:
            print("Account not found.")

    # Transactions
    elif choice == "5":

        account_number = input(
            "Enter account number: "
        )

        for account in accounts:

            if account.account_number == account_number:
                account.show_transactions()
                break

        else:
            print("Account not found.")

    # Save
    elif choice == "6":

        save_transactions(accounts)

        print("Thank you!")
        break

    else:

        print("Invalid choice.")