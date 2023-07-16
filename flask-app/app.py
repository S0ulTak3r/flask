from flask import Flask, render_template, redirect, url_for, request
import mysql.connector
import os
import random
import time


app = Flask(__name__, template_folder='Web', static_folder='CSS')


def establish_db_connection():
    while True:
        try:
            db = mysql.connector.connect(
                host="db",
                user="root",
                password="password",
                database="flask_db"
            )
            return db
        except mysql.connector.Error as err:
            print("Failed connecting to database. Retrying...")
            time.sleep(1)

# Establish the initial database connection
db = establish_db_connection()

@app.route("/")
def intro():
    return render_template("intro.html")

@app.route("/second_intro")
def second_intro():
    return render_template("second_intro.html")

@app.route("/welcome", methods=["GET", "POST"])
def welcome():
    if request.method == "GET":
        return redirect(url_for("display_gifs"))
    return render_template("welcome.html")

@app.route("/gifs")
def display_gifs():
    global db  # ensure you're modifying the glssobal db
    for _ in range(3):  # Try 3 times
        try:
            if db.is_connected() == False: # check if connection is still open
                db = establish_db_connection()
            cursor = db.cursor()
            cursor.execute("SELECT url FROM images;")
            images = [row[0] for row in cursor.fetchall()]
            url = random.choice(images)
            return render_template("gifs.html", url=url)
        except mysql.connector.Error as err:
            # Handle the error and attempt to reconnect
            print("Error accessing the database. Reconnecting...")
            db = establish_db_connection()
            continue
    return "Error accessing the database. Please try again later."



if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 5000)))
