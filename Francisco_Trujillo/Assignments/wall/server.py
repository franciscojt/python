from flask import Flask, render_template, flash, session, request, redirect
from mysqlconnection import MySQLConnector
import re
from flask.ext.bcrypt import Bcrypt
app = Flask(__name__)

EMAIL_REGEX = re.compile(r'^[a-zA-Z0-9.+_-]+@[a-zA-Z0-9._-]+\.[a-zA-Z]+$')

app.secret_key ="kwenfou4n3iru498"
bcrypt=Bcrypt(app)
mysql = MySQLConnector(app, 'wall')

#login validation
def validemail():
    
    if not EMAIL_REGEX.match(request.form['email']):
        flash('Please enter a valid email')
        return False
    
    return True

def validregistration():
    fname=request.form['fname']
    lname=request.form['lname']
    pwd=request.form['pwd']
    cpwd=request.form['cpwd']
    
    if len(fname)<2 or len(lname)<2:
        flash("First and last name mustbe at least two chracter")
        return False
    
    if fname.isalpha()== False or lname.isalpha() ==False:
        flash("First or Last name contains numbers")
        return False
    
    if len(pwd)< 8 or len(cpwd)<8:
        flash('Password must be 8 character or greater')
        return False
    
    if not pwd == cpwd:
        flash('Password do not Match')
        return False
    
    return True
    

@app.route('/')
def index():
#    if 'id' in session:
#        session['id']=''
#        return redirect('/')
 
    return  render_template('index.html')

@app.route('/login', methods = ['POST'])
def login():
    query = "SELECT * FROM user WHERE email = :email"

    
    if validemail() == True:
        data = {
        'email': request.form['email'],
        'pwd' : request.form['pwd']
        
    }

    users = mysql.query_db(query,data)
    
    if len(users) == 0:
        flash('Email or password does not match')
        return redirect('/')
    
    user = users[0]
    if not bcrypt.check_password_hash(user['password'],data['pwd']):
        flash('Email or password does not match')
        return redirect('/')
        
    session['info'] = user

    flash('access granted')
    return redirect('/wall')

@app.route('/registration', methods = ['POST'])
def registration():
    print 'made it to registration'
    if not validregistration() or not validemail():
        return redirect('/')
    
    data = {
        'fname': request.form['fname'],
        'lname': request.form['lname'],
        'email': request.form['email'],
        'pwd':bcrypt.generate_password_hash(request.form['pwd'])
        
    }

    query = "INSERT INTO user(fname, lname, email, password) VALUES (:fname, :lname, :email, :pwd)"
    
    nid =mysql.query_db(query,data)
    query= "SELECT * FROM user WHERE id = :id"
    user =mysql.query_db(query,{'id':nid})
    session['info'] = user[0]
    print session['info']
    flash('Welcome new user')
    return redirect('/wall')

@app.route('/wall')
def wall():
    query = "SELECT user.fname, user.lname, message.id as mid, message.message, DATE_FORMAT(message.created, '%M %D, %Y' ) AS date FROM user JOIN message ON user.id = message.user_id ORDER by date DESC"

    messages = mysql.query_db(query)
    
    query = "SELECT fname, lname, comment.comment, message.id as cid, DATE_FORMAT(comment.created, '%M %D, %Y' ) AS date FROM user JOIN comment on user.id = comment.user_id JOIN message ON comment.message_id = message.id ORDER by date DESC"
    comments = mysql.query_db(query)
    
    return render_template('wall.html', messages=messages, comments=comments)

@app.route('/message', methods = ['POST'])
def message():
    user = session['info']
    
    data = {'message' : request.form['message'],
            'id' : user['id']}
    
    if len(data['message'])<1:
        flash('Message box cannot be empty')
        return redirect('/wall')
    
    query = 'INSERT INTO message (user_id, message) VALUES (:id, :message)'
    mysql.query_db(query,data)
    return redirect('/wall')

@app.route('/comment/<mid>', methods=['POST'])


def comment(mid):
    user = session['info']
    
    data = {'comment' : request.form['comment'],
            'id' : user['id'],
           'mid': mid}
    
    
    if len(data['comment'])<1:
        flash('Message box cannot be empty')
        return redirect('/wall')
    
    query = 'INSERT INTO comment (user_id, message_id, comment) VALUES (:id, :mid, :comment)'
    mysql.query_db(query,data)
    
    return redirect('/wall')


@app.route('/logout')
def logout():
    session.clear()
    return redirect('/')


app.run(debug=True)