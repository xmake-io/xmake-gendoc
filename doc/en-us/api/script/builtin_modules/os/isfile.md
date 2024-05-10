---
key: os.isfile
name: os.isfile
api: bool os.isfile(string path)
version: 2.0.1
refer: os.isdir, os.islink, os.isexec, os.exists
---

### os.isfile

#### Determine if it is a file

Return `false` if the file does not exist

```lua
if ${link os.isfile}("${link var_buildir}/libxxx.a") then
    -- ...
end
```
