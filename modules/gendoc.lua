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
import("plugins.show.lists.apis", {rootdir = os.programdir()})
import("shared.md4c")

function _load_apimetadata(filecontent, opt)
    opt = opt or {}
    local content = {}
    local apimetadata = {}
    local ismeta = false
    for idx, line in ipairs(filecontent:split("\n", {strict = true})) do
        if idx == 1 then
            local _, _, includepath = line:find("${include (.+)}")
            if includepath then
                local apientrydata = io.readfile(path.join(os.projectdir(), "doc", opt.locale, includepath))
                local apimetadata, content = _load_apimetadata(apientrydata, opt)
                local isinclude = true
                return apimetadata, content, isinclude
            elseif idx == 1 and line == "---" then
                ismeta = true
            end
        elseif ismeta then
            if line == "---" then
                ismeta = false
            else
                local key, value = line:match("(.+): (.+)")
                apimetadata[key] = value
            end
        else
            table.insert(content, line)
        end
    end
    if apimetadata.api then
        local api = apimetadata.api
        if api ~= "true" and api ~= "false" then
            for idx, line in ipairs(content) do
                if line:startswith("### ") then
                    table.insert(content, idx + 1, "`" .. api .. "`")
                    break
                end
            end
        end
    end
    if apimetadata.version then
        local names = {
            ["en-us"] = "Introduced in version",
            ["zh-cn"] = "被引入的版本"
        }
        local name = names[opt.locale]
        if name then
            table.insert(content, "#### " .. name .. " " .. apimetadata.version)
        end
    end
    if apimetadata.refer then
        local names = {
            ["en-us"] = "See also",
            ["zh-cn"] = "参考"
        }
        local name = names[opt.locale]
        if name then
            table.insert(content, "#### " .. name)
            local refers = {}
            for _, line in ipairs(apimetadata.refer:split(",%s+")) do
                table.insert(refers, "${link " .. line .. "}")
            end
            table.insert(content, table.concat(refers, ", "))
        end
    end
    return apimetadata, table.concat(content, "\n")
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
                    local apimetadata, _, isinclude = _load_apimetadata(apientrydata, {locale = locale})
                    if apimetadata.key and not isinclude then
                        assert(db[locale].apis[apimetadata.key] == nil, "keys must be unique (\"" .. apimetadata.key .. "\" was already inserted) (" .. apientryfile .. ")")
                        db[locale].apis[apimetadata.key] = apimetadata
                        db[locale].apis[apimetadata.key].page = page
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

function _make_anchor(db, key, locale, siteroot, text)
    assert(db and key and locale and siteroot and db[locale])
    if db[locale].apis[key] then
        text = text or db[locale].apis[key].name
        return [[<a href="]] .. _join_link(siteroot, locale, db[locale].apis[key].page.docdir .. ".html") .. '#' .. db[locale].apis[key].key .. [[" id="]] .. db[locale].apis[key].key .. [[">]] .. text .. [[</a>]]
    else
        text = text or key
        return [[<s>]] .. text .. [[</s>]]
    end
end

function _make_link(db, key, locale, siteroot, text)
    assert(db and key and locale and siteroot and db[locale])
    if db[locale].apis[key] then
        text = text or db[locale].apis[key].name
        return [[<a href="]] .. _join_link(siteroot, locale, db[locale].apis[key].page.docdir .. ".html") .. '#' .. db[locale].apis[key].key .. [[">]] .. text .. [[</a>]]
    else
        text = text or key
        return [[<s>]] .. text .. [[</s>]]
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

function _write_api(sitemap, db, locale, siteroot, apimetalist, apientrydata)
    local apimetadata, content = _load_apimetadata(apientrydata, {locale = locale})
    assert(apimetadata.api ~= nil, "entry api is nil value")
    assert(apimetadata.key ~= nil, "entry key is nil value")
    assert(apimetadata.name ~= nil, "entry name is nil value")
    table.insert(apimetalist, apimetadata)
    vprint("apimetadata", apimetadata)

    content = content:gsub("\n### " .. apimetadata.key .. "\n", "\n### " .. _make_anchor(db, apimetadata.key, locale, siteroot) .. "\n")

    -- TODO auto generate links
    -- do not match is_arch before matching os.is_arch
    -- local orderedapikeys = table.orderkeys(db[locale].apis, function(lhs, rhs) return #lhs > #rhs end)
    -- for _, key in ipairs(orderedapikeys) do
    --     local api = db[locale].apis[key]
    -- end

    local htmldata, errors = md4c.md2html(content)
    assert(htmldata, errors)

    local findstart, findend
    repeat
        local anchor
        findstart, findend, anchor = htmldata:find("%${anchor ([^%s${%}]+)}")
        if findstart == nil then break end

        htmldata = htmldata:gsub("%${anchor [^%s${%}]+}", _make_anchor(db, anchor, locale, siteroot), 1)
    until not findstart
    repeat
        local anchor, text
        findstart, findend, anchor, text = htmldata:find("%${anchor ([^%s${%}]+) ([^${%}]+)}")
        if findstart == nil then break end

        htmldata = htmldata:gsub("%${anchor [^%s${%}]+ [^${%}]+}", _make_anchor(db, anchor, locale, siteroot, text), 1)
    until not findstart
    repeat
        local link
        findstart, findend, link = htmldata:find("%${link ([^%s${%}]+)}")
        if findstart == nil then break end

        htmldata = htmldata:gsub("%${link [^%s${%}]+}", _make_link(db, link, locale, siteroot), 1)
    until not findstart
    repeat
        local link, text
        findstart, findend, link, text = htmldata:find("%${link ([^%s${%}]+) ([^%{%}]+)}")
        if findstart == nil then break end

        htmldata = htmldata:gsub("%${link [^%s${%}]+ [^%{%}]+}", _make_link(db, link, locale, siteroot, text), 1)
    until not findstart

    sitemap:write(htmldata)
end

function _write_table_of_content(sitemap, db, locale, siteroot, apimetalist)
    local names = {
        ["en-us"] = "Interfaces",
        ["zh-cn"] = "接口"
    }
    local interfaces = names[locale]
    sitemap:write(string.format([[
<div id="toc">
<table>
    <thead>
        <tr><td>%s</td></tr>
    </thead>
    <tbody id="toc-body">]] .. "\n", interfaces))

        for _, apimetadata in ipairs(apimetalist) do
            if apimetadata.api then
                sitemap:write("        <tr><td>" .. _make_link(db, apimetadata.key, locale, siteroot) .. "</td></tr>\n")
            end
        end

        sitemap:write([[
    </tbody>
</table>
</div>]])
end

function _write_footer(sitemap, siteroot, jssearcharray)
    sitemap:write(string.format("\n" .. [[
<script src="%s/prism.js"></script>
<script src="https://cdn.jsdelivr.net/npm/minisearch@6.3.0/dist/umd/index.min.js"></script>
<script type="text/javascript">
const documents = [
]] .. jssearcharray .. [[
]

let miniSearch = new MiniSearch({
    fields: ['key', 'name'],
    storeFields: ['key', 'name', 'url'],
    searchOptions: {
        boost: { name: 2 },
        prefix: true,
        fuzzy: 0.4
    }
})

miniSearch.addAll(documents)

function changeSearch(input) {
    var result = ""

    var found = miniSearch.search(input)

    found.forEach((e) => {
        result = result + "<tr><td><a href='" + e.url + "#" + e.key + "'>" + e.name + "</a></td></tr>"
    })

    document.getElementById("search-table-body").innerHTML = result
}
</script>
<script type="text/javascript">
function locationHashChanged(e)
{
    var tocLinks = document.getElementById("toc-body").getElementsByTagName("a")
    for(let i = 0;i < tocLinks.length; i++)
    {
        if (tocLinks[i].href == window.location.href)
        {
            tocLinks[i].style = "font-weight:bold"
            tocLinks[i].parentElement.style = "background-color:#d6ffed"
        }
        else
        {
            tocLinks[i].style = ""
            tocLinks[i].parentElement.style = ""
        }
    }
}
window.onhashchange = locationHashChanged;
locationHashChanged({})
</script>
</body>
</html>
]], siteroot))
end

function _build_html_page(docdir, title, db, sidebar, jssearcharray, opt)
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
    sitemap:write([[
<input type="search" id="search-input" placeholder="search" name="search" oninput="changeSearch(this.value);">
<table><tbody id="search-table-body"></tbody></table>
]])
    sitemap:write('</div>\n')

    sitemap:write('<div id="content">\n')
    local isfirst = true
    local apimetalist = {}
    local docroot = path.join(os.projectdir(), "doc", locale)
    local files = {}
    for _, file in ipairs(os.files(path.join(docroot, docdir, "*.md"))) do
        local filename = path.filename(file)
        if not filename:startswith("_") then
            if filename == "0_intro.md" then
                table.insert(files, 1, file)
            else
                table.insert(files, file)
            end
        end
    end
    for _, file in ipairs(files) do
        if isfirst then
            isfirst = false
        else
            sitemap:write("<hr />")
        end
        vprint("loading " .. file)
        local apientrydata = io.readfile(file)
        _write_api(sitemap, db, locale, siteroot, apimetalist, apientrydata)
    end
    sitemap:write("</div>\n")
    if not isindex then
        _write_table_of_content(sitemap, db, locale, siteroot, apimetalist)
    end
    _write_footer(sitemap, siteroot, jssearcharray)
    sitemap:close()
end

function _make_search_array(db, opt)
    local jssearcharray = ""
    local odreredapikeys = table.orderkeys(db[opt.locale].apis)
    local id = 1
    for _, apikey in ipairs(odreredapikeys) do
        local api = db[opt.locale].apis[apikey]
        if api.api ~= "false" then
            jssearcharray = jssearcharray .. "    {id: " .. tostring(id) .. ", key: \"" .. api.key .. "\", name: \"" .. api.name .. "\", url: \"" .. _join_link(opt.siteroot, opt.locale, api.page.docdir) .. ".html\" },\n"
            id = id + 1
        end
    end
    return jssearcharray:gsub("\\", "/")
end

function _build_html_pages(opt)
    opt = opt or {}
    os.tryrm(opt.outputdir)
    local db = _make_db()
    for _, pagefile in ipairs(os.files(path.join(os.projectdir(), "doc", "*", "pages.lua"))) do
        opt.locale = path.basename(path.directory(pagefile))
        local jssearcharray = _make_search_array(db, opt)
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
            _build_html_page(page.docdir, page.title, db, sidebar, jssearcharray, opt)
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
        siteroot = "file://" .. path.absolute(siteroot)
    end
    if #siteroot > 1 and siteroot:endswith("/") then
        siteroot = siteroot:sub(1, -2)
    end

    _build_html_pages({outputdir = outputdir, siteroot = siteroot})

    cprint("Generated document: ${bright}%s${clear}", outputdir)
    cprint("Siteroot: ${bright}%s${clear}", siteroot)
end
