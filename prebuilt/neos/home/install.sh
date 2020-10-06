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

pkg install numpy

TMPDIR=/data/data/com.termux/files/tmp
cd $TMPDIR

# capnp and opencv - this is temp
# -------- Capnp stuff
VERSION=0.8.0
wget --tries=inf https://capnproto.org/capnproto-c++-${VERSION}.tar.gz
tar xvf capnproto-c++-${VERSION}.tar.gz
pushd capnproto-c++-${VERSION}
CXXFLAGS="-fPIC -O2" ./configure --prefix=$PREFIX
make -j$(nproc) install
popd

if false; then
    # -------- Opencv stuff
    VERSION=4.4.0
    wget --tries=inf https://github.com/opencv/opencv_contrib/archive/${VERSION}.tar.gz
    tar xvf ${VERSION}.tar.gz
    wget --tries=inf https://github.com/opencv/opencv/archive/${VERSION}.zip
    unzip ${VERSION}.zip
    pushd opencv-${VERSION}
    mkdir build && cd build

    LDFLAGS=" -llog -lpython3 " cmake \
    -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DBUILD_JAVA=OFF -DBUILD_SHARED_LIBS=ON \
    -DBUILD_opencv_python3=on -DBUILD_opencv_python2=off \
    -DWITH_QT=OFF -DBUILD_ANDROID_EXAMPLES=OFF \
    -DWITH_GTK=OFF \
    -DOPENCV_EXTRA_MODULES_PATH=$TMPDIR/opencv_contrib/modules \
    -DOPENCV_ENABLE_NONFREE:BOOL=ON -DBUILD_TESTS=NO \
    -D WITH_TEST=OFF -D BUILD_TESTS=OFF -DBUILD_EXAMPLES=ON \
    ..

    cmake .
    make -j$(nproc)
    make install
    popd
fi

# -------- Python pip
cd $HOME

export PYCURL_SSL_LIBRARY=openssl
pip install --upgrade pip
pip install pipenv
pipenv install --deploy --system