#
# This policy configuration will be used by all qcom products
# that inherit from Lineage
#

BOARD_SEPOLICY_DIRS += \
    vendor/dragons/sepolicy/qcom/common \
    vendor/dragons/sepolicy/qcom/$(TARGET_BOARD_PLATFORM)
