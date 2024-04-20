---
isapi: true
key: os_mv
name: os.mv
---

### ${anchor:os_mv}

Move to rename a file or directory

Similar to the use of ${link:os_cp}, it also supports multi-file move operations and pattern matching, for example:

```lua
-- Move multiple files to a temporary directory
${link:os_mv}("${link:var_buildir}/test1", "${link:var_tmpdir}")

-- File movement does not support bulk operations, which is file renaming
${link:os_mv}("${link:var_buildir}/libtest.a", "${link:var_buildir}/libdemo.a")
```

#### Introduced in version 2.0.1

#### See also

${link:os_cp}, ${link:os_trycp}, ${link:os_rm}
