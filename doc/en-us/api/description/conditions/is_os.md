---
key: is_os
name: is_os
api: bool is_os(string os, ...)
version: 2.0.1
refer: var_os, is_arch, is_host, is_mode, is_plat
---

### is_os

#### Is the current compilation target system

Returns true if the target compilation os is the one specified with *os*. Returns false otherwise.

```lua
if ${link is_os}("ios") then
    ${link add_files}("src/xxx/*.m")
end
```

Valid input values are:

* "windows"
* "linux"
* "android"
* "macosx"
* "ios"

