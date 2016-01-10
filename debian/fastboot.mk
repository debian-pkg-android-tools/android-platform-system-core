NAME = fastboot
SOURCES = protocol.c engine.c bootimg_utils.cpp fastboot.cpp util.c fs.c usb_linux.c util_linux.c
CSOURCES = $(foreach source, $(filter %.c, $(SOURCES)), fastboot/$(source))
CXXSOURCES = $(foreach source, $(filter %.cpp, $(SOURCES)), fastboot/$(source))
COBJECTS = $(CSOURCES:.c=.o)
CXXOBJECTS = $(CXXSOURCES:.cpp=.o)
CFLAGS += -c -fPIC
CXXFLAGS += -c -fPIC -fpermissive
CPPFLAGS += -DUSE_F2FS -DFASTBOOT_REVISION='"debian"' \
            -include android/arch/AndroidConfig.h \
            -Iinclude \
            -Imkbootimg \
            -I/usr/include/android/ext4_utils \
            -I/usr/include/android/f2fs_utils \
            -I/usr/include/openssl \
            -Ilibsparse/include
LDFLAGS += -fPIC -Wl,-rpath=/usr/lib/android -Wl,-rpath-link=. \
           -L. -lziparchive -lsparse \
           -L/usr/lib/android -lext4_utils -lf2fs_utils

build: $(COBJECTS) $(CXXOBJECTS)
	$(CC) $^ -o fastboot/$(NAME) $(LDFLAGS)

clean:
	$(RM) fastboot/$(NAME) $(COBJECTS) $(CXXOBJECTS)

$(CXXOBJECTS): %.o: %.cpp
	$(CXX) $< -o $@ $(CXXFLAGS) $(CPPFLAGS)

$(COBJECTS): %.o: %.c
	$(CC) $< -o $@ $(CFLAGS) $(CPPFLAGS)