---
key: os.exec
name: os.exec
api: nil os.exec(string cmd_format[, ...])
version: 2.0.1
refer: os.run, os.runv, os.iorun, os.iorunv, os.execv, os.vexec, os.vexecv, os.isexec, vformat
---

### os.exec

#### Echo running native shell commands

Similar to the ${link os.run} interface, the only difference is that when this interface executes the shell program, it has the output printed in the console, which is used in general debugging.
An exception will be raised if an error happens.

```lua
${link os.exec}("program --%s=%d --path=${link var_buildir}", "value", 42)
```
