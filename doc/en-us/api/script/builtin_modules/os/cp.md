---
key: os.cp
name: os.cp
api: nil os.cp(string src, string dst[, table opt])
version: 2.0.1
refer: os.trycp, os.mv, os.rm
---

### os.cp

#### Copy files or directories

The behavior is similar to the `cp` command in the shell, supporting path wildcard matching (using lua pattern matching), support for multi-file copying, and built-in variable support.

Valid fields for `opt` are:

* `string rootdir`
* `bool symlink`

e.g:

```lua
${link os.cp}("${link var_scriptdir}/*.h", "${link var_buildir}/inc")
${link os.cp}("${link var_projectdir}/src/test/**.h", "${link var_buildir}/inc")
```

The above code will: all the header files in the current `xmake.lua` directory, the header files in the project source test directory are all copied to the `${link var_buildir}` output directory.

Among them `${link var_scriptdir}`, `${link var_projectdir}` These variables are built-in variables of xmake. For details, see the related documentation of ${link builtin_variables_intro}.

The matching patterns in `*.h` and `**.h` are similar to those in ${link target.add_files add_files}, the former is a single-level directory matching, and the latter is a recursive multi-level directory matching.

This interface also supports `recursive replication' of directories, for example:

```lua
-- Recursively copy the current directory to a temporary directory
${link os.cp}("${link var_curdir}/test/", "${link var_tmpdir}/test")
```

The copy at the top will expand and copy all files to the specified directory, and lose the source directory hierarchy. If you want to copy according to the directory structure that maintains it, you can set the rootdir parameter:

```lua
${link os.cp}("src/**.h", "/tmp/", {rootdir="src"})
```

The above script can press the root directory of `src` to copy all sub-files under src in the same directory structure.

> ⚠ **Try to use the `${link os.cp}` interface instead of `${link os.run}("cp ..")`, which will ensure platform consistency and cross-platform build description.**

Under 2.5.7, the parameter `{symlink = true}` is added to keep the symbolic link when copying files.

```lua
${link os.cp}("/xxx/foo", "/xxx/bar", {symlink = true})
```

