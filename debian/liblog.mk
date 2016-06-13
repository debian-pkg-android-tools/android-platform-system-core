NAME = liblog
SOURCES = fake_log_device.c logd_write_kern.c logprint.c uio.c event_tag_map.c
SOURCES := $(foreach source, $(SOURCES), liblog/$(source))
CPPFLAGS += -include android/arch/AndroidConfig.h -Iinclude -DLIBLOG_LOG_TAG=1005
LDFLAGS += -shared -Wl,-soname,$(NAME).so.0

build: $(SOURCES)
	$(CC) $^ -o $(NAME).so.0 $(CFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.0 $(NAME).so

clean:
	$(RM) $(NAME).so*