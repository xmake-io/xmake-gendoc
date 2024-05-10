---
key: os.filedirs
name: os.filedirs
api: table os.filedirs(string path_pattern[, function callback])
version: 2.0.1
refer: os.files, os.dirs, os.match
---

### os.filedirs

#### Traverse to get all files and directories under the specified directory

Supports pattern matching in ${link target.add_files}, supports recursive and non-recursive mode traversal, and returns a table array. If not, returns an empty array, for example:

```lua
-- Recursive traversal to get all child files and directories
for _, filedir in ${link ipairs}(${link os.filedirs}("${link var_buildir}/**")) do
    ${link print}(filedir)
end
```
