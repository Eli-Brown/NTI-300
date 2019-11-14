#!/bin/bash

if [ -z "$1" ]; then
	echo "PEBCAK - Enter an argument"
	exit 0;
fi

installed=$(yum list installed $1 | grep $1 | awk -F. '{print $1}' )
input="$1"
status=$(systemctl status $1 | grep Active | awk '{print $2}')
inactive="inactive"

while [ $# > 0 ]; do
if [ $installed == $input ]; then
	echo "This package is installed"
	if [ $status == $inactive ]; then
		echo "Nooooo it is turned off"
		echo "Do you wish to start $input? 1 for yes, 2 for no:"
		select yn in "Yes" "No"; do
			case $yn in
				Yes ) systemctl start $input; break;;
				No ) break;;
			esac
		done
	else
		echo "My status is $status"
		echo "Do you wish to stop $input? 1 for yes, 2 for no:"
		select yn in "Yes" "No"; do
			case $yn in
				Yes ) systemctl stop $input; break;;
				No ) break;;
			esac
		done
	fi

else
	echo "This package is not installed"
	echo "Do you wish to install $input? 1 for yes, 2 for no:"
	select yn in "Yes" "No"; do
		case $yn in
			Yes ) yum install -y $input; break;;
			No ) break;;
		esac
	done
fi
done