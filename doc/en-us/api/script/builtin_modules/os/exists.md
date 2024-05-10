---
key: os.exists
name: os.exists
api: bool os.exists(string path)
version: 2.0.1
refer: os.isfile, os.isdir, os.isexec
---

### os.exists

#### Determine if a file or directory exists

Return `false` if the file or directory does not exist

```lua
-- Judging the existence of the directory
if ${link os.exists}("${link var_buildir}") then
    -- ...
end

-- Judging the existence of the file
if ${link os.exists}("${link var_buildir}/libxxx.a") then
    -- ...
end
```
