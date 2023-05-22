from flask import Flask, render_template
import os
import random

app = Flask(__name__)

# list of cat images
images = [
    "https://media.tenor.com/HnJ-a1i_Bp8AAAAM/patrick-bateman-sigma.gif",
    "https://media.tenor.com/cStcTpCulccAAAAd/patrick-bateman-sigma.gif",
]


@app.route("/")
def index():
    url = random.choice(images)
    return render_template("index.html", url=url)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 5000)))
