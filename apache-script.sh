#!/bin/bash

yum -y install httpd mod ssl                                                           # start apache commit out welcome page
systemctl restart httpd                                                                # restart httpd service
sed -i 's/^/#/g' /etc/httpd.conf.d/welcome.conf                                        # create webpage 
echo "<html><body><H1>Hi There NTI-300</h1></body></html>" > /var/www/html/index.html
systemctl restart httpd

