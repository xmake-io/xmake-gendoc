---
key: os.mclock
name: os.mclock
api: numeric os.mclock()
refer: os.time, os.mtime, os.sleep
---

### os.mclock

```lua
local time = ${link os.mclock}()
${link os.execv}(program)
time = ${link os.mclock}() - time
${link print}("time %0.3fs", time / 1000.)
```
