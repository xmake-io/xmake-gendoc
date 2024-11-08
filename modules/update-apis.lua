import("plugins.show.lists.apis", {rootdir = os.programdir()})
import("core.base.hashset")

function _create_file(pth, api, opt)
    opt = opt or {}
    local s = opt.s or ([[---
    key: API_NAME
    name: API_NAME
    api: true
    ---
    
    ### API_NAME]]):gsub("\n%s+", "\n"):gsub("API_NAME", api)

    print("Creating markdown file for", api, "in", path.relative(pth, os.projectdir()))
    io.writefile(p, s)
end

-- do the update in the api/description/scopes folder of one locale
function _update_description_scope_apis(opt)
    local apis = apis.description_scope_apis()

    local scopes_root = path.join(os.projectdir(), "doc", opt.locale, "api", "description", "scopes")
    for _, api in ipairs(apis) do
        local type, interface = table.unpack(api:split(".", {plain = true}))
        local p = path.join(scopes_root, type, interface .. ".md")
        
        if not os.exists(p) then
            _create_file(p, api)
        end
    end
end

-- do the update in the api/description/builtins folder of one locale
function _update_description_builtin_apis(opt)
    local description_builtin = apis.description_builtin_apis()
    local script_builtin = hashset.from(apis.script_builtin_apis())

    local builtins_root = path.join(os.projectdir(), "doc", opt.locale, "api", "description", "builtins")
    for _, api in ipairs(description_builtin) do
        -- conditions are located in different places
        -- some in api/description/builtins
        -- others in api/description/condition
        -- so it's easier just to ignore them
        if api:startswith("is_") then
            goto continue
        end

        local p = path.join(builtins_root, api .. ".md")
        if not os.exists(p) then
            if script_builtin:has(api) then
                local s = format("${include api/script/builtins/%s.md}", api)
                _create_file(p, api, {s = s})
            else
               _create_file(p, api)
            end
        end
       ::continue::
    end 

end

-- do the update in the api/script/builtins_modules folder of one locale
function _update_description_builtin_modules_apis(opt)
    local description_builtin = apis.description_builtin_module_apis()
    local script_builtin = hashset.from(apis.script_builtin_module_apis())

    local builtins_root = path.join(os.projectdir(), "doc", opt.locale, "api", "description", "builtin_modules") 

    for _, api in ipairs(description_builtin) do
        local type, interface = table.unpack(api:split(".", {plain = true}))
        local p = path.join(builtins_root, type, interface .. ".md")

        if not os.exists(p) then
            if script_builtin:has(api) then
                local s = format("${include api/script/builtin_modules/%s.md}", api)
                _create_file(p, api, {s = s})
            else
                _create_file(p, api)
            end
        end
    end
end

-- do the update in the api/script/instances folder of one locale
function _update_script_instances_apis(opt)
    local apis = apis.script_instance_apis()

    local instances_root = path.join(os.projectdir(), "doc", opt.locale, "api", "script", "instances")
    for _, api in ipairs(apis) do
        local type, interface = table.unpack(api:split(":", {plain = true}))
        local p = path.join(instances_root, type, interface .. ".md")

        if not os.exists(p) then
            _create_file(p, api)
        end
    end
end

-- do the update in the api/script/builtins folder of one locale
function _update_script_builtin_apis(opt)
    local apis = apis.script_builtin_apis()

    local builtins_root = path.join(os.projectdir(), "doc", opt.locale, "api", "script", "builtins")
    for _, api in pairs(apis) do
        -- conditions are located in different places
        -- some in api/description/builtins
        -- others in api/description/condition
        -- so it's easier just to ignore them
        if api:startswith("is_") then
            goto continue
        end

        local p = path.join(builtins_root, api .. ".md")
        if not os.exists(p) then
            _create_file(p, api, opt)
        end
        ::continue::
    end
end

-- do the update in the api/script/builtin_modules folder of one locale
function _update_script_builtin_modules_apis(opt)
    local apis = apis.script_builtin_module_apis()

    local builtins_root = path.join(os.projectdir(), "doc", opt.locale, "api", "script", "builtin_modules")
    for _, api in ipairs(apis) do
        local type, interface = table.unpack(api:split(".", {plain = true}))
        local p = path.join(builtins_root, type, interface .. ".md")

        if not os.exists(p) then
            _create_file(p, api)
        end
    end
end

function main()
    
    for _, pagefile in ipairs(os.files(path.join(os.projectdir(), "doc", "*", "pages.lua"))) do
        local locale = path.basename(path.directory(pagefile))

        -- description
        _update_description_scope_apis({locale = locale})
        _update_description_builtin_apis({locale = locale})
        _update_description_builtin_modules_apis({locale = locale})

        -- script
        _update_script_instances_apis({locale = locale})
        _update_script_builtin_modules_apis({locale = locale})
    end
end