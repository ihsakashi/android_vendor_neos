# NEOS Vendor

# AOSPA Specific
TARGET_DISABLES_GAPPS := true

# Overlays
DEVICE_PACKAGE_OVERLAYS += vendor/neos/overlay/common

# Termux usr
#$(info $(shell python $(vendor/neos/termux_usr/install.py)))

# Termux comma env
PRODUCT_COPY_FILES += \
	$(call find-copy-subdir-files,*,vendor/neos/termux_usr/out/data/data/com.termux/files/usr,system/comma/usr) \
	$(call find-copy-subdir-files,*,vendor/neos/prebuilt/comma/home,system/comma/home) \
	$(call find-copy-subdir-files,*,vendor/neos/prebuilt/common/etc/ssh,system/etc/ssh)

# Neos rc and scripts
PRODUCT_PACKAGES += \
	neos-common.rc \
	neos.sh \
	neos-ssh.sh

# Window Wrapper Lib
PRODUCT_PACKAGES += \
	libww

# Build these
PRODUCT_PACKAGES += \
	TermuxAPI

