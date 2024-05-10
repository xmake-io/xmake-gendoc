---
key: os.islink
name: os.islink
api: bool os.islink(string path)
version: 2.0.1
refer: os.isdir, os.isfile, os.isexec, os.exists, os.ln
---

### os.islink

#### Determine if it is a link

Return `false` if the link does not exist

```lua
if ${link os.islink}("/usr/lib/libmythings.so") then
    -- ...
end
```
