# NEOS Vendor

# Overlays
DEVICE_PACKAGE_OVERLAYS += vendor/neos/overlay/common

# Termux usr
#$(info $(shell python $(vendor/neos/termux_usr/install.py)))

# Termux env
PRODUCT_COPY_FILES += \
	$(call find-copy-subdir-files,*,vendor/neos/prebuilt/neos/home,$(TARGET_COPY_OUT_SYSTEM)/neos/home) \
	$(call find-copy-subdir-files,*,vendor/neos/termux_usr/out/data/data/com.termux/files/usr,$(TARGET_COPY_OUT_SYSTEM)/neos/usr)

# Neos rc and scripts
PRODUCT_PACKAGES += \
	neos-common.rc \
	neos-main \
	neos-ssh

# ssh
PRODUCT_COPY_FILES += \
	$(call find-copy-subdir-files,*,vendor/neos/prebuilt/common/etc/ssh,$(TARGET_COPY_OUT_SYSTEM)/etc/ssh)

# ssh system
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen

# Build these
PRODUCT_PACKAGES += \
	su \
	libww

PRODUCT_PACKAGES += \
	TermuxAPI

