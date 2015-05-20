############################################################
# Dockerfile to build Zimbra Collaboration 8.6 container images
# Based on Ubuntu 14.04
# Created by Jorge de la Cruz
############################################################
FROM ubuntu:14.04
MAINTAINER Jorge de la Cruz <jorgedlcruz@gmail.com>

## Installing the DNS Server##
RUN echo "Installing DNS Server"
RUN sudo apt-get update && sudo sudo apt-get install -y bind9 bind9utils bind9-doc
RUN echo "Configuring DNS Server"
RUN sed "s/-u/-4 -u/g" /etc/default/bind9 > /etc/default/bind9.new
RUN mv /etc/default/bind9.new /etc/default/bind9
RUN rm /etc/bind/named.conf.options
RUN cat <<EOF >>/etc/bind/named.conf.options
options {
directory "/var/cache/bind";

listen-on { 127.0.0.1; }; # ns1 private IP address - listen on private network only
allow-transfer { none; }; # disable zone transfers by default

forwarders {
8.8.8.8;
8.8.4.4;
};
auth-nxdomain no; # conform to RFC1035
#listen-on-v6 { any; };

};
EOF
ADD named.conf.local /etc/bind/named.conf.local
RUN sudo service bind9 restart

##Install the Zimbra Collaboration OS dependencies and server ##
RUN apt-get update
RUN echo "Download and install Zimbra Collaboration dependencies"
RUN sudo apt-get install -y netcat-openbsd sudo libidn11 libpcre3 libgmp10 libexpat1 libstdc++6 libperl5.18 libaio1 resolvconf unzip pax sysstat sqlite3 wget
RUN echo "Creating a tmp folder, and downloading Zimbra Collaboration 8.6"
RUN mkdir /tmp/zcs && cd /tmp/zcs && wget -O- https://files.zimbra.com/downloads/8.6.0_GA/zcs-8.6.0_GA_1153.UBUNTU14_64.20141215151116.tgz 

## Adding the Scripts keystrokes and the config.defaults
ADD installZimbra-keystrokes /tmp/zcs/installZimbra-keystrokes
ADD installZimbraScript /tmp/zcs/installZimbraScript

## Install Zimbra Collaboration
RUN echo "Installing Zimbra Collaboration, just the Software"
RUN cd /tmp/zcs/ && tar xzvf zcs-*
RUN cd /tmp/zcs/zcs-* && ./install.sh -s < /tmp/zcs/keystrokes
RUN echo "Installing Zimbra Collaboration, time to inject the configuration"
RUN /opt/zimbra/libexec/zmsetup.pl -c /tmp/zcs/config.defaults

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