# Beginning, an init system that isn't smarter than you

An [ISC-licensed](LICENSE) init system and service manager, designed to be
deterministic and not do anything unexpected.

Beginning is still a work-in-progress; it is not finalized. Design choices
may still change, and configurations may need to be updated often. You
should keep an eye on the commit log and actually read the changes if you
plan on installing this, until it is stable.

## Requirements
- bash
- coreutils
- syslogd
- agetty, if you wish to log in from the console

## Installation
Well that's a bad idea

## Usage
After installation, `/bin/begin` will need to be linked to `/bin/init`. Or,
you can just add `init=/bin/begin` to the kernel command line if you wish.

## Rationale and Design
Beginning is somewhat designed to be an anti-thesis of systems such as
Upstart and systemd. In addition, the philosophy behind it is somewhat akin
to how BSD-style inits work. Consider it an amalgamation of the very good
parts of systemd, with the configurability and straightforwardness of
BSD-style init.

Prior art: OpenBSD init, systemd, Arch Linux initscripts, sinit

### What it does not have
- No runlevels (`telinit 1`, `systemctl start multi-user.target`, etc.)
- No network management (use a separate daemon for that)
- No socket managing
    - Not enough possible benefits of using sockets for daemons. If you
      have to keep starting and stopping `sshd` instances when users come
      and go to conserve resources, you might have bigger problems on your
      hands.
- No enable/disable functionality in `rc`
    - This will probably change once I work out a better way to handle it
      while still keeping the `DAEMONS` variable in `/etc/rc.conf`.

