LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := termux-home.zip
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC

FINAL_TAR_FILE := $(local-generated-sources-dir)/termux-home.zip
$(FINAL_TAR_FILE): PRIVATE_INPUT_DIR := $(LOCAL_PATH)/home
$(FINAL_TAR_FILE):
	rm -f $@
	(cd $(PRIVATE_INPUT_DIR) && zip -r - .*) > $@

LOCAL_PREBUILT_MODULE_FILE := $(FINAL_TAR_FILE)

include $(BUILD_PREBUILT)