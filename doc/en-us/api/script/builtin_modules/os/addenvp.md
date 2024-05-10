---
key: os.addenvp
name: os.addenvp
api: bool os.addenv(string key, table values, string separator)
version: 2.1.5
refer: os.addenv, os.addenvs
---

### os.addenvp

#### Add values to one environment variable with a given separator

```lua
-- Add 'bin$lib' to PATH
local ok = ${link os.addenvp}("PATH", {"bin", "lib"}, '$')
```
