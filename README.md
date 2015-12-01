# Beginning, an init system that isn't smarter than you

"_Omnium rerum principia parva sunt._" --Marcus Tullius Cicero

An [ISC-licensed](LICENSE) init system and service manager, designed to be
deterministic and not do anything unexpected.

Beginning is still a work-in-progress. Design choices may still change, and
configurations may need to be updated often. You should keep an eye on the
commit log and actually read the changes if you plan on installing this,
until it is stable.

## Requirements
- bash
- C compiler (for the executables in libexec/)
- coreutils (busybox is more than enough)
- syslogd
- agetty, if you wish to log in from the console

## Installation
1.  `git clone https://github.com/somasis/beginning`, or [download a release]

2.  `make`

3.  `make install`

    The makefile follows standard variables, and can be influenced by variables
    such as `DESTDIR`, `BINDIR`, `LIBDIR`, `LIBEXECDIR`,`DOCDIR`, `SYSCONFDIR`,
    and `PREFIX`.

[download a release]: https://github.com/somasis/beginning/releases

### Defaults
-   The `PID 1` will be installed to `$(PREFIX)$(BINDIR)/begin`. To use it as
    the default init system, either add `init=/bin/begin` to your kernel's boot
    parameters, or make a symlink at `/bin/init` that points to `begin`.
-   A reboot/shutdown/poweroff/halt program is installed to
    `$(PREFIX)$(BINDIR)/reboot`. Run it as root to reboot, make a symlink to it
    named `poweroff`, `halt`, and `shutdown` in order to turn off the system.

## Usage
After installation, `/bin/begin` will need to be linked to `/bin/init`. Or,
you can just add `init=/bin/begin` to the kernel command line if you wish.

## Rationale and Design
*Prior art: OpenBSD init, systemd, Arch Linux initscripts, sinit*

Beginning is my response to systemd and friends. I've used systemd,
Upstart, OpenRC, Arch Linux's initscripts, and basically all of them leave
a bit to be desired, are annoying to use, feel inconsistent, or do too much.

The philosophy behind it is very much akin to how BSD-style inits work.

Configuration is intended to be flexible, but not overbearing; in addition,
I want it to be as deterministic as it can. The program should not have any
functionality which decides for the user; things like providers for virtuals,
order to run daemons in, and so on, should all be determined and executed the
same way each time. While this does mean it requires some initial set up
before you can safely reboot with Beginning as your init, it means that you
can expect it to always run the same way, regardless of what changes on your
system. (aside from obvious things such as removing daemons and stuff)

You could also consider this to be a demonstration of just how simple init
systems really need to be; the most complex part of this is probably the
daemon dependency resolution.

The actual `init` program is just 34 SLOC, because all `init` has to do is
sleep forever, and handle shutdown and reboot signals. `bash` takes care of
reparenting children processes for us.

### What it does have
- `PID 1`
    - Only handles shutdown, reboot, and starting the service manager
- Service management
    - Daemon starting, with dependency resolution
    - Virtuals, with customizable providers for them (network/syslog/udev,
      etc.)
    - `rc`, the main way for interacting with Beginning
    - `rc.conf`, which allows for lots of configuration

### What it does not have
- No runlevels (`telinit 1`, `systemctl start multi-user.target`, etc.)
- No network management (use a separate daemon for that)
- No socket managing
    - Not enough possible benefits of using sockets for daemons. If you
      have to keep starting and stopping `sshd` instances when users come
      and go to conserve resources, you might have bigger problems on your
      hands.
- No enable/disable functionality in `rc`
    - This will might change once I work out a better way to handle it
      while still keeping the `DAEMONS` variable in `/etc/rc.conf`.
    - OpenBSD apparently switched to using key=value format for their `rc.conf`;
      but we don't want to do that because having functions in rc.conf is nice.

