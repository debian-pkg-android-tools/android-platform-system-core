NAME = adb
SOURCES = adb_client.cpp \
          client/main.cpp \
          console.cpp \
          commandline.cpp \
          file_sync_client.cpp \
          line_printer.cpp \
          shell_service_protocol.cpp
SOURCES := $(foreach source, $(SOURCES), adb/$(source))
CXXFLAGS += -std=c++14 -fpermissive
CPPFLAGS += -Iinclude -Iadb -Ibase/include \
            -DADB_REVISION='"debian"' -DADB_HOST=1 -D_GNU_SOURCE
LDFLAGS += -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android -Wl,-rpath-link=. \
           -lpthread -L. -ladb -lbase -lcutils

build: $(SOURCES)
	$(CXX) $^ -o adb/$(NAME) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)

clean:
	$(RM) adb/$(NAME)