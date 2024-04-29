---
api: true
key: template_unique_key
name: template:name
refer: os.trycp, os.cp, is.os
version: 1.0.1
---

If an h3 title only contains the api name, an anchor is automatically generated

### template:name

Otherwise, it can explicitely be defined

## ${anchor template_unique_key}

#### Add here any documentation. The text can contain a link to another page: ${link os.cp}.

```lua
-- links also work in code blocks
if ${link is.os}("windows") then
	-- do stuff
end
```
