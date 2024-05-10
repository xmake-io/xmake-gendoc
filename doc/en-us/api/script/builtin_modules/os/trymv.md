---
key: os.trymv
name: os.trymv
api: bool os.trymv(string srcpath, dstpath)
version: 2.1.6
refer: os.mv, os.trycp, os.tryrm
---

### os.trymv

#### Try moving a file or directory

Similar to ${link os.mv}, the only difference is that this interface operation will not throw an exception interrupt xmake, but the return value indicates whether the execution is successful.

```lua
if ${link os.trymv}("file", "dest/file") then
end
```
