#!/system/bin/sh

umask 077

# DEBUG=1

LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib
PATH=/usr/local/bin:/data/data/com.termux/files/usr/bin:/data/data/com.termux/files/usr/sbin:/data/data/com.termux/files/usr/bin/applets:/bin:/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin
HOME=/data/data/com.termux/files/home

DSA_KEY=/data/ssh/ssh_host_dsa_key
DSA_PUB_KEY=/data/ssh/ssh_host_dsa_key.pub
RSA_KEY=/data/ssh/ssh_host_rsa_key
RSA_PUB_KEY=/data/ssh/ssh_host_rsa_key.pub
AUTHORIZED_KEYS=/data/ssh/authorized_keys
DEFAULT_AUTHORIZED_KEYS=/system/etc/security/authorized_keys.default

if [ ! -f $DSA_KEY ]; then
    if [ -f /system/comma/ssh/ssh_host_dsa_key ]; then
        cp -f /system/comma/ssh/ssh_host_dsa_key
        cp -f /system/comma/ssh/ssh_host_dsa_key.pub
    else
        /system/bin/ssh-keygen -t dsa -f $DSA_KEY -N ""
    fi
    chmod 600 /$DSA_KEY
    chmod 644 $DSA_PUB_KEY
fi

if [ ! -f $RSA_KEY ]; then
    if [ -f /system/comma/ssh/ssh_host_rsa_key ]; then
        cp -f /system/comma/ssh/ssh_host_rsa_key
        cp -f /system/comma/ssh/ssh_host_rsa_key.pub
    else
        /system/bin/ssh-keygen -t rsa -f $RSA_KEY -N ""
    fi
    chmod 600 /$RSA_KEY
    chmod 644 $RSA_PUB_KEY
fi

if [[ ! -f $AUTHORIZED_KEYS && -f $DEFAULT_AUTHORIZED_KEYS ]]; then
    cat $DEFAULT_AUTHORIZED_KEYS > $AUTHORIZED_KEYS
fi

# SSH into Termux env
export HOME
export LD_LIBRARY_PATH
export PATH

if [ "1" == "$DEBUG" ] ; then
    # run sshd in debug mode and capture output to logcat
    /system/bin/logwrapper /system/bin/sshd -f /system/etc/ssh/sshd_config -D -d
else
    # don't daemonize - otherwise we can't stop the sshd service
    /system/bin/sshd -f /system/etc/ssh/sshd_config -D
fi