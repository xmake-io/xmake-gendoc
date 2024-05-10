---
key: os.execv
name: os.execv
api: bool, string os.execv(string cmd, table args[, table opt])
version: 2.1.5
refer: os.exec, os.run, os.vexec, os.vexecv, vformat
---

### os.execv

#### Echo running native shell commands with parameter list

Similar to ${link os.exec}, just the way to pass parameters is passed through the parameter list, not the string command, for example:

```lua
${link os.execv}("echo", {"hello", "xmake!"})
```

In addition, this interface also supports an optional parameter for passing settings: redirect output, perform environment variable settings, for example:

```lua
${link os.execv}("echo", {"hello", "xmake!"}, {stdout = outfile, stderr = errfile, envs = {PATH = "xxx;xx", CFLAGS = "xx"}})
```

Valid fields for `opt` are:

* `bool try`, default value: `false`
* `string shell`
* `table envs`
* `table setenvs`
* `table addenvs`
* `filepath/file/pipe stdin`
* `filepath/file/pipe stdout`
* `filepath/file/pipe stderr`
* `bool detatch`, default value: `false`
* `bool exclusive`, default value: `false`

Set `try` to `true` to return the errors instead of raising them.

```lua
local ok, errors = ${link os.execv}("echo", {"hello", "xmake!"}, {try = true})
```

Among them, the stdout and stderr parameters are used to pass redirected output and error output. You can directly pass in the file path or the file object opened by ${link io.open}.

After v2.5.1, we also support setting the stdin parameter to support redirecting input files.

!> stdout/stderr/stdin can simultaneously support three types of values: file path, file object, and pipe object.

In addition, if you want to temporarily set and rewrite some environment variables during this execution, you can pass the envs parameter. The environment variable settings inside will replace the existing settings, but will not affect the outer execution environment, only the current command.

We can also get all the current environment variables through the `${link os.getenvs}()` interface, and then pass in the envs parameter after rewriting some parts.
