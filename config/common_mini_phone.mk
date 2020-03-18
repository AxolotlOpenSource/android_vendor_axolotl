$(call inherit-product, vendor/axolotl/config/common_mini.mk)

# Required XPe packages
PRODUCT_PACKAGES += \
LatinIME

# Include XPe LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/axolotl/overlay/dictionaries

$(call inherit-product, vendor/axolotl/config/telephony.mk)
