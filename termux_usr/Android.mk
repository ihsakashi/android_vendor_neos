LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := termux_usr
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC

MY_SCRIPT := vendor/neos/termux_usr/generate-bootstraps.sh

working:= $(local-intermediates-dir)

FINAL_TAR_FILE := $(local-generated-sources-dir)/bootstrap.zip
$(FINAL_TAR_FILE): PRIVATE_SCRIPT := $(MY_SCRIPT)
$(FINAL_TAR_FILE):
	rm -f $@
	mkdir -p $(working)
	cd $(working)
	/usr/bin/bash $(PRIVATE_SCRIPT) --architectures aarch64 --add autoconf,automake,bison,clang,cmake,coreutils,curl,ffmpeg,flex,gdb,git,git-lfs,htop,jq,libcurl-static,libffi-static,libjpeg-turbo,libjpeg-turbo-static,liblz4,liblz4-static,liblzo,liblzo-static,libmpc,libtool,libuuid-static,libzmq,libpcap,libpcap-static,libpng,make,man,nano,ncurses-static,patchelf,python-static,strace,tar,tmux,vim,wget,zlib-static,zsh
	mv -f bootstrap-aarch64.zip $@

LOCAL_PREBUILT_MODULE_FILE := $(FINAL_TAR_FILE)

include $(BUILD_PREBUILT)