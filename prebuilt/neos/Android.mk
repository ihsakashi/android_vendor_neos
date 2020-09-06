LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := termux_home.tar
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC

FINAL_TAR_FILE := $(local-generated-sources-dir)/termux_home.tar
$(FINAL_TAR_FILE): PRIVATE_INPUT_DIR := $(LOCAL_PATH)
$(FINAL_TAR_FILE):
	rm -f $@
	cd $(PRIVATE_INPUT_DIR)
	tar -cvf $@ ./home

LOCAL_PREBUILT_MODULE_FILE := $(FINAL_TAR_FILE)

include $(BUILD_PREBUILT)