--- Bufferinator menu module
-- @module bufferinator.menu
local actions = require("bufferinator.actions")

local M = {}

--- Open the Bufferinator floating menu.
-- Shows buffer management options in a floating window.
function M.open()
	local menu = {
		{
			desc = "Cancel the action",
			action = function()
				vim.notify("Cancelled", vim.log.levels.INFO)
			end,
		},
		{ desc = "Close hidden buffers", action = actions.close_hidden_buffers },
		{ desc = "Close current buffer", action = actions.close_current_buffer },
		{ desc = "Close all buffers except current", action = actions.close_other_buffers },
		{ desc = "Close all buffers (including current)", action = actions.close_all_buffers },
	}

	local lines = {
		"Select action:",
		"1: " .. menu[1].desc,
		"2: " .. menu[2].desc,
		"3: " .. menu[3].desc,
		"4: " .. menu[4].desc,
		"5: " .. menu[5].desc,
		"",
		"Press number or q/Esc/Ctrl+C to cancel",
	}

	local width = 0
	for _, line in ipairs(lines) do
		width = math.max(width, #line)
	end
	width = width + 4

	local height = #lines + 2

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].modifiable = false
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].swapfile = false

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = math.floor((vim.o.lines - height) / 2),
		col = math.floor((vim.o.columns - width) / 2),
		style = "minimal",
		border = "rounded",
		zindex = 1000,
	})

	local function close_menu()
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end
	end

	for i = 1, #menu do
		vim.keymap.set("n", tostring(i), function()
			close_menu()
			menu[i].action()
		end, { buffer = buf, nowait = true, noremap = true, silent = true })
	end
	vim.keymap.set("n", "q", close_menu, { buffer = buf, nowait = true, noremap = true, silent = true })
	vim.keymap.set("n", "<Esc>", close_menu, { buffer = buf, nowait = true, noremap = true, silent = true })
	vim.keymap.set("n", "<C-c>", close_menu, { buffer = buf, nowait = true, noremap = true, silent = true })

	vim.cmd("normal! gg")
end

return M
