NAME = libziparchive
SOURCES = zip_archive.cc
SOURCES := $(foreach source, $(SOURCES), libziparchive/$(source))
OBJECTS = $(SOURCES:.cc=.o)
CXXFLAGS += -fPIC -c -std=gnu++11
CPPFLAGS += -include include/arch/linux-$(CPU)/AndroidConfig.h \
            -Iinclude -Ibase/include
LDFLAGS += -fPIC -shared  -Wl,-soname,$(NAME).so.0 \
           -Wl,-rpath=/usr/lib/android -lz -L. -lutils -llog -lbase

build: $(OBJECTS)
	$(CXX) $^ -o $(NAME).so.$(ANDROID_LIBVERSION) $(LDFLAGS)
	$(AR) rs $(NAME).a $^
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so.0

clean:
	$(RM) $(OBJECTS)

$(OBJECTS): %.o: %.cc
	$(CXX) $< -o $@ $(CXXFLAGS) $(CPPFLAGS)