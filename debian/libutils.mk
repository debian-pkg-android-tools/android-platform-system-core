NAME = libutils
SOURCES = BasicHashtable.cpp \
          CallStack.cpp \
          FileMap.cpp \
          JenkinsHash.cpp \
          LinearTransform.cpp \
          Log.cpp \
          NativeHandle.cpp \
          Printer.cpp \
          ProcessCallStack.cpp \
          PropertyMap.cpp \
          RefBase.cpp \
          SharedBuffer.cpp \
          Static.cpp \
          StopWatch.cpp \
          String8.cpp \
          String16.cpp \
          SystemClock.cpp \
          Threads.cpp \
          Timers.cpp \
          Tokenizer.cpp \
          Unicode.cpp \
          VectorImpl.cpp \
          misc.cpp \
          Looper.cpp
SOURCES := $(foreach source, $(SOURCES), libutils/$(source))
CXXFLAGS += -fPIC -std=gnu++11
CPPFLAGS += -include android/arch/AndroidConfig.h \
            -Iinclude -Idebian \
            -DLIBUTILS_NATIVE=1
LDFLAGS += -shared -Wl,-soname,$(NAME).so.0 \
           -Wl,-rpath=/usr/lib/android \
           -lpthread -L. -llog -lcutils -lbacktrace

build: $(SOURCES)
	$(CXX) $^ -o $(NAME).so.$(ANDROID_LIBVERSION) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so.0

clean:
	$(RM) $(NAME).so*