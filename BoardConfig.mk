#
# Copyright (C) 2022 The Android Open Source Project
# Copyright (C) 2023 The TWRP Open Source Project
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

# Device path
DEVICE_PATH := device/Tecno/Camon18P

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a53

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53

TARGET_BOARD_SUFFIX := _64
TARGET_USES_64_BIT_BINDER := true
TARGET_SUPPORTS_64_BIT_APPS := true
TARGET_IS_64_BIT := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := Camon18P
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true

# Platform
TARGET_BOARD_PLATFORM := mt6781

#BOARD_HAS_MTK_HARDWARE := true
BOARD_USES_MTK_HARDWARE := true
#MTK_HARDWARE := true

# Assert
TARGET_OTA_ASSERT_DEVICE := Camon18P

# A/B
AB_OTA_UPDATER := true
TW_INCLUDE_REPACKTOOLS := true

AB_OTA_PARTITIONS += \
    system \
    vendor \
    product \
    system_ext \
    boot \
    vbmeta_vendor \
    vbmeta_system

# File systems and partitions
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4

# Workaround for error copying vendor files to recovery ramdisk
TARGET_COPY_OUT_VENDOR := vendor

TARGET_USERIMAGES_USE_F2FS := true
TARGET_USERIMAGES_USE_EXT4 := true

# Dynamic Partition
BOARD_SUPER_PARTITION_SIZE := 9126805504 # TODO: Fix hardcoded value
BOARD_SUPER_PARTITION_GROUPS := tecno_dynamic_partitions
BOARD_TECNO_DYNAMIC_PARTITIONS_PARTITION_LIST := system vendor product system_ext
BOARD_TECNO_DYNAMIC_PARTITIONS_SIZE := 9122611200 # TODO: Fix hardcoded value

# System as root
BOARD_BUILD_SYSTEM_ROOT_IMAGE := false
BOARD_SUPPRESS_SECURE_ERASE := true

# Kernel
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x2000000
BOARD_KERNEL_BASE := 0x40078000
BOARD_DTB_OFFSET := 0x0bc08000
BOARD_HASH_TYPE := sha1
BOARD_BOOTIMG_HEADER_VERSION := 2
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_RAMDISK_OFFSET := 0x07c08000
BOARD_KERNEL_SECOND_OFFSET := 0xbff88000
BOARD_KERNEL_TAGS_OFFSET := 0x0bc08000
BOARD_KERNEL_IMAGE_NAME := Image.gz
BOARD_RAMDISK_USE_XZ := true
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/Image.gz
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_MKBOOTIMG_ARGS += --base $(BOARD_KERNEL_BASE)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE) --board ""
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --second_offset $(BOARD_KERNEL_SECOND_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)

# AVB
BOARD_AVB_ENABLE := true
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

# Hack to get keymaster to recognize the key files
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31
PLATFORM_VERSION := 16.1.0

# Charger
BOARD_CHARGER_ENABLE_SUSPEND := true
TARGET_DISABLE_TRIPLE_BUFFERING := false
BOARD_CHARGER_DISABLE_INIT_BLANK := true

# Metadata
BOARD_USES_METADATA_PARTITION := true
BOARD_ROOT_EXTRA_FOLDERS += metadata

# Crypto
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab
BOARD_HAS_LARGE_FILESYSTEM := true
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
# Additional binaries & libraries needed for recovery
     TARGET_RECOVERY_DEVICE_MODULES += \
     libkeymaster4 \
     libpuresoftkeymasterdevice \
     ashmemd_aidl_interface-cpp \
     libashmemd_client

  TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += \
   $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster4.so \
   $(TARGET_OUT_SHARED_LIBRARIES)/libpuresoftkeymasterdevice.so \
   $(TARGET_OUT_SHARED_LIBRARIES)/ashmemd_aidl_interface-cpp.so \
   $(TARGET_OUT_SHARED_LIBRARIES)/libashmemd_client.so

# Properties
TARGET_SYSTEM_PROP := $(DEVICE_PATH)/system.prop
TARGET_RECOVERY_INITRC := $(DEVICE_PATH)/recovery/root/init.recovery.mt6781.rc

# Recovery
#TARGET_RECOVERY_PIXEL_FORMAT := BGRA_8888
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
#TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/twrp.fstab
RECOVERY_SDCARD_ON_DATA := true
BOARD_USES_RECOVERY_AS_BOOT := true
BOARD_HAS_NO_SELECT_BUTTON := true
TARGET_NO_RECOVERY := true
TW_HAS_NO_RECOVERY_PARTITION := true

# TWRP specific build flags
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_INCLUDE_NTFS_3G := true
TW_OEM_BUILD := true
TARGET_USES_MKE2FS := true
TW_USE_MODEL_HARDWARE_ID_FOR_DEVICE_ID := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_NO_BATT_PERCENT := false

# TWRP Configuration
TW_DEFAULT_LANGUAGE := ru
TW_EXTRA_LANGUAGES := false
TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.usb0/lun.%d/file
TW_CUSTOM_CPU_TEMP_PATH := /sys/devices/virtual/thermal/thermal_zone1/temp
TARGET_RECOVERY_LCD_BACKLIGHT_PATH := \"/sys/class/leds/lcd-backlight/brightness\"
TW_NO_SCREEN_BLANK := true
TW_SCREEN_BLANK_ON_BOOT := true

# Display
TW_BRIGHTNESS_PATH := /sys/class/leds/lcd-backlight/brightness
TW_MAX_BRIGHTNESS := 2047
TW_DEFAULT_BRIGHTNESS := 1200

# Storage
TW_NO_USB_STORAGE := false
TW_INTERNAL_STORAGE_PATH := "/data/media/0"
TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
TW_EXTERNAL_STORAGE_PATH := "/external_sd"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "external_sd"
TW_HAS_MTP := true
TW_MTP_DEVICE := /dev/mtp_usb
TW_DEFAULT_EXTERNAL_STORAGE := true

# Debug
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true

# Excludes
TW_DEVICE_VERSION := Tecno Camon18P by SK
