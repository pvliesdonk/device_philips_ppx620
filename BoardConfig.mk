#
# Copyright (C) 2018 The TwrpBuilder Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

LOCAL_PATH := device/philips/ppx620

TARGET_NO_RADIOIMAGE := true
TARGET_NO_BOOTLOADER := true

TARGET_BOARD_PLATFORM := rk3328
TARGET_BOOTLOADER_BOARD_NAME := ppx620
TARGET_BOARD_PLATFORM_GPU := mali450
BOARD_USE_DRM := true
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true

# Sepolicy
PRODUCT_SEPOLICY_SPLIT := true
BOARD_SEPOLICY_DIRS ?= \
    $(LOCAL_PATH)/sepolicy/vendor
BOARD_PLAT_PUBLIC_SEPOLICY_DIR ?= $(LOCAL_PATH)/sepolicy/public
BOARD_PLAT_PRIVATE_SEPOLICY_DIR ?= \
    $(LOCAL_PATH)/sepolicy/private \
    $(LOCAL_PATH)/rk3328/sepolicy




TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
BOARD_USES_HWCOMPOSER := true
TARGET_USES_ION := true
BOARD_EGL_CFG := $(LOCAL_PATH)/egl.cfg
USE_OPENGL_RENDERER := true
ENABLE_WEBGL := true
TARGET_FORCE_CPU_UPLOAD := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
BOARD_USES_MMCUTILS := true


# Recovery
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_RECOVERY_SWIPE := false
BOARD_USES_MMCUTILS := true
BOARD_SUPPRESS_EMMC_WIPE := true

RECOVERY_FSTAB_VERSION := 2
TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/recovery/root/fstab.rk30board
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_HAS_NO_SELECT_BUTTON := true
TARGET_RECOVERY_INITRC := $(LOCAL_PATH)/recovery/root/init.rc

RECOVERY_GRAPHICS_USE_LINELENGTH := true
RECOVERY_GRAPHICS_FORCE_USE_LINELENGTH := true
BOARD_VOLD_EMMC_SHARES_DEV_MAJOR := true
BOARD_SUPPRESS_SECURE_ERASE := true

USE_E2FSPROGS := true


# TWRP

#this would disable a mouse pointer in view
#TW_INPUT_BLACKLIST := "hbtp_vm"

TW_INCLUDE_CRYPTO := true
TW_USE_TOOLBOX := true
TW_THEME := landscape_hdpi
TW_USE_MODEL_HARDWARE_ID_FOR_DEVICE_ID := true
TW_BRIGHTNESS_PATH := "/brightness"
TW_HAVE_SELINUX := true
TW_INCLUDE_NTFS_3G := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TARGET_RECOVERY_FORCE_PIXEL_FORMAT := RGB_565
TW_NO_SCREEN_TIMEOUT := true
TW_NO_SCREEN_BLANK := true
TW_SCREEN_BLANK_ON_BOOT := false
DEVICE_RESOLUTION := 1280x720
TW_EXCLUDE_SUPERSU := true
TW_EXCLUDE_TWRPAPP := true
TWRP_INCLUDE_LOGCAT := true
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TW_EXCLUDE_ENCRYPTED_BACKUPS := true


include $(LOCAL_PATH)/kernel.mk
include $(LOCAL_PATH)/BoardConfig64.mk

