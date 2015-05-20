#!/bin/sh
echo "Installing Zimbra Collaboration, time to inject the configuration" \
/opt/zimbra/libexec/zmsetup.pl -c /tmp/zcs/installZimbraScript
/etc/init.d/sshd start
/etc/init.d/sshd stop
su -c "/opt/zimbra/bin/zmcontrol start" zimbra
exec /usr/sbin/sshd -D -e 