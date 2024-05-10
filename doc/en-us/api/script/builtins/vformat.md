---
key: vformat
name: vformat
api: string vformat(string formatstr[, ...])
---

### vformat

#### Formatting strings, support for built-in variable escaping

This interface is followed by the ${link format} interface is similar, but adds support for the acquisition and escaping of built-in variables.

```lua
local s = ${link vformat}("hello %s ${link builtin_variables_intro $(mode)} {link builtin_variables_intro $(arch)} ${link var_env $(env PATH)}", xmake)
```
