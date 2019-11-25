#!/bin/bash
# create local git repository

if [ -e /usr/bin/wget ]; then
	exit 0;
fi
yum -y install wget
wget https://raw.githubusercontent.com/eli-brown/NTI-300/master/packages.txt
for packages in $(cat packages.txt); do
	yum -y install $packages

export HOME="/root"

cd NTI-300/
git clone https://github.com//eli-brown/NTI-300.git
git config --global user.name eli-brown 
git config --global user.email Vincent.Brown@seattlecolleges.edu

done
