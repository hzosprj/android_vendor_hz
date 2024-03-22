# Versioning System
HZ_PLATFORM_VERSION := 14.0
HZVERSION := 1.0
HZ_BUILD_TYPE ?= COMMUNITY
HZ_CODENAME := DTA

# HZOS Release
ifeq ($(HZ_BUILD_TYPE), OFFICIAL)

  OFFICIAL_DEVICES = $(shell cat vendor/hz/config/hz.devices)
  FOUND_DEVICE =  $(filter $(HZ_BUILD), $(OFFICIAL_DEVICES))
    ifeq ($(FOUND_DEVICE),$(HZ_BUILD))
      HZ_BUILD_TYPE := OFFICIAL
    else
      HZ_BUILD_TYPE := COMMUNITY
      $(error Device is not official "$(HZ_BUILD)")
    endif
endif

# System version
TARGET_PRODUCT_SHORT := $(subst hz_,,$(HZ_BUILD_TYPE))

HZ_DATE_YEAR := $(shell date -u +%Y)
HZ_DATE_MONTH := $(shell date -u +%m)
HZ_DATE_DAY := $(shell date -u +%d)
HZ_DATE_HOUR := $(shell date -u +%H)
HZ_DATE_MINUTE := $(shell date -u +%M)
HZ_BUILD_DATE_UTC := $(shell date -d '$(HZ_DATE_YEAR)-$(HZ_DATE_MONTH)-$(HZ_DATE_DAY) $(HZ_DATE_HOUR):$(HZ_DATE_MINUTE) UTC' +%s)
HZ_BUILD_DATE := $(HZ_DATE_YEAR)$(HZ_DATE_MONTH)$(HZ_DATE_DAY)-$(HZ_DATE_HOUR)$(HZ_DATE_MINUTE)

ifeq ($(HZ_VANILLA), true)
HZ_VERSION := HZOS-v$(HZVERSION)-$(HZ_BUILD_DATE)-$(HZ_BUILD)-$(HZ_BUILD_TYPE)-Vanilla
else
HZ_VERSION := HZOS-v$(HZVERSION)-$(HZ_BUILD_DATE)-$(HZ_BUILD)-$(HZ_BUILD_TYPE)-GApps
endif
HZ_VERSION_PROP := $(PLATFORM_VERSION)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.hz.version=$(HZVERSION) \
    ro.hz.version.display=$(HZ_VERSION) \
    ro.hz.build_date=$(HZ_BUILD_DATE) \
    ro.hz.codename=$(HZ_CODENAME) \
    ro.hz.version.prop=$(HZ_VERSION_PROP) \
    ro.hz.build_date_utc=$(HZ_BUILD_DATE_UTC) \
    ro.hz.maintainer=$(HZ_MAINTAINER) \
    ro.hz.display_resolution?=$(HZ_DISPLAY) \
    ro.hz.build_type=$(HZ_BUILD_TYPE)