---
key: os.argv
name: os.argv
api: table os.argv(string command[, table opt])
refer: os.args
---

### os.argv

#### Parse a command and split its arguments

Valid fields for `opt` are:

* `bool splitonly`, default value: `false`

e.g:

```lua
local args = ${link os.argv}('cmd --value="hello, world" -i 123')
-- got {
--   "cmd",
--   "--value=hello, world",
--   "-i",
--   "123"
-- }

args = ${link os.argv}('cmd --value="hello, world" -i 123', {splitonly = true})
-- got {
--   "cmd",
--   '--value="hello, world"',
--   "-i",
--   "123"
-- }
```
