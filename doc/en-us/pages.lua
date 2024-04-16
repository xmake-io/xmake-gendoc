function main()
    return {
        {
            title = "index",
            pages = {
                {
                    path = "index.html",
                    docdir = ".",
                    title = "index",
                },
            },
        },
        {
            title = "API Manual (Description Scope)", -- "API手册（描述域）",
            pages = {
                {
                    path = "api/conditions.html",
                    docdir = "api/conditions",
                    title = "Conditions",
                },
                {
                    path = "api/builtin_modules/exceptions.html",
                    docdir = "api/builtin_modules/exceptions",
                    title = "Exceptions",
                },
                {
                    path = "api/builtin_modules/os.html",
                    docdir = "api/builtin_modules/os",
                    title = "os",
                },
            },
        },
    }
end
