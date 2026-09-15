def calculate_average(marks):
    total = 0

    for mark in marks:
        total += mark

    return total / len(marks)


def calculate_grade(average):
    if average >= 90:
        return "A"
    elif average >= 75:
        return "B"
    elif average >= 60:
        return "C"
    else:
        return "D"


def get_mark(subject):
    while True:
        try:
            mark = int(input("Enter " + subject + " mark: "))

            if 0 <= mark <= 100:
                return mark
            else:
                print("Please enter a mark between 0 and 100.")

        except ValueError:
            print("Please enter a valid number.")


def display_result(name, marks, average, grade):
    print("\n--- Student Result ---")
    print("Name:", name)

    for subject, mark in marks.items():
        print(subject, ":", mark)

    print("Average:", round(average, 2))
    print("Grade:", grade)
    print("----------------------")


subjects = ["Python", "SQL", "Aptitude"]

while True:

    # Get student name
    while True:
        name = input("\nEnter student name: ").strip()

        if name:
            break

        print("Name cannot be empty.")

    # Get marks
    marks = {}

    for subject in subjects:
        marks[subject] = get_mark(subject)

    # Calculate result
    average = calculate_average(marks.values())
    grade = calculate_grade(average)

    # Show result
    display_result(name, marks, average, grade)

    # Ask for another student
    while True:
        choice = input("\nDo you want to enter another student? (yes/no): ").strip().lower()

        if choice == "yes":
            break
        elif choice == "no":
            print("\nThank you! Program finished.")
            exit()
        else:
            print("Please enter yes or no.")
