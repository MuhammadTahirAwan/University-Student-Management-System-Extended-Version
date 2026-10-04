import Foundation

class Person {
    var name: String
    var age: Int
    
    static let minAgeForEnrollment: Int = 16
    
    var isAdult: Bool {
        age >= 18
    }
    
    lazy var profileDescription: String = {
        "\(name) is \(age) years old."
    }()
    
    init?(name: String, age: Int) {

        guard age >= Person.minAgeForEnrollment else {
            return nil
        }
        self.name = name
        self.age = age
    }
}

class Student: Person {
    var studentID: String
    var major: String
    
    static var studentCount: Int = 0
    
    weak var advisor: Professor?
    
    var formattedID: String {
        "ID: \(studentID.uppercased())"
    }
    
    required init?(name: String, age: Int, studentID: String, major: String) {
        self.studentID = studentID
        self.major = major
        
        super.init(name: name, age: age)
        
        Student.studentCount += 1
    }
    
    convenience init?(name: String, studentID: String, major: String) {
        self.init(name: name, age: 18, studentID: studentID, major: major)
    }
}

class Professor: Person {
    var faculty: String
    
    static var professorCount: Int = 0
    
    var fullTitle: String {
        "Professor \(name), Faculty of \(faculty)"
    }
    
    init?(name: String, age: Int, faculty: String) {
        self.faculty = faculty
        super.init(name: name, age: age)
        
        Professor.professorCount += 1
    }
}

struct University {
    var name: String
    var location: String
    
    var description: String {
        "\(name), located in \(location)"
    }
}

// MARK: - Verification
let prof = Professor(name: "Dr. Smith", age: 45, faculty: "Engineering")
let student = Student(name: "Haris", studentID: "stu-101", major: "Computer Science")

// Assign the weak reference
student?.advisor = prof

print("Student formatted ID: \(student?.formattedID ?? "")") // ID: STU-101
print("Professor Title: \(prof?.fullTitle ?? "")")
print("Advisor Name: \(student?.advisor?.name ?? "None")")

// Counters incremented automatically:
print("Total Students: \(Student.studentCount)")       // 1
print("Total Professors: \(Professor.professorCount)") // 1
