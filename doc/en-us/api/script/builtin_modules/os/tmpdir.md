---
key: os.tmpdir
name: os.tmpdir
api: string os.tmpdir([table opt])
version: 2.0.1
refer: var_tmpdir, os.tmpfile
---

### os.tmpdir

#### Get temporary directory

Consistent with the result of ${link var_tmpdir}, it is just a direct return to return a variable that can be maintained with subsequent strings.

```lua
${link print}(path.join(${link os.tmpdir}(), "file.txt"))
```

Equivalent to:

```lua
${link print}("${link var_tmpdir}/file.txt")
```

Valid field for `opt` is:

* `bool ramdisk`, default value is `true`
