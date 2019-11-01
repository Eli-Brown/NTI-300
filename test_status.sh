#!/bin/bash

if [ -z "$1" ]; then
	echo "Please enter a service to check"
	exit 0;
fi
for packages in $( echo "$@"); do

installed=$(yum list installed $packages | grep $packages | awk -F. '{print $1}' )
input="$packages"
status=$(systemctl status $packages | grep Active | awk '{print $2}')
inactive="inactive"
if [ $installed == $input ]; then
	echo "This is a Service Status check!"
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
			Yes ) yum -y install  $input; break;;
			No ) break;;
		esac
	done
fi
done
