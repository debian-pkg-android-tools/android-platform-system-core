NAME = libbase
SOURCES = file.cpp \
          stringprintf.cpp \
          strings.cpp
SOURCES := $(foreach source, $(SOURCES), base/$(source))
OBJECTS = $(SOURCES:.cpp=.o)
CXXFLAGS += -fPIC -c -std=gnu++11
CPPFLAGS += -include android/arch/AndroidConfig.h -Iinclude -Ibase/include
LDFLAGS += -fPIC -shared -Wl,-soname,$(NAME).so.0 \
           -Wl,-rpath=/usr/lib/android -L. -llog

build: $(OBJECTS)
	$(CXX) $^ -o $(NAME).so.$(ANDROID_LIBVERSION) $(LDFLAGS)
	$(AR) rs $(NAME).a $^
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so.0

clean:
	$(RM) $(OBJECTS)

$(OBJECTS): %.o: %.cpp
	$(CXX) $< -o $@ $(CXXFLAGS) $(CPPFLAGS)