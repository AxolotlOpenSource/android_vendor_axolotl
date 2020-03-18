# Inherit common axolotl stuff
$(call inherit-product, vendor/axolotl/config/common_full.mk)

# Required CM packages
PRODUCT_PACKAGES += \
    LatinIME

# Include CM LatinIME dictionaries
    PRODUCT_PACKAGE_OVERLAYS += vendor/axolotl/overlay/dictionaries

$(call inherit-product, vendor/axolotl/config/telephony.mk)
