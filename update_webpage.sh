#!/bin/bash
# changed variable time to date command
time=$(date)                                           
echo "<html><body><h1>Hello NTI, it is $time, what are you up to?</h1></body></html>" >> /var/www/html/pages.dir/page2.html  