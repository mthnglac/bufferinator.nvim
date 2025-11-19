local bufferinator = require("bufferinator")
local menu = require("bufferinator.menu")
local commands = require("bufferinator.commands")

describe("Bufferinator Integration", function()
	after_each(function()
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_is_loaded(buf) then
				vim.api.nvim_buf_delete(buf, { force = true })
			end
		end
	end)

	it("opens menu with custom keymap (direct call)", function()
		bufferinator.setup({ keymap = "<leader>bn" })
		assert.has_no.errors(function()
			menu.open()
		end)
		vim.cmd("close")
	end)

	it("opens menu with :BufferinatorMenu command", function()
		bufferinator.setup()
		commands.setup_commands()
		assert.has_no.errors(function()
			vim.cmd("BufferinatorMenu")
		end)
		vim.cmd("close")
	end)

	it("does not set keymaps when disable_keymaps is true", function()
		bufferinator.setup({ disable_keymaps = true })
		local keymaps_list = vim.api.nvim_get_keymap("n")
		local found = false
		for _, map in ipairs(keymaps_list) do
			if map.lhs == "<C-q>" then
				found = true
			end
		end
		assert.is_false(found)
	end)

	it("allows user to set their own keymap", function()
		bufferinator.setup({ disable_keymaps = true })
		vim.keymap.set("n", "<leader>bm", function()
			vim.cmd("BufferinatorMenu")
		end)
		assert.has_no.errors(function()
			vim.cmd("BufferinatorMenu")
		end)
		vim.cmd("close")
	end)

	it("does not error when no buffers are open", function()
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_is_loaded(buf) then
				vim.api.nvim_buf_delete(buf, { force = true })
			end
		end
		assert.has_no.errors(function()
			menu.open()
		end)
		vim.cmd("close")
	end)
end)
