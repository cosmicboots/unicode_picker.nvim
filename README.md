# unicode_picker.nvim

A Unicode picker for [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim).

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
    "cosmicboots/unicode_picker.nvim",
    dependencies = {
        "uga-rosa/utf8.nvim",
        "nvim-telescope/telescope.nvim",
    },
}
```

Using [packer.nvim](https://github.com/wbthomason/packer.nvim):
```lua
use {
    "cosmicboots/unicode_picker.nvim",
    requires = {
        "uga-rosa/utf8.nvim",
        "nvim-telescope/telescope.nvim",
    },
}
```

## Usage

There are currently two ways to activate the Unicode character picker:

1. Through the `:Telescope unicode_picker` command
2. Through the Lua interface

A simple keybind to activate the picker via the Lua interface could look like
the following:

```lua
local unicode_picker = require("unicode_picker")
unicode_picker.setup()
vim.keymap.set("i", "<C-j>", unicode_picker.unicode_chars, {})
```

### Digraph Support

The drop-down picker will attempt to show vim
[digraphs](https://neovim.io/doc/user/digraph.html) alongside their Unicode
representation.

For example, the for all symbol (∀) uses the `FA` digraph:

```
1   _⤶
~   ╭────────────────────────── Pick a unicode character ──────────────────────────╮
~   │> forall|                                                          380 / 29974│
~   ├──────────────────────────────────────────────────────────────────────────────┤
~   │> [∀] (FA): 2200 FOR ALL universal quantifier                                 │
~   │  [䷈]: 4DC8 HEXAGRAM FOR SMALL TAMING                                         │
~   │  [䷽]: 4DFD HEXAGRAM FOR SMALL PREPONDERANCE                                  │
~   │  [ᴰ]: 1D30  TETRAGRAM FOR KEEPING SMALL                                      │
~   │  [ὒ]: 1F52  INPUT SYMBOL FOR LATIN SMALL LETTERS                             │
~   ╰──────────────────────────────────────────────────────────────────────────────╯
```
