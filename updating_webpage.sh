#!/bin/bash                 

time=$(date)                #sets variable time
echo "<html><body><h1>Hello there NTI-300, it is now: $time, What would you like to do today?</h1></body></html>" > /var/www/html/index.html  #create html page with time var
