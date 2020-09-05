LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := termux_usr
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC

intermediates:= $(call local-generated-sources-dir)

FINAL_TAR_FILE := $(intermediates)/termux_usr.tar
$(FINAL_TAR_FILE): PRIVATE_SCRIPT := $(LOCAL_PATH)/install.py
$(FINAL_TAR_FILE):
	rm -f $@
	cd $(intermediates)
	python $(PRIVATE_SCRIPT)
	tar -cvf $@ $(intermediates)/out/data/data/com.termux/files/usr

LOCAL_PREBUILT_MODULE_FILE := $(FINAL_TAR_FILE)

include $(BUILD_PREBUILT)