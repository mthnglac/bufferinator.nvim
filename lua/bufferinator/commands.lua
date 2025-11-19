--- Bufferinator command setup
-- @module bufferinator.commands

local menu = require("bufferinator.menu")

local M = {}

--- Setup Bufferinator user commands
-- Defines :BufferinatorMenu command to open the menu.
function M.setup_commands()
  vim.api.nvim_create_user_command("BufferinatorMenu", function()
    menu.open()
  end, { desc = "Open Bufferinator menu" })
end

return M
