add_rules("mode.debug", "mode.release")

add_requires("md4c")

set_languages("c11")

target("md4c")
    add_rules("module.shared")
    add_packages("md4c")
    add_files("*.c")
