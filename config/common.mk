# NEOS Vendor

# Overlays
DEVICE_PACKAGE_OVERLAYS += vendor/neos/overlay/common

# Termux env
PRODUCT_PACKAGES += \
	termux_home \
	termux_usr

# Neos rc and scripts
PRODUCT_PACKAGES += \
	neos-common.rc \
	neos-setup \
	neos-main \
	neos-ssh

# ssh system
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
	ssh_keys

# Build these
PRODUCT_PACKAGES += \
	su \
	libww

PRODUCT_PACKAGES += \
	TermuxAPI

