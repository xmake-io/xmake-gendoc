---
key: ipairs
name: ipairs
api: true
refer: pairs
---

### ipairs

#### for traversing arrays

This is lua's native built-in api. In xmake, it has been extended in its original behavior to simplify some of the daily lua traversal code.

First look at the default native notation:

```lua
for idx, val in ${link ipairs}({"a", "b", "c", "d", "e", "f"}) do
     ${link print}("%d %s", idx, val)
end
```

The extension is written like the ${link pairs} interface, for example:

```lua
for idx, val in ${link ipairs}({"a", "b", "c", "d", "e", "f"}, function (v) return v:upper() end) do
     ${link print}("%d %s", idx, val)
end

for idx, val in ${link ipairs}({"a", "b", "c", "d", "e", "f"}, function (v, a, b) return v:upper() .. a .. b end, "a", "b") do
     ${link print}("%d %s", idx, val)
end
```

This simplifies the logic of the `for` block code. For example, if I want to traverse the specified directory and get the file name, but not including the path, I can simplify the writing by this extension:

```lua
for _, filename in ${link ipairs}(${link os.dirs}("*"), path.filename) do
    -- ...
end
```
