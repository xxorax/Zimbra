#!/bin/sh
echo "Installing Zimbra Collaboration, time to inject the configuration" \
sed -i "s/XHOSTNAMEX/`hostname -f`/" /tmp/zcs/installZimbraScript
sed -i "s/XPASSWORDX/`date | sha1sum | cut -c-8`/" /tmp/zcs/installZimbraScript
sed -i "s/XPASSWORD2X/`date | sha1sum | cut -c-8`/" /tmp/zcs/installZimbraScript
sed -i "s/XRANDOMX/`date | sha1sum | cut -c-8`/" /tmp/zcs/installZimbraScript
sed -i "s/XRANDOM2X/`date | sha1sum | cut -c-8`/" /tmp/zcs/installZimbraScript
sed -i "s/XRANDOM3X/`date | sha1sum | cut -c-8`/" /tmp/zcs/installZimbraScript
/opt/zimbra/libexec/zmsetup.pl -c /tmp/zcs/installZimbraScript
/etc/init.d/sshd start
/etc/init.d/sshd stop
su -c "/opt/zimbra/bin/zmcontrol start" zimbra
exec /usr/sbin/sshd -D -e 