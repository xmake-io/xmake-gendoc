---
key: add_requireconfs
name: add_requireconfs
api: true
---

### add_requireconfs

#### Set the configuration of the specified dependent package

This is a newly added interface after v2.5.1. We can use it to expand and rewrite the configuration of the package defined by `add_requires()` and its dependent packages. It has the following uses.

##### Expand the configuration of the specified package

This is the basic usage. For example, we have declared a package through `add_requires("zlib")`, and want to expand the configuration of this zlib later and change it to dynamic library compilation. You can configure it in the following way.

```lua
add_requires("zlib")
add_requireconfs("zlib", {configs = {shared = true}})
```

It is equivalent to

```lua
add_requires("zlib", {configs = {shared = true}})
```

##### Set general default configuration

The above usage, we still don't see any practical use, we can look at the following example first:

```lua
add_requireconfs("*", {configs = {shared = true}})
add_requires("zlib")
add_requires("pcre")
add_requires("libpng")
add_requires("libwebp")
add_requires("libcurl", {configs = {shared = false}})
```

For the above configuration, we use pattern matching through `add_requireconfs("*", {configs = {shared = true}})` to set all dependent packages to compile and install dynamic libraries by default.

However, we used `add_requires("libcurl", {configs = {shared = false}})` to configure libcurl to compile and install static libraries.

The final configuration result is: zlib/pcre/libpng/libwebp is a shared library, and libcurl is a static library.

Through pattern matching, we can put some common configurations of each package into the unified `add_requireconfs` to pre-configure, which greatly simplifies the definition of each `add_requires`.

!> By default, for the same configuration, xmake will give priority to the configuration in add_requires instead of add_requireconfs.

If the version is set in `add_requires("zlib 1.2.11")`, the configuration of add_requires will be used first, and the version configuration in add_requireconfs will be completely ignored. Of course, we can also completely override the version specified in `add_requires` through override .

```lua
add_requires("zlib 1.2.11")
add_requireconfs("zlib", {override = true, version = "1.2.10"})
```

##### Rewrite package dependency configuration

In fact, the biggest use of `add_requireconfs` is to allow users to rewrite the configuration of specific dependent packages of the installation package.

What does it mean? For example, our project integrates the package libpng and uses a dynamic library version, but the zlib library that libpng depends on is actually a static library version.

```lua
add_requires("libpng", {configs = {shared = true}})
```

So if we want to change the zlib package that libpng depends on to be compiled as a dynamic library, how should we configure it? This requires `add_requireconfs`.


```lua
add_requires("libpng", {configs = {shared = true}})
add_requireconfs("libpng.zlib", {configs = {shared = true}})
```

Through the writing method of `libpng.zlib` dependency path, specify an internal dependency and rewrite the internal dependency configuration.

If the dependency path is deep, such as the dependency chain of `foo -> bar -> xyz`, we can write: `foo.bar.xyz`

We can also rewrite the internal zlib library version that libpng depends on:


```lua
add_requires("libpng")
add_requireconfs("libpng.zlib", {version = "1.2.10"})
```

##### Pattern matching for cascading dependencies

If a package has a lot of dependencies, and the dependency level is also very deep, what to do, for example, the package libwebp, its dependencies are:

```
libwebp
  - libpng
    - zlib
    - cmake
  - libjpeg
  - libtiff
    - zlib
  - giflib
  - cmake
```

If I want to rewrite all the dependent libraries in libwebp to add specific configuration, then the configuration one by one will be very cumbersome. At this time, the recursive dependency pattern matching of `add_requireconfs()` is needed to support.

```lua
add_requires("libwebp")
add_requireconfs("libwebp.**|cmake", {configs = {cxflags = "-DTEST"}})
```

In the above configuration, we added `-DTEST` to compile all the library dependencies in libwebp, but the cmake dependency is a build tool dependency, and we can exclude it by way of `|xxx`.

The pattern matching here is very similar to `add_files()`.

We are giving a few examples. For example, this time we only rewrite the single-level dependency configuration under libwebp to enable the debugging library:

```lua
add_requires("libwebp")
add_requireconfs("libwebp.*|cmake", {debug = true})
```
