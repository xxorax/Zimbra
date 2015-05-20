#!/bin/sh
cat <<EOF >>named.conf.local
zone "$1" {
        type master;
        file "/etc/bind/db.$1";
};
EOF

touch db.$1
cat <<EOF >db.$1
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
cat <<EOF >>named.conf.options
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