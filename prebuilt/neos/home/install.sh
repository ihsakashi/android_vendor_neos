#!/usr/bin/env bash
set -e

while true; do
    ping -c 1 8.8.8.8 && break
    sleep 1
done

# Apt partial cache?
mkdir -p /data/data/com.termux/files/cache/apt/archives/partial

# Execute all apt postinstall scripts
chmod +x /usr/var/lib/dpkg/info/*.postinst
find /usr/var/lib/dpkg/info -type f -executable -exec sh -c 'exec "$1"' _ {} \;
chmod +x /usr/var/lib/dpkg/info/*.prerm

# being cheeky - this is temp
# Update, add repos, and moar packages
pkg update
pkg upgrade
pkg install root-repo science-repo
pkg install eigen

# its-pointless - this is temp
curl -LO https://its-pointless.github.io/setup-pointless-repo.sh
bash setup-pointless-repo.sh

pkg install numpy opencv

# -------- Python pip
cd $HOME

export PYCURL_SSL_LIBRARY=openssl
pip install --upgrade pip
pip install pipenv
#pipenv lock
pipenv install --deploy --system