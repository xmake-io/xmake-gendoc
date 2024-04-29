---
key: is_arch
name: is_arch
api: bool is_arch(string arch, ...)
version: 2.0.1
refer: is_host, is_os, is_plat, is_subarch
---

### is_arch

#### Is the current compilation architecture

Returns true if the current compilation architecture is the one specified with *arch*. Returns false otherwise.

You can use this api to check the configuration command: `xmake f -a armv7`

```lua
-- if the current architecture is x86_64 or i386
if ${link is_arch}("x86_64", "i386") then
    ${link target:add_files add_files}("src/xxx/*.c")
end

-- if the current architecture is armv7 or arm64 or armv7s or armv7-a
if ${link is_arch}("armv7", "arm64", "armv7s", "armv7-a") then
    -- ...
end
```

And you can also use the lua regular expression: `.*` to check all matched architectures.

```lua
-- if the current architecture is arm which contains armv7, arm64, armv7s and armv7-a ...
if ${link is_arch}("arm.*") then
    -- ...
end
```

