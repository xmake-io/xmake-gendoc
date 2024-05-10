---
key: os.readlink
name: os.readlink
api: true
version: 2.2.2
refer: os.ln
---

### os.readlink

#### Read the content of a symlink

```lua
${link os.touch}("xxx.txt")
${link os.ln}("xxx.txt", "xxx.txt.ln")
${link print}(${link os.readlink}("xxx.txt.ln")) -- got "xxx.txt"
```
