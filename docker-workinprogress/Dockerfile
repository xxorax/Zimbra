#################################################################
# Dockerfile to build Zimbra Collaboration 8.6 container images
# Based on Ubuntu 14.04
# Created by Jorge de la Cruz
#################################################################
FROM ubuntu:14.04
MAINTAINER Jorge de la Cruz <jorgedlcruz@gmail.com>

## Install wget ##
RUN sudo apt-get update && sudo apt-get install -y wget

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

ADD dns.sh /tmp/zcs/dns.sh
ADD start.sh /tmp/zcs/createInstallFile.sh
ADD start.sh /tmp/zcs/start.sh

CMD ["/bin/bash", "/start.sh"]