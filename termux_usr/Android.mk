LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := termux_usr
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_COPY_OUT_SYSTEM)/neos/

FINAL_TAR_FILE := $(local-generated-sources-dir)/termux_usr.tar
$(FINAL_TAR_FILE): PRIVATE_SCRIPT := $(LOCAL_PATH)/install.py
$(FINAL_TAR_FILE):
	rm -f $@
	cd $(local-generated-sources-dir)
	python $(PRIVATE_SCRIPT)
	tar -cvf $@ $(local-generated-sources-dir)/out/data/data/com.termux/files/usr

LOCAL_PREBUILT_MODULE_FILE := $(FINAL_TAR_FILE)

LOCAL_PRODUCT_MODULE := true

include $(BUILD_PREBUILT)