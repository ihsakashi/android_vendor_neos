LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := ssh_keys
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/ssh

LOCAL_SRC_FILES := \
	ssh_host_dsa_key \
	ssh_host_dsa_key.pub \
	ssh_host_ecdsa_key \
	ssh_host_ecdsa_key.pub \
	ssh_host_ed25519_key \
	ssh_host_ed25519_key.pub \
	ssh_host_rsa_key \
	ssh_host_rsa_key.pub

include $(BUILD_PREBUILT)