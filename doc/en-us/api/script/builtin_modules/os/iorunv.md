---
key: os.iorunv
name: os.iorunv
api: string, string os.iorunv(string cmd, table args[, table opt])
version: 2.1.5
refer: os.iorun, os.exec, os.run
---

### os.iorunv

#### Run the native shell command quietly and get the output with a list of parameters

Similar to ${link os.iorun}, just the way to pass arguments is passed through the argument list, not the string command, for example:

```lua
local outdata, errdata = ${link os.iorunv}("echo", {"hello", "xmake!"})
local outdata, errdata = ${link os.iorunv}("echo", {"hello", "xmake!"}, {envs = {PATH="..."}})
```

Valid fields for `opt` are:

* `string shell`
* `table envs`
* `table setenvs`
* `table addenvs`
* `filepath/file/pipe stdin`
* `bool detatch`, default value: `false`
* `bool exclusive`, default value: `false`
