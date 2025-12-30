# TODO: Fill up the contents below in order to reference your assignment 3 git contents
# Use the full 40-character git commit hash here
AESD_ASSIGNMENTS_VERSION = 307741399b9b9a8f0ab8273b70cbc9de4396a3ca
# Example: git@github.com:cu-ecen-aeld/assignments-3-and-later-YOURUSERNAME.git
AESD_ASSIGNMENTS_SITE = git@github.com:cu-ecen-aeld/assignments-3-and-later-pkrkrish.git
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

define AESD_ASSIGNMENTS_BUILD_CMDS
	# Build finder-app from previous assignments
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app all
	# Build the new aesdsocket application from the server directory
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server all
endef

define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	# 1. Create directories
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/bin
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/etc/init.d
	mkdir -p $(TARGET_DIR)/etc/finder-app/conf
	mkdir -p $(TARGET_DIR)/root/.ssh

	# 2. Set strict permissions
	chmod 0700 $(TARGET_DIR)/root
	chmod 0700 $(TARGET_DIR)/root/.ssh

	# 3. Install binaries and scripts (Updated for Assignment 5)
	$(INSTALL) -m 0755 $(@D)/finder-app/writer $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 0755 $(@D)/finder-app/finder.sh $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 0755 $(@D)/finder-app/finder-test.sh $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 0755 $(@D)/full-test.sh $(TARGET_DIR)/usr/bin/
	# Install the aesdsocket binary
	$(INSTALL) -m 0755 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin/

	# 4. Install configuration files
	$(INSTALL) -m 0644 $(@D)/finder-app/conf/* $(TARGET_DIR)/etc/finder-app/conf/

	# 5. Install init scripts (Required for Assignment 5)
	# This installs your start-stop script as an auto-starting daemon
	$(INSTALL) -m 0755 $(@D)/server/aesdsocket-start-stop $(TARGET_DIR)/etc/init.d/S99aesdsocket

	# 6. Install SSH KEY
	$(INSTALL) -m 0600 $(AESD_ASSIGNMENTS_PKGDIR)/authorized_keys $(TARGET_DIR)/root/.ssh/authorized_keys
endef
$(eval $(generic-package))
