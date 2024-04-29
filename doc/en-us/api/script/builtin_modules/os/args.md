---
key: os.args
name: os.args
api: string os.args(table aguments[, table opt])
refer: os.argv
---

### os.args

#### Format arguments to be passed to a process

Valid fields for `opt` are:

* `bool escape`, default value: `false`
* `bool nowrap`, default value: `false`

e.g:

```lua
local cmd = "program"
cmd = cmd .. " " .. ${link os.args}({"--value=hello, world", "-i", 123})
-- cmd is:
--     program "--value=hello, world" -i 123
```

Set `escape` to `true` if you want to escape backslashes:

```lua
${link print}(${link os.args}({"path=C:\\Folder\\Subfolder"}))                  -- got path=C:\Folder\Subfolder
${link print}(${link os.args}({"path=C:\\Folder\\Subfolder"}, {escape = true})) -- got path=C:\\Folder\\Subfolder
```

Set `nowrap` to `true` if you don't want to wrap quotes:

```lua
${link print}(${link os.args}({'path="C:/Program Files/xmake"', "-i", 42}))                  -- got "path=\"C:/Program Files/xmake\"" -i 42
${link print}(${link os.args}({'path="C:/Program Files/xmake"', "-i", 42}, {nowrap = true})) -- got path=\"C:/Program Files/xmake\" -i 42
```
