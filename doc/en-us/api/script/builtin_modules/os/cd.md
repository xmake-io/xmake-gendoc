---
key: os.cd
name: os.cd
api: string os.cd(string dir)
version: 2.0.1
refer: os.curdir
---

### os.cd

#### Enter the specified directory

This operation is used for directory switching and also supports built-in variables, but does not support pattern matching and multi-directory processing, for example:

```lua
-- Enter the temporary directory
${link os.cd}("${link var_tmpdir}")
```

If you want to leave the previous directory, there are several ways:

```lua
-- Enter the parent directory
${link os.cd}("..")

-- Enter the previous directory, equivalent to: cd -
${link os.cd}("-")

-- Save the previous directory before entering the directory,
-- then use it to cut back directly after the level
local oldir = ${link os.cd}("./src")
...
${link os.cd}(oldir)
```
