# NEOS Vendor

# AOSPA Specific
TARGET_DISABLES_GAPPS := true

# Overlays
DEVICE_PACKAGE_OVERLAYS += vendor/neos/overlay/common

# Copy all NEOS-specific init rc files
$(foreach f,$(wildcard vendor/neos/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):system/etc/init/$(notdir $f)))

# Copy all NEOS-specific sh files
$(foreach f,$(wildcard vendor/neos/prebuilt/common/etc/*.sh),\
	$(eval PRODUCT_COPY_FILES += $(f):system/etc/$(notdir $f)))

# Termux usr
#$(info $(shell python $(vendor/neos/termux_usr/install.py)))

PRODUCT_COPY_FILES += \
	$(call find-copy-subdir-files,*,vendor/neos/termux_usr/out/data/data/com.termux/files/usr,system/comma/usr) \
	$(call find-copy-subdir-files,*,vendor/neos/prebuilt/comma/home,system/comma/home) \

# Window Wrapper Lib
PRODUCT_PACKAGES += \
	libww

# Build these
PRODUCT_PACKAGES += \
	TermuxAPI

