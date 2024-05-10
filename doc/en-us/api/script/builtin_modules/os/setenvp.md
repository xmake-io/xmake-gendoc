---
key: os.setenvp
name: os.setenvp
api: bool os.setenvp(string varname, table values, string separator)
version: 2.1.5
refer: os.setenv, os.setenvs
---

### os.setenvp

#### Setting environment variables with a given separator

```lua
-- Set 'bin$lib' to PATH
local ok = ${link os.setenvp}("PATH", {"bin", "lib"}, '$')
```
