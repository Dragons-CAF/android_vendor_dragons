# Target-specific configuration

# Bring in Qualcomm helper macros
include vendor/dragons/build/core/qcom_utils.mk

# Set device-specific HALs into project pathmap
define set-device-specific-path
$(if $(USE_DEVICE_SPECIFIC_$(1)), \
    $(if $(DEVICE_SPECIFIC_$(1)_PATH), \
        $(eval path := $(DEVICE_SPECIFIC_$(1)_PATH)), \
        $(eval path := $(TARGET_DEVICE_DIR)/$(2))), \
    $(eval path := $(3))) \
$(call project-set-path,qcom-$(2),$(strip $(path)))
endef

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
    B_FAMILY := msm8226 msm8610 msm8974
    B64_FAMILY := msm8992 msm8994
    BR_FAMILY := msm8909 msm8916

    BOARD_USES_ADRENO := true

    TARGET_USES_QCOM_BSP := true

    # Tell HALs that we're compiling an AOSP build with an in-line kernel
    TARGET_COMPILE_WITH_MSM_KERNEL := true

    ifneq ($(filter msm7x27a msm7x30 msm8660 msm8960,$(TARGET_BOARD_PLATFORM)),)
        # Enable legacy audio functions
        ifeq ($(BOARD_USES_LEGACY_ALSA_AUDIO),true)
            USE_CUSTOM_AUDIO_POLICY := 1
        endif
    endif

    # Allow building audio encoders
    TARGET_USES_QCOM_MM_AUDIO := true

    # Enable color metadata for modern UM targets
    ifneq ($(filter msm8996 msm8998 sdm660,$(TARGET_BOARD_PLATFORM)),)
        TARGET_USES_COLOR_METADATA := true
    endif

    # List of targets that use master side content protection
    MASTER_SIDE_CP_TARGET_LIST := msm8996 msm8998 sdm660

    ifeq ($(call is-board-platform-in-list, $(B_FAMILY)),true)
        MSM_VIDC_TARGET_LIST := $(B_FAMILY)
        QCOM_HARDWARE_VARIANT := msm8974
    else
    ifeq ($(call is-board-platform-in-list, $(B64_FAMILY)),true)
        MSM_VIDC_TARGET_LIST := $(B64_FAMILY)
        QCOM_HARDWARE_VARIANT := msm8994
    else
    ifeq ($(call is-board-platform-in-list, $(BR_FAMILY)),true)
        MSM_VIDC_TARGET_LIST := $(BR_FAMILY)
        QCOM_HARDWARE_VARIANT := msm8916
    else
        MSM_VIDC_TARGET_LIST := $(TARGET_BOARD_PLATFORM)
        QCOM_HARDWARE_VARIANT := $(TARGET_BOARD_PLATFORM)
    endif
    endif
    endif

$(call set-device-specific-path,AUDIO,audio,hardware/qcom/audio/$(QCOM_HARDWARE_VARIANT))
$(call set-device-specific-path,DISPLAY,display,hardware/qcom/display/$(QCOM_HARDWARE_VARIANT))
$(call set-device-specific-path,MEDIA,media,hardware/qcom/media/$(QCOM_HARDWARE_VARIANT))
$(call set-device-specific-path,GPS,gps,hardware/qcom/gps)
endif # BOARD_USES_QCOM_HARDWARE
