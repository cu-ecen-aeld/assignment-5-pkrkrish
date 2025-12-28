# TODO: Fill up the contents below in order to reference your assignment 3 git contents
# Use the full 40-character git commit hash here
AESD_ASSIGNMENTS_VERSION = ca49cc4a107a0fbaaf31c772640a7f57cbf55f79
# Example: git@github.com:cu-ecen-aeld/assignments-3-and-later-YOURUSERNAME.git
AESD_ASSIGNMENTS_SITE = https://github.com/cu-ecen-aeld/assignments-3-and-later-pkrkrish.git
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

define AESD_ASSIGNMENTS_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app all
endef

# TODO add your writer, finder and finder-test utilities/scripts to the installation steps below
define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	# Remove any existing file/link named dropbear to prevent the 'File exists' error
	rm -rf $(TARGET_DIR)/etc/dropbear
	
	# Create directories (mkdir -p won't fail if the directory exists, 
	# but it fails if a FILE with that name exists, which is why we rm -rf above)
	mkdir -p $(TARGET_DIR)/usr/bin
	mkdir -p $(TARGET_DIR)/usr/conf
	mkdir -p $(TARGET_DIR)/etc/finder-app/conf
	mkdir -p $(TARGET_DIR)/etc/dropbear

	# Install binaries/scripts
	$(INSTALL) -m 0755 $(@D)/finder-app/writer $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 0755 $(@D)/finder-app/finder.sh $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 0755 $(@D)/finder-app/finder-test.sh $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 0755 $(@D)/full-test.sh $(TARGET_DIR)/usr/bin/

	# Install configuration files
	$(INSTALL) -m 0644 $(@D)/finder-app/conf/* $(TARGET_DIR)/usr/conf/
	$(INSTALL) -m 0644 $(@D)/finder-app/conf/* $(TARGET_DIR)/etc/finder-app/conf/

	# Install assignment-specific test scripts
	$(INSTALL) -m 0755 $(@D)/assignment-autotest/test/assignment4/* $(TARGET_DIR)/usr/bin/
	# 1. Clean and Create the directory with strict 700 permissions
	rm -rf $(TARGET_DIR)/etc/dropbear
	$(INSTALL) -d -m 0700 $(TARGET_DIR)/etc/dropbear
endef
$(eval $(generic-package))
