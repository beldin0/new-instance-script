#!/bin/bash

echo Enter your username
read varname
useradd $varname
passwd $varname
usermod -aG wheel $varname

echo "Checking for any system updates"
yum -y -q update

echo "Do you wish to install GNOME? Choose option 1 or 2"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) bash ./install_gnome.sh; break;;
        No ) break;;
    esac
done

echo "Do you wish to install GoLang? Choose option 1 or 2"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) echo "Installing GoLang"; yum install -y -q golang; break;;
        No ) break;;
    esac
done

echo "Completed setup."