def calculate_average(marks):
    total = 0

    for mark in marks:
        total += mark

    average = total / len(marks)
    return average

def calculate_grade(average):
    if average >= 90:
        return "A"
    elif average >= 75:
        return "B"
    elif average >= 60:
        return "C"
    else:
        return "D"

def display_result(name, marks, average, grade):
    print("\n Student Result\n")
    print("Name:", name)

    for subject, mark in marks.items():
        print(subject, ":", mark)

    print("Average:", average)
    print("Grade:", grade)

name = input("Enter student name: ")
marks = {}
subjects = ["Python", "SQL", "Aptitude"]
for subject in subjects:
    mark = int(input("Enter " + subject + " mark: "))
    marks[subject] = mark
average = calculate_average(marks.values())
grade = calculate_grade(average)

display_result(name, marks, average, grade)