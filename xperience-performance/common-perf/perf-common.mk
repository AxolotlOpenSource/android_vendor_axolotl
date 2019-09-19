# Copyright (C) 2018-2019 The XPerience Project
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

#PRODUCT_PACKAGES += \
    Perfdump \
    QPerformance \
    UxPerformance

#system
PRODUCT_COPY_FILES += \
    vendor/xperience/xperience-performance/common-perf/bin/perfservice::$(TARGET_COPY_OUT_SYSTEM)/bin/perfservice \
    vendor/xperience/xperience-performance/common-perf/etc/init/perfservice.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/perfservice.rc \
    vendor/xperience/xperience-performance/common-perf/lib/libqti-at.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libqti-at.so \
    vendor/xperience/xperience-performance/common-perf/lib/libqti-perfd-client_system.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libqti-perfd-client_system.so \
    vendor/xperience/xperience-performance/common-perf/lib/libqti-iopd-client_system.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libqti-iopd-client_system.so\
    vendor/xperience/xperience-performance/common-perf/lib/libqti_performance.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libqti_performance.so \
    vendor/xperience/xperience-performance/common-perf/lib/libqti-util_system.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libqti-util_system.so \
    vendor/xperience/xperience-performance/common-perf/lib/vendor.qti.hardware.perf@1.0.so:$(TARGET_COPY_OUT_SYSTEM)/lib/vendor.qti.hardware.perf@1.0.so \
    vendor/xperience/xperience-performance/common-perf/lib/vendor.qti.hardware.iop@1.0.so:$(TARGET_COPY_OUT_SYSTEM)/lib/vendor.qti.hardware.iop@1.0.so \
    vendor/xperience/xperience-performance/common-perf/lib/vendor.qti.hardware.iop@2.0.so:$(TARGET_COPY_OUT_SYSTEM)/lib/vendor.qti.hardware.iop@2.0.so

ifeq ($(TARGET_ARCH),arm64)
PRODUCT_COPY_FILES += \
    vendor/xperience/xperience-performance/common-perf/lib64/libqti-at.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libqti-at.so \
    vendor/xperience/xperience-performance/common-perf/lib64/libqti-perfd-client_system.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libqti-perfd-client_system.so \
    vendor/xperience/xperience-performance/common-perf/lib64/libqti-iopd-client_system.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libqti-iopd-client_system.so\
    vendor/xperience/xperience-performance/common-perf/lib64/libqti_performance.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libqti_performance.so \
    vendor/xperience/xperience-performance/common-perf/lib64/libqti-util_system.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libqti-util_system.so \
    vendor/xperience/xperience-performance/common-perf/lib64/vendor.qti.hardware.perf@1.0.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/vendor.qti.hardware.perf@1.0.so \
    vendor/xperience/xperience-performance/common-perf/lib64/vendor.qti.hardware.iop@1.0.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/vendor.qti.hardware.iop@1.0.so \
    vendor/xperience/xperience-performance/common-perf/lib64/vendor.qti.hardware.iop@2.0.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/vendor.qti.hardware.iop@2.0.so
endif

#vendor
PRODUCT_COPY_FILES += \
    vendor/xperience/xperience-performance/common-perf/vendor/lib/hw/vendor.qti.hardware.iop@2.0-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/vendor.qti.hardware.iop@2.0-impl.so \
    vendor/xperience/xperience-performance/common-perf/vendor/lib/libqti-iopd-client.so:$(TARGET_COPY_OUT_VENDOR)/lib/libqti-iopd-client.so \
    vendor/xperience/xperience-performance/common-perf/vendor/lib/vendor.qti.hardware.iop@1.0.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.iop@1.0.so \
    vendor/xperience/xperience-performance/common-perf/vendor/lib/vendor.qti.hardware.iop@2.0.so:$(TARGET_COPY_OUT_VENDOR)/lib/vendor.qti.hardware.iop@2.0.so

ifeq ($(TARGET_ARCH),arm64)
PRODUCT_COPY_FILES += \
    vendor/xperience/xperience-performance/common-perf/vendor/lib64/hw/vendor.qti.hardware.iop@2.0-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/vendor.qti.hardware.iop@2.0-impl.so \
    vendor/xperience/xperience-performance/common-perf/vendor/lib64/libqti-iopd-client.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libqti-iopd-client.so \
    vendor/xperience/xperience-performance/common-perf/vendor/lib64/vendor.qti.hardware.iop@1.0.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.iop@1.0.so \
    vendor/xperience/xperience-performance/common-perf/vendor/lib64/vendor.qti.hardware.iop@2.0.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.qti.hardware.iop@2.0.so
endif
