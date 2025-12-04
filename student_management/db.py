import pyodbc  # type: ignore


def get_connection(): 
    conn = pyodbc.connect(
        'Driver={SQL SERVER};'
        'Server=HP\\SQLEXPRESS02;'
        'Database=student_management;'
        'Trusted_Connection=yes;'
    )
    
    return conn


def init_db():
    conn = get_connection()
    cur = conn.cursor()
    
    cur.execute(
        """
            IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'students' AND XTYPE = 'U')
            
            CREATE TABLE students (
                id INT IDENTITY(1,1) PRIMARY KEY,
                name NVARCHAR(255) NOT NULL, 
                email NVARCHAR(255) UNIQUE NOT NULL,
                phone NVARCHAR(20),
                course NVARCHAR(255) NOT NULL
            );
        """
    )
    
    conn.commit()
    conn.close()