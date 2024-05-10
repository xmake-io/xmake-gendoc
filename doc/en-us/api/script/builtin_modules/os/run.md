---
key: os.run
name: os.run
api: nil os.run(string cmd_format[, ...])
version: 2.0.1
refer: os.runv, os.vrun, os.iorun, os.exec, core.base.process
---

### os.run

#### Quietly running native shell commands

Used to execute third-party shell commands, but will not echo the output, only after the error, highlight the error message.

This interface supports parameter formatting and built-in variables such as:

```lua
-- Formatted parameters passed in
${link os.run}("echo hello %s!", "xmake")

-- List build directory files
${link os.run}("ls -l ${link var_buildir}")
```

<p class="warn">
Using this interface to execute shell commands can easily reduce the cross-platform build. For `${link os.run}("cp ..")`, try to use `${link os.cp}` instead. <br>
If you must use this interface to run the shell program, please use the ${link core.project.config.plat config.plat} interface to determine the platform support.
</p>

For more advanced process operations and control, see the ${link core.base.process.open process} module interface.
