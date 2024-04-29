---
api: true
key: var_env
name: $(env)
version: 2.1.5
refer: os.getenvs
---

### ${anchor var_env}

#### Get external environment variables

For example, you can get the path in the environment variable:

```lua
target("test")
    ${link target.add_includedirs add_includedirs}("${link var_env $(env PROGRAMFILES)/OpenSSL/inc}")
```

