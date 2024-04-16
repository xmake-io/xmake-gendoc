add_rules("mode.debug", "mode.release")

add_requires("cmark 0.31.0", {alias = "libcmark"})

set_languages("c11")

target("cmark")
    add_rules("module.shared")
    add_packages("libcmark")
    add_files("cmark_module.c")
