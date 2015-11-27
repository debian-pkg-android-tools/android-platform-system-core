NAME = libbase
SOURCES = file.cpp \
          stringprintf.cpp \
          strings.cpp
SOURCES := $(foreach source, $(SOURCES), base/$(source))
CXXFLAGS += -fPIC -std=gnu++11
CPPFLAGS += -include android/arch/AndroidConfig.h -Iinclude -Ibase/include
LDFLAGS += -shared -Wl,-soname,$(NAME).so.0 \
           -Wl,-rpath=/usr/lib/android -L. -llog

build: $(SOURCES)
	$(CXX) $^ -o $(NAME).so.$(ANDROID_LIBVERSION) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so.0

clean:
	$(RM) $(NAME).so*