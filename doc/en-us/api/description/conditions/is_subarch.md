---
key: is_subarch
name: is_subarch
api: bool is_arch(string arch, ...)
version: 2.0.1
refer: is_arch, is_os, is_plat
---

### is_subarch

#### Determine the architecture of the current host subsystem environment

At present, it is mainly used for the detection of the architecture under the subsystem environment such as cygwin and msys2 on the windows system. The msvc tool chain is usually used on the windows compilation platform, and the architecture is x64, x86.
In the msys/cygwin subsystem environment, the compiler architecture defaults to x86_64/i386, which is different.

We can also quickly view the current subsystem architecture by executing `xmake l os.subarch`.

