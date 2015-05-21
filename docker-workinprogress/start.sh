#!/bin/sh
echo 
IP=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')
HOSTNAME=$(hostname -a)
DOMAIN=$(hostname -d)
PASSWORD='Zimbra2015'
## Installing the DNS Server ##
echo "Installing DNS Server"
sudo apt-get update && sudo sudo apt-get install -y bind9 bind9utils bind9-doc
echo "Configuring DNS Server"
sed "s/-u/-4 -u/g" /etc/default/bind9 > /etc/default/bind9.new
mv /etc/default/bind9.new /etc/default/bind9
rm /etc/bind/named.conf.options
sudo service bind9 restart 

##Install the Zimbra Collaboration OS dependencies and Zimbra package ##
apt-get update
echo "Download and install Zimbra Collaboration dependencies"
sudo apt-get install -y netcat-openbsd sudo libidn11 libpcre3 libgmp10 libexpat1 libstdc++6 libperl5.18 libaio1 resolvconf unzip pax sysstat sqlite3
echo "Creating a tmp folder, and downloading Zimbra Collaboration 8.6"
cd /tmp/zcs 
wget http://192.168.211.1:8000/zcs-8.6.0_GA_1153.UBUNTU14_64.20141215151116.tgz

## Building and adding the Scripts keystrokes and the config.defaults
chmod +x dns.sh
chmod +x createInstallFile.sh
/bin/bash dns.sh $DOMAIN $IP $HOSTNAME
/bin/bash createInstallFile.sh $DOMAIN $IP $PASSWORD $HOSTNAME

##Install the Zimbra Collaboration ##
echo "Downloading Zimbra Collaboration 8.6"
cd /tmp/zcs && tar xzvf zcs-*
echo "Installing Zimbra Collaboration just the Software"
cd /tmp/zcs/zcs-* && ./install.sh -s < /tmp/zcs/installZimbra-keystrokes
echo "Installing Zimbra Collaboration injecting the configuration"
/opt/zimbra/libexec/zmsetup.pl -c /tmp/zcs/installZimbraScript