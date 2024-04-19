---
isapi: true
key: var_env
name: ${env}
---

### ${anchor:var_env}

Get external environment variables

For example, you can get the path in the environment variable:

```lua
target("test")
    ${link:add_includedirs}("$(env PROGRAMFILES)/OpenSSL/inc")
```

#### Introduced in version 2.1.5

#### See also

${link:os_getenvs}
