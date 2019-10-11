#!/bin/bash
for packages in $(cat packages.txt); do
  yum -y install $packages
done
