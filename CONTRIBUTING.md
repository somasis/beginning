# Contributing to Beginning

## Code

Contributions of code are accepted through [GitHub's pull requests][pull-requests].

If you have multiple features/fixes/things done in one commit, please split them
up into multiple commits, so that they can be reviewed seperately.

### Daemon scripts

Scripts for controlling daemons (which are located in lib/rc.d) should be sent to
[beginning-scripts], unless they concern the scripts already located in the lib/rc.d
directory in this repository. However, for scripts that may be deemed important
enough for systems of any type (embedded, servers, desktops, low-resource), scripts
can be submitted and we can decide then.

But for the most part they should go in [beginning-scripts].

## Bugs

Bugs should be reported to [GitHub's issue tracker][issues]. It is recommended
that you read Simon Tatham's excellent article,
["How to Report Bugs Effectively"][reporting-bugs].

[reporting-bugs]:       http://www.chiark.greenend.org.uk/~sgtatham/bugs.html
[pull-requests]:        https://github.com/somasis/beginning/pulls
[issues]:               https://github.com/somasis/beginning/issues
[beginning-scripts]:    https://github.com/somasis/beginning-scripts
