---
key: os.isdir
name: os.isdir
api: bool os.isdir(string path)
version: 2.3.1
refer: os.isfile, os.islink, os.isexec, os.exists
---

### os.isdir

#### Determine if it is a directory

Return `false` if the directory does not exist

```lua
if ${link os.isdir}("src") then
    -- ...
end
```
