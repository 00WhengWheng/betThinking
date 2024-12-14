from flask import Flask, jsonify, render_template
from football_api import get_fake_todays_matches

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api/todays_matches')
def todays_matches():
    return jsonify(get_fake_todays_matches())

if __name__ == '__main__':
    app.run(debug=True)