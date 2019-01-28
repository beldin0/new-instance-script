#!/bin/bash

echo "Installing GNOME"
yum -y -q groupinstall "GNOME Desktop" "Graphical Administration Tools"
ln -sf /lib/systemd/system/runlevel5.target /etc/systemd/system/default.target
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

echo "Installing VNC and RDP"
yum -y -q install xrdp tigervnc-server
systemctl start xrdp
systemctl enable xrdp
firewall-cmd --permanent --add-port=3389/tcp
firewall-cmd --reload
chcon --type=bin_t /usr/sbin/xrdp
chcon --type=bin_t /usr/sbin/xrdp-sesman

echo "Do you wish to install VS Code? Choose option 1 or 2"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) echo "Installing VS Code"; rpm --import https://packages.microsoft.com/keys/microsoft.asc; sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo';yum -q check-update; yum install -y -q code; break;;
        No ) break;;
    esac
done