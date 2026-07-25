BR2_EXTERNAL := $(TOPDIR)/../base_external

include $(sort $(wildcard $(BR2_EXTERNAL)/package/*/*.mk))
