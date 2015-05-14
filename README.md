# Zimbra
In this Repository you will find different Zimbra Scripts.

##What is the installZimbra&DNS_Server_Single-Server Script

This Script install and configures bind9 with the domain and IP that is defined while invoke the command. After that the Scripts prepare the keystroke script with a default installation of Zimbra Collaboration 8.6 (without dnscache) and the config.defaults script, using the domain, IP and password that is defined while invoke the command. Once everything is ready the Script download the latest version of Zimbra Collaboration 8.6, uncompress it and install it using the keystrokes script and the config script.

##Advantages of use the Script
 * Time saving
 * Fully automated
 * Easy to use 
 * Good for a quick Zimbra Preview

#Usage and Example
The the installZimbra&DNS_Server_Single-Server Script is a Script to install Zimbra in a easier way, without be worry of the DNS configuration, etc. Just execute it and after a few minutes have Zimbra up and running.

Just run the Script adding the TLD domain for your Zimbra Collaboration server, the IP of the DNS server (usually will be the same of the server, but instead you are using different eth interfaces), and add the password for the Zimbra Collaboration server. 
```bash
root@zimbramail:/home/oper# ./installZimbra\&DNS_Server_Single-Server zimbralab.local 192.168.211.40 Zimbra2015
 
```
The Script will take care of everything and after a few minutes you can go to the IP of your server and use the next URL:
 * Web Client - https://YOURIP
 * Admin Console - https://YOURIP:7071
