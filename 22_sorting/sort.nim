# Example of sorting students by their GPA

import sorting/quickSort

type
    Student = object
      name: string
      gpa: float

proc `<`*(a, b: Student): bool {.inline.} =
    return a.gpa < b.gpa

var students: array[4, Student] = [Student(name: "Bob", gpa: 4.2),
                                   Student(name: "Diana", gpa: 4.9),
                                   Student(name: "Julie", gpa: 3.7),
                                   Student(name: "Max", gpa: 2.6)]

students.quickSort()

assert students == [Student(name: "Max", gpa: 2.6),
                    Student(name: "Julie", gpa: 3.7),
                    Student(name: "Bob", gpa: 4.2),
                    Student(name: "Diana", gpa: 4.9)]