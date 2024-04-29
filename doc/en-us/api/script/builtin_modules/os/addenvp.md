---
key: os.addenvp
name: os.addenvp
api: nil os.addenv(string key, table values, string separator)
version: 2.1.5
refer: os.addenv
---

### os.addenvp

#### Add values to one environment variable with a given separator

```lua
-- Add 'bin$lib' to PATH
${link os.addenvp}("PATH", {"bin", "lib"}, '$')
```
