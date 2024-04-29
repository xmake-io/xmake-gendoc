---
key: os.addenv
name: os.addenv
api: nil os.addenv(string name[, string ...])
version: 2.1.5
refer: var_env, os.joinenvs
---

### os.addenv

#### Add values to one environment variable

```lua
-- Add 'bin' to PATH
${link os.addenv}("PATH", "bin")
```

When adding several values, they are concatenated depending on the current os.

```lua
-- MY_ENV=value1;value2 on windows,
-- MY_ENV=value1:value2 on linux
${link os.addenv}("MY_ENV", "value1", "value2")
```
