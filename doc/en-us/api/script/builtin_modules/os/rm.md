---
key: os.rm
name: os.rm
api: nil os.rm(string path)
version: 2.0.1
refer: os.tryrm, os.vrm, os.rmdir, os.mv, os.cp, os.touch
---

### os.rm

#### Delete files or directory trees

Support for recursive deletion of directories, bulk delete operations, and pattern matching and built-in variables, such as:

```lua
${link os.rm}("${link var_buildir}/inc/**.h")
${link os.rm}("${link var_buildir}/lib/")
```
