LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := termux_home
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC

FINAL_TAR_FILE := $(local-generated-sources-dir)/termux_home.tar
$(FINAL_TAR_FILE): PRIVATE_INPUT_DIR := $(LOCAL_PATH)/home
$(FINAL_TAR_FILE):
	rm -f $@
	tar -cvf $@ $(PRIVATE_INPUT_DIR)

LOCAL_PREBUILT_MODULE_FILE := $(FINAL_TAR_FILE)

include $(BUILD_PREBUILT)