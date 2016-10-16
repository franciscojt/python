from system.core.controller import *

class Form(Controller):
	def __init__(self, action):
		super(Form, self).__init__(action)
        
	def index(self):
		if not 'name' in session:
			session['name'] =''
			session['location'] = ''
			session['language'] = ''
			session['comment'] = ''
			session['counter']= 0
			session['form'] = 'show'
			session['results'] = 'hide'
		return self.load_view('index.html')
	
	
	def clear(self):
		session.clear()
		return redirect('/')
	
	def send(self):
		session['name'] = request.form['name']
		session['location'] = request.form['location']
		session['language'] = request.form['language']
		session['comment'] = request.form['comment']
		session['counter']+=1

		return redirect ('/view')
	
	def view(self):
		session['results']='show'
		session['form']='hide'
		return redirect('/')
	

	
	def back(self):
		session['form']='show'
		session['results']='hide'
		return redirect('/')
