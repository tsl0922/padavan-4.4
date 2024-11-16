SRC_NAME = ZeroTierOne-1.14.0
THISDIR = $(shell pwd)

all: 

config_test:

configure:

clean:

romfs:
	$(ROMFSINST) -p +x $(THISDIR)/zerotier-one /usr/bin/zerotier-one
	$(ROMFSINST) -p +x $(THISDIR)/zerotier.sh /usr/bin/zerotier.sh
	ln -sf zerotier-one $(ROMFSDIR)/usr/bin/zerotier-cli
	ln -sf zerotier-one $(ROMFSDIR)/usr/bin/zerotier-idtool
