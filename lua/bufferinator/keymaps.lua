--- Bufferinator keymap setup
-- @module bufferinator.keymaps

local M = {}

--- Setup Bufferinator keymaps
-- @param opts table Options table (expects 'keymap' key)
-- @param menu_open_fn function Function to call when keymap is triggered
function M.setup_keymaps(opts, menu_open_fn)
  local key = opts.keymap or "<C-q>"
  vim.keymap.set("n", key, menu_open_fn, {
    noremap = true,
    silent = true,
    desc = "Open Bufferinator menu",
  })
end

return M
