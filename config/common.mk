RODUCT_BRAND ?= XPerience & MXSeñorPato

#ifneq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))
# determine the smaller dimension
#TARGET_BOOTANIMATION_SIZE := $(shell \
#  if [ "$(TARGET_SCREEN_WIDTH)" -lt "$(TARGET_SCREEN_HEIGHT)" ]; then \
#    echo $(TARGET_SCREEN_WIDTH); \
#  else \
#    echo $(TARGET_SCREEN_HEIGHT); \
#  fi )

# get a sorted list of the sizes
#bootanimation_sizes := $(subst .zip,,$(shell ls -1 vendor/axolotl/prebuilt/common/bootanimation | sort -rn))

# find the appropriate size and set
#define check_and_set_bootanimation
#$(eval TARGET_BOOTANIMATION_NAME := $(shell \
#  if [ -z "$(TARGET_BOOTANIMATION_NAME)" ]; then \
#    if [ "$(1)" -le "$(TARGET_BOOTANIMATION_SIZE)" ]; then \
#      echo $(1); \
#      exit 0; \
#    fi;
#  fi;
#  echo $(TARGET_BOOTANIMATION_NAME); ))
#endef
#$(foreach size,$(bootanimation_sizes), $(call check_and_set_bootanimation,$(size)))

#PRODUCT_BOOTANIMATION := vendor/axolotl/prebuilt/common/bootanimation/$(TARGET_BOOTANIMATION_NAME).zip

#We aren't using this old form anymore so for now i will use all other info with copy file then i will change it
#PRODUCT_COPY_FILES += $(PRODUCT_BOOTANIMATION):$(TARGET_COPY_OUT_SYSTEM)/media/bootanimation.zip

#endif

#well I add ringtones here for all devices
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.config.ringtone=XPerienceRing.ogg,XPerienceRing.ogg \
    ro.config.notification_sound=Reminder.ogg \
    ro.config.alarm_alert=Fuego.ogg

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    keyguard.no_require_sim=true \
    ro.opa.elegible_device=true

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.dun.override=0
endif

ifneq ($(TARGET_BUILD_VARIANT),eng)
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Disable Rescue Party
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.sys.disable_rescue=true

# Lower RAM devices
ifeq ($(AX_LOW_RAM_DEVICE),true)
TARGET_BOOTANIMATION_TEXTURE_CACHE := false
TARGET_HAS_LOW_RAM := true

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    config.disable_atlas=true \
    dalvik.vm.jit.codecachesize=0 \
    persist.sys.force_highendgfx=true \
    ro.config.low_ram=true \
    ro.config.max_starting_bg=8 \
    ro.sys.fw.bg_apps_limit=16
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/axolotl/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/axolotl/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/axolotl/prebuilt/common/bin/50-xpe.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-xpe.sh \
    vendor/axolotl/prebuilt/common/bin/blacklist:$(TARGET_COPY_OUT_SYSTEM)/addon.d/blacklist

ifneq ($(AB_OTA_PARTITIONS),)
PRODUCT_COPY_FILES += \
    vendor/axolotl/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/axolotl/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/axolotl/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
endif

# Clean up packages cache to avoid wrong strings and resources
PRODUCT_COPY_FILES += \
    vendor/axolotl/prebuilt/bin/clean_cache.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/clean_cache.sh

# Fonts
PRODUCT_COPY_FILES += \
    vendor/axolotl/prebuilt/common/fonts/GoogleSans-Regular.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/GoogleSans-Regular.ttf \
    vendor/axolotl/prebuilt/common/fonts/GoogleSans-Medium.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/GoogleSans-Medium.ttf \
    vendor/axolotl/prebuilt/common/fonts/GoogleSans-MediumItalic.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/GoogleSans-MediumItalic.ttf \
    vendor/axolotl/prebuilt/common/fonts/GoogleSans-Italic.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/GoogleSans-Italic.ttf \
    vendor/axolotl/prebuilt/common/fonts/GoogleSans-Bold.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/GoogleSans-Bold.ttf \
    vendor/axolotl/prebuilt/common/fonts/GoogleSans-BoldItalic.ttf:$(TARGET_COPY_OUT_SYSTEM)/fonts/GoogleSans-BoldItalic.ttf

#Falcon Tweaking
ifeq ($(AX_BUILD), falcon)
PRODUCT_COPY_FILES += \
    vendor/axolotl/prebuilt/common/etc/init.d/01XPerienceKernelCOnf:$(TARGET_COPY_OUT_SYSTEM)/etc/init.d/01XPerienceKernelCOnf
endif

ifeq ($(AX_BUILD), ghost)
PRODUCT_COPY_FILES += \
    vendor/axolotl/prebuilt/common/etc/init.d/02XPerienceColorcalib:$(TARGET_COPY_OUT_SYSTEM)/etc/init.d/02XPerienceColorcalib
endif

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/axolotl/config/permissions/backup.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/backup.xml

# init.d support
PRODUCT_COPY_FILES += \
    vendor/axolotl/prebuilt/common/etc/init.d/00banner:$(TARGET_COPY_OUT_SYSTEM)/etc/init.d/00banner \
    vendor/axolotl/prebuilt/common/bin/sysinit:$(TARGET_COPY_OUT_SYSTEM)/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/axolotl/prebuilt/common/etc/init.d/90userinit:$(TARGET_COPY_OUT_SYSTEM)/etc/init.d/90userinit
endif

# Copy all axolotl-specific init rc files
$(foreach f,$(wildcard vendor/axolotl/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/axolotl/prebuilt/common/lib/content-types.properties:$(TARGET_COPY_OUT_SYSTEM)/lib/content-types.properties

# Enable Android Beam on all targets
PRODUCT_COPY_FILES += \
    vendor/axolotl/config/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.nfc.beam.xml

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/Vendor_045e_Product_0719.kl

# This is axolotl!
PRODUCT_COPY_FILES += \
    vendor/axolotl/config/permissions/mx.axolotl.android.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/mx.axolotl.android.xml \
    vendor/axolotl/config/permissions/privapp-permissions-ax-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-ax-product.xml \
    vendor/axolotl/config/permissions/privapp-permissions-ax-system.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-ax-system.xml

# Hidden API whitelist
PRODUCT_COPY_FILES += \
    vendor/axolotl/config/permissions/xperience-hiddenapi-package-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/xperience-hiddenapi-package-whitelist.xml

# Power whitelist
PRODUCT_COPY_FILES += \
    vendor/axolotl/config/permissions/xperience-power-whitelist.xml:system/etc/sysconfig/xperience-power-whitelist.xml

# Markup Google
PRODUCT_COPY_FILES += \
    vendor/axolotl/prebuilt/lib/libsketchology_native.so:system/lib/libsketchology_native.so \
    vendor/axolotl/prebuilt/lib64/libsketchology_native.so:system/lib64/libsketchology_native.so

# Include AOSP audio files
include vendor/axolotl/config/aosp_audio.mk

# Include axolotl audio files
include vendor/axolotl/config/xpe_audio.mk

# Use signing keys for only official builds
ifeq ($(AXOLOTL_CHANNEL),OFFICIAL)
    PRODUCT_DEFAULT_DEV_CERTIFICATE := .keys/releasekey
    PRODUCT_OTA_PUBLIC_KEYS = .keys/otakey.x509.pem

# Only build OTA if official
PRODUCT_PACKAGES += \
    Updater

endif

#XPerience colour :v well not is from xpe but It will be added here so..
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.ime.theme_id=4

#PRODUCT_PACKAGES += QPerformance UxPerformance
#PRODUCT_BOOT_JARS += QPerformance UxPerformance

# TWRP
ifeq ($(WITH_TWRP),true)
include vendor/axolotl/config/twrp.mk
endif

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

PRODUCT_PACKAGES += \
    Longshot \
    MarkupGoogle \
    OmniStyle

ifeq ($(TARGET_ARCH),arm64)
PRODUCT_PACKAGES += \
     turbo
endif

ifneq ($(PRODUCT_SIZE), mini)
# Required XPe packages
PRODUCT_PACKAGES += \
    BluetoothExt \
    Development \
    DownloadProvider \
    MediaProvider

# Optional packages
PRODUCT_PACKAGES += \
    libemoji \
    Terminal

PRODUCT_DEXPREOPT_SPEED_APPS += \
    NightFallQuickStep \
    Settings \
    SystemUI \
    XMusic \
    XPerienceOverlayStub

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Custom packages
PRODUCT_PACKAGES += \
    CommandCenter3 \
    ExactCalculator \
    DeskClock \
    Launcher3QuickStep \
    NightFallQuickStep \
    SubstratumSignature \
    WeatherClient \
    XPeriaHome \
    XMusic \
    XPeriaWeather \
    XPerienceOverlayStub \
    Yunikon
else
# Required XPe packages
PRODUCT_PACKAGES += \
    BluetoothExt \
    DownloadProvider \
    MediaProvider

# Optional packages
PRODUCT_PACKAGES += \
    libemoji \
    Terminal

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Custom packages
PRODUCT_PACKAGES += \
    CommandCenter3 \
    ExactCalculator \
    NightFallQuickStepGo \
    Launcher3QuickStepGo \
    WeatherClient \
    XMusic \
    XPerienceOverlayStub \
    Yunikon

PRODUCT_DEXPREOPT_SPEED_APPS += \
    NightFallQuickStepGo \
    Settings \
    SystemUI \
    XMusic
endif

# ThemePicker
PRODUCT_PACKAGES += \
    ThemePicker

# Exchange support
PRODUCT_PACKAGES += \
    Exchange2

# Extra tools
PRODUCT_PACKAGES += \
    7z \
    awk \
    bash \
    bzip2 \
    curl \
    getcap \
    htop \
    lib7z \
    libsepol \
    pigz \
    powertop \
    setcap \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

# Charger
PRODUCT_PACKAGES += \
    charger_res_images \
    product_charger_res_images

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# These packages are excluded from user builds
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
    micro_bench \
    procmem \
    procrank \
    strace

# Conditionally build in su
ifeq ($(WITH_SU),true)
PRODUCT_PACKAGES += \
    su
endif
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.sys.root_access=0

DEVICE_PACKAGE_OVERLAYS += \
    vendor/axolotl/overlay/common

PRODUCT_VERSION_MAJOR = 1
PRODUCT_VERSION_MINOR = 0
PRODUCT_VERSION_MAINTENANCE = 0
PRODUCT_NAME = Quelea

ifndef AXOLOTL_CHANNEL
    AXOLOTL_CHANNEL := UNOFFICIAL
endif

###########################################################################
# Set AX_BUILDTYPE from the env RELEASE_TYPE
ifeq ($(TARGET_VENDOR_SHOW_MAINTENANCE_VERSION),true)
    AX_VERSION_MAINTENANCE := $(PRODUCT_VERSION_MAINTENANCE)
else
    AX_VERSION_MAINTENANCE := 0
endif

# Set AX_BUILDTYPE from the env RELEASE_TYPE, for jenkins compat

ifndef AX_BUILDTYPE
    ifdef RELEASE_TYPE
        # Starting with "AX_" is optional
        RELEASE_TYPE := $(shell echo $(RELEASE_TYPE) | sed -e 's|^AX_||g')
        AX_BUILDTYPE := $(RELEASE_TYPE)
    endif
endif

# Filter out random types, so it'll reset to UNOFFICIAL
ifeq ($(filter RELEASE NIGHTLY HOMECASE WEEKLY SNAPSHOT EXPERIMENTAL STABLERELEASE,$(AX_BUILDTYPE)),)
    AX_BUILDTYPE :=
endif

ifdef AX_BUILDTYPE
    ifneq ($(AX_BUILDTYPE), SNAPSHOT)
        ifdef AX_EXTRAVERSION
            # Force build type to EXPERIMENTAL
            AX_BUILDTYPE := EXPERIMENTAL
            # Remove leading dash from AX_EXTRAVERSION
            AX_EXTRAVERSION := $(shell echo $(AX_EXTRAVERSION) | sed 's/-//')
            # Add leading dash to AX_EXTRAVERSION
            AX_EXTRAVERSION := -$(AX_EXTRAVERSION)
        endif
    else
        ifndef AX_EXTRAVERSION
            # Force build type to EXPERIMENTAL, SNAPSHOT mandates a tag
            AX_BUILDTYPE := EXPERIMENTAL
        else
            # Remove leading dash from AX_EXTRAVERSION
            AX_EXTRAVERSION := $(shell echo $(AX_EXTRAVERSION) | sed 's/-//')
            # Add leading dash to AX_EXTRAVERSION
            AX_EXTRAVERSION := -$(AX_EXTRAVERSION)
        endif
    endif
else
    # If AX_BUILDTYPE is not defined, set to UNOFFICIAL
ifeq ($(PRODUCT_EXPERIMENTAL),1)
    AX_BUILDTYPE := EXPERIMENTAL
    AX_EXTRAVERSION :=
else
    AX_BUILDTYPE := HOMECASE
    AX_EXTRAVERSION :=
endif
endif

ifeq ($(AX_BUILDTYPE), UNOFFICIAL HOMECASE)
    ifneq ($(TARGET_UNOFFICIAL_BUILD_ID),)
        AX_EXTRAVERSION := -$(TARGET_UNOFFICIAL_BUILD_ID)
    endif
endif

ifeq ($(AX_BUILDTYPE), RELEASE)
    ifndef TARGET_VENDOR_RELEASE_BUILD_ID
        AX_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(shell date -u +%Y%m%d)-$(AX_BUILDTYPE)-$(AXOLOTL_BUILD)-$(PRODUCT_NAME)
    else
        ifeq ($(TARGET_BUILD_VARIANT),user)
            ifeq ($(AX_VERSION_MAINTENANCE),0)
                AX_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(AXOLOTL_BUILD)-$(PRODUCT_NAME)
            else
                AX_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(AXOLOTL_BUILD)-$(PRODUCT_NAME)
            endif
        else
            AX_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(AXOLOTL_BUILD)-$(PRODUCT_NAME)
        endif
    endif
else
    ifeq ($(AX_VERSION_MAINTENANCE),0)
        AX_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(shell date -u +%Y%m%d)-$(AX_BUILDTYPE)$(AX_EXTRAVERSION)-$(AXOLOTL_BUILD)-$(PRODUCT_NAME)
    else
        AX_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(shell date -u +%Y%m%d)-$(AX_BUILDTYPE)$(AX_EXTRAVERSION)-$(AXOLOTL_BUILD)-$(PRODUCT_NAME)
    endif
endif

###########################################################################
-include vendor/XPe-priv/keys/keys.mk

ifneq ($(PRODUCT_DEFAULT_DEV_CERTIFICATE),)
ifneq ($(PRODUCT_DEFAULT_DEV_CERTIFICATE),build/target/product/security/testkey)
    ifneq ($(AX_BUILDTYPE), UNOFFICIAL)
        ifndef TARGET_VENDOR_RELEASE_BUILD_ID
            ifneq ($(AX_EXTRAVERSION),)
        		# Remove leading dash from AX_EXTRAVERSION
                AX_EXTRAVERSION := $(shell echo $(AX_EXTRAVERSION) | sed 's/-//')
                TARGET_VENDOR_RELEASE_BUILD_ID := $(AX_EXTRAVERSION)
            else
                TARGET_VENDOR_RELEASE_BUILD_ID := $(shell date -u +%Y%m%d)
            endif
        else
            TARGET_VENDOR_RELEASE_BUILD_ID := $(TARGET_VENDOR_RELEASE_BUILD_ID)
        endif
            AX_DISPLAY_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(TARGET_VENDOR_RELEASE_BUILD_ID)-$(PRODUCT_NAME)
     endif
endif
endif

-include $(WORKSPACE)/build_env/image-auto-bits.mk
