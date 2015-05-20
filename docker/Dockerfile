#################################################################
# Dockerfile to build Zimbra Collaboration 8.6 container images
# Based on Ubuntu 14.04
# Created by Jorge de la Cruz
#################################################################
FROM ubuntu:14.04
MAINTAINER Jorge de la Cruz <jorgedlcruz@gmail.com>

RUN echo 'zimbra01' > /etc/hostname
RUN hostname zimbra01.zimbralab.local
## Installing the DNS Server ##
RUN echo "Installing DNS Server" \
    && sudo apt-get update && sudo sudo apt-get install -y bind9 bind9utils bind9-doc \
    && echo "Configuring DNS Server" \
    && sed "s/-u/-4 -u/g" /etc/default/bind9 > /etc/default/bind9.new \
    && mv /etc/default/bind9.new /etc/default/bind9 \
    && rm /etc/bind/named.conf.options
    
ADD named.conf.options /etc/bind/named.conf.options
ADD named.conf.local /etc/bind/named.conf.local
ADD db.* /etc/bind/
RUN sudo service bind9 restart 

##Install the Zimbra Collaboration OS dependencies and server ##
RUN apt-get update \
    && echo "Download and install Zimbra Collaboration dependencies" \
    && sudo apt-get install -y netcat-openbsd sudo libidn11 libpcre3 \
    libgmp10 libexpat1 libstdc++6 libperl5.18 libaio1 resolvconf \
    unzip pax sysstat sqlite3 wget \
    && echo "Creating a tmp folder, and downloading Zimbra Collaboration 8.6" \
    && mkdir /tmp/zcs && cd /tmp/zcs \
    && wget http://192.168.211.1:8000/zcs-8.6.0_GA_1153.UBUNTU14_64.20141215151116.tgz

## Building and adding the Scripts keystrokes and the config.defaults
ADD installZimbra-keystrokes /tmp/zcs/installZimbra-keystrokes
ADD installZimbraScript /tmp/zcs/installZimbraScript

## Install Zimbra Collaboration
RUN echo "Installing Zimbra Collaboration, just the Software" \
    && cd /tmp/zcs/ && tar xzvf zcs-* \
    && cd /tmp/zcs/zcs-* && ./install.sh -s --platform-override /tmp/zcs/installZimbraScript < /tmp/zcs/installZimbra-keystrokes 

VOLUME ["/opt/zimbra"]

EXPOSE 22
EXPOSE 25
EXPOSE 456
EXPOSE 587
EXPOSE 110
EXPOSE 143
EXPOSE 993
EXPOSE 995
EXPOSE 80
EXPOSE 443
EXPOSE 8080
EXPOSE 8443
EXPOSE 7071

ADD start.sh /start.sh

CMD ["/start.sh"]