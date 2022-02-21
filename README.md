# Poiekolon

_ποίηκώλον_ - from Classical Greek _ποιέω poiéo_ - to make, and _κῶλον kôlon_ - a part or, in rhetoric and
poetry, a section of a complete thought or passage.

A very configurable neovim plugin to add or toggle a char at the end of a line.

## Usage

Requires neovim > 0.5.0

### Install

Use with whatever favoured package manager. Masochists may be inclined to git clone directly into vim.fn.stdpath("data").

### Configuration

No keymaps are setup by default. Use `autokeys` or `maps` to set up any desired keybinds.

Default is:

<!--{ "lua/poiekolon/config.lua" | match: "M.default\s*?=\s*?(\{[\s\S]*?\n\})" 1 | code: Lua }-->
```Lua
{
    default_mode = "add", -- add, force, or toggle. Add "newline" to add a newline after.
    auto_indent_after_newline = true, -- matches indent of current line
    prefix = "<localleader>", -- prefix for autokeys
    autokeys = {}, -- chars to be automatically setup for hotkeys. See 'Autokeys' in README.md for more info
    maps = {}, -- See 'Maps' in README.md for more info
}
```
<!--{ end }-->

Call setup like so to use all the defaults.

```Lua
require("poiekolon").setup()
```

Call setup with one option to override just that one option.

```Lua
require("poiekolon").setup({ default_mode = "toggle" })
```

For users of init.vim, wrap all of that in a lua block like so:

```vim
lua <<< EOF
require("poiekolon").setup({ default_mode = "toggle" })
EOF
```

#### Available functions

The available functions are:

<!--{ "doc/poiekolon.txt" | match: "Functions\s*?are:\s*?\n>([\s\S]*?\n)<" 1 | code }-->
```

    do_default              -> Invoke configured default action with <char> (default: add_char)
    add_char                -> Add <char> to the end of the line unless it exists.
    force_add_char          -> Add <char> to the end of the line even if it exists.
    toggle_char             -> Toggle <char> at the end of the line.
    add_char_newline        -> Add <char> to the end of the line unless it exists, and add a newline after.
    force_add_char_newline  -> Add <char> to the end of the line even if it exists, and add a newline after.
    toggle_char_newline     -> Toggle <char> at the end of the line, and add a newline after.

```
<!--{ end }-->

### Keybinds

#### Autokeys

config.autokeys should be a table of characters to be added at the end of the line. For each character,
the following keys will be setup:

```
<prefix><char>     -> do_default
<prefix>a<char>    -> add_char
<prefix>f<char>    -> force_add_char
<prefix>t<char>    -> toggle_char
<prefix>A<char>    -> add_char_newline
<prefix>F<char>    -> force_add_char_newline
<prefix>T<char>    -> toggle_char_newline
```

Doing this:

```Lua
require("poiekolon").setup({ autokeys = {";"} })
```

Will result in normal mode keybinds: `<localleader>;` will do the configured default, `<localleader>a;` will add ; to the end of the current line, and `<localleader>T;`
will toggle ; at the end of the line and move to a new line, etc.

#### Maps

To setup custom keymaps, config.maps can be used.

```Lua
require("poiekolon").setup({
    maps = {
        i = { -- the mode desired, same mode as vim's map command, i.e. n = normal, v = visual/select, i = insert
            {
                key = "<C-\\>", -- key to be mapped
                char = ";", -- char to be used
                func = "add_char", -- function to be used
            },
            { -- another one
                key = "<C-l>",
                char = ";",
                func = "add_char_newline",
            },
        },
    },
})
```

Or just do it completely manually:

```Lua
vim.api.nvim_set_keymap("n", "<leader>;", "<CMD>lua require('poiekolon').add_char(';')<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("i", "<C-\\>", "<CMD>lua require('poiekolon').add_char(';')<CR>", { silent = true, noremap = true })
```

### Commands

There is also a `:Poiekolon` command. It takes arguments `function` and `char` like `:Poiekolon add_char ;` or `:Poiekolon toggle_char ,`. See `:help :Poiekolon` for in vim help.

## Known Issues

- \<C-CR\> or \<S-CR\> cannot be mapped as in the VSCode extension colonize. This is a vim/terminal limitation. 😓

## Inspiration

My goal was basically to combine functionality from these plugins:

- [vmsynkov-zz/colonize](https://github.com/vmsynkov-zz/colonize) - VS Code extension to add ; with Shift/Ctrl + Enter
- [saifulapm/chartoggle.nvim](https://github.com/saifulapm/chartoggle.nvim) - Neovim plugin to toggle char at the end of
  a line.
