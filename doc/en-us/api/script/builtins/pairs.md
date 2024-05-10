---
key: pairs
name: pairs
api: true
refer: ipairs
---

### pairs

#### Used to traverse the dictionary

This is lua's native built-in api. In xmake, it has been extended in its original behavior to simplify some of the daily lua traversal code.

First look at the default native notation:

```lua
local t = {a = "a", b = "b", c = "c", d = "d", e = "e", f = "f"}

for key, val in ${link pairs}(t) do
    ${link print}("%s: %s", key, val)
end
```

This is sufficient for normal traversal operations, but if we get the uppercase for each of the elements it traverses, we can write:

```lua
for key, val in ${link pairs}(t, function (v) return v:upper() end) do
     ${link print}("%s: %s", key, val)
end
```

Even pass in some parameters to the second `function`, for example:

```lua
for key, val in ${link pairs}(t, function (v, a, b) return v:upper() .. a .. b end, "a", "b") do
     ${link print}("%s: %s", key, val)
end
```
