---
key: os.isexec
name: os.isexec
api: bool os.isexec(string path)
version: 2.0.1
refer: os.isfile, is.isdir, os.islink, os.exists
---

### os.isexec

#### Test if a file is executable

```lua
if ${link os.isexec}("path/to/file.exe") then
    ${link os.run}("path/to/file.exe")
end
```

