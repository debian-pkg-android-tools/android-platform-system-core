NAME = libbacktrace
SOURCES = Backtrace.cpp \
          BacktraceCurrent.cpp \
          BacktraceMap.cpp \
          BacktracePtrace.cpp \
          thread_utils.c \
          ThreadEntry.cpp \
          UnwindCurrent.cpp \
          UnwindMap.cpp \
          UnwindPtrace.cpp
CSOURCES = $(foreach source, $(filter %.c, $(SOURCES)), libbacktrace/$(source))
CXXSOURCES = $(foreach source, $(filter %.cpp, $(SOURCES)), libbacktrace/$(source))
COBJECTS = $(CSOURCES:.c=.o)
CXXOBJECTS = $(CXXSOURCES:.cpp=.o)
CFLAGS += -fPIC -c
CXXFLAGS += -fPIC -c -std=gnu++11
CPPFLAGS += -include android/arch/AndroidConfig.h \
            -Iinclude -Ibase/include -I/usr/include/android/unwind
LDFLAGS += -fPIC -shared -Wl,-soname,$(NAME).so.0 \
           -Wl,-rpath=/usr/lib/android -lrt -lpthread \
           -L/usr/lib/android -lunwind -L. -lbase -llog -lcutils

build: $(COBJECTS) $(CXXOBJECTS)
	$(CXX) $^ -o $(NAME).so.$(ANDROID_LIBVERSION) $(LDFLAGS)
	$(AR) rs $(NAME).a $^
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so.0

clean:
	$(RM) $(COBJECTS) $(CXXOBJECTS)

$(CXXOBJECTS): %.o: %.cpp
	$(CXX) $< -o $@ $(CXXFLAGS) $(CPPFLAGS)

$(COBJECTS): %.o: %.c
	$(CC) $< -o $@ $(CFLAGS) $(CPPFLAGS)