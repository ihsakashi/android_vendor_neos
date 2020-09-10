# NEOS Vendor

# Overlays
#DEVICE_PACKAGE_OVERLAYS += vendor/neos/overlay/common

# Termux env
PRODUCT_PACKAGES += \
	termux-bootstrap.zip \
	termux-home.zip

# Neos rc and scripts
PRODUCT_PACKAGES += \
	neos-common.rc \
	neos-setup \
	neos-main \
	neos-ssh

# ssh
PRODUCT_COPY_FILES += \
	$(call find-copy-subdir-files,*,vendor/neos/prebuilt/common/etc/ssh,$(TARGET_COPY_OUT_SYSTEM)/etc/ssh)

# Build these
PRODUCT_PACKAGES += \
	su \
	libwindoww \
	openpilot-framebuffer

PRODUCT_PACKAGES += \
	TermuxAPI

