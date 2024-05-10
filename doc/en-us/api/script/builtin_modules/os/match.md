---
key: os.match
name: os.match
api: table, numeric os.match(string pattern[, mode[, function callback]])
version: 2.0.1
---

### os.match

#### match files or directories

The search pattern uses:

* `"*"` to match any part of a file or directory name
* `"**"` to recurse into subdirectories

Valid values for `mode` are:

* `'f'` or `true` or `nil` to only match files
* `'d'` or `false` to only match directories
* `'a'` to match both files and directories

The function returns the items found and count.

```lua
local dirs, count = os.match("./src/*", true)
local files, count = os.match("./src/**.c")
local file = os.match("./src/test.c", 'f', function (filepath, isdir)
                 return true   -- continue it
                 return false  -- break it
             end)
```
