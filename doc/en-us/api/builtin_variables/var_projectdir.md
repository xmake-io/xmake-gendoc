---
api: true
key: var_projectdir
name: $(projectdir)
version: 2.0.1
refer: os_projectdir
---

### ${anchor:var_projectdir}

#### Project root directory

That is, the directory path specified in the `xmake -P xxx` command, the default is not specified is the current directory when the `xmake` command is executed, which is generally used to locate the project file.

