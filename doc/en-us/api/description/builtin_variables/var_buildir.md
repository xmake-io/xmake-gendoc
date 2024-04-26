---
api: true
key: var_buildir
name: $(buildir)
version: 2.0.1
refer: config_buildir
---

### ${anchor var_buildir}

#### Get the current build output directory

The default is usually the `./build` directory in the current project root directory. You can also modify the default output directory by executing the `xmake f -o /tmp/build` command.

