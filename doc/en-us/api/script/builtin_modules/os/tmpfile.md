---
key: os.tmpfile
name: os.tmpfile
api: string os.tmpfile(opt_or_key)
version: 2.0.1
refer: os.tmpdir
---

### os.tmpfile

#### Get temporary file path

Used to get a temporary file path, just a path, the file needs to be created by itself.

```lua
local tmp1 = ${link os.tmpfile}("xxx")
local tmp2 = ${link os.tmpfile}({key = "xxx", ramdisk = false})
```

Valid fields for `opt` are:

* `string key`
* `bool ramdisk`, default value is `true`
