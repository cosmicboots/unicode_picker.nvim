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
        "uga-rosa/utf8.nvim"
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
vim.keymap.set("i", "<C-j>", unicode_picker.unicode_chars, {})
```
