---
key: os_mv
name: os.mv
api: nil os.mv(string src, string dst, table opt)
version: 2.0.1
refer: os_cp, os_trycp, os_rm
---

### ${anchor:os_mv}

#### Move to rename a file or directory

Similar to the use of ${link:os_cp}, it also supports multi-file move operations and pattern matching, for example:

```lua
-- Move multiple files to a temporary directory
${link:os_mv}("${link:var_buildir}/test1", "${link:var_tmpdir}")

-- File movement does not support bulk operations, which is file renaming
${link:os_mv}("${link:var_buildir}/libtest.a", "${link:var_buildir}/libdemo.a")
```
