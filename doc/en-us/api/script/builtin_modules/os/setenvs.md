---
key: os.setenvs
name: os.setenvs
api: table os.setenvs(table envs)
version: 2.2.6
refer: os.setenv, os.setenvp, os.getenvs
---

### os.setenvs

#### Set environment variables. Replace the current envs by a new one and return old envs

```lua
local envs = {}
envs["PATH"] = "/xxx:/yyy/foo"
local oldenvs = ${link os.setenvs}(envs)
-- ...
${link os.setenvs}(oldenvs)
```
