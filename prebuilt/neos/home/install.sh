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
find /usr/var/lib/dpkg/info -type f  -executable -exec sh -c 'exec "$1"' _ {} \;
chmod +x /usr/var/lib/dpkg/info/*.prerm

# Update, add repos, and moar packages
pkg update
pkg upgrade
pkg install root-repo
pkg install science-repo
pkg install eigen # these can't be bootstrapped or not yet

# Build stuff
mkdir /tmp/build
cd /tmp/build

# -------- Capnp stuff
VERSION=0.8.0
wget --tries=inf https://capnproto.org/capnproto-c++-${VERSION}.tar.gz
tar xvf capnproto-c++-${VERSION}.tar.gz
pushd capnproto-c++-${VERSION}
CXXFLAGS="-fPIC -O2" ./configure --prefix=$PREFIX
make -j$(nproc) install
popd

# -------- Czmq
VERSION="4.2.0"
wget --tries=inf https://github.com/zeromq/czmq/releases/download/v$VERSION/czmq-$VERSION.tar.gz
wget --tries=inf https://raw.githubusercontent.com/ihsakashi/termux-packages/czmq/packages/libczmq/01-support-ifaddrs.patch
tar xvf czmq-$VERSION.tar.gz
pushd czmq-$VERSION
patch -p1 < ../01-support-ifaddrs.patch
CFLAGS="-fPIC -O2 -DCZMQ_HAVE_ANDROID=1" LDFLAGS="-llog" ./configure --prefix=$PREFIX --enable-drafts=no
make -j$(nproc)
make install
popd

# -------- Python pip
#cd $HOME

#export PYCURL_SSL_LIBRARY=openssl
#pip install --upgrade pip
#pip install pipenv
#pipenv install --deploy --system