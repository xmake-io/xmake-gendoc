---
key: os.addenvs
name: os.addenvs
api: table os.addenvs(table envs)
version: 2.5.6
refer: os.addenv, os.addenvp
---

### os.addenvs

#### Add environment variables to current envs, return the all old envs

```lua
${link os.setenvs}({EXAMPLE = "a/path"}) -- add a custom variable to see addenvs impact on it

local oldenvs = ${link os.addenvs}({EXAMPLE = "some/path/"})
${link print}(${link os.getenvs}()["EXAMPLE"]) --got some/path/;a/path
${link print}(oldenvs["EXAMPLE"]) -- got a/path
```
