## startup-apache-automation.sh 
#!/bin/bash

if [ -e /etc/httpd ]; then exit 0; fi                                                           # Stops file from overwritting system reboot

yum -y install httpd mod_ssl                                                                    # Yum all apache and ssl support
systemctl start httpd                                                                           # Start apache service
sed -i 's/^/#/g' /etc/httpd/conf.d/welcome.conf                                                 # Comment out welcome page
sed -i '151s/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf                  # Replace AllowOverride None with AllowOverride All in the httpd.conf file
mkdir /var/www/html/pages.dir                                                                 # Make new directory for additional webpages
    echo "<html><body><h1>Welcome to NTI 300</h1><p><a href="pages.dir/page2.html">Page 2</a></p></body></html>" > /var/www/html/index.html  # Create custom welcome page
    htpasswd -cb /usr/local/etc/.htpasswd eli P@ssw0rd1                              				# Create .htaccess with user Eli set standard password.
    htpasswd -b /usr/local/etc/.htpasswd eli P@ssw0rd1                                           	# Create user Eli with standard password
    echo "AuthUserFile /usr/local/etc/.htpasswd" > /var/www/html/pages.dir/.htaccess                # Create .htaccess file
    echo 'AuthName "Page2 Access"' >> /var/www/html/pages.dir/.htaccess                             # Concatenate to .htaccess
    echo "AuthType Basic" >> /var/www/html/pages.dir/.htaccess                                      # Concatenate to .htaccess
    echo "<Limit GET POST>" >> /var/www/html/pages.dir/.htaccess                                    # Concatenate to .htaccess
    echo "require user Eli" >> /var/www/html/pages.dir/.htaccess                                   # Concatenate to .htaccess
    echo "require user Eli" >> /var/www/html/pages.dir/.htaccess                                   # Concatenate to .htaccess
    echo "</Limit>" >> /var/www/html/pages.dir/.htaccess                                            # Concatenate to .htaccess
    chmod 755 /var/www/html/pages.dir/.htaccess                                                     # Change .htaccess file permissions to 755
    systemctl restart httpd                                                                         # Restart apache
    echo '#!/bin/bash' > /root/automated_webpage.sh                                                  # Create the website updating shell script
    echo 'time=$(date)' >> /root/automated_webpage.sh                                                # Make the variable time equal to $date
    echo 'echo "<html><body><h1>Welcome to my world $time, </h1></body></html>" > /var/www/html/pages.dir/page2.html' >> /root/automated_webpage.sh # Create page 2 with time/date
    chmod 755 /root/automated_webpage.sh                                                            # Change permissions to updating_webpage
    echo '* * * * * /bin/echo "I am running automated_webpage.sh" | logger' > /root/up_web_cron      # Create file used in crontab. Also contains log message
    echo '* * * * * /root/automated_webpage.sh' >> /root/up_web_cron                                 # Add automated_webpage.sh script
    crontab /root/up_web_cron                                                                       # Create the cron job
