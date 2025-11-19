--- Bufferinator.nvim main module
-- @module bufferinator

local menu = require("bufferinator.menu")
local keymaps = require("bufferinator.keymaps")
local commands = require("bufferinator.commands")

local default_opts = {
	keymap = "<C-q>",
	disable_keymaps = false,
}

local M = {}

--- Setup Bufferinator.nvim
-- @param opts table|nil Optional table of options:
--   - keymap (string): Keymap to open the menu (default: "<C-q>")
--   - disable_keymaps (boolean): If true, built-in keymaps are not set
function M.setup(opts)
	opts = vim.tbl_deep_extend("force", {}, default_opts, opts or {})
	if not opts.disable_keymaps then
		keymaps.setup_keymaps(opts, menu.open)
	end
	commands.setup_commands()
end

return M
