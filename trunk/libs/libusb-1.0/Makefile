include $(ROOTDIR)/rules.mk

PKG_NAME:=libusb
PKG_VERSION:=1.0.27

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=\
  https://github.com/libusb/libusb/releases/download/v$(PKG_VERSION) \
  @SF/$(PKG_NAME)
PKG_HASH:=ffaa41d741a8a3bee244ac8e54a72ea05bf2879663c098c82fc5757853441575

include $(INCLUDE_DIR)/package.mk

CONFIGURE_ARGS += \
	--disable-static \
	--disable-log \
	--disable-udev \
	--disable-examples-build \
	--disable-tests-build

$(eval $(call BuildPackage,libusb))

romfs:
	$(INSTALL_DIR) $(ROMFSDIR)/lib
	$(CP) $(PKG_INSTALL_DIR)/lib/libusb-1.0.so* $(ROMFSDIR)/lib/
