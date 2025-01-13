# 🎥 Movie Theater Management System - Database Management Project

A database-driven application designed to manage a movie theater's operations, including scheduling, reservations, and hall management. This project was developed as part of a college database management system (DBMS) course.

---

## 🌟 Features

- **Database Design**: Fully normalized relational database schema with an ER Diagram.
- **Core Functionalities**: 
  - Manages movie schedules, theater halls, and customer reservations.
  - Provides data consistency and efficient operations through SQL queries.
- **Frontend**: 
  - Dynamic and responsive UI built with HTML and CSS.
  - Templates for user interaction and result visualization.
- **Backend**: 
  - Python-based logic to handle business requirements.
- **Documentation**: 
  - Includes project requirements, ER diagram, and relational mapping.

---

## 📂 Folder Structure

```bash
 Movie Theater Management System
    ├── static                    # Static files for the frontend
    │   ├── css                   # CSS files for styling
    │   │   └── style.css
    │   ├── images                # Images used in the project
    │   │   ├── cinema-screen.jpg
    │   │   └── Relational Mapping.jpg
    ├── templates                 # HTML templates for the frontend
    │   ├── index.html
    │   └── result.html
    ├── pycache                   # Compiled Python files
    │   └── models.cpython-312.pyc
    ├── database                  # Database-related files
    │   ├── schema.sql            # SQL script for creating the database
    │   └── ER-Diagram.png        # Entity-Relationship Diagram
    ├── docs                      # Documentation files
    │   └── requirements.pdf      # Project requirements document
    ├── app.py                    # Main application script
    ├── config.py                 # Configuration settings
    ├── models.py                 # Python file for database models
    └── requirements.txt          # Python dependencies file
```

---

## 🛠️ Technologies Used

- **Frontend**: HTML, CSS
- **Backend**: Python
- **Database**: SQL (SQLite or any DBMS)
- **Tools**: ER Diagramming Tools, SQLite

---
## 🚀 How to Run the Project

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/Movie-Theater-Management-System.git
   cd Movie-Theater-Management-System
   
2. Set up the database:
   - Navigate to the /database folder and run the schema.sql script to create the database.
3. Install dependencies:
```bash
pip install -r requirements.txt
```
4. Run the application:
  ```bash
  python app.py
```
5. Open the app in your browser: Visit http://localhost:5000

---

📄 Documentation
- Entity-Relationship Diagram (ER Diagram): Found in the /database folder as ER-Diagram.png.
- Requirements Document: Available in the /docs folder as requirements.pdf.

---

🤝 Contributions
Contributions are welcome! Here's how you can contribute:

1. Fork the repository.
2. Create a new branch (git checkout -b feature-name).
3. Commit your changes (git commit -m "Add a feature").
4. Push to the branch (git push origin feature-name).
5. Open a pull request.
