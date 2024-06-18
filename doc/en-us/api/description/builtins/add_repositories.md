---
key: add_repositories
name: add_repositories
api: true
---

### add_repositories

#### Add 3rd package repositories

If the required package is not in the official repository [xmake-repo](https://github.com/xmake-io/xmake-repo), we can submit the contribution code to the repository for support.
But if some packages are only for personal or private projects, we can create a private repository repo. The repository organization structure can be found at: [xmake-repo](https://github.com/xmake-io/xmake-repo)

For example, now we have a private repository repo:`git@github.com:myrepo/xmake-repo.git`

We can add through this interface:

```lua
add_repositories("my-repo git@github.com:myrepo/xmake-repo.git")
```

If we just want to add one or two private packages, this time to build a git repository is too big, we can directly put the package repository into the project, for example:

```
projectdir
  - myrepo
    - packages
      - t/tbox/xmake.lua
      - z/zlib/xmake.lua
  - src
    - main.c
  - xmake.lua
```

The above myrepo directory is your own private package repository, built into your own project, and then add this repository location in xmake.lua:

```lua
add_repositories("my-repo myrepo")
```

This can be referred to [benchbox](https://github.com/tboox/benchbox) project, which has a built-in private repository.

Note: myrepo is the relative path of the directory where the xmake command is executed. It will not be automatically converted according to the directory where the configuration file is located. If you want to set the path relative to the current xmake.lua file, you can specify it through the rootdir parameter.

```lua
add_repositories("my-repo myrepo", {rootdir = os.scriptdir()})
```

However, this parameter setting is only supported by v2.5.7 and above.
