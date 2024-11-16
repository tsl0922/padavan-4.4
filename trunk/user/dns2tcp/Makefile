include $(ROOTDIR)/rules.mk

PKG_NAME:=dns2tcp
PKG_VERSION:=1.1.1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/zfl9/dns2tcp/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=35251fbe1645601086f21cdbd5a2f75471d812f99ed8017bb05158840456b43c

include $(INCLUDE_DIR)/package.mk

$(eval $(call BuildPackage,dns2tcp))

romfs:
	$(INSTALL_DIR) $(ROMFSDIR)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/dns2tcp $(ROMFSDIR)/usr/bin/dns2tcp
