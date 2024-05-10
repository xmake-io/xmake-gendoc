---
key: os.mkdir
name: os.mkdir
api: nil os.mkdir(string dir)
version: 2.0.1
refer: os.touch, os.cp, os.mv, os.ln
---

### os.mkdir

#### Create a directory

Support for batch creation and built-in variables, such as:

```lua
${link os.mkdir}("${link var_tmpdir}/test", "${link var_buildir}/inc")
```
