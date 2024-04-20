---
key: is_host
name: is_host
api: bool is_host(string host, ...)
version: 2.1.4
refer: var_host, is_arch, is_os, is_plat, is_subhost
---

### ${anchor:is_host}

#### Is the current compilation host system

Returns true if the current compilation host system is the one specified with *host*. Returns false otherwise.

Some compilation platforms can be built on multiple different operating systems, for example: android ndk (on linux, macOS and windows).

So, we can use this api to determine the current host operating system.

```lua
if ${link:is_host}("windows") then
    ${link:add_includedirs}("C:\\includes")
else
    ${link:add_includedirs}("/usr/includess")
end
```

Support hosts:

* "windows"
* "linux"
* "macosx"

We can also get it from ${link:var_host} or ${link:os_host}.
