# Inherit common stuff
$(call inherit-product, vendor/dragons/config/common.mk)

PRODUCT_SIZE := full

# Recorder
PRODUCT_PACKAGES += \
    Recorder
