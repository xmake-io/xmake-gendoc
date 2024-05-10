---
key: raise
name: raise
api: nil raise(string message)
refer: try, catch, finally
---

### raise

#### Throwing an abort program

If you want to interrupt xmake running in custom scripts and plug-in tasks, you can use this interface to throw an exception. If the upper layer does not show the call to ${link exceptions_intro}, xmake will be executed. An error message is displayed.

```lua
if errors then ${link raise}(errors) end
```

If an exception is thrown in the try block, the error information is captured in ${link catch} and ${link finally}. See: ${link exceptions_intro}
