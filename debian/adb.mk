NAME = adb
SOURCES = adb_main.cpp \
          console.cpp \
          commandline.cpp \
          adb_client.cpp \
          file_sync_client.cpp
SOURCES := $(foreach source, $(SOURCES), adb/$(source))
CXXFLAGS += -fPIC -std=gnu++11 -fpermissive
CPPFLAGS += -include android/arch/AndroidConfig.h \
            -Iinclude -Ibase/include \
            -DADB_REVISION='"debian"' -DWORKAROUND_BUG6558362 -DADB_HOST=1 \
            -D_XOPEN_SOURCE -D_GNU_SOURCE
LDFLAGS += -fPIC -Wl,-rpath=/usr/lib/android -Wl,-rpath-link=. \
           -lpthread -L. -ladb -lbase -lcutils

build: $(SOURCES)
	$(CXX) $^ -o $(NAME) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)

clean:
	$(RM) $(NAME)