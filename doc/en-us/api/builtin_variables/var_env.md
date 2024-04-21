---
api: true
key: var_env
name: $(env)
version: 2.1.5
refer: os_getenvs
---

### ${anchor:var_env}

#### Get external environment variables

For example, you can get the path in the environment variable:

```lua
target("test")
    ${link:add_includedirs}("$(env PROGRAMFILES)/OpenSSL/inc")
```

