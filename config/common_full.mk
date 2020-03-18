# Inherit common axolotl stuff
$(call inherit-product, vendor/axolotl/config/common.mk)

PRODUCT_SIZE := full

# Recorder
PRODUCT_PACKAGES += \
    Recorder
