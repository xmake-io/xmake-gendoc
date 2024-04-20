---
api: true
key: template_unique_key
name: template:name
refer: os_trycp, os_cp, is_os
---

### ${anchor:template_unique_key} ( <- this anchor key must be replaced )

#### Add here any documentation. The text can contain a link to another page: ${link:os_cp}.

```lua
-- links also work in code blocks: ${link:is_os}
if ${link:is_os}("windows") then
	-- do stuff
end
```
