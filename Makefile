DESTDIR?=build/
BINDIR?=$(PREFIX)/bin
LIBDIR?=$(PREFIX)/lib
SYSCONFDIR?=$(PREFIX)/etc

clean:
	rm -rf $(DESTDIR)/*

install:
	mkdir -p $(DESTDIR)/$(BINDIR)
	cp -dr --no-preserve=ownership bin/* $(DESTDIR)/$(BINDIR)
	mkdir -p $(DESTDIR)/$(LIBDIR)
	cp -dr --no-preserve=ownership lib/* $(DESTDIR)/$(LIBDIR)
	mkdir -p $(DESTDIR)/$(SYSCONFDIR)
	cp -dr --no-preserve=ownership etc/* $(DESTDIR)/$(SYSCONFDIR)
