from db import init_db
from models import add_student, view_students, search_student, update_student, delete_student

def main(): 
    init_db
    
    while True: 
        print(
            """
            \n---- Student Management System ----
            1. Add Student
            2.View All Student
            3.Search Student
            4.Update Student
            5.Delete Student
            6.Exit
            """
        )
        
        choice = input("Choose: ")
        
        match choice: 
            case "1": 
                name = input("Name: ")
                email = input("Email: ")
                phone = int(input("Phone: "))
                course = input("Course: ")

                add_student(name, email, phone, course)
                print("===> Added! <===")
            
            case "2": 
                student = view_students()
                for r in student: 
                    print(r)
            
            case "3": 
                kw = input("Search name/email: ")
                results = search_student(kw)
                for r in results: 
                    print(r)
            
            case "4": 
                sid = int(input("ID to update: "))
                name = input("Name: ")
                email = input("Email: ")
                phone = int(input("Phone: "))
                course = input("Course: ")
                
                update_student(sid, name, email, phone, course)
                print("===> Updated! <===")
            
            case "5": 
                sid = int(input("ID to delete: ")) 
                delete_student(sid)
                print("===> Deleted! <===")
            
            case "6": 
                exit()

if __name__ == "__main__":  
    main()