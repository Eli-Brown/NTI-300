#!/bin/bash
for packages in $(cat packages.txt); do
  yum -y install $packages
wget https://raw.githubusercontent.com/Eli-Brown/NTI-300/master/packages.txt
done
