---
key: os.getenvs
name: os.getenvs
api: table os.getenvs()
version: 2.2.6
refer: os.getenv, var_env
---

### os.getenvs

#### Get all current environment variables

```lua
local envs = ${link os.getenvs}()
--- home directory (on linux)
${link print}(envs["HOME"])
```
