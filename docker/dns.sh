#!/bin/sh
cat <<EOF >>named.conf.local
zone "$1" {
        type master;
        file "/etc/bind/db.$1";
};
EOF

touch /etc/bind/db.$1
cat <<EOF >/etc/bind/db.$1
\$TTL  604800
@      IN      SOA    ns1.$1. root.localhost. (
                              2        ; Serial
                        604800        ; Refresh
                          86400        ; Retry
                        2419200        ; Expire
                        604800 )      ; Negative Cache TTL
;
@     IN      NS      ns1.$1.
@     IN      A      $2
@     IN      MX     10     $3.$1.
$3     IN      A      $2
ns1     IN      A      $2
mail     IN      A      $2
pop3     IN      A      $2
imap     IN      A      $2
imap4     IN      A      $2
smtp     IN      A      $2
EOF