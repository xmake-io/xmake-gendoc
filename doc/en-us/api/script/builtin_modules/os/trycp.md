---
key: os.trycp
name: os.trycp
api: bool os.trycp(string srcpath, string dstpath[, table opt])
version: 2.1.6
refer: os.cp, os.tryrm, os.trymv
---

### os.trycp

#### Try copying files or directories

Similar to ${link os.cp}, the only difference is that this interface operation will not throw an exception interrupt xmake, but the return value indicates whether the execution is successful.

```lua
if ${link os.trycp}("file", "dest/file") then
end
```

Valid fields for `opt` are:

* `string rootdir`
* `bool symlink`
