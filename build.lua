--!A cross-platform build utility based on Lua
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--
-- Copyright (C) 2015-present, TBOOX Open Source Group.
--
-- @author      charlesseizilles
-- @file        build.lua
--

-- imports
import("core.base.option")
import("core.sandbox.module")

local options = {
    {'o', "output",   "kv", nil, "Output html directory. (default is ./html)"},
    {'s', "siteroot", "kv", nil, "Site root. (default is https://xmake.io)"}
}

function _load_file_metadata(filecontent)

    local pattern = "%-%-%-\nisapi: ([%w%p]+)\nkey: ([%w%p]+)\nname: (.+)\n%-%-%-"

    local apientry = {}
    apientry.isapi, apientry.key, apientry.name = filecontent:match(pattern)
    local metadatastart, metadataend = filecontent:find(pattern)

    return apientry, metadatastart, metadataend
end

function _make_db(locale)
    local db = {}

    for _, apientryfile in ipairs(os.files(path.join(os.scriptdir(), "doc", locale, "*/**.md"))) do
        local apientrydata = io.readfile(apientryfile)
        local apientry = _load_file_metadata(apientrydata)
        if apientry.key then
            assert(db[apientry.key] == nil, "keys must be unique (" .. apientry.key .. " was already inserted)")

            db[apientry.key] = apientry
        end
    end

    return db
end

function _make_anchor(db, key, page, locale, siteroot)
    assert(db and key and page and locale and siteroot)
    if db[key] then
        return [[<a href="]] .. siteroot .. '/' .. locale .. '/' .. page .. '#' .. db[key].key .. [[" id="]] .. db[key].key .. [[">]] .. db[key].name .. [[</a>]]
    else
        return [[<s>]] .. key .. [[</s>]]
    end
end

function _make_link(db, key, page, locale, siteroot)
    assert(db and key and page and locale and siteroot)
    if db[key] then
        return [[<a href="]] .. siteroot .. '/' .. locale .. '/' .. page .. '#' .. db[key].key .. [[">]] .. db[key].name .. [[</a>]]
    else
        return [[<s>]] .. key .. [[</s>]]
    end
end

function _build_html_page(cmark, docdir, title, db, sidebar, opt)
    opt = opt or {}

    local locale = opt.locale or "en-us"
    local page = docdir .. ".html"
    local isindex = false
    if title == "index" and docdir == "." then
        page = "index.html"
        isindex = true
    end
    local outputfile = path.join(opt.outputdir or "", locale, page)

    local siteroot = opt.siteroot or "https://xmake.io"
    local interfaces = "Interfaces" -- TODO change with language

    local sitemap = io.open(outputfile, 'w')
    sitemap:write(string.format([[
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="resource-type" content="document">
<link rel="stylesheet" href="%s/xmake.css" type="text/css" media="all">
<link rel="stylesheet" href="%s/prism.css" type="text/css" media="all">
<title>%s</title>
</head>
<body>
<div id="sidebar">
%s
</div>
<div id="content">
]], siteroot, siteroot, title, sidebar))

    local docroot = path.join(os.scriptdir(), "doc", locale)

    local isfirst = true
    local apientries = {}
    for _, apientryfile in ipairs(os.files(path.join(docroot, docdir, "*.md"))) do

        if path.filename(apientryfile):startswith("_") then
            goto continue
        end

        if isfirst then
            isfirst = false
        else
            sitemap:write("<hr />")
        end

        vprint("loading " .. apientryfile)
        local apientrydata = io.readfile(apientryfile)
        local apientry, metadatastart, metadataend = _load_file_metadata(apientrydata)
        vprint("apientry", apientry)

        -- remove the metadata and anything that may be before it
        apientrydata = apientrydata:sub(metadataend + 1)

        local htmldata = cmark.md2html(apientrydata)

        assert(apientry.isapi ~= nil, "entry isapi is nil value")
        assert(apientry.key ~= nil, "entry key is nil value")
        assert(apientry.name ~= nil, "entry name is nil value")
        table.insert(apientries, apientry)

        local anchorstart, anchorend
        repeat
            anchorstart, anchorend = htmldata:find("%${anchor:[%w_]+}")
            if anchorstart == nil then break end

            local anchor = htmldata:sub(anchorstart + 9, anchorend - 1)
            htmldata = htmldata:gsub("%${anchor:[%w_]+}", _make_anchor(db, anchor, page, locale, siteroot), 1)
        until not anchorstart

        local linkstart, linkend
        repeat
            linkstart, linkend = htmldata:find("%${link:[%w_]+}")
            if linkstart == nil then break end

            local link = htmldata:sub(linkstart + 7, linkend - 1)
            htmldata = htmldata:gsub("%${link:[%w_]+}", _make_link(db, link, page, locale, siteroot), 1)
        until not linkstart

        sitemap:write(htmldata)

        ::continue::
    end

    sitemap:write("</div>\n")

    if not isindex then
        sitemap:write(string.format([[
<div id="toc">
<table>
    <thead>
        <tr><td>%s</td></tr>
    </thead>
    <tbody id="toc-body">]] .. "\n", interfaces))

        for _, apientry in ipairs(apientries) do
            if apientry.isapi then
                sitemap:write("        <tr><td>" .. _make_link(db, apientry.key, page, locale, siteroot) .. "</td></tr>\n")
            end
        end

        sitemap:write([[
    </tbody>
</table>
</div>]])
    end

    sitemap:write(string.format("\n"..[[
<script src="%s/prism.js"></script>
</body>
</html>
]], siteroot))
    sitemap:close()
end

function _build_html_pages(cmark, opt)
    opt = opt or {}

    local buildopt = {
        outputdir = opt.output or path.join("html"),
        siteroot = opt.siteroot or "https://xmake.io",
    }

    if os.isdir(buildopt.outputdir) then
        raise("the output folder '" .. buildopt.outputdir .. "' already exists and is not empty")
    end

    for _, dir in ipairs(os.dirs(path.join(os.scriptdir(), "doc", "*"))) do
        buildopt.locale = path.basename(dir)

        local db = _make_db(buildopt.locale)

        local pagesgroups = import("doc." .. buildopt.locale .. ".pages")()

        local sidebar = ""
        for _, pagegroup in ipairs(pagesgroups) do
            sidebar = sidebar .. "\n<p>" .. pagegroup.title .. "</p>\n<ul>\n"
            for _, page in ipairs(pagegroup.pages) do
                sidebar = sidebar .. [[<li><a href="]] .. buildopt.siteroot .. '/' .. buildopt.locale .. '/' .. page.path .. [[">]] .. page.title .. "</a></li>\n"
            end
            sidebar = sidebar .. "</ul>\n"
        end

        for _, pagegroup in ipairs(pagesgroups) do
            for _, page in ipairs(pagegroup.pages) do
                _build_html_page(cmark, page.docdir, page.title, db, sidebar, buildopt)
            end
        end
    end

    os.trycp(path.join(os.scriptdir(), "resources", "*"), buildopt.outputdir)
end

-- main entry
function main(...)

    -- parse arguments
    local argv = {...}
    local opt  = option.parse(argv, options, "Generate the API documentation."
                                           , ""
                                           , "Usage: xmake l gendoc [options]")

    module.add_directories(path.join(os.scriptdir(), "modules"))
    local cmark = module.import("shared.cmark")

    _build_html_pages(cmark, opt)
end
