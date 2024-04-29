---
key: os.dirs
name: os.dirs
api: table os.dirs(string path)
version: 2.0.1
refer: os.files, os.isdir
---

### os.dirs

#### Traverse to get all the directories under the specified directory

Supports pattern matching in ${link target.add_files add_files}, supports recursive and non-recursive mode traversal, and returns a table array. If not, returns an empty array, for example:

```lua
-- Recursive traversal to get all subdirectories
for _, dir in ${link ipairs}(${link os.dirs}("${link var_buildir}/inc/**")) do
    ${link print}(dir)
end
```
