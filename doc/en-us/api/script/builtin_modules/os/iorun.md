---
key: os.iorun
name: os.iorun
api: string, string os.iorun(string cmd)
version: 2.0.1
refer: os.iorunv, os.exec, os.run
---

### os.iorun

#### Quietly running native shell commands and getting output

Similar to the ${link os.run} interface, the only difference is that after executing the shell program, this interface will get the execution result of the shell program, which is equivalent to redirecting the output.

You can get the contents of `stdout`, `stderr` at the same time, for example:

```lua
local outdata, errdata = ${link os.iorun}("echo hello xmake!")
```
