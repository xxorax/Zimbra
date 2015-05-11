#!/bin/bash
#Script para instalar Zimbra Collaboration 8.6 de manera desatendida
mkdir /tmp/zcs && cd /tmp/zcs && wget https://files.zimbra.com/downloads/8.6.0_GA/zcs-8.6.0_GA_1153.UBUNTU14_64.20141215151116.tgz
wget https://jorgedelacruz.es/installZimbra10mins
wget https://jorgedelacruz.es/installZimbra10mins-keystrokes
tar xzvf zcs-*
cd /tmp/zcs/zcs-* && ./install.sh -s < /tmp/zcs/installZimbra10mins-keystrokes
/opt/zimbra/libexec/zmsetup.pl -c /tmp/zcs/installZimbra10mins
