# Charger
ifneq ($(WITH_XPE_CHARGER),)
    BOARD_HAL_STATIC_LIBRARIES := libhealthd.xpe
endif

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/axolotl/config/BoardConfigQcom.mk
endif

include vendor/axolotl/config/BoardConfigKernel.mk

# soong
include vendor/axolotl/build/soong/soong_config.mk
include vendor/axolotl/config/BoardConfigSoong.mk

PRODUCT_SOONG_NAMESPACES += $(PATHMAP_SOONG_NAMESPACES)
