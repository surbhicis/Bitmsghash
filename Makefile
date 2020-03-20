UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
	CCFLAGS += -I/usr/local/Cellar/openssl/1.0.2d_1/include
	LDFLAGS += -L/usr/local/Cellar/openssl/1.0.2d_1/lib
else ifeq ($(UNAME_S),MINGW32_NT-6.1)
	CCFLAGS += -IC:\OpenSSL-1.0.2j-mingw\include -D_WIN32 -march=native
	LDFLAGS += -static-libgcc -LC:\OpenSSL-1.0.2j-mingw\lib -lwsock32 -o bitmsghash32.dll -Wl,--out-implib,bitmsghash.a
else
	LDFLAGS += -o libbitmsghash.so
endif
   	
all: libbitmsghash.so

powtest:
	./testpow.py

libbitmsghash.so: bitmsghash.o
	${CXX} bitmsghash.o -shared -fPIC -lcrypto $(LDFLAGS)

bitmsghash.o:
	${CXX} -Wall -O3 -march=armv2a -fPIC $(CCFLAGS) -c bitmsghash.cpp

clean:
	rm -f bitmsghash.o libbitmsghash.so bitmsghash*.dll

