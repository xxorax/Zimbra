#!/bin/sh
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