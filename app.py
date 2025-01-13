from flask import Flask, render_template, request
import os
from models import db, Movie, Show

app = Flask(__name__)

app.secret_key = os.environ.get("FLASK_SECRET_KEY", "default_secret_key")

app.config["SQLALCHEMY_DATABASE_URI"] = (
    "mssql+pyodbc://@ShahdElwan/CinemaDatabase?driver=ODBC+Driver+17+for+SQL+Server"
)

#هنا هتبدل @ShahdElwan باليوزر الخاص بيك
#هنا هتبدل CinemaDatabase بالداتابيز الخاص بيك
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

db.init_app(app)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/search_movie', methods=['GET'])
def search_movie():
    movie_name = request.args.get('film_name') 
    
    if not movie_name:
        return render_template('index.html', error="Movie name is required") 
    
    try:
        results = db.session.query(Movie, Show.StartTime).join(Show, Movie.ShowPresentsMovie == Show.ShowNumber).filter(Movie.MovieName.ilike(f"%{movie_name}%")).all()

        if not results:
            return render_template('result.html', error="No movies found")
        
        movies = [{"MovieName": result.Movie.MovieName, 
                   "Director": result.Movie.Director,
                   "MovieType": result.Movie.MovieType, 
                   "StartTime": result.StartTime} for result in results]

        return render_template('result.html', movies=movies)

    except Exception as e:
        return render_template('result.html', error=f"An error occurred: {str(e)}")

if __name__ == "__main__":
    app.run(debug=True)
