# Inherit common CM stuff
$(call inherit-product, vendor/axolotl/config/common.mk)

PRODUCT_SIZE := mini

# Include XPe audio files
include vendor/axolotl/config/xpe_audio.mk
