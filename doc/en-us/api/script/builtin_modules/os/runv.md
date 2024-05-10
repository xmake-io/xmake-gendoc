---
key: os.runv
name: os.runv
api: nil os.runv(string cmd, table args[, table opt])
version: 2.1.5
refer: os.run, os.vrunv, os.iorunv, os.execv
---

### os.runv

#### Quietly running native shell commands with parameter list

Similar to ${link os.run}, just the way to pass parameters is passed through the parameter list, not the string command, for example:

```lua
${link os.runv}("echo", {"hello", "xmake!"})
```

Valid fields for `opt` are:

* `string shell`
* `table envs`
* `table setenvs`
* `table addenvs`
* `filepath/file/pipe stdin`
* `filepath/file/pipe stdout`
* `filepath/file/pipe stderr`
* `bool detatch`, default value: `false`
* `bool exclusive`, default value: `false`
