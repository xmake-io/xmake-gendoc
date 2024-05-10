---
key: os.joinenvs
name: os.joinenvs
api: table os.joinenvs(table envs, table oldenvs)
version: 2.5.6
refer: os.getenv, os.getenvs, os.addenv, os.addenvs
---

### os.joinenvs

#### Join environment variables. Similar to ${link os.addenvs} but with two envs variable

```lua
local envs = {CUSTOM = "a/path"}
local envs2 = {CUSTOM = "some/path/"}
${link print}(${link os.joinenvs}(envs, envs2))
```

The result is: `{ CUSTOM = "a/path;some/path/" }`
