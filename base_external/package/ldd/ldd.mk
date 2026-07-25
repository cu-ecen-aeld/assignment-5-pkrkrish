LDD_VERSION = 5fcc017ec23331e7f760fb5f118852d7247566e0
LDD_SITE = git@github.com:cu-ecen-aeld/assignment-7-pkrkrish.git
LDD_SITE_METHOD = git

# 1. Added LDD_ prefix so Buildroot recognizes the subdirectories
LDD_MODULE_SUBDIRS = misc-modules scull

# 2. Removed the manual .ko installation (kernel-module macro handles this automatically)
# 3. Added -m 0755 to ensure scripts are executable on the target
define LDD_INSTALL_TARGET_CMDS
    $(INSTALL) -m 0755 $(@D)/misc-modules/module_load $(TARGET_DIR)/usr/sbin/module_load
    $(INSTALL) -m 0755 $(@D)/misc-modules/module_unload $(TARGET_DIR)/usr/sbin/module_unload
    $(INSTALL) -m 0755 $(@D)/scull/scull_load $(TARGET_DIR)/usr/sbin/scull_load
    $(INSTALL) -m 0755 $(@D)/scull/scull_unload $(TARGET_DIR)/usr/sbin/scull_unload
endef

$(eval $(kernel-module))
$(eval $(generic-package))