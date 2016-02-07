CC				?=cc
CFLAGS			?=-O2 -g

DESTDIR			?=$(PWD)/image
BUILD			?=$(PWD)/build

prefix			?=/usr/local
exec_prefix		?=$(prefix)
bindir			?=$(exec_prefix)/bin
sbindir			?=$(exec_prefix)/sbin
libdir			?=$(exec_prefix)/lib
libexecdir		?=$(exec_prefix)/libexec
datarootdir		?=$(prefix)/share
datadir			?=$(datarootdir)
sysconfdir		?=$(prefix)/etc
docdir			?=$(datarootdir)/doc/beginning-$(VERSION)
mandir			?=$(datarootdir)/man
localstatedir	?=$(prefix)/var
runstatedir		?=$(localstatedir)/run

bash_completion	?=true
COPYRIGHT		?=
VERSION			=scm

ifeq ($(bash_completion), true)
    bash_completion	=true
else ifeq ($(bash_completion), false)
    bash_completion	=false
else
    $(error bash_completion can only be true or false)
endif

all:
	@printf "Beginning $(VERSION), an init system that isn't smarter than you\n\n"
	@printf "%-20s%-20s\n"	\
		"DESTDIR"		"$(DESTDIR)"		\
		"BUILD"			"$(BUILD)"			\
		"prefix"		"$(prefix)"			\
		"exec_prefix"	"$(exec_prefix)"	\
		"bindir"		"$(bindir)"			\
		"sbindir"		"$(sbindir)"			\
		"libdir"		"$(libdir)"			\
		"libexecdir"	"$(libexecdir)"		\
		"datarootdir"	"$(datarootdir)"	\
		"datadir"		"$(datadir)"		\
		"sysconfdir"	"$(sysconfdir)"		\
		"docdir"		"$(docdir)"			\
		"mandir"		"$(mandir)"			\
		"localstatedir"	"$(localstatedir)"	\
		"runstatedir"	"$(runstatedir)"	\
		""				""					\
		"Options:"		""					\
		"COPYRIGHT"			"$(COPYRIGHT)"			\
		"bash_completion"	"$(bash_completion)"	\
		""
	@$(MAKE) --no-print-directory build

$(BUILD)/%: libexec/%.c
	-mkdir -p $(BUILD)
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
	cp -r share/* $(BUILD)$(datadir)
	-[[ "$(bash_completion)" == 'true' ]] || rm -rf $(BUILD)$(datadir)/bash-completion
	find $(BUILD) -type f -exec sed \
		-e "s|@@prefix@@|$(prefix)|g"				\
		-e "s|@@exec_prefix@@|$(exec_prefix)|g"		\
		-e "s|@@bindir@@|$(bindir)|g"				\
		-e "s|@@sbindir@@|$(sbindir)|g"				\
		-e "s|@@libdir@@|$(libdir)|g"				\
		-e "s|@@libexecdir@@|$(libexecdir)|g"		\
		-e "s|@@datarootdir@@|$(datarootdir)|g"		\
		-e "s|@@datadir@@|$(datadir)|g"				\
		-e "s|@@sysconfdir@@|$(sysconfdir)|g"		\
		-e "s|@@docdir@@|$(docdir)|g"				\
		-e "s|@@mandir@@|$(mandir)|g"				\
		-e "s|@@localstatedir@@|$(localstatedir)|g"	\
		-e "s|@@runstatedir@@|$(runstatedir)|g"		\
		-e "s|@@COPYRIGHT@@|$(COPYRIGHT)|g"			\
		-e "s|@@VERSION@@|$(VERSION)|g"				\
		-i {} \;
	@echo
	@for file in $$(grep -lr '^\#!/bin/bash' $(BUILD));do \
		bash -n "$$file"; \
		if [[ $$? -eq 0 ]];then \
			echo "SYNTAX PASS: $$file"; \
		else \
			echo "SYNTAX FAIL: $$file";	\
			exit 2; \
		fi; \
	done

install: $(BUILD)
	mkdir -p $(DESTDIR)
	cp -r $(BUILD)/* $(DESTDIR)

clean:
	rm -rf $(BUILD)

.PHONY:	all build clean

