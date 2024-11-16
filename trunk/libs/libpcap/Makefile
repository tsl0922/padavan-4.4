include $(ROOTDIR)/rules.mk

PKG_NAME:=libpcap
PKG_VERSION:=1.10.4

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://www.tcpdump.org/release/
PKG_HASH:=ed19a0383fad72e3ad435fd239d7cd80d64916b87269550159d20e47160ebe5f

include $(INCLUDE_DIR)/package.mk

CONFIGURE_ARGS += \
	--enable-static \
	--enable-shared \
	--disable-yydebug \
	--disable-dbus \
	--disable-usb \
	--disable-bluetooth \
	--with-pcap=linux \
	--without-flex \
	--without-bison \
	--without-dag \
	--without-septel \
	--without-libnl

CONFIGURE_VARS += ac_cv_netfilter_can_compile=no

$(eval $(call BuildPackage,libpcap))

romfs:
	$(INSTALL_DIR) $(ROMFSDIR)/lib
	$(CP) $(PKG_INSTALL_DIR)/lib/libpcap.so* $(ROMFSDIR)/lib/
