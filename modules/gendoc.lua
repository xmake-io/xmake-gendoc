--!A cross-platform document build utility based on Lua
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
-- @file        gendoc.lua
--

-- imports
import("core.base.option")
import("shared.cmark")

function _load_file_metadata(filecontent)
    local apientry = {}
    local pattern = "%-%-%-\nisapi: ([%w%p]+)\nkey: ([%w%p]+)\nname: (.+)\n%-%-%-"
    apientry.isapi, apientry.key, apientry.name = filecontent:match(pattern)
    local metadatastart, metadataend = filecontent:find(pattern)
    return apientry, metadatastart, metadataend
end

function _make_db()
    local db = {}

    local docroot = path.join(os.projectdir(), "doc")
    for _, pagefilepath in ipairs(os.files(path.join(os.projectdir(), "doc", "*", "pages.lua"))) do
        local locale = path.basename(path.directory(pagefilepath))
        local localizeddocroot = path.join(docroot, locale)
        db[locale] = io.load(path.join(localizeddocroot, "pages.lua"))
        db[locale].apis = {}
        db[locale].pages = {}
        for _, pagegroup in ipairs(db[locale].categories) do
            for _, page in ipairs(pagegroup.pages) do
                table.insert(db[locale].pages, page)
                for _, apientryfile in ipairs(os.files(path.join(localizeddocroot, page.docdir, "*.md"))) do
                    local apientrydata = io.readfile(apientryfile)
                    local apientry = _load_file_metadata(apientrydata)
                    if apientry.key then
                        assert(db[locale].apis[apientry.key] == nil, "keys must be unique (" .. apientry.key .. " was already inserted)")
                        db[locale].apis[apientry.key] = apientry
                        db[locale].apis[apientry.key].page = page
                    end
                end
            end
        end
    end
    return db
end

function _join_link(...)
    return table.concat(table.pack(...), "/")
end

function _make_anchor(db, key, locale, siteroot)
    assert(db and key and locale and siteroot and db[locale])
    if db[locale].apis[key] then
        return [[<a href="]] .. _join_link(siteroot, locale, db[locale].apis[key].page.docdir .. ".html") .. '#' .. db[locale].apis[key].key .. [[" id="]] .. db[locale].apis[key].key .. [[">]] .. db[locale].apis[key].name .. [[</a>]]
    else
        return [[<s>]] .. key .. [[</s>]]
    end
end

function _make_link(db, key, locale, siteroot)
    assert(db and key and locale and siteroot and db[locale])
    if db[locale].apis[key] then
        return [[<a href="]] .. _join_link(siteroot, locale, db[locale].apis[key].page.docdir .. ".html") .. '#' .. db[locale].apis[key].key .. [[">]] .. db[locale].apis[key].name .. [[</a>]]
    else
        return [[<s>]] .. key .. [[</s>]]
    end
end

function _build_language_selector(db, locale, siteroot, page)
    local languageSelect = [[
<select name="language" onchange='changeLanguage(this, "]] .. locale .. [[");'>
]]
    local odrereddbkeys = table.orderkeys(db)
    for _, localename in ipairs(odrereddbkeys) do
        local dblocaleentry = db[localename]
        local selected = localename == locale and "selected" or ""
        languageSelect = languageSelect .. string.format([[    <option %s value="%s">%s %s</option>
]], selected, localename, dblocaleentry.flag, dblocaleentry.name)
    end
    languageSelect = languageSelect .. [[
</select>
<script>
function changeLanguage(select, currentLang) {
    if(select.value != currentLang) {
        var newUrl = "%s/" + select.value + "/%s";
        var splitUrl = window.location.href.split('#');
        if (splitUrl.length > 1)
            newUrl = newUrl + '#' + splitUrl[splitUrl.length - 1];
        window.location.href = newUrl;
    }
}
</script>
]]
    return string.format(languageSelect, siteroot, page)
end

function _write_header(sitemap, siteroot, title)
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
]], siteroot, siteroot, title))
end

function _write_api(sitemap, db, locale, siteroot, apientries, apientrydata)
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
        htmldata = htmldata:gsub("%${anchor:[%w_]+}", _make_anchor(db, anchor, locale, siteroot), 1)
    until not anchorstart

    local linkstart, linkend
    repeat
        linkstart, linkend = htmldata:find("%${link:[%w_]+}")
        if linkstart == nil then break end

        local link = htmldata:sub(linkstart + 7, linkend - 1)
        htmldata = htmldata:gsub("%${link:[%w_]+}", _make_link(db, link, locale, siteroot), 1)
    until not linkstart

    sitemap:write(htmldata)
end

function _write_table_of_content(sitemap, db, locale, siteroot, apientries)
    local interfaces = "Interfaces" -- TODO change with language
    sitemap:write(string.format([[
<div id="toc">
<table>
    <thead>
        <tr><td>%s</td></tr>
    </thead>
    <tbody id="toc-body">]] .. "\n", interfaces))

        for _, apientry in ipairs(apientries) do
            if apientry.isapi then
                sitemap:write("        <tr><td>" .. _make_link(db, apientry.key, locale, siteroot) .. "</td></tr>\n")
            end
        end

        sitemap:write([[
    </tbody>
</table>
</div>]])
end

function _write_footer(sitemap, siteroot)
    sitemap:write(string.format("\n" .. [[
<script src="%s/prism.js"></script>
</body>
</html>
]], siteroot))
end

function _build_html_page(docdir, title, db, sidebar, opt)
    opt = opt or {}
    local locale = opt.locale or "en-us"
    local page = docdir .. ".html"
    local isindex = false
    if title == "index" and docdir == "." then
        page = "index.html"
        isindex = true
    end
    local outputfiledir = path.join(opt.outputdir or "", locale)
    local outputfile = path.join(outputfiledir, page)
    local sitemap = io.open(outputfile, 'w')
    local siteroot = opt.siteroot:gsub("\\", "/")
    _write_header(sitemap, siteroot, title)

    sitemap:write('<div id="sidebar">\n')
    sitemap:write(_build_language_selector(db, locale, siteroot, page))
    sitemap:write(sidebar)
    sitemap:write('</div>\n')

    sitemap:write('<div id="content">\n')
    local isfirst = true
    local apientries = {}
    local docroot = path.join(os.projectdir(), "doc", locale)
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
        _write_api(sitemap, db, locale, siteroot, apientries, apientrydata)

        ::continue::
    end
    sitemap:write("</div>\n")

    if not isindex then
        _write_table_of_content(sitemap, db, locale, siteroot, apientries)
    end

    _write_footer(sitemap, siteroot)
    sitemap:close()
end

function _build_html_pages(opt)
    opt = opt or {}
    os.tryrm(opt.outputdir)
    local db = _make_db()
    for _, pagefile in ipairs(os.files(path.join(os.projectdir(), "doc", "*", "pages.lua"))) do
        opt.locale = path.basename(path.directory(pagefile))
        local sidebar = ""
        for _, category in ipairs(db[opt.locale].categories) do
            sidebar = sidebar .. "\n<p>" .. category.title .. "</p>\n<ul>\n"
            for _, page in ipairs(category.pages) do
                local pagepath = page.docdir
                if pagepath == "." then
                    pagepath = page.title
                end
                sidebar = sidebar .. [[<li><a href="]] .. _join_link(opt.siteroot, opt.locale, pagepath .. ".html") .. [[">]] .. page.title .. "</a></li>\n"
            end
            sidebar = sidebar .. "</ul>\n"
        end

        for _, page in ipairs(db[opt.locale].pages) do
            _build_html_page(page.docdir, page.title, db, sidebar, opt)
        end
    end
    for _, htmlfile in ipairs(os.files(path.join(os.projectdir(), "doc", "*.html"))) do
        os.trycp(htmlfile, opt.outputdir)
        io.gsub(path.join(opt.outputdir, path.filename(htmlfile)), "%${siteroot}", opt.siteroot)
    end
    os.trycp(path.join(os.projectdir(), "resources", "*"), opt.outputdir)
end

function main()
    local outputdir = path.absolute(option.get("outputdir"))
    local siteroot = option.get("siteroot")
    if not siteroot:startswith("http") then
        siteroot = path.absolute(siteroot)
    end
    if #siteroot > 1 and siteroot:endswith("/") then
        siteroot = siteroot:sub(1, -2)
    end

    _build_html_pages({outputdir = outputdir, siteroot = siteroot})

    cprint("Generated document: ${bright}%s${clear}", outputdir)
    cprint("Siteroot: ${bright}%s${clear}", siteroot)
end
