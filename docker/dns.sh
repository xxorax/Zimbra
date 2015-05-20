#!/bin/sh
#Install a DNS Server and Zimbra Collaboration 8.6
echo "Installing DNS Server"
sudo apt-get update && sudo sudo apt-get install -y bind9 bind9utils bind9-doc
echo "Configuring DNS Server"
sed "s/-u/-4 -u/g" /etc/default/bind9 > /etc/default/bind9.new
mv /etc/default/bind9.new /etc/default/bind9
rm /etc/bind/named.conf.options

cat <<EOF >>/etc/bind/named.conf.options
options {
directory "/var/cache/bind";

listen-on { $IP; }; # ns1 private IP address - listen on private network only
allow-transfer { none; }; # disable zone transfers by default

forwarders {
8.8.8.8;
8.8.4.4;
};
auth-nxdomain no; # conform to RFC1035
#listen-on-v6 { any; };

};
EOF

cat <<EOF >>/etc/bind/named.conf.local
zone "$DOMAIN" {
        type master;
        file "/etc/bind/db.$DOMAIN";
};
EOF

touch /etc/bind/db.$DOMAIN
cat <<EOF >/etc/bind/db.$DOMAIN
\$TTL  604800
@      IN      SOA    ns1.$DOMAIN. root.localhost. (
                              2        ; Serial
                        604800        ; Refresh
                          86400        ; Retry
                        2419200        ; Expire
                        604800 )      ; Negative Cache TTL
;
@     IN      NS      ns1.$DOMAIN.
@     IN      A      $IP
@     IN      MX     10     $HOSTNAME.$1.
$HOSTNAME     IN      A      $IP
ns1     IN      A      $IP
mail     IN      A      $IP
pop3     IN      A      $IP
imap     IN      A      $IP
imap4     IN      A      $IP
smtp     IN      A      $IP
EOF
sudo service bind9 restart