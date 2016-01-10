NAME = libcutils
SOURCES = hashmap.c \
          atomic.c \
          native_handle.c \
          config_utils.c \
          load_file.c \
          strlcpy.c \
          open_memstream.c \
          strdup16to8.c \
          strdup8to16.c \
          record_stream.c \
          process_name.c \
          threads.c \
          sched_policy.c \
          iosched_policy.c \
          str_parms.c \
          fs_config.c \
          fs.c \
          multiuser.c \
          socket_inaddr_any_server.c \
          socket_local_client.c \
          socket_local_server.c \
          socket_loopback_client.c \
          socket_loopback_server.c \
          socket_network_client.c \
          sockets.c \
          ashmem-host.c \
          trace-host.c \
          dlmalloc_stubs.c
SOURCES := $(foreach source, $(SOURCES), libcutils/$(source))
CFLAGS += -fPIC
CPPFLAGS += -include android/arch/AndroidConfig.h -Iinclude
LDFLAGS += -shared -Wl,-soname,$(NAME).so.0 \
           -Wl,-rpath=/usr/lib/android -lpthread -L. -llog

build: $(SOURCES)
	$(CC) $^ -o $(NAME).so.0 $(CFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.0 $(NAME).so

clean:
	$(RM) $(NAME).so*