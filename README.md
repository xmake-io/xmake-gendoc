# xmake-gendoc

This repository contains xmake's documentation (work in progress) and a [script](build.lua) that generates a static HTML website from it.

## How to build

### Local test

To generate the pages, you need to call the following command in this repository root:

```bash
$ xmake gendoc -s ./html
```

If you specify the same absolute path for both the -o (--output) and -s options, you can easily test the links in local in your browser without the need to setup a server.
ie.:

```bash
$ xmake gendoc -o C:/Users/Me/Desktop/xmakedoc -s C:/Users/Me/Desktop/xmakedoc
```

Open the generated html page to test it.

```bash
$ xmake opendoc
```

### Deploy release site

```bash
$ xmake gendoc
$ open https://xmake.io
```

The pages will be linked with each other by using absolute URLs. The default URL base is `https://xmake.io`. It can be changed by using the -s (--siteroot) option.
ie.:

```bash
$ xmake gendoc -s https://my-xmake-fork.com
```

## How to contribute

Each page on the generated site is built by concatenating rendered markdown files.

The pages are defined in [doc/en-us/pages.lua](doc/en-us/pages.lua) (for american english pages). The pages are groupped by category, so that they are easily distinguished in the site left sidebar.

A page is defined by a path (where the html file will be generated), a title (the page's tab title and displayed name in the site left sidebar), and a docdir. The docdir is the path to the directory that contains the markdown files used to fill the page's content. The paths are relative to the localization directory. For american english, docdir is relative to `doc/en-us`.

Localization directories can be added, they will automatically be discovered and added to the generated site on build.
Localization directories are completely independent from each other.

### API description

In order to add an API documentation to a page, you can copy the [template](doc/template.md) file to a page's docdir and rename it. The markdown's file name is important, as it determines the order in which the files are concatenated in the page.

Next, you need to set this API a unique key in the file header/metadata. This key will be used to generate links from other API documentations or pages to this API. For the link to work, an anchor must be defined with the `${anchor:key}` value in the markdown file.

Then, you should change the `name` metadata. This name is what will be used as replacement text when generating a link for this API.

Links are defined with the `${link:key}` value in a markdown file.

---

Although partially obsolete, more information can be found [here](https://github.com/xmake-io/xmake/pull/4969).
