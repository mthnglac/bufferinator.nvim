# Bufferinator.nvim

> Epic, humorous, and modern buffer management plugin for Neovim — nuke, blast, or yeet your buffers with style!

---

## Features

- 🧨 Dynamic floating menu with border for buffer actions
- 🚀 Close hidden buffers, current buffer, all except current, or all buffers
- 🎛️ Easily overridable keymap and options (default: `<C-q>`)
- 🧩 Optionally disable built-in keymaps and use only the `:BufferinatorMenu` command
- 📝 LuaDoc-style API documentation & Neovim help file (`:help bufferinator`)
- 🧪 Automated tests with plenary.nvim
- 🪶 No runtime plugin dependencies (except for tests)
- ⚖️ MIT License

---

## Installation

**With [lazy.nvim](https://github.com/folke/lazy.nvim):**

```lua
{
  "mthnglac/bufferinator.nvim",
  config = function() require("bufferinator").setup() end -- or use `config = true`
}
```

---

## Configuration & Usage

```lua
require("bufferinator").setup({
  -- Default keymap to open the menu (normal mode)
  keymap = "<C-q>",

  -- Set to true to disable built-in keymaps
  -- Only use the :BufferinatorMenu command or your own keymap
  disable_keymaps = false,
})

-- Example: set your own keymap to open the menu via the command
-- vim.keymap.set("n", "<leader>bm", function() vim.cmd("BufferinatorMenu") end)
```

---

## Bufferinator Menu Options

1. Cancel the action
2. Close hidden buffers
3. Close current buffer
4. Close all buffers except current
5. Close all buffers (including current)

---

## Commands

- `:BufferinatorMenu` — Open the Bufferinator floating menu

---

## Documentation

- `:help bufferinator` for full help and usage details.

---

## License

MIT
