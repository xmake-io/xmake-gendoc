add_moduledirs("modules")

task("gendoc")
    on_run("gendoc")
    set_menu {
        usage = "xmake gendoc [options] [arguments]",
        description = "Generate the xmake documents.",
        options = {
            {'o', "outputdir",   "kv", nil, "Output html directory. (default is ./html)"},
            {'s', "siteroot", "kv", nil, "Site root. (default is https://xmake.io)"}
        }
    }

