VERSION=scm

CC?=cc

DESTDIR?=$(PWD)/image
BUILD?=$(PWD)/build

prefix?=/usr/local
exec_prefix?=$(prefix)
bindir?=$(exec_prefix)/bin
libdir?=$(exec_prefix)/lib
libexecdir?=$(exec_prefix)/libexec
datarootdir?=$(prefix)/share
datadir?=$(datarootdir)
sysconfdir?=$(prefix)/etc
docdir?=$(datarootdir)/doc/beginning-$(VERSION)
mandir?=$(datarootdir)/man
localstatedir?=$(prefix)/var
runstatedir?=$(localstatedir)/run

all:	build

$(BUILD)/%: libexec/%.c
	@[[ -d "$(BUILD)" ]] || mkdir -p $(BUILD)
	$(CC) $(CFLAGS) $< -o $@

build:	$(BUILD)/halt $(BUILD)/poweroff $(BUILD)/reboot
	mkdir -p $(BUILD)
	mkdir -p $(BUILD)$(bindir)
	mkdir -p $(BUILD)$(libdir)/beginning
	mkdir -p $(BUILD)$(libexecdir)/beginning
	mkdir -p $(BUILD)$(datadir)
	mkdir -p $(BUILD)$(sysconfdir)
	mkdir -p $(BUILD)$(docdir)
	cp -r bin/* $(BUILD)$(bindir)
	cp -r lib/* $(BUILD)$(libdir)/beginning
	mv $(BUILD)/reboot $(BUILD)/halt $(BUILD)/poweroff $(BUILD)$(libexecdir)/beginning
	cp -r etc/* $(BUILD)$(sysconfdir)
	cp -r doc/* $(BUILD)$(docdir)
	find $(BUILD) -type f -exec sed \
		-e "s|@@prefix@@|$(prefix)|g"				\
		-e "s|@@exec_prefix@@|$(exec_prefix)|g"		\
		-e "s|@@libdir@@|$(libdir)|g"				\
		-e "s|@@bindir@@|$(bindir)|g"				\
		-e "s|@@libexecdir@@|$(libexecdir)|g"		\
		-e "s|@@datarootdir@@|$(datarootdir)|g"		\
		-e "s|@@datadir@@|$(datadir)|g"				\
		-e "s|@@sysconfdir@@|$(sysconfdir)|g"		\
		-e "s|@@docdir@@|$(docdir)|g"				\
		-e "s|@@mandir@@|$(mandir)|g"				\
		-e "s|@@localstatedir@@|$(localstatedir)|g"	\
		-e "s|@@runstatedir@@|$(runstatedir)|g"		\
		-e "s|@@COPYRIGHT@@|$(copyright)|g"			\
		-i {} \;

install: $(BUILD)
	mkdir -p $(DESTDIR)
	cp -r $(BUILD)/* $(DESTDIR)

clean:
	rm -rf $(BUILD)

.PHONY:	all build clean

