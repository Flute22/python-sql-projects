from db import get_connection

def add_student(name, email, phone, course):
    conn = get_connection ()
    cur = conn.cursor()
    
    cur.execute(
        """
            INSERT INTO students(name, email, phone, course)
            VALUES (?, ?, ?, ?)
        """, (name, email, phone, course)
    )
    
    conn.commit()
    conn.close()


def view_students():
    conn = get_connection()
    cur = conn.cursor()
    
    cur.execute("SELECT * FROM students")
    # ==> What rows doing here
    rows = cur.fetchall()
    
    conn.close()
    return rows


def search_student(keyword):
    conn = get_connection()
    cur = conn.cursor()
    
    cur.execute(
        """
            SELECT * FROM students
            WHERE name like ? or email like ? 
        """, (f"%{keyword}%", f"%{keyword}%")
    )
    
    rows = cur.fetchall()
    conn.close()
    return rows


def update_student(student_id, name, email, phone, course): 
    conn = get_connection()
    cur = conn.cursor()
    
    cur.execute(
        """
            UPDATE students
            SET name=?, email=?, phone=?, course=?
            WHERE id=?
        """, (name, email, phone, course, student_id)
    )
    
    conn.commit()
    cur.close()
    

def delete_student(student_id):
    conn = get_connection()
    cur = conn.cursor()
    
    cur.execute("DELETE FROM students WHERE id=?", (student_id,))
    
    conn.commit()
    conn.close()

