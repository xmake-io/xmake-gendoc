---
key: os.atexit
name: os.atexit
api: nil os.atexit(function on_exit)
refer: os.exit
---

### os.atexit

#### Register exit callback

e.g:

```lua
${link os.atexit}(function (ok, errors)
    ${link print}(ok, errors)
end)
```
