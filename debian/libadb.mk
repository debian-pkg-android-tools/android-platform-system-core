NAME = libadb
SOURCES = adb.cpp \
          adb_auth.cpp \
          adb_io.cpp \
          adb_listeners.cpp \
          adb_utils.cpp \
          sockets.cpp \
          transport.cpp \
          transport_local.cpp \
          transport_usb.cpp \
          fdevent.cpp \
          get_my_path_linux.cpp \
          usb_linux.cpp \
          adb_auth_host.cpp \
          services.cpp
SOURCES := $(foreach source, $(SOURCES), adb/$(source))
CXXFLAGS += -fPIC -fpermissive -std=gnu++11
CPPFLAGS += -include android/arch/AndroidConfig.h \
            -Iinclude -Ibase/include -DADB_HOST=1 -DADB_REVISION='"debian"'
LDFLAGS += -shared -Wl,-soname,$(NAME).so.0 \
           -Wl,-rpath=/usr/lib/android -lcrypto -lpthread -L. -lbase -lcutils

build: $(SOURCES)
	$(CXX) $^ -o $(NAME).so.$(ANDROID_LIBVERSION) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so.0

clean:
	$(RM) $(NAME).so*