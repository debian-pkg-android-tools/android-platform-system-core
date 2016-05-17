NAME = libziparchive
SOURCES = zip_archive.cc
SOURCES := $(foreach source, $(SOURCES), libziparchive/$(source))
CXXFLAGS += -fPIC -std=gnu++11
CPPFLAGS += -include android/arch/AndroidConfig.h \
            -Iinclude -Ibase/include
LDFLAGS += -shared -Wl,-soname,$(NAME).so.0 \
           -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -lz -L. -lutils -llog -lbase

build: $(SOURCES)
	$(CXX) $^ -o $(NAME).so.0 $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.0 $(NAME).so

clean:
	$(RM) $(NAME).so*