DESTDIR?=build
BINDIR?=$(PREFIX)/bin
LIBDIR?=$(PREFIX)/lib
DOCDIR?=$(PREFIX)/share/doc
SYSCONFDIR?=$(PREFIX)/etc

clean:
	rm -rf $(DESTDIR)/*

install:
	mkdir -p $(DESTDIR)$(BINDIR)
	cp -r bin/* $(DESTDIR)$(BINDIR)
	mkdir -p $(DESTDIR)$(LIBDIR)
	cp -r lib/* $(DESTDIR)$(LIBDIR)
	mkdir -p $(DESTDIR)$(SYSCONFDIR)
	cp -r etc/* $(DESTDIR)$(SYSCONFDIR)
	mkdir -p $(DESTDIR)$(DOCDIR)
	cp -r doc/* $(DESTDIR)$(DOCDIR)

