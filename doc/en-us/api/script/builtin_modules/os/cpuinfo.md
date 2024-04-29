---
key: os.cpuinfo
name: os.cpuinfo
api: table os.cpuinfo()
version: 2.1.5
refer: os.default_njob
---

### os.cpuinfo

#### Get cpu information

```lua
${link print}(${link os.cpuinfo}())
-- got {
--   ncpu = 8,
--   usagerate = 0.0,
--   model_name = "Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz",
--   march = "Kaby Lake",
--   vendor = "GenuineIntel",
--   model = 158,
--   family = 6
-- }
${link print}(${link os.cpuinfo}("march")) -- got "Kaby Lake"
```
