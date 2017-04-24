# Makefile to build and install the SDL library

top_builddir = .
srcdir  = .
objects = build
depend	= build-deps
prefix = /c/onscripter/extlib
exec_prefix = ${prefix}
bindir	= ${exec_prefix}/bin
libdir  = ${exec_prefix}/lib
includedir = ${prefix}/include
datarootdir = ${prefix}/share
datadir	= ${datarootdir}
mandir	= ${datarootdir}/man
auxdir	= ./build-scripts
distpath = $(srcdir)/..
distdir = SDL-1.2.13
distfile = $(distdir).tar.gz


SHELL	= /bin/sh
CC      = gcc
INCLUDE = -I./include
CFLAGS  = -I/c/onscripter/extlib/include   -I/c/onscripter/extlib/include  
EXTRA_CFLAGS = -I./include -D_GNU_SOURCE=1
LDFLAGS = -L/c/onscripter/extlib/lib  
EXTRA_LDFLAGS =  -lm -luser32 -lgdi32 -lwinmm
LIBTOOL = $(SHELL) $(top_builddir)/libtool
INSTALL = /bin/install -c
NASM	=  -f win32
AR	= ar
RANLIB	= ranlib
WINDRES	= windres

TARGET  = libSDL.la
SOURCES =  ./src/*.c ./src/audio/*.c ./src/cdrom/*.c ./src/cpuinfo/*.c ./src/events/*.c ./src/file/*.c ./src/stdlib/*.c ./src/thread/*.c ./src/timer/*.c ./src/video/*.c ./src/video/dummy/*.c ./src/audio/disk/*.c ./src/audio/dummy/*.c ./src/video/wincommon/*.c ./src/video/windib/*.c ./src/audio/windib/*.c ./src/cdrom/win32/*.c ./src/thread/win32/SDL_sysmutex.c ./src/thread/win32/SDL_syssem.c ./src/thread/win32/SDL_systhread.c ./src/thread/generic/SDL_syscond.c ./src/timer/win32/*.c ./src/loadso/win32/*.c ./src/main/win32/*.rc
OBJECTS = $(objects)/SDL.lo $(objects)/SDL_error.lo $(objects)/SDL_fatal.lo $(objects)/SDL_audio.lo $(objects)/SDL_audiocvt.lo $(objects)/SDL_audiodev.lo $(objects)/SDL_mixer.lo $(objects)/SDL_mixer_MMX.lo $(objects)/SDL_mixer_MMX_VC.lo $(objects)/SDL_mixer_m68k.lo $(objects)/SDL_wave.lo $(objects)/SDL_cdrom.lo $(objects)/SDL_cpuinfo.lo $(objects)/SDL_active.lo $(objects)/SDL_events.lo $(objects)/SDL_expose.lo $(objects)/SDL_keyboard.lo $(objects)/SDL_mouse.lo $(objects)/SDL_quit.lo $(objects)/SDL_resize.lo $(objects)/SDL_rwops.lo $(objects)/SDL_getenv.lo $(objects)/SDL_iconv.lo $(objects)/SDL_malloc.lo $(objects)/SDL_qsort.lo $(objects)/SDL_stdlib.lo $(objects)/SDL_string.lo $(objects)/SDL_thread.lo $(objects)/SDL_timer.lo $(objects)/SDL_RLEaccel.lo $(objects)/SDL_blit.lo $(objects)/SDL_blit_0.lo $(objects)/SDL_blit_1.lo $(objects)/SDL_blit_A.lo $(objects)/SDL_blit_N.lo $(objects)/SDL_bmp.lo $(objects)/SDL_cursor.lo $(objects)/SDL_gamma.lo $(objects)/SDL_pixels.lo $(objects)/SDL_stretch.lo $(objects)/SDL_surface.lo $(objects)/SDL_video.lo $(objects)/SDL_yuv.lo $(objects)/SDL_yuv_mmx.lo $(objects)/SDL_yuv_sw.lo $(objects)/SDL_nullevents.lo $(objects)/SDL_nullmouse.lo $(objects)/SDL_nullvideo.lo $(objects)/SDL_diskaudio.lo $(objects)/SDL_dummyaudio.lo $(objects)/SDL_sysevents.lo $(objects)/SDL_sysmouse.lo $(objects)/SDL_syswm.lo $(objects)/SDL_wingl.lo $(objects)/SDL_dibevents.lo $(objects)/SDL_dibvideo.lo $(objects)/SDL_dibaudio.lo $(objects)/SDL_syscdrom.lo $(objects)/SDL_sysmutex.lo $(objects)/SDL_syssem.lo $(objects)/SDL_systhread.lo $(objects)/SDL_syscond.lo $(objects)/SDL_systimer.lo $(objects)/SDL_sysloadso.lo $(objects)/version.o

SDLMAIN_TARGET = libSDLmain.a
SDLMAIN_SOURCES = ./src/main/win32/*.c
SDLMAIN_OBJECTS = $(objects)/SDL_win32_main.o

HDRS = SDL.h SDL_active.h SDL_audio.h SDL_byteorder.h SDL_cdrom.h SDL_cpuinfo.h SDL_endian.h SDL_error.h SDL_events.h SDL_getenv.h SDL_joystick.h SDL_keyboard.h SDL_keysym.h SDL_loadso.h SDL_main.h SDL_mouse.h SDL_mutex.h SDL_name.h SDL_opengl.h SDL_platform.h SDL_quit.h SDL_rwops.h SDL_stdinc.h SDL_syswm.h SDL_thread.h SDL_timer.h SDL_types.h SDL_version.h SDL_video.h begin_code.h close_code.h

LT_AGE      = 11
LT_CURRENT  = 11
LT_RELEASE  = 1.2
LT_REVISION = 2
LT_LDFLAGS  = -no-undefined -rpath $(DESTDIR)$(libdir) -release $(LT_RELEASE) -version-info $(LT_CURRENT):$(LT_REVISION):$(LT_AGE)

all: $(srcdir)/configure Makefile $(objects) $(objects)/$(TARGET) $(objects)/$(SDLMAIN_TARGET)

$(srcdir)/configure: $(srcdir)/configure.in
	@echo "Warning, configure.in is out of date"
	#(cd $(srcdir) && sh autogen.sh && sh configure)
	@sleep 3

Makefile: $(srcdir)/Makefile.in
	$(SHELL) config.status $@

$(objects):
	$(SHELL) $(auxdir)/mkinstalldirs $@

.PHONY: all depend install install-bin install-hdrs install-lib install-data uninstall uninstall-bin uninstall-hdrs uninstall-lib uninstall-data clean distclean dist
depend:
	@SOURCES="$(SOURCES)" INCLUDE="$(INCLUDE)" output="$(depend)" \
	$(SHELL) $(auxdir)/makedep.sh
	@for src in $(SDLMAIN_SOURCES); do \
	    obj=`echo $$src | sed -e 's|.*/||' -e 's|\.[^\.]*$$|.o|'`; \
	    echo "\$$(objects)/$$obj: $$src" >>$(depend); \
	    echo "	\$$(CC) \$$(CFLAGS) \$$(EXTRA_CFLAGS) -c $$src -o \$$@" >>$(depend); \
	done

include $(depend)

$(objects)/$(TARGET): $(OBJECTS)
	$(LIBTOOL) --mode=link $(CC) -o $@ $(OBJECTS) $(LDFLAGS) $(EXTRA_LDFLAGS) $(LT_LDFLAGS)

$(objects)/$(SDLMAIN_TARGET): $(SDLMAIN_OBJECTS)
	$(AR) cru $@ $(SDLMAIN_OBJECTS)
	$(RANLIB) $@

install: all install-bin install-hdrs install-lib install-data
install-bin:
	$(SHELL) $(auxdir)/mkinstalldirs $(DESTDIR)$(bindir)
	$(INSTALL) -m 755 sdl-config $(DESTDIR)$(bindir)/sdl-config
install-hdrs:
	$(SHELL) $(auxdir)/mkinstalldirs $(DESTDIR)$(includedir)/SDL
	for file in $(HDRS); do \
	    $(INSTALL) -m 644 $(srcdir)/include/$$file $(DESTDIR)$(includedir)/SDL/$$file; \
	done
	$(INSTALL) -m 644 include/SDL_config.h $(DESTDIR)$(includedir)/SDL/SDL_config.h
install-lib: $(objects) $(objects)/$(TARGET) $(objects)/$(SDLMAIN_TARGET)
	$(SHELL) $(auxdir)/mkinstalldirs $(DESTDIR)$(libdir)
	$(LIBTOOL) --mode=install $(INSTALL) $(objects)/$(TARGET) $(DESTDIR)$(libdir)/$(TARGET)
	$(INSTALL) -m 644 $(objects)/$(SDLMAIN_TARGET) $(DESTDIR)$(libdir)/$(SDLMAIN_TARGET)
	$(RANLIB) $(DESTDIR)$(libdir)/$(SDLMAIN_TARGET)
install-data:
	$(SHELL) $(auxdir)/mkinstalldirs $(DESTDIR)$(datadir)/aclocal
	$(INSTALL) -m 644 $(srcdir)/sdl.m4 $(DESTDIR)$(datadir)/aclocal/sdl.m4
	$(SHELL) $(auxdir)/mkinstalldirs $(DESTDIR)$(libdir)/pkgconfig
	$(INSTALL) -m 644 sdl.pc $(DESTDIR)$(libdir)/pkgconfig

uninstall: uninstall-bin uninstall-hdrs uninstall-lib uninstall-data 
uninstall-bin:
	rm -f $(DESTDIR)$(bindir)/sdl-config
uninstall-hdrs:
	for file in $(HDRS); do \
	    rm -f $(DESTDIR)$(includedir)/SDL/$$file; \
	done
	rm -f $(DESTDIR)$(includedir)/SDL/SDL_config.h
	-rmdir $(DESTDIR)$(includedir)/SDL
uninstall-lib:
	$(LIBTOOL) --mode=uninstall rm -f $(DESTDIR)$(libdir)/$(TARGET)
	rm -f $(DESTDIR)$(libdir)/$(SDLMAIN_TARGET)
uninstall-data:
	rm -f $(DESTDIR)$(datadir)/aclocal/sdl.m4

clean:
	rm -rf $(objects)
	if test -f test/Makefile; then (cd test; $(MAKE) $@); fi

distclean: clean
	rm -f Makefile include/SDL_config.h sdl-config
	rm -f SDL.qpg
	rm -f config.status config.cache config.log libtool $(depend)
	rm -rf $(srcdir)/autom4te*
	rm -rf $(srcdir)/test/autom4te*
	find $(srcdir) \( \
	    -name '*~' -o \
	    -name '*.bak' -o \
	    -name '*.old' -o \
	    -name '*.rej' -o \
	    -name '*.orig' -o \
	    -name '.#*' \) \
	    -exec rm -f {} \;
	cp $(srcdir)/include/SDL_config.h.default $(srcdir)/include/SDL_config.h
	if test -f test/Makefile; then (cd test; $(MAKE) $@); fi
