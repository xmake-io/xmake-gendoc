---
key: add_requires
name: add_requires
api: true
---

### add_requires

#### Add the required dependency packages

The dependency package management of xmake fully supports semantic version selection, for example: "~1.6.1". For a detailed description of the semantic version, please see: [https://semver.org/](https://semver.org/)

##### Semantic version

```lua
add_requires("tbox 1.6.*", "pcre 8.x", "libpng ^1.18")
add_requires("libpng ~1.16", "zlib 1.1.2 || >=1.2.11 <1.3.0")
```

At present, the semantic version parser used by xmake is the [sv](https://github.com/uael/sv) library contributed by [uael](https://github.com/uael), which also contains the version description writing method For detailed instructions, please refer to the following: [Version Description](https://github.com/uael/sv#versions)

##### Install latest version

Of course, if we have no special requirements for the version of the current dependency package, we can write it directly like this:

```lua
add_requires("tbox", "libpng", "zlib")
```

By default, if the version number is not set, xmake will select the latest version of the package, which is equivalent to `add_requires("zlib latest")`

##### Branch selection

This will use the latest known version of the package, or a package compiled from the source code of the master branch. If the current package has a git repo address, we can also specify a specific branch version:

```lua
add_requires("tbox master")
add_requires("tbox dev")
```

If the specified dependent package is not supported by the current platform, or the compilation and installation fails, then xmake will compile an error. This is reasonable for some projects that must rely on certain packages to work.
But if some packages are optional dependencies and can be compiled and used normally even if not, they can be set as optional packages:

##### Git commit selection

With version 2.6.5, we can select a version by specifying git commit directly for packages maintained by git.

```lua
add_requires("tbox e807230557aac69e4d583c75626e3a7ebdb922f8")
```

##### Optional package

```lua
add_requires("zlib", {optional = true})
```

##### Disable system package

With the default setting, xmake will first check whether the system library exists (if the version requirement is not set). If the user does not want to use the system library and the library provided by the third-party package management at all, then you can set:

```lua
add_requires("zlib", {system = false})
```

##### Disable package verification

The default package installation will automatically check the integrity of the downloaded package to avoid tampering, but if you install some unknown new version of the package, it will not work.

Users can install them temporarily via `{verify = false}` to forcibly disable the package integrity check (but this is generally not recommended).

```lua
add_requires("zlib", {verify = false})
```

##### Use the debug package

If we want to debug the dependent packages at the same time, we can set to use the debug version of the package (of course, the premise is that this package supports debug compilation):

```lua
add_requires("zlib", {debug = true})
```

If the current package does not support debug compilation, you can submit a modification to the compilation rules in the warehouse to support debugging, for example:

```lua
package("openssl")
    on_install("linux", "macosx", function (package)
        os.vrun("./config %s --prefix=\"%s\"", package:debug() and "--debug" or "", package:installdir())
        os.vrun("make -j4")
        os.vrun("make install")
    end)
```

##### Use as a private package

If this package is only used for package definition, and we don’t want to export links/linkdirs information by default, it can be provided as a private package.

This is usually useful when making packages.

```lua
package("test")
    add_deps("zlib", {private = true})
    on_install(function (package)
        local zlib = package:dep("zlib"):fetch()
        - TODO
    end)
```

If you define a test package and privately rely on a zlib package, wait for the zlib installation to complete, get the package file information inside for further processing and installation, but the zlib package itself will not export links/linkdirs.

Although `add_requires` also supports this option, it does not export links/linkdirs, so it is usually not used in this way. It is only useful for making packages.

##### Use dynamic libraries

The default package installs a static library. If you want to enable a dynamic library, you can configure it as follows:

```lua
add_requires("zlib", {configs = {shared = true}})
```

!> Of course, the premise is that in the definition of this package, there is a judgment and processing of `package:config("shared")`. In the official xmake-repo repository, it is usually strictly differentiated and supported.

##### Disable pic support

The linux packages installed by default are compiled with pic enabled, which is very useful for relying on static libraries in dynamic libraries, but if you want to disable pic, it is also possible.

```lua
add_requires("zlib", {configs = {pic = false}})
```

##### Set vs runtime

The windows package installed by default is compiled with msvc/MT, if you want to switch to MD, you can configure it as follows:

```lua
add_requires("zlib", {configs = {vs_runtime = "MD"}})
```

In addition, it supports four options: MT, MTd, MD, and MDd.

If there are many dependent packages, it is very troublesome to switch each configuration again. We can also switch through the `set_runtimes` global setting to take effect for all dependent packages.

```lua
set_runtimes("MD")
add_requires("zlib", "pcre2", "mbedtls")
```

##### Specific configuration package

Some packages have various compilation options during compilation, and we can also pass them in:

```lua
add_requires("boost", {configs = {context = true, coroutine = true}})
```

For example, the boost package installed above has enabled some of its internal sub-module features (packages with coroutine module support).

Of course, which configurations are specifically supported are different for each package. You can use the `xmake require --info boost` command to view the list of the configs section inside.

Because, in each package definition, there will be its own configuration options, and you can use `package:config("coroutine")` to determine whether to enable them during installation.

##### Install third-party manager package

Currently, the following packages in the third-party package manager are supported.

* Conan (conan::openssl/1.1.1g)
* Conda (conda::libpng 1.3.67)
* Vcpkg (vcpkg:ffmpeg)
* Homebrew/Linuxbrew (brew::pcre2/libpcre2-8)
* Pacman on archlinux/msys2 (pacman::libcurl)
* Apt on ubuntu/debian (apt::zlib1g-dev)
* Clib (clib::clibs/bytes@0.0.4)
* Dub (dub::log 0.4.3)
* Portage on Gentoo/Linux (portage::libhandy)


For example, add conan's dependency package:

```lua
add_requires("conan::zlib/1.2.11", {alias = "zlib", debug = true})
add_requires("conan::openssl/1.1.1g", {alias = "openssl",
    configs = {options = "OpenSSL:shared=True"}})

target("test")
    set_kind("binary")
    add_files("src/*.c")
    add_packages("openssl", "zlib")
```

After executing xmake to compile:

```console
ruki:test_package ruki$ xmake
checking for the architecture ... x86_64
checking for the Xcode directory ... /Applications/Xcode.app
checking for the SDK version of Xcode ... 10.14
note: try installing these packages (pass -y to skip confirm)?
  -> conan::zlib/1.2.11 (debug)
  -> conan::openssl/1.1.1g
please input: y (y/n)

  => installing conan::zlib/1.2.11 .. ok
  => installing conan::openssl/1.1.1g .. ok

[0%]: cache compiling.release src/main.c
[100%]: linking.release test
```

For a complete introduction to this and the installation and use of all third-party packages,
you can refer to the document: [Third-party dependency package installation](https://xmake.io/#/package/remote_package?id=install-third-party-packages)
