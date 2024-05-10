---
key: os.mv
name: os.mv
api: nil os.mv(string src, string dst)
version: 2.0.1
refer: os.trymv, os.vmv, os.cp, os.trycp, os.rm, os.ln, os.touch
---

### os.mv

#### Move to rename a file or directory

Similar to the use of ${link os.cp}, it also supports multi-file move operations and pattern matching, for example:

```lua
-- Move multiple files to a temporary directory
${link os.mv}("${link var_buildir}/test1", "${link var_tmpdir}")

-- File movement does not support bulk operations, which is file renaming
${link os.mv}("${link var_buildir}/libtest.a", "${link var_buildir}/libdemo.a")
```
