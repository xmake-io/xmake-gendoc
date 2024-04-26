---
key: is_plat
name: is_plat
api: bool is_plat(string plat, ...)
refer: is_arch, is_host, is_mode, is_os
---

### is_plat

#### Is the current compilation platform

Returns true if the current compilation platform is the one specified with *plat*. Returns false otherwise.

You can use this api to check the configuration command: `xmake f -p iphoneos`

```lua
-- if the current platform is android
if ${link is_plat}("android") then
    ${link add_files}("src/xxx/*.c")
end

-- if the current platform is macosx or iphoneos
if ${link is_plat}("macosx", "iphoneos") then
    ${link add_frameworks}("Foundation")
end
```

Support platforms:

* "windows"
* "linux"
* "macosx"
* "android"
* "iphoneos"
* "watchos"

