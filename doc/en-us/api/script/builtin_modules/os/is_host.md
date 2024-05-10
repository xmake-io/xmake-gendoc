---
key: os.is_host
name: os.is_host
api: bool os.is_host(string host[, string ...])
version: 2.3.1
refer: os.host, is_host, var_host
---

### os.is_host

#### Test if a given host is the current

```lua
local is_windows_or_linux = ${link os.is_host}("windows", "linux")
```
