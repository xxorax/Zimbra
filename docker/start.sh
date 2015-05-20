#!/bin/sh
/etc/init.d/sshd start
/etc/init.d/sshd stop
su -c "/opt/zimbra/bin/zmcontrol start" zimbra
exec /usr/sbin/sshd -D -e 