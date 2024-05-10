---
key: os.host
name: os.host
api: string os.host()
version: 2.0.1
refer: is_host, var_host, os.subhost
---

### os.host

#### Get the operating system of the current host

Consistent with the result of ${link var_host}, for example, if I execute xmake on `linux x86_64` to build, the return value is: `linux`
