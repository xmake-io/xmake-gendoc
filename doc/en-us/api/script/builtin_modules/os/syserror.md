---
key: os.syserror
name: os.syserror
api: numeric os.syserror()
refer: os.strerror
---

### os.syserror

#### Get the current internal system error

Possible return values are:

* `os.SYSERR_UNKNOWN` (-1)
* `os.SYSERR_NONE` (0)
* `os.SYSERR_NOT_PERM` (1)
* `os.SYSERR_NOT_FILEDIR` (2)
* `os.SYSERR_NOT_ACCESS` (3)

```lua
local errcode = ${link os.syserror}()
-- got -1
```
