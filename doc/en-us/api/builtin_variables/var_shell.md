---
api: true
key: var_shell
name: ${shell}
version: 2.0.1
refer: os_shell
---

### ${anchor:var_shell}

#### Executing external shell commands

In addition to the built-in variable handling, xmake also supports the native shell to handle some of the features that xmake does not support.

For example, there is a need now, I want to use the `pkg-config` to get the actual third-party link library name when compiling the Linux program, you can do this:

```lua
target("test")
    ${link:set_kind}("binary")
    if ${link:is_plat}("linux") then
        ${link:add_ldflags}("$(shell pkg-config --libs sqlite3)")
    end
```

Xmake has its own automated third library detection mechanism, which generally does not need such trouble, and lua's own scripting is very good.

But this example shows that xmake can be used with some third-party tools through the native shell.

