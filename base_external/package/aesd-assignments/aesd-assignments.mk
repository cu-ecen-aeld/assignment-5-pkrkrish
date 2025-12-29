# TODO: Fill up the contents below in order to reference your assignment 3 git contents
# Use the full 40-character git commit hash here
AESD_ASSIGNMENTS_VERSION = ca49cc4a107a0fbaaf31c772640a7f57cbf55f79
# Example: git@github.com:cu-ecen-aeld/assignments-3-and-later-YOURUSERNAME.git
AESD_ASSIGNMENTS_SITE = git@github.com:cu-ecen-aeld/assignments-3-and-later-pkrkrish.git
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

define AESD_ASSIGNMENTS_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app all
endef

# TODO add your writer, finder and finder-test utilities/scripts to the installation steps below
define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	# 1. Create directories
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/bin
	mkdir -p $(TARGET_DIR)/etc/finder-app/conf
	mkdir -p $(TARGET_DIR)/root/.ssh

	# 2. Set strict permissions (The critical fix)
	chmod 0700 $(TARGET_DIR)/root
	chmod 0700 $(TARGET_DIR)/root/.ssh

	# 3. Install binaries and scripts
	$(INSTALL) -m 0755 $(@D)/finder-app/writer $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 0755 $(@D)/finder-app/finder.sh $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 0755 $(@D)/finder-app/finder-test.sh $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 0755 $(@D)/full-test.sh $(TARGET_DIR)/usr/bin/

	# 4. Install configuration files
	$(INSTALL) -m 0644 $(@D)/finder-app/conf/* $(TARGET_DIR)/etc/finder-app/conf/

	# 5. Install autograder test scripts
	$(INSTALL) -m 0755 $(@D)/assignment-autotest/test/assignment4/* $(TARGET_DIR)/usr/bin/

	# 6. Install SSH KEY (Verify this filename matches exactly in your repo)
	$(INSTALL) -m 0600 $(AESD_ASSIGNMENTS_PKGDIR)/authorized_keys $(TARGET_DIR)/root/.ssh/authorized_keys
endef
$(eval $(generic-package))
