---
api: false
key: builtin_variables_intro
name: built-in variables
---

## ${anchor builtin_variables_intro}

Xmake provides the syntax of `$(varname)` to support the acquisition of built-in variables, for example:

```lua
${link add_cxflags}("-I${link var_buildir}")
```

It will convert the built-in `buildir` variable to the actual build output directory when compiling: `-I./build`

General built-in variables can be used to quickly get and splicing variable strings when passing arguments, for example:

```lua
target("test")

    -- Add source files in the project source directory
    ${link add_files}("${link var_projectdir}/src/*.c")

    -- Add a header file search path under the build directory
    ${link add_includedirs}("${link var_buildir}/inc")
```

It can also be used in the module interface of a custom script, for example:

```lua
target("test")
    on_run(function (target)
        -- Copy the header file in the current script directory to the output directory
        ${link os_cp}("${link var_scriptdir}/xxx.h", "${link var_buildir}/inc")
    end)
```

All built-in variables can also be retrieved via the [val](#val) interface.

This way of using built-in variables makes the description writing more concise and easy to read.

It is possible to add custom, project-specific, variables. By default, the `xmake f --var=val` command can be used to directly obtain the parameters. For example:

```lua
target("test")
    ${link add_defines}("-DTEST=$(var)")
```

> ℹ️ All the parameter values of the `xmake f --xxx=...` configuration can be obtained through built-in variables, for example: `xmake f --arch=x86` corresponds to `$(arch)`, others have `$(plat)`, `$(mode)` and so on. What are the specific parameters, you can check it out by `xmake f -h`.

Since the support is directly obtained from the configuration options, it is convenient to extend the custom options to get the custom variables. For details on how to customize the options, see: [option](#option).
