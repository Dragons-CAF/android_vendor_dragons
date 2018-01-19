# Inherit full common stuff
$(call inherit-product, vendor/dragons/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

$(call inherit-product, vendor/dragons/config/telephony.mk)
