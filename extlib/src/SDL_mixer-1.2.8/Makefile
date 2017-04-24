# Makefile to build and install the SDL_mixer library

top_builddir = .
srcdir  = .
objects = build
depend	= build-deps
prefix = /c/onscripter/extlib
exec_prefix = ${prefix}
bindir	= $(DESTDIR)${exec_prefix}/bin
libdir  = $(DESTDIR)${exec_prefix}/lib
includedir = $(DESTDIR)${prefix}/include
datadir	= $(DESTDIR)${prefix}/share
mandir	= $(DESTDIR)${prefix}/man
auxdir	= ./build-scripts
distpath = $(srcdir)/..
distdir = SDL_mixer-1.2.8
distfile = $(distdir).tar.gz


EXE	= .exe
SHELL	= /bin/sh
CC      = gcc
CFLAGS  = -I/c/onscripter/extlib/include   -I/c/onscripter/extlib/include  
EXTRA_CFLAGS =  -D_GNU_SOURCE=1 -I/c/onscripter/extlib/include/SDL -D_GNU_SOURCE=1 -Dmain=SDL_main -DWAV_MUSIC -DMOD_MUSIC -I$(srcdir)/mikmod -DMID_MUSIC -DUSE_NATIVE_MIDI -I$(srcdir)/native_midi -DMP3_MUSIC -I/c/onscripter/extlib/include -I/c/onscripter/extlib/include/smpeg -I/c/onscripter/extlib/include/SDL -D_GNU_SOURCE=1 -Dmain=SDL_main
LDFLAGS = -L/c/onscripter/extlib/lib  
EXTRA_LDFLAGS =  -L/c/onscripter/extlib/lib -lmingw32 -lSDLmain -lSDL -mwindows -lwinmm -lwinmm -L/c/onscripter/extlib/lib -lsmpeg -L/c/onscripter/extlib/lib -lmingw32 -lSDLmain -lSDL -mwindows -lwinmm
LIBTOOL = $(SHELL) $(top_builddir)/libtool
INSTALL = /bin/install -c
AR	= ar
RANLIB	= ranlib
WINDRES	= windres
SDL_CFLAGS = -I/c/onscripter/extlib/include/SDL -D_GNU_SOURCE=1 -Dmain=SDL_main
SDL_LIBS = -L/c/onscripter/extlib/lib -lmingw32 -lSDLmain -lSDL -mwindows -lwinmm

TARGET  = libSDL_mixer.la
SOURCES =  ./effect_position.c ./effect_stereoreverse.c ./effects_internal.c ./load_aiff.c ./load_voc.c ./mixer.c ./music.c ./wavestream.c ./mikmod/*.c ./native_midi/*.c ./*_mp3.c
OBJECTS = $(objects)/effect_position.lo $(objects)/effect_stereoreverse.lo $(objects)/effects_internal.lo $(objects)/load_aiff.lo $(objects)/load_voc.lo $(objects)/mixer.lo $(objects)/music.lo $(objects)/wavestream.lo $(objects)/drv_nos.lo $(objects)/load_it.lo $(objects)/load_mod.lo $(objects)/load_s3m.lo $(objects)/load_xm.lo $(objects)/mdreg.lo $(objects)/mdriver.lo $(objects)/mloader.lo $(objects)/mlreg.lo $(objects)/mlutil.lo $(objects)/mmalloc.lo $(objects)/mmerror.lo $(objects)/mmio.lo $(objects)/mplayer.lo $(objects)/munitrk.lo $(objects)/mwav.lo $(objects)/npertab.lo $(objects)/sloader.lo $(objects)/virtch.lo $(objects)/virtch2.lo $(objects)/virtch_common.lo $(objects)/native_midi_common.lo $(objects)/native_midi_mac.lo $(objects)/native_midi_win32.lo $(objects)/dynamic_mp3.lo

DIST = CHANGES COPYING Makefile.in README SDL_mixer.h SDL_mixer.qpg.in SDL_mixer.spec SDL_mixer.spec.in acinclude autogen.sh build-scripts configure configure.in dynamic_mp3.c dynamic_mp3.h dynamic_ogg.c dynamic_ogg.h effect_position.c effect_stereoreverse.c effects_internal.c effects_internal.h gcc-fat.sh load_aiff.c load_aiff.h load_ogg.c load_ogg.h load_voc.c load_voc.h mikmod mixer.c music.c music_cmd.c music_cmd.h music_mad.c music_mad.h music_ogg.c music_ogg.h native_midi native_midi_gpl timidity wavestream.c wavestream.h

LT_AGE      = 2
LT_CURRENT  = 2
LT_RELEASE  = 1.2
LT_REVISION = 6
LT_LDFLAGS  = -no-undefined -rpath $(libdir) -release $(LT_RELEASE) -version-info $(LT_CURRENT):$(LT_REVISION):$(LT_AGE)

all: $(srcdir)/configure Makefile $(objects) $(objects)/$(TARGET) 

$(srcdir)/configure: $(srcdir)/configure.in
	@echo "Warning, configure.in is out of date"
	#(cd $(srcdir) && sh autogen.sh && sh configure)
	@sleep 3

Makefile: $(srcdir)/Makefile.in
	$(SHELL) config.status $@

$(objects):
	$(SHELL) $(auxdir)/mkinstalldirs $@

.PHONY: all depend install install-hdrs install-lib uninstall uninstall-hdrs uninstall-lib clean distclean dist
depend:
	@SOURCES="$(SOURCES)" INCLUDE="$(INCLUDE)" output="$(depend)" \
	$(SHELL) $(auxdir)/makedep.sh

include $(depend)

$(objects)/$(TARGET): $(OBJECTS)
	$(LIBTOOL) --mode=link $(CC) -o $@ $(OBJECTS) $(LDFLAGS) $(EXTRA_LDFLAGS) $(LT_LDFLAGS)

install: all install-hdrs install-lib #install-bin
install-hdrs:
	$(SHELL) $(auxdir)/mkinstalldirs $(includedir)/SDL
	for src in $(srcdir)/SDL_mixer.h; do \
	    file=`echo $$src | sed -e 's|^.*/||'`; \
	    $(INSTALL) -m 644 $$src $(includedir)/SDL/$$file; \
	done
install-lib: $(objects) $(objects)/$(TARGET)
	$(SHELL) $(auxdir)/mkinstalldirs $(libdir)
	$(LIBTOOL) --mode=install $(INSTALL) $(objects)/$(TARGET) $(libdir)/$(TARGET)

uninstall: uninstall-hdrs uninstall-lib
uninstall-hdrs:
	for src in $(srcdir)/SDL_mixer.h; do \
	    file=`echo $$src | sed -e 's|^.*/||'`; \
	    rm -f $(includedir)/SDL/$$file; \
	done
	-rmdir $(includedir)/SDL
uninstall-lib:
	$(LIBTOOL) --mode=uninstall rm -f $(libdir)/$(TARGET)

clean:
	rm -rf $(objects)

distclean: clean
	rm -f Makefile
	rm -f SDL_mixer.qpg
	rm -f config.status config.cache config.log libtool $(depend)
	rm -rf $(srcdir)/autom4te*
	find $(srcdir) \( \
	    -name '*~' -o \
	    -name '*.bak' -o \
	    -name '*.old' -o \
	    -name '*.rej' -o \
	    -name '*.orig' -o \
	    -name '.#*' \) \
	    -exec rm -f {} \;

dist $(distfile):
	$(SHELL) $(auxdir)/mkinstalldirs $(distdir)
	tar cf - $(DIST) | (cd $(distdir); tar xf -)
	rm -rf `find $(distdir) -name .svn`
	rm -f `find $(distdir) -name '.#*'`
	tar cvf - $(distdir) | gzip --best >$(distfile)
	rm -rf $(distdir)

rpm: $(distfile)
	rpmbuild -ta $?
