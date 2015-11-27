NAME = liblog
SOURCES = fake_log_device.c logd_write_kern.c logprint.c uio.c event_tag_map.c
SOURCES := $(foreach source, $(SOURCES), liblog/$(source))
CFLAGS += -fPIC
CPPFLAGS += -include android/arch/AndroidConfig.h -Iinclude
LDFLAGS += -shared -Wl,-soname,$(NAME).so.0 \
           -Wl,-rpath=/usr/lib/android

build: $(SOURCES)
	$(CC) $^ -o $(NAME).so.$(ANDROID_LIBVERSION) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so.0

clean:
	$(RM) $(NAME).so*