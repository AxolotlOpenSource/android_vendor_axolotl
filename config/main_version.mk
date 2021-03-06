# XPerience System Properties
ADDITIONAL_BUILD_PROPERTIES += \
    ro.ax.version=$(AX_VERSION) \
    ro.ax.releasetype=$(AX_BUILDTYPE) \
    ro.axolotl.build.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.ax.channeltype=$(AXOLOTL_CHANNEL) \
    ro.axolotl.channeltype=$(AXOLOTL_CHANNEL) \
    ro.axolotl.version=$(AX_VERSION) \
    ro.axolotl.releasetype=$(AX_BUILDTYPE) \
    ro.ax.channeltype=$(AXOLOTL_CHANNEL) \
    ro.modversion=$(AX_VERSION) \
    ro.ax.model=$(AXOLOTL_BUILD) \
    ro.ax.codename=Quelea \
    ro.axolotl.model=$(AXOLOTL_BUILD) \
    ro.axolotl.codename=Quelea \
    ro.ax.egal.url=http://klozz.github.io/TheXPerienceProject/legal/ \
    ro.boot.vendor.overlay.theme=com.android.internal.systemui.navbar.gestural

# Build fingerprint
ifneq ($(BUILD_FINGERPRINT),)
ADDITIONAL_BUILD_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)
endif

AX_DISPLAY_VERSION := $(AX_VERSION)

CAF_BRANCH := LA.UM.8.1.r1-14500-sm8150.0 

ADDITIONAL_BUILD_PROPERTIES += \
    ro.ax.display.version=$(AX_DISPLAY_VERSION)

ADDITIONAL_BUILD_PROPERTIES += \
    persist.backup.ntpServer=0.pool.ntp.org \
    sys.vendor.shutdown.waittime=500

ADDITIONAL_BUILD_PROPERTIES += \
    ro.vendor.extension_library=libqti-perfd-client.so \
    vendor.enable_prefetch=1 \
    vendor.iop.enable_uxe=1 \
    vendor.iop.enable_prefetch_ofr=1 \
    vendor.perf.iop_v3.enable=1 \
    ro.vendor.at_library=libqti-at.so \
    persist.vendor.qti.games.gt.prof=1 \
    ro.build.version.qcom=$(CAF_BRANCH)
