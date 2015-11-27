NAME = libsparse
SOURCES = backed_block.c output_file.c sparse.c sparse_crc32.c sparse_err.c sparse_read.c
SOURCES := $(foreach source, $(SOURCES), libsparse/$(source))
OBJECTS = $(SOURCES:.c=.o)
CFLAGS += -fPIC -c
CPPFLAGS += -include android/arch/AndroidConfig.h -Iinclude -Ilibsparse/include
LDFLAGS += -fPIC -shared -Wl,-soname,$(NAME).so.0 \
           -Wl,-rpath=/usr/lib/android -lz

build: $(OBJECTS)
	$(CC) $^ -o $(NAME).so.$(ANDROID_LIBVERSION) $(LDFLAGS)
	$(AR) rs $(NAME).a $^
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so.0

clean:
	$(RM) $(OBJECTS)

$(OBJECTS): %.o: %.c
	$(CC) $< -o $@ $(CFLAGS) $(CPPFLAGS)