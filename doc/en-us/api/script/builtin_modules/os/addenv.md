---
key: os.addenv
name: os.addenv
api: bool os.addenv(string name[, string ...])
version: 2.1.5
refer: os.addenvp, os.addenvs, var_env, os.setenv, os.getenv, os.joinenvs
---

### os.addenv

#### Add values to one environment variable

```lua
-- Add 'bin' to PATH
local ok = ${link os.addenv}("PATH", "bin")
```

When adding several values, they are concatenated depending on the current os.

```lua
-- MY_ENV=value1;value2 on windows,
-- MY_ENV=value1:value2 on linux
${link os.addenv}("MY_ENV", "value1", "value2")
```
