---
key: os.is_arch
name: os.is_arch
api: bool os.is_arch(string arch[, string ...])
version: 2.3.1
refer: os.arch, is_arch
---

### os.is_arch

#### Test if a given arch is the current

```lua
local is_x86_64_or_arm64 = ${link os.is_arch}("x86_64", "arm64")
```
