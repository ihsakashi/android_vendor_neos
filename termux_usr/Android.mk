LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := termux_usr
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC


working:= $(local-intermediates-dir)

FINAL_TAR_FILE := $(local-generated-sources-dir)/termux_usr.tar
$(FINAL_TAR_FILE):
	rm -f $@
	mkdir -p $(working)
	cp -f $(LOCAL_PATH)/install.py $(working)
	/usr/bin/python $(working)/install.py
	tar -cvf $@ $(working)/out/data/data/com.termux/files/usr

LOCAL_PREBUILT_MODULE_FILE := $(FINAL_TAR_FILE)

include $(BUILD_PREBUILT)