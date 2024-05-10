---
key: os.files
name: os.files
api: table os.files(string path_pattern[, function callback])
version: 2.0.1
refer: os.isfile, os.dirs, os.filedirs, os.match
---

### os.files

#### Traverse to get all the files in the specified directory

Supports pattern matching in ${link target.add_files}, supports recursive and non-recursive mode traversal, and returns a table array. If not, returns an empty array, for example:

```lua
-- Non-recursive traversal to get all child files
for _, filepath in ${link ipairs}(${link os.files}("${link var_buildir}/inc/*.h")) do
    ${link print}(filepath)
end
```
