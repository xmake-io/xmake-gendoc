---
key: os.touch
name: os.touch
api: nil os.touch(string path[, table opt])
refer: os.cp, os.mv, os.rm
---

### os.touch

#### Create an empty file

```lua
${link print}(${link os.isfile}("xxx.txt")) -- got false
${link os.touch}("xxx.txt")
${link print}(${link os.isfile}("xxx.txt")) -- got true
```

Valid field for `opt` is:

* `numeric atime`, default value is `0`
* `numeric mtime`, default value is `0`
