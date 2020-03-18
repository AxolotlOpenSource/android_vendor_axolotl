# Inherit common axolotl stuff
$(call inherit-product, vendor/axolotl/config/common_full.mk)

# Required CM packages
PRODUCT_PACKAGES += \
LatinIME

# Include CM LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/axolotl/overlay/dictionaries

ifeq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))
    PRODUCT_COPY_FILES += \
        vendor/axolotl/prebuilt/common/bootanimation/720.zip:system/media/bootanimation.zip
endif
