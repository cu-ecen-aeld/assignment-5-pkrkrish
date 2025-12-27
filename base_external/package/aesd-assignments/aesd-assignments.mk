# TODO: Fill up the contents below in order to reference your assignment 3 git contents
# Use the full 40-character git commit hash here
AESD_ASSIGNMENTS_VERSION = b6e38b3256d30162aa4a647082289c99af22694e
# Example: git@github.com:cu-ecen-aeld/assignments-3-and-later-YOURUSERNAME.git
AESD_ASSIGNMENTS_SITE = https://github.com/cu-ecen-aeld/assignments-3-and-later-pkrkrish.git
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

define AESD_ASSIGNMENTS_BUILD_CMDS
        $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app all
endef

# TODO add your writer, finder and finder-test utilities/scripts to the installation steps below
define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
        # 1. Install executables and scripts to /usr/bin
        $(INSTALL) -m 0755 $(@D)/finder-app/writer $(TARGET_DIR)/usr/bin/
        $(INSTALL) -m 0755 $(@D)/finder-app/finder.sh $(TARGET_DIR)/usr/bin/
        $(INSTALL) -m 0755 $(@D)/finder-app/finder-test.sh $(TARGET_DIR)/usr/bin/
        $(INSTALL) -m 0755 $(@D)/assignment-autotest/tester.sh $(TARGET_DIR)/usr/bin/

        # 2. Install configuration files to /etc/finder-app/conf/
        $(INSTALL) -d -m 0755 $(TARGET_DIR)/etc/finder-app/conf/
        $(INSTALL) -m 0644 $(@D)/conf/* $(TARGET_DIR)/etc/finder-app/conf/

        # 3. Also include assignment-autotest/test/assignment4 content if needed by your scripts
        # Note: Instructions usually imply these go into /usr/bin for global PATH access
        $(INSTALL) -m 0755 $(@D)/assignment-autotest/test/assignment4/* $(TARGET_DIR)/usr/bin/
endef

$(eval $(generic-package))
