LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := termux-home.zip
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC

FINAL_TAR_FILE := $(local-generated-sources-dir)/termux-home.zip
$(FINAL_TAR_FILE): PRIVATE_INPUT_DIR := $(LOCAL_PATH)/home
$(FINAL_TAR_FILE):
	rm -f $@
	(cd $(PRIVATE_INPUT_DIR) && zip -r - ./) > $@

LOCAL_PREBUILT_MODULE_FILE := $(FINAL_TAR_FILE)

include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := neos-sshd_config
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC

LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/ssh
LOCAL_SRC_FILES := ssh/sshd_config
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := neos-override
LOCAL_MODULE_TAGS := optional

OVERRIDE_PACKAGES := \
	sshd_config

PACKAGES.$(LOCAL_MODULE).OVERRIDES := $(strip $(UNWANTED_OVERRIDE_PACKAGES))
include $(BUILD_PHONY_PACKAGE)