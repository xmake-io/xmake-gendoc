---
isapi: true
key: var_reg
name: ${reg}
---

### ${anchor:var_reg}

Get the value of the windows registry configuration item

Get the value of an item in the registry by `regpath; name`:

```lua
${link:print}("$(reg HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\XXXX;Name)")
```

#### Introduced in version 2.1.5

#### See also

${link:winos_registry_query}
