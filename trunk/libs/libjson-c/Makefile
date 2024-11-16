include $(ROOTDIR)/rules.mk

PKG_NAME:=json-c
PKG_VERSION:=0.17

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://s3.amazonaws.com/json-c_releases/releases/
PKG_HASH:=7550914d58fb63b2c3546f3ccfbe11f1c094147bd31a69dcd23714d7956159e6

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

CMAKE_OPTIONS += -DDISABLE_EXTRA_LIBS=TRUE

$(eval $(call BuildPackage,json-c))

romfs:
	$(INSTALL_DIR) $(ROMFSDIR)/lib
	$(CP) $(PKG_INSTALL_DIR)/lib/libjson-c.so* $(ROMFSDIR)/lib/
