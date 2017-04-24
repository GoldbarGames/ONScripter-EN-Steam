# -*- makefile-gmake -*-
#
# THIS IS A GENERATED FILE - changes will not be kept if configure is
# run again.  If you wish to customise it, please be sure to give your
# version a different filename.
#
# Makefile for ONScripter-EN

WIN32=true
OBJSUFFIX=.o
LIBSUFFIX=.a
EXESUFFIX=.exe

PREFIX ?= /usr/local

# Extra handling for internal libraries.
EXTRADEPS= $(internal_sdl) $(internal_png) $(internal_jpeg) $(internal_sdl_image) $(internal_ogglibs) $(internal_sdl_mixer) $(internal_bzip2) $(internal_smpeg) $(internal_freetype) $(internal_sdl_ttf)
INTERNAL_SDL=$(findstring true,true)
INTERNAL_SMPEG=$(findstring true,true)
INTERNAL_LIBPNG=$(findstring true,true)
INTERNAL_LIBJPEG=$(findstring true,true)
INTERNAL_OGGLIBS=$(findstring true,true)
SDL_CONFIG=./extlib/bin/sdl-config

export PATH     :=   $(shell pwd)/extlib/bin:$(PATH)
export CFLAGS   := -I$(shell pwd)/extlib/include $(CFLAGS) 
export CPPFLAGS := -I$(shell pwd)/extlib/include $(CPPFLAGS) 
export LDFLAGS  := -L$(shell pwd)/extlib/lib $(LDFLAGS) 
export CSTD     := -std=c99
export CXXSTD   := -std=c++98

export CC      := gcc
export CXX     := g++
export MAKE    := make
export GNUMAKE := make
export AR      := ar
export RANLIB  := ranlib

# ONScripter variables
OSCFLAGSEXTRA = -Wall  -DUSE_X86_GFX $(OSCTMPFLAGS)
INCS = -Iextlib/include $(shell $(SDL_CONFIG) --cflags)      \
                        $(shell ./extlib/bin/smpeg-config --cflags)    \
                        $(shell ./extlib/bin/freetype-config --cflags) \
       $(shell [ -d extlib/include/SDL ] && echo -Iextlib/include/SDL)

GNURX_DIR = tools/libgnurx
TOOL_EXTRA_INCS = -I$(GNURX_DIR)
TOOL_EXTRADEPS = $(GNURX_DIR)/libgnurx.a
TOOL_EXTRA_CLEAN = clean_libgnurx
TOOL_LIBS = -Lextlib/lib \
            -static -Wl,--start-group \
            extlib/lib/libjpeg$(LIBSUFFIX) extlib/lib/libpng$(LIBSUFFIX) extlib/lib/libz$(LIBSUFFIX) \
            -L$(GNURX_DIR) -lgnurx \
            extlib/lib/libbz2$(LIBSUFFIX) -Wl,--end-group
LIBS = -Lextlib/lib \
       -static -Wl,--start-group \
       $(filter-out -lSDLmain,$(shell $(SDL_CONFIG) --static-libs)) \
       extlib/lib/libSDL_ttf$(LIBSUFFIX) \
       $(shell ./extlib/bin/smpeg-config --libs) $(shell ./extlib/bin/freetype-config --libs) \
       extlib/lib/libSDL_image$(LIBSUFFIX) extlib/lib/libjpeg$(LIBSUFFIX) extlib/lib/libpng$(LIBSUFFIX) extlib/lib/libz$(LIBSUFFIX) \
       extlib/lib/libSDL_mixer$(LIBSUFFIX) extlib/lib/libogg$(LIBSUFFIX) extlib/lib/libvorbis$(LIBSUFFIX) extlib/lib/libvorbisfile$(LIBSUFFIX) \
       extlib/lib/libbz2$(LIBSUFFIX) -Wl,--end-group

# Remove -DUSE_MESSAGEBOX if you don't want Windows dialog boxes
DEFS = -DWIN32 -DUSE_MESSAGEBOX -DUSE_OGG_VORBIS
EXT_OBJS = SDL_win32_main.o win32rc.o graphics_mmx.o graphics_sse2.o


.SUFFIXES:
.SUFFIXES: .o .cpp .h .c

ifdef DEBUG
OSCFLAGS = -O0 -g -pg -ggdb -pipe -Wpointer-arith -Werror  $(OSCFLAGSEXTRA)
export LDFLAGS  := -pg $(LDFLAGS)
else
  ifdef PROF
  OSCFLAGS = -O3 -pg -pipe -Wpointer-arith -Werror  $(OSCFLAGSEXTRA)
  export LDFLAGS  := -pg $(LDFLAGS)
  else
  OSCFLAGS = -O3 -fomit-frame-pointer -pipe -Wpointer-arith -Werror  $(OSCFLAGSEXTRA)
  endif
endif

TARGET ?= onscripter-en

binary: $(TARGET).exe

.PHONY: all clean distclean tools binary
all: $(TARGET).exe tools

SDLOTHERCONFIG := 
OTHERCONFIG := 

OTHER_OBJS =
RC_HDRS =

include Makefile.extlibs
include Makefile.onscripter

clean: pclean $(CLEAN_TARGETS)
distclean: clean pdistclean $(DISTCLEAN_TARGETS)
	rm -r -f extlib/bin extlib/lib extlib/include \
	         extlib/share extlib/man
	rm -f Makefile 

install-bin:
	./install-sh -c -s $(TARGET) $(PREFIX)/bin/$(TARGET)
install: install-bin
uninstall:
	rm $(PREFIX)/bin/$(TARGET)

RCFILE ?= onscripter.rc
WICONFILE ?= ons-en.ico
RCCLEAN = $(RCFILE)
win32rc.o: $(RCFILE) $(WICONFILE)
	windres $< -o $@

%.rc: %.rc.in version.h winres.h
	ver=`awk '/define VER_NUMBER/ { print $$3 }' version.h`; \
	y=`expr substr $$ver 1 4`; \
	m=`expr substr $$ver 5 2`; mn=`expr $$m + 0`; \
	d=`expr substr $$ver 7 2`; dn=`expr $$d + 0`; \
	i=\"$(WICONFILE)\"; \
	sed -e "s/@Y@/$$y/g;s/@0M@/$$m/g;s/@M@/$$mn/g;s/@0D@/$$d/g;s/@D@/$$dn/g;s%@I@%$$i%g" $< > $@

SDL_win32_main.o: SDL_win32_main.c
	$(CC) $(CSTD) $(OSCFLAGS) $(INCS) $(DEFS) -c $< -o $@

$(GNURX_DIR)/libgnurx.a:
	$(MAKE) -C $(GNURX_DIR) libgnurx.a

.PHONY: clean_libgnurx
clean_libgnurx:
	$(MAKE) -C $(GNURX_DIR) clean


graphics_sse2.o: graphics_sse2.cpp graphics_sse2.h graphics_common.h graphics_sum.h graphics_blend.h
	$(CXX) $(CXXSTD) $(OSCFLAGS) $(INCS) $(DEFS) -msse2 -DUSE_X86_GFX -c $< -o $@

graphics_mmx.o: graphics_mmx.cpp graphics_mmx.h graphics_common.h graphics_sum.h
	$(CXX) $(CXXSTD) $(OSCFLAGS) $(INCS) $(DEFS) -mmmx -DUSE_X86_GFX -c $< -o $@

.PHONY: dist
dist:
	svn export . onscripter-en-20110628
	tar cf onscripter-en-20110628-fullsrc.tar onscripter-en-20110628
	rm -rf onscripter-en-20110628/extlib onscripter-en-20110628/win_dll \
			onscripter-en-20110628/tools/libgnurx
	tar cf onscripter-en-20110628-src.tar onscripter-en-20110628
	bzip2 -9 onscripter-en-20110628-*src.tar
	rm -rf onscripter-en-20110628
