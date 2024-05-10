---
key: print
name: print
api: true
refer: printf, vprint, cprint, dprint
---

### print

#### Wrapping print terminal log

This interface is also the native interface of lua. xmake is also extended based on the original behavior, and supports: formatted output, multivariable output.

First look at the way native support:

```lua
${link print}("hello xmake!")
${link print}("hello", "xmake!", 123)
```

And also supports extended formatting:

```lua
${link print}("hello %s!", "xmake")
${link print}("hello xmake! %d", 123)
```

Xmake will support both types of writing at the same time, and the internal will automatically detect and select the output behavior.
