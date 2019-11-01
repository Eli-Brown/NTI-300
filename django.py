#!/usr/bin/python

import os
import re
import subprocess



Def setup_install():
	print('installing pip and virtualenv so we can give django its own version of python')
	os.system('yum -y install python-pip && pip install --upgrade pip')
	os.system('pip install virtualenv')
	os.chdir('/opt')
	os.mkdir('/opt/django')
	os.chdir('/opt/django')
	os.system('virtualenv django-env')
	os.system('chown -R eliBrown /opt/django')
	
os.system('adduser -M django')
os.system('chown -R django /opt/django')
os.system('usermod -L django')	
	
def django_install():
	print('activating virtualenv and instakking django after prereq's are met')
	os.system('source/opt/django/django-env/bin/activate ' +\
		'&& django-admin --version ' +\
		'&& django-admin startproject project1')
		
def django_start():
	print('starting django')
	os.system('chown -R eliBrown /opt/django')
	os.chdir('/opt/django/project1')
	os.system('source /opt/django/django-env/bin/activate' +\
		'&& python manage.py migrate')
	os.system('source/opt/django/django-env/bin/activate && echo "from django.contrib.auth import get_user_model; User = get_user_model1(); User.objects.create_superuser(\'admin\',\'admin@newproject.com\',\nti300nti300\')" | python manage.py shell|')	
	outputwithnewline = subprocess.check_output('curl -s checkip.dyndns.org | sed -e \'s/.*Current IP Address: //\' e \'s/<.*$//\' ', shell=true)
	print outputwithnewline
	output = outputwithnewline.replace("\n", "")
	old_string = "ALLOWED_HOST = []"
	new_string = 'ALLOWED_HOST = [\'{}\']' .format(output) 
	print (old_string)
	print (new_string)
	
	with open('project1/settings.py') as f:
		newText=f.read().replace(old_string, new_string)
	with open (project1/settings.py', "w") as f:
		f.write(newText
	os.system('sudo -u django sh -c "source /opt/django/django-env/bin/activate && python manage.py runserver 0.0.0.0:8000&"')

setup_install()
django_install()	
django_start()