# Zimbra
In this Repository you will find different Zimbra Scripts.

# Docker
## Install Docker
* Keep posted of the changes in the next Zimbra Wiki - https://wiki.zimbra.com/wiki/Deploy_Zimbra_Collaboration_using_docker

Depend of your OS, you need to install Docker in different ways, take a look into the official Website - https://docs.docker.com/installation/#installation

One of the advantages of using docker is that the host OS does not matter, the containers will work on any platform. 
##Creating the Zimbra Image

The content of the Dockerfile and the start.sh is based on the next Script - ZimbraEasyInstall. The Dockerfile creates a Ubuntu Server 14.04 image and install on it wget, then when the container is launched, automatically starts with the start.sh script:
###Dockerfile & start.sh
Download from github 
```bash
wget https://raw.githubusercontent.com/jorgedlcruz/Zimbra/master/docker/Dockerfile
wget https://raw.githubusercontent.com/jorgedlcruz/Zimbra/master/docker/start.sh
```
##Build the image using the Dockerfile
Just run the next command to build the image based in the previous Dockerfile, you can use the name that you want, in this case is zimbra_docker:
```bash
sudo docker build -t zimbra_docker .
```
##Deploy the Docker container
Now, to deploy the container based on the previous image. As well as publish the Zimbra Collaboration ports, the hostname and the proper DNS, as you want to use bind as a local DNS nameserver within the container, also we will send the password that we want to our Zimbra Server like admin password, mailbox, LDAP, etc.: Syntax:
```bash
docker run -p PORTS -h HOSTNAME.DOMAIN --dns DNSSERVER -i -t -e PASSWORD=YOURPASSWORD NAMEOFDOCKERIMAGE
```
Example:
```bash
docker run -p 25:25 -p 80:80 -p 456:456 -p 587:587 -p 110:110 -p 143:143 -p 993:993 -p 995:995 -p 443:443 -p 8080:8080 -p 8443:8443 -p 7071:7071 -p 9071:9071 -h zimbra86-docker.zimbra.io --dns 127.0.0.1 --dns 8.8.8.8 -i -t -e PASSWORD=Zimbra2015 zimbra_docker
```
This will create the container in few seconds, and run automatically the start.sh:

* Install a DNS Server based in bind9 and the dnsutils package
* Configure all the DNS Server to resolve automatically internal the MX and the hostname that we define while launch the container.
* Install the OS dependencies for Zimbra Collaboration 8.6
* Create 2 files to automate the Zimbra Collaboration installation, the keystrokes and the config.defaults.
* Launch the installation of Zimbra based only in the .install.sh -s
* Inject the config.defaults file with all the parameters that is autoconfigured with the Hostname, domain, IP, and password that you define before. 

The script takes a few minutes, dependent on the your Internet Speed, and resources. 

# ZimbraEasyInstall
##What is the ZimbraEasyInstall
This Script install and configures bind9 with the domain and IP that is defined while invoke the command. After that the Scripts prepare the keystroke script with a default installation of Zimbra Collaboration 8.6 (without dnscache) and the config.defaults script, using the domain, IP and password that is defined while invoke the command. Once everything is ready the Script download the latest version of Zimbra Collaboration 8.6, uncompress it and install it using the keystrokes script and the config script.

##Advantages of use the Script
 * Time saving
 * Fully automated
 * Easy to use 
 * Good for a quick Zimbra Preview

##Usage and Example
The ZimbraEasyInstall Script is an easy way to install Zimbra Collaboration, without be worry of the DNS configuration, OS depencies, etc. Just execute it and after a few minutes have Zimbra up and running.

Just run the Script adding the TLD domain for your Zimbra Collaboration server, the IP of the DNS server (usually will be the same of the server, but instead you are using different eth interfaces), and add the password for the Zimbra Collaboration server. 
```bash
root@zimbramail:/home/oper# ./ZimbraEasyInstall zimbralab.local 192.168.211.40 Zimbra2015
 
```
##Access to the Web Client and Admin Console
The Script will take care of everything and after a few minutes you can go to the IP of your server and use the next URL:
 * Web Client - https://YOURIP
 * Admin Console - https://YOURIP:7071
 
##Next steps
The script still needs some work on the next:
 * Prepare and configure automatically the Reverse DNS Zone
 * Make it multi-platform to use it in CentOS/RedHat, Suse and Ubuntu 12.04
 * Make it Multi-Server, to install in each server only the rol that selects (LDAP, Mailbox, MTA, PROXY, UI)
