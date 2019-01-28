sudo yum -y update
sudo yum -y groupinstall "GNOME Desktop" "Graphical Administration Tools"
sudo ln -sf /lib/systemd/system/runlevel5.target /etc/systemd/system/default.target
sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum -y install xrdp tigervnc-server
sudo systemctl start xrdp
sudo systemctl enable xrdp
sudo firewall-cmd --permanent --add-port=3389/tcp
sudo firewall-cmd --reload
sudo chcon --type=bin_t /usr/sbin/xrdp
sudo chcon --type=bin_t /usr/sbin/xrdp-sesman
echo Enter your username
read varname
sudo useradd $varname
sudo passwd $varname
sudo usermod -aG wheel $varname

echo "Do you wish to install VS Code? Choose option 1 or 2"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc; sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo';yum check-update; sudo yum install -y code; break;;
        No ) break;;
    esac
done

echo "Do you wish to install GoLang? Choose option 1 or 2"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) sudo yum install -y golang; break;;
        No ) break;;
    esac
done