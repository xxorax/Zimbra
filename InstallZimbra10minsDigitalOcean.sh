#!/bin/bash
#Script para instalar Zimbra Collaboration 8.6 de manera desatendida
sudo apt-get update
sudo apt-get install -y netcat-openbsd sudo libidn11 libpcre3 libgmp10 libexpat1 libstdc++6 libperl5.18 libaio1 resolvconf unzip pax sysstat sqlite3
mkdir /tmp/zcs && cd /tmp/zcs && wget https://files.zimbra.com/downloads/8.6.0_GA/zcs-8.6.0_GA_1153.UBUNTU14_64.20141215151116.tgz
wget https://jorgedelacruz.es/installZimbra10minsDigitalOcean
wget https://jorgedelacruz.es/installZimbra10mins-keystrokes
tar xzvf zcs-*
echo "Instalando Zimbra Collaboration, solamente la parte de Software"
cd /tmp/zcs/zcs-* && ./install.sh -s < /tmp/zcs/installZimbra10mins-keystrokes
echo "Instalando Zimbra Collaboration, inyectando el fichero de config"
/opt/zimbra/libexec/zmsetup.pl -c /tmp/zcs/installZimbra10minsDigitalOcean
