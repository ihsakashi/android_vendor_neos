LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := termux_usr
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC

MY_SCRIPT := vendor/neos/termux_usr/install.py

working:= $(local-intermediates-dir)

FINAL_TAR_FILE := $(local-generated-sources-dir)/termux_usr.tar
$(FINAL_TAR_FILE): PRIVATE_SCRIPT := $(MY_SCRIPT)
$(FINAL_TAR_FILE):
	rm -f $@
	mkdir -p $(working)
	cp -f $(PRIVATE_SCRIPT) $(working)
	/usr/bin/python $(working)/install.py
	tar -cvf $@ $(working)/out/data/data/com.termux/files/usr

LOCAL_PREBUILT_MODULE_FILE := $(FINAL_TAR_FILE)

include $(BUILD_PREBUILT)