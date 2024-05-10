---
key: os.tryrm
name: os.tryrm
api: bool os.tryrm(string path[, table opt])
version: 2.1.6
refer: os.rm, os.trycp, os.trymv
---

### os.tryrm

#### Try deleting files or directories

Similar to ${link os.rm}, the only difference is that this interface operation will not throw an exception interrupt xmake, but the return value indicates whether the execution is successful.

```lua
if ${link os.tryrm}("file") then
end
```

Valid field for `opt` is:

* `bool emptydirs`, default value is `false`

Set `emptydirs` to `true` to also remove empty parent directories of this file path.
