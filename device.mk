#
# Copyright (C) 2014 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

## Get non-open-source specific aspects
$(call inherit-product-if-exists, vendor/samsung/klte/klte-vendor.mk)

## overlays
DEVICE_PACKAGE_OVERLAYS += device/samsung/klte/overlay

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal hdpi xhdpi xxhdpi
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# Boot animation
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080

# Audio configuration
PRODUCT_COPY_FILES += \
    device/samsung/klte/audio/audio_effects.conf:system/vendor/etc/audio_effects.conf \
    device/samsung/klte/audio/mixer_paths.xml:system/etc/mixer_paths.xml \
    device/samsung/klte/audio/audio_policy.conf:system/etc/audio_policy.conf \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml

PRODUCT_PROPERTY_OVERRIDES += \
    af.resampler.quality=4 \
    audio.offload.buffer.size.kb=32 \
    audio.offload.gapless.enabled=false \
    av.offload.enable=true

# Thermal config
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/thermal-engine-8974.conf:system/etc/thermal-engine-8974.conf

# Media Profile
PRODUCT_COPY_FILES += \
    device/samsung/klte/media/media_profiles.xml:system/etc/media_profiles.xml

# Extended media support
PRODUCT_PACKAGES += \
    qcmediaplayer

PRODUCT_BOOT_JARS += qcmediaplayer

# GPS
PRODUCT_PACKAGES += \
    gps.msm8974 \
    libgps.utils \
    libloc_core \
    libloc_eng

GPS_CONF := device/samsung/klte/gps/etc/gps.conf

PRODUCT_COPY_FILES += \
    $(GPS_CONF):/system/etc/gps.conf \
    device/samsung/klte/gps/etc/sap.conf:/system/etc/sap.conf

# Keylayouts
PRODUCT_COPY_FILES += \
    device/samsung/klte-common/keylayout/atmel_mxt_ts.kl:system/usr/keylayout/atmel_mxt_ts.kl \
    device/samsung/klte-common/keylayout/AVRCP.kl:system/usr/keylayout/AVRCP.kl \
    device/samsung/klte-common/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    device/samsung/klte-common/keylayout/qwerty.kl:system/usr/keylayout/qwerty.kl \
    device/samsung/klte-common/keylayout/sec_navigation.kl:system/usr/keylayout/sec_navigation.kl \
    device/samsung/klte-common/keylayout/sec_touchscreen.kl:system/usr/keylayout/sec_touchscreen.kl \
    device/samsung/klte-common/keylayout/synaptics_rmi4_i2c.kl:system/usr/keylayout/synaptics_rmi4_i2c.kl

# Ramdisk
PRODUCT_PACKAGES += \
    fstab.qcom \
    initlogo.rle \
    init.bt.rc \
    init.carrier.rc \
    init.qcom.rc \
    init.qcom.usb.rc \
    init.ril.rc \
    init.target.rc \
    ueventd.qcom.rc

# System init scripts
PRODUCT_PACKAGES += \
    init.crda.sh \
    init.sec.boot.sh

# HAL
PRODUCT_PACKAGES += \
    copybit.msm8974 \
    gralloc.msm8974 \
    hwcomposer.msm8974 \
    memtrack.msm8974 \
    power.msm8974 \
    camera.msm8974

# Audio
PRODUCT_PACKAGES += \
    audiod \
    audio.a2dp.default \
    audio_policy.msm8974 \
    audio.primary.msm8974 \
    audio.r_submix.default \
    audio.usb.default \
    libaudio-resampler \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    tinymix

# Torch
PRODUCT_PACKAGES += Torch

# Wifi
PRODUCT_PACKAGES += \
    libnetcmdiface \
    macloader \
    crda \
    regulatory.bin \
    linville.key.pub.pem

# libxml2 is needed for camera
PRODUCT_PACKAGES += libxml2

# IR packages
PRODUCT_PACKAGES += \
    consumerir.msm8974
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.consumerir.xml:system/etc/permissions/android.hardware.consumerir.xml

# Nfc
NFCEE_ACCESS_PATH := device/samsung/klte/nfc/nfcee_access.xml

ifeq ($(TARGET_NFC_TECH), nxp)
PRODUCT_PACKAGES += \
    libnfc \
    libnfc_jni \
    Nfc \
    Tag \
    com.android.nfc_extras

PRODUCT_COPY_FILES += \
    $(NFCEE_ACCESS_PATH):system/etc/nfcee_access.xml

else

PRODUCT_PACKAGES += \
    libnfc-nci \
    libnfc_nci_jni \
    nfc_nci.msm8974 \
    NfcNci \
    Tag \
    com.android.nfc_extras

PRODUCT_COPY_FILES += \
    $(NFCEE_ACCESS_PATH):system/etc/nfcee_access.xml \
    device/samsung/klte/nfc/libnfc-brcm-20791b05.conf:system/etc/libnfc-brcm-20791b05.conf \
    device/samsung/klte/nfc/libnfc-brcm-20791b04.conf:system/etc/libnfc-brcm-20791b04.conf \
    device/samsung/klte/nfc/libnfc-brcm.conf:system/etc/libnfc-brcm.conf

endif

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp

# Sensors
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:system/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml

# Lights
PRODUCT_PACKAGES += lights.MSM8974

# QC Perf
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.extension_library=/vendor/lib/libqc-opt.so

#common build.props
PRODUCT_PROPERTY_OVERRIDES += \
    ro.chipname=msm8974 \
    ro.sf.lcd_density=480 \
    ro.opengles.version=196608 \
    persist.timed.enable=true \
    keyguard.no_require_sim=true

# Radio properties
PRODUCT_PROPERTY_OVERRIDES += \
    rild.libpath=/system/lib/libsec-ril.so \
    ril.subscription.types=NV,RUIM \
    ro.ril.hsxpa=1 \
    ro.ril.gprsclass=10 \
    ro.use_data_netmgrd=true \
    persist.data.netmgrd.qos.enable=true \
    persist.radio.add_power_save=1 \
    persist.radio.apm_sim_not_pwdn=1 \
    persist.radio.lte_vrat_report=1 \
    persist.rild.nitz_plmn="" \
    persist.rild.nitz_long_ons_0="" \
    persist.rild.nitz_long_ons_1="" \
    persist.rild.nitz_long_ons_2="" \
    persist.rild.nitz_long_ons_3="" \
    persist.rild.nitz_short_ons_0="" \
    persist.rild.nitz_short_ons_1="" \
    persist.rild.nitz_short_ons_2="" \
    persist.rild.nitz_short_ons_3=""

# msm_rng entropy feeder
PRODUCT_PACKAGES += \
    qrngd \
    qrngp

# Wifi
PRODUCT_COPY_FILES += \
   device/samsung/klte/wifi/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf \
   device/samsung/klte/wifi/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf

# call common msm8974
$(call inherit-product, device/samsung/msm8974-common/msm8974.mk)

# call dalvik heap config
$(call inherit-product, frameworks/native/build/phone-xxhdpi-2048-dalvik-heap.mk)

# call hwui memory config
$(call inherit-product-if-exists, frameworks/native/build/phone-xxhdpi-2048-hwui-memory.mk)