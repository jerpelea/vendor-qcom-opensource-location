ifneq ($(BUILD_TINY_ANDROID),true)

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := libloc_api_v02

LOCAL_MODULE_TAGS := optional
LOCAL_PROPRIETARY_MODULE := true

ifeq ($(TARGET_DEVICE),apq8026_lw)
LOCAL_CFLAGS += -DPDK_FEATURE_SET
else ifeq ($(BOARD_VENDOR_QCOM_LOC_PDK_FEATURE_SET),true)
LOCAL_CFLAGS += -DPDK_FEATURE_SET
endif
ifneq ($(filter msm8926 msm8974,$(TARGET_BOARD_PLATFORM)),)
LOCAL_CFLAGS += -DLEGACY_DEVICES
endif

LOCAL_SHARED_LIBRARIES := \
    libutils \
    libcutils \
    libqmi_cci \
    libqmi_csi \
    libqmi_common_so \
    libloc_core \
    libgps.utils \
    libloc_ds_api

LOCAL_SRC_FILES = \
    LocApiV02.cpp \
    loc_api_v02_log.c \
    loc_api_v02_client.c \
    loc_api_sync_req.c \
    location_service_v02.c

LOCAL_CFLAGS += \
    -fno-short-enums \
    -D_ANDROID_

LOCAL_COPY_HEADERS_TO:= libloc_api_v02/

LOCAL_COPY_HEADERS:= \
    location_service_v02.h \
    loc_api_v02_log.h \
    loc_api_v02_client.h \
    loc_api_sync_req.h \
    LocApiV02.h \
    loc_util_log.h


## Includes
LOCAL_C_INCLUDES := \
    $(TARGET_OUT_HEADERS)/libloc_core \
    $(TARGET_OUT_HEADERS)/gps.utils \
    $(TARGET_OUT_HEADERS)/libloc_ds_api

LOCAL_PRELINK_MODULE := false

include $(BUILD_SHARED_LIBRARY)

endif # not BUILD_TINY_ANDROID
