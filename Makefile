DESTDIR?=build
BINDIR?=$(PREFIX)/bin
LIBDIR?=$(PREFIX)/lib
DOCDIR?=$(PREFIX)/share/doc
SYSCONFDIR?=$(PREFIX)/etc

clean:
	rm -rf $(DESTDIR)/*

install:
	mkdir -p $(DESTDIR)/$(BINDIR)
	cp -dr bin/* $(DESTDIR)/$(BINDIR)
	mkdir -p $(DESTDIR)/$(LIBDIR)
	cp -dr lib/* $(DESTDIR)/$(LIBDIR)
	mkdir -p $(DESTDIR)/$(SYSCONFDIR)
	cp -dr etc/* $(DESTDIR)/$(SYSCONFDIR)
	mkdir -p $(DESTDIR)/$(DOCDIR)
	cp -dr doc/* $(DESTDIR)/$(DOCDIR)
