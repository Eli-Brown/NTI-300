#!/bin/bash
yum -y install wget git
wget https://raw.githubusercontent.com/Eli-Brown/NTI-300/master/packages.txt       # placed before for loop

for packages in $(cat packages.txt); do
  yum -y install $packages
done

#!/bin/bash
if [ -e /usr/bin/wget ]; then                                                       # Test if wget is installed
  echo "wget already exists" | logger                                               #
  exit 0;                                                                           # Exit if wget is installed
fi                                                                                  #
yum install -y wget                                                                 # Install wget
wget https://raw.githubusercontent.com/Eli-Brown/NTI-300/master/packages.txt      # wget the packages.txt file from github
for packages in $(cat packages.txt); do                                             # Install all packages in the packages.txt file
  yum install -y $packages                                                          #
done                                                                                #
cd /root                                                                            # cd root
git clone https://github.com/Eli-Brown/NTI-300.git                                 # Clone repository from github
cd /root/NTI-Brown                                                                 # cd to the new directory NTI300
git config --global user.name "Eli-Brown"                                          # Set me as user
git config --global user.email Vincent.Brown@seattlecolleges.edu                  # Set my email