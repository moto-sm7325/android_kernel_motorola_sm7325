DLKM_DIR := motorola/kernel/modules
LOCAL_PATH := $(call my-dir)

ifneq ($(FOCALTECH_TOUCH_IC_NAME),)
	KERNEL_CFLAGS += CONFIG_INPUT_FOCALTECH_V3_MMI_IC_NAME=$(FOCALTECH_TOUCH_IC_NAME)
else
	KERNEL_CFLAGS += CONFIG_INPUT_FOCALTECH_V3_MMI_IC_NAME=ft3681
endif

ifeq ($(BOARD_USES_DOUBLE_TAP),true)
	KERNEL_CFLAGS += CONFIG_INPUT_FOCALTECH_V3_MMI_ENABLE_DOUBLE_TAP=y
endif

ifneq ($(BOARD_USES_TOUCH_PALM),)
	KERNEL_CFLAGS += CONFIG_INPUT_FOCALTECH_V3_MMI_ENABLE_PALM=y
endif

ifneq ($(BOARD_USES_PEN_NOTIFIER),)
	KERNEL_CFLAGS += CONFIG_INPUT_FOCALTECH_V3_MMI_PEN_NOTIFIER=y
endif

ifneq ($(findstring touchscreen_mmi.ko,$(BOARD_VENDOR_KERNEL_MODULES)),)
    KERNEL_CFLAGS += CONFIG_INPUT_TOUCHSCREEN_MMI=y
endif

ifeq ($(DRM_PANEL_NOTIFICATIONS),true)
	KERNEL_CFLAGS += CONFIG_DRM_PANEL_NOTIFICATIONS=y
endif

include $(CLEAR_VARS)
LOCAL_MODULE := focaltech_v3.ko
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(KERNEL_MODULES_OUT)
LOCAL_ADDITIONAL_DEPENDENCIES += $(KERNEL_MODULES_OUT)/mmi_info.ko
ifneq ($(findstring touchscreen_mmi.ko,$(BOARD_VENDOR_KERNEL_MODULES)),)
	LOCAL_ADDITIONAL_DEPENDENCIES += $(KERNEL_MODULES_OUT)/touchscreen_mmi.ko
endif

KBUILD_OPTIONS_GKI += GKI_OBJ_MODULE_DIR=gki
KBUILD_OPTIONS_GKI += MODULE_KERNEL_VERSION=$(TARGET_KERNEL_VERSION)
include $(DLKM_DIR)/AndroidKernelModule.mk
