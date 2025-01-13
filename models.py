from flask_sqlalchemy import SQLAlchemy
db = SQLAlchemy()

from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Theater(db.Model):
    __tablename__ = 'Theater'
    TheaterID = db.Column(db.String(3), primary_key=True)
    TheaterName = db.Column(db.String(20), nullable=False)
    Address = db.Column(db.String(100), nullable=False)
    
    customers = db.relationship('Customer', backref='theater', lazy=True)
    employees = db.relationship('Employee', backref='theater', lazy=True)
    halls = db.relationship('Hall', backref='theater', lazy=True)

class Customer(db.Model):
    __tablename__ = 'Customer'
    CustomerId = db.Column(db.String(10), primary_key=True)
    CustomerName = db.Column(db.String(20), nullable=False)
    Email = db.Column(db.String(50), nullable=False)
    Phone = db.Column(db.String(10), nullable=True)
    THId = db.Column(db.String(3), db.ForeignKey('Theater.TheaterID'))

    tickets = db.relationship('Ticket', backref='customer', lazy=True)

class Employee(db.Model):
    __tablename__ = 'Employee'
    EmpID = db.Column(db.String(10), primary_key=True)
    Age = db.Column(db.String(2), nullable=False)
    EmpName = db.Column(db.String(50), nullable=False)
    TId = db.Column(db.String(3), db.ForeignKey('Theater.TheaterID'))
    ServiceYears = db.Column(db.String(2), nullable=False)
    SpNb = db.Column(db.String(10), db.ForeignKey('Employee.EmpID'), nullable=True)

    supervisor = db.relationship('Employee', remote_side=[EmpID], backref='subordinates', lazy=True)
    
    tickets = db.relationship('Ticket', backref='employee', lazy=True)

class Hall(db.Model):
    __tablename__ = 'Hall'
    HallNumber = db.Column(db.String(2), primary_key=True)
    TheaterID = db.Column(db.String(3), db.ForeignKey('Theater.TheaterID'), primary_key=True)
    SeatType = db.Column(db.String(10), nullable=False)
    NumberOfSeats = db.Column(db.String(3), nullable=False)

class Show(db.Model):
    __tablename__ = 'Show'
    ShowNumber = db.Column(db.String(10), primary_key=True)
    Language = db.Column(db.String(15), nullable=False)
    Show = db.Column(db.String(50), nullable=True)
    StartTime = db.Column(db.Time, nullable=False)

    movie = db.relationship('Movie', backref='show', lazy=True)

class Movie(db.Model):
    __tablename__ = 'Movie'
    MovieId = db.Column(db.String(10), primary_key=True)
    MovieType = db.Column(db.String(15), nullable=False)
    Director = db.Column(db.String(20), nullable=True)
    MovieName = db.Column(db.String(50), nullable=False)
    Actors = db.Column(db.String(20), nullable=True)
    ShowPresentsMovie = db.Column(db.String(10), db.ForeignKey('Show.ShowNumber'))

class Ticket(db.Model):
    __tablename__ = 'Ticket'
    TicketNb = db.Column(db.String(10), primary_key=True)
    MovieTime = db.Column(db.Time, nullable=False)
    MovieDate = db.Column(db.Date, nullable=False)
    Price = db.Column(db.Integer, nullable=True)
    SeatNum = db.Column(db.String(3), nullable=False)
    EId = db.Column(db.String(10), db.ForeignKey('Employee.EmpID'), nullable=True)
    ShowNb = db.Column(db.String(10), db.ForeignKey('Show.ShowNumber'), nullable=True)
    CusId = db.Column(db.String(10), db.ForeignKey('Customer.CustomerId'), nullable=True)
    DOP = db.Column(db.Date, nullable=False)
    TNb = db.Column(db.String(10), nullable=True)
    Cid = db.Column(db.Integer, nullable=True)


