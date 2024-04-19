---
isapi: true
key: is_host
name: is_host
---

### ${anchor:is_host}

是否为当前的编译主机系统

`bool is_host(string host, ...)`

如果匹配当前的主机系统，那么返回 true，否则返回 false。

一些目标编译平台能够在不同的操作系统上进行构建，例如：Android NDK 可以在 linux, macOS 和 windows 上编译。

因此，我们能够使用这个 API 去决定当前的操作系统。

```lua
if ${link:is_host}("windows") then
    ${link:add_includedirs}("C:\\includes")
else
    ${link:add_includedirs}("/usr/includess")
end
```

支持的主机系统有：

* "windows"
* "linux"
* "macosx"

#### 在 2.1.4 版本被引入

#### 相关接口

${link:is_arch}, ${link:is_os}, ${link:is_plat}, ${link:is_subhost}
