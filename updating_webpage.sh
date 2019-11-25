#!/bin/bash                 

time=$(date)                #sets variable time
echo "<html><body><h1>Hello there NTI-300, it is now: $time, how are you doing today?</h1></body></html>" > /var/www/html/index.html  #create html page with time var
