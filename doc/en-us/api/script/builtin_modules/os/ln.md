---
key: os.ln
name: os.ln
api: nil os.ln(string srcpath, string dstpath[, opt])
version: 2.2.2
refer: os.vln, os.islink, os.cp, os.mv, os.touch
---

### os.ln

#### Create a symlink to a file or directory

```lua
-- creates a symlink file "xxx.txt.ln" which is pointing to "xxx.txt"
${link os.ln}("xxx.txt", "xxx.txt.ln")
```

Valid field for `opt` is:

* `bool force`, default value is `false`

Set force to `true` if you wish to overwrite the item at `dstpath`
