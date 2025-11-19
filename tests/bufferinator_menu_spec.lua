local menu = require("bufferinator.menu")
local bufferinator = require("bufferinator")

describe("Bufferinator Menu", function()
	before_each(function()
		bufferinator.setup()
	end)

	after_each(function()
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_is_loaded(buf) then
				vim.api.nvim_buf_delete(buf, { force = true })
			end
		end
	end)

	it("opens the floating menu without error", function()
		assert.has_no.errors(function()
			menu.open()
		end)
		vim.cmd("close")
	end)
end)
