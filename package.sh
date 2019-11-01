#!/bin/bash
wget https://raw.githubusercontent.com/Eli-Brown/NTI-300/master/packages.txt

for packages in $(cat packages.txt); do
  yum -y install $packages
done
