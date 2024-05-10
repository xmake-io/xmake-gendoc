---
key: cprint
name: cprint
api: true
refer: cprintf, print
---

### cprint

#### Wrap color print terminal log

The behavior is similar to ${link print}, the difference is that this interface also supports color terminal output, and supports `emoji` character output.

E.g:

```lua
    ${link cprint}('${bright}hello xmake')
    ${link cprint}('${red}hello xmake')
    ${link cprint}('${bright green}hello ${clear}xmake')
    ${link cprint}('${blue onyellow underline}hello xmake${clear}')
    ${link cprint}('${red}hello ${magenta}xmake')
    ${link cprint}('${cyan}hello ${dim yellow}xmake')
```

The results are as follows:

![cprint_colors](https://tboox.org/static/img/xmake/cprint_colors.png)

The color-related descriptions are placed in `${ }`, and you can set several different properties at the same time, for example:

```
    ${bright red underline onyellow}
```

Indicates: highlighted red, background yellow, and with a down line

All of these descriptions will affect the entire entire line of characters. If you only want to display partial color text, you can insert `${clear}` at the end position to clear the previous color description.

E.g:

```
    ${red}hello ${clear}xmake
```

In this case, only hello is displayed in red, and the others are still normal black display.

Other colors belong to, I will not introduce them here, directly paste the list of attributes in the xmake code:

```lua
    colors.keys =
    {
        -- Attributes
      reset = 0 -- reset attribute
    , clear = 0 -- clear attribute
    , default = 0 -- default property
    , bright = 1 -- highlight
    , dim = 2 -- dark
    , underline = 4 -- underline
    , blink = 5 -- flashing
    , reverse = 7 -- reverse color
    , hidden = 8 -- hidden text

        -- Foreground
    , black = 30
    , red = 31
    , green = 32
    , yellow = 33
    , blue = 34
    , magenta = 35
    , cyan = 36
    , white = 37

        -- Background color
    , onblack = 40
    , onred = 41
    , ongreen = 42
    , onyellow = 43
    , onblue = 44
    , onmagenta = 45
    , oncyan = 46
    , onwhite = 47
```

In addition to color highlighting, if your terminal is under macosx, lion above the system, xmake can also support the display of emoji expressions, for systems that do not support
Ignore the display, for example:

```lua
    ${link cprint}("hello xmake${beer}")
    ${link cprint}("hello${ok_hand} xmake")
```

The above two lines of code, I printed a classic beer symbol in the homebrew, the following line printed an ok gesture symbol, is not very dazzling.

![cprint_emoji](https://tboox.org/static/img/xmake/cprint_emoji.png)

All emoji emoticons, as well as the corresponding keys in xmake, can be found in [emoji](http://www.emoji-cheat-sheet.com/).

Version 2.1.7 supports 24-bit true color output, if the terminal supports it:

```lua
${link import}("core.base.colors")
if colors.truecolor() then
    ${link cprint}("${255;0;0}hello")
    ${link cprint}("${on;255;0;0}hello${clear} xmake")
    ${link cprint}("${bright 255;0;0 underline}hello")
    ${link cprint}("${bright on;255;0;0 0;255;0}hello${clear} xmake")
end
```

Xmake's detection support for truecolor is implemented by the `$COLORTERM` environment variable. If your terminal supports truecolor, you can manually set this environment variable to tell xmake to enable truecolor support.

It can be enabled and tested with the following command:

```bash
$ export COLORTERM=truecolor
$ xmake --version
```

The 2.1.7 version can disable color output with `COLORTERM=nocolor`.
