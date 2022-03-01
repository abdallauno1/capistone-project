from flask import Flask, render_template, request, redirect
from flask_bootstrap import Bootstrap



app = Flask(__name__)
Bootstrap(app)

@app.route('/')
def index():
    title = "Per Scholas"
    return  render_template("index.html" ,title = title)


@app.route('/index.html')
def html():
    title = "Per Scholas"
    return  render_template("index.html" ,title = title)    

@app.route('/teachers.html')
def teachers():
    title = "Teachers"
    return  render_template("teachers.html" ,title = title)

@app.route('/students.html')
def students():
    title = "Students"
    return  render_template("students.html" ,title = title)


@app.route('/jafer.html')
def jafer():
    title = "Jafer"
    return  render_template("jafer.html" ,title = title)

@app.route('/william.html')
def william():
    title = "Jafer"
    return  render_template("william.html" ,title = title)    

@app.route('/eldad.html')
def eldad():
    title = "Eldad"
    return  render_template("eldad.html" ,title = title)   

@app.route('/steve.html')
def steve():
    title = "Steve"
    return  render_template("steve.html" ,title = title)          

@app.route('/tamara.html')
def tamara():
    title = "Tamara"
    return  render_template("tamara.html" ,title = title)    


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, debug=True)
