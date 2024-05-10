---
key: os.raise
name: os.raise
api: nil os.raise(string messageformat[, ...])
version: 2.2.8
refer: raise, try, catch, finally
---

### os.raise

#### Raise an exception and abort the current script

```lua
-- Raise exception with message "the error #42 occurred"
${link os.raise}("the error #%d occurred", errcode)
```

<p class="warn">
It is recommanded to use the builtin function `${link raise}` instead of `${link os.raise}`
</p>
