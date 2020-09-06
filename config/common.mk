# NEOS Vendor

# Overlays
DEVICE_PACKAGE_OVERLAYS += vendor/neos/overlay/common

# Termux env
PRODUCT_PACKAGES += \
	termux-bootstrap.zip \
	termux_usr.tar

# Neos rc and scripts
PRODUCT_PACKAGES += \
	neos-common.rc \
	neos-setup \
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

