NAME = libziparchive
SOURCES = zip_archive.cc
SOURCES := $(foreach source, $(SOURCES), libziparchive/$(source))
CXXFLAGS += -fPIC -std=gnu++11
CPPFLAGS += -include android/arch/AndroidConfig.h \
            -Iinclude -Ibase/include
LDFLAGS += -fPIC -shared  -Wl,-soname,$(NAME).so.0 \
           -Wl,-rpath=/usr/lib/android -lz -L. -lutils -llog -lbase

build: $(SOURCES)
	$(CXX) $^ -o $(NAME).so.$(ANDROID_LIBVERSION) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so.0

clean:
	$(RM) $(NAME).so*