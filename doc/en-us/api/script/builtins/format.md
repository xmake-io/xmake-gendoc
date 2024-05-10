---
key: format
name: format
api: string format(string formatstr[, ...])
refer: string.format, vformat
---

### format

#### Formatting a string

If you just want to format the string and don't output it, you can use this interface. This interface is equivalent to the ${link string.format} interface, just a simplified version of the interface name.

```lua
local s = ${link format}("hello %s", xmake)
```
