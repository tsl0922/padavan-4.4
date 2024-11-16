SRC_NAME=squashfs
#SRC_URL=https://github.com/plougher/squashfs-tools/archive/refs/tags/4.6.1.tar.gz

#all: download_test extract_test
all: 
	make -j$(HOST_NCPU) -C $(SRC_NAME) ; \
	cp $(SRC_NAME)/mksquashfs ./
	cp $(SRC_NAME)/unsquashfs ./

download_test:
	( if [ ! -f $(SRC_NAME).tar.gz ]; then \
		wget -t5 --timeout=20 --no-check-certificate -O $(SRC_NAME).tar.gz $(SRC_URL); \
	fi )

extract_test:
	( if [ ! -d $(SRC_NAME) ]; then \
		tar zxf $(SRC_NAME).tar.gz; \
	fi )

clean:
	if [ -f $(SRC_NAME)] ; then \
		make -C $(SRC_NAME) clean ; \
	fi
	rm -f mksquashfs unsquashfs
