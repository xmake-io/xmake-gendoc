---
api: true
key: var_curdir
name: $(curdir)
version: 2.0.1
refer: os.curdir
---

### ${anchor var_curdir}

#### Get the current directory

The default is the project root directory when the `xmake` command is executed. Of course, if the directory is changed by ${link os.cd}, this value will also change.

