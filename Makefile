VERSION=scm

CC?=cc

BUILD?=$(PWD)/build
DESTDIR?=$(PWD)/image
BINDIR?=$(PREFIX)/bin
LIBDIR?=$(PREFIX)/lib
LIBEXECDIR?=$(PREFIX)/usr/libexec
DOCDIR?=$(PREFIX)/usr/share/doc/beginning
SYSCONFDIR?=$(PREFIX)/etc

build:
	mkdir -p $(BUILD)
	$(CC) $(CFLAGS) libexec/halt.c     -o $(BUILD)/halt
	$(CC) $(CFLAGS) libexec/poweroff.c -o $(BUILD)/poweroff
	$(CC) $(CFLAGS) libexec/reboot.c   -o $(BUILD)/reboot

install: build
	mkdir -p $(DESTDIR)$(BINDIR)
	cp -r bin/* $(DESTDIR)$(BINDIR)
	mkdir -p $(DESTDIR)$(LIBDIR)/beginning
	cp -r lib/* $(DESTDIR)$(LIBDIR)
	mkdir -p $(DESTDIR)$(LIBEXECDIR)/beginning
	cp $(BUILD)/reboot $(BUILD)/halt $(BUILD)/poweroff $(DESTDIR)$(LIBEXECDIR)/beginning
	mkdir -p $(DESTDIR)$(SYSCONFDIR)
	cp -r etc/* $(DESTDIR)$(SYSCONFDIR)
	mkdir -p $(DESTDIR)$(DOCDIR)
	cp -r doc/* $(DESTDIR)$(DOCDIR)

clean:
	rm -rf $(DESTDIR)/*
	rm -rf $(BUILD)

