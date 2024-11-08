add_moduledirs("modules")

task("gendoc")
    on_run("gendoc")
    set_menu {
        usage = "xmake gendoc [options] [arguments]",
        description = "Generate the xmake documents.",
        options = {
            {'o', "outputdir", "kv", "html", "Output html directory."},
            {'s', "siteroot",  "kv", "https://xmake.io", "Site root."}
        }
    }

task("opendoc")
    on_run("opendoc")
    set_menu {
        usage = "xmake opendoc [options] [arguments]",
        description = "Open the local xmake documents.",
        options = {
            {nil, "htmldir", "kv", "html", "The documents html directory."},
        }
    }

task("update-apis")
    on_run("update-apis")
    set_menu {
        usage = "xmake update-apis",
        description = "Create markdown files based on the new available apis in xmake.",
        options = nil
    }

