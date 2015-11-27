NAME = liblog
SOURCES = fake_log_device.c logd_write_kern.c logprint.c uio.c event_tag_map.c
SOURCES := $(foreach source, $(SOURCES), liblog/$(source))
OBJECTS = $(SOURCES:.c=.o)
CFLAGS += -fPIC -c
CPPFLAGS += -include android/arch/AndroidConfig.h -Iinclude
LDFLAGS += -fPIC -shared -Wl,-soname,$(NAME).so.0 \
           -Wl,-rpath=/usr/lib/android

build: $(OBJECTS)
	$(CC) $^ -o $(NAME).so.$(ANDROID_LIBVERSION) $(LDFLAGS)
	$(AR) rs $(NAME).a $^
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so.0

clean:
	$(RM) $(OBJECTS)

$(OBJECTS): %.o: %.c
	$(CC) $< -o $@ $(CFLAGS) $(CPPFLAGS)