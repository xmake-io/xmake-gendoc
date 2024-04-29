---
key: is_mode
name: is_mode
api: bool is_mode(string mode, ...)
version: 2.0.1
refer: is_config, var_mode, os.is_mode
---

### is_mode

#### Is the current compilation mode

You can use this api to check the configuration command: `xmake f -m debug`

The compilation mode is not builtin mode for xmake, so you can set the mode value by yourself.

We often use these configuration values: `debug`, `release`, `profile`, etc.

```lua
-- if the current compilation mode is debug?
if ${link is_mode}("debug") then

    -- add macro: DEBUG
    ${link target.add_defines add_defines}("DEBUG")

    -- enable debug symbols
    ${link target.set_symbols set_symbols}("debug")

    -- disable optimization
    ${link target.set_optimize set_optimize}("none")

end

-- if the current compilation mode is release or profile?
if ${link is_mode}("release", "profile") then

    if ${link is_mode}("release") then

        -- mark symbols visibility as hidden
        ${link target.set_symbols set_symbols}("hidden")

        -- strip all symbols
        ${link target.set_strip set_strip}("all")

        -- fomit frame pointer
        ${link target.add_cxflags add_cxflags}("-fomit-frame-pointer")
        ${link target.add_mxflags add_mxflags}("-fomit-frame-pointer")

    else

        -- enable debug symbols
        ${link target.set_symbols set_symbols}("debug")

    end

    -- add vectorexts
    ${link target.add_vectorexts add_vectorexts}("sse2", "sse3", "ssse3", "mmx")
end
```

