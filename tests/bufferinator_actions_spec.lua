local bufferinator = require("bufferinator")
local actions = require("bufferinator.actions")

describe("Bufferinator Actions", function()
	before_each(function()
    bufferinator.setup()

		vim.cmd("enew")
		vim.cmd("enew")
		vim.cmd("enew")
	end)

	after_each(function()
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_is_loaded(buf) then
				vim.api.nvim_buf_delete(buf, { force = true })
			end
		end
	end)

	it("closes hidden buffers", function()
		local current_buf = vim.api.nvim_get_current_buf()
		vim.cmd("enew")
		vim.cmd("bprevious")
		actions.close_hidden_buffers()

		local bufs = vim.api.nvim_list_bufs()
		local loaded = vim.tbl_filter(function(b)
			return vim.api.nvim_buf_is_loaded(b)
		end, bufs)
		assert.are.same({ current_buf }, loaded)
	end)

	it("closes other buffers", function()
		local current_buf = vim.api.nvim_get_current_buf()
		actions.close_other_buffers()
		local bufs = vim.api.nvim_list_bufs()
		local loaded = vim.tbl_filter(function(b)
			return vim.api.nvim_buf_is_loaded(b)
		end, bufs)
		assert.are.same({ current_buf }, loaded)
	end)

	it("closes all buffers", function()
		actions.close_all_buffers()
		local bufs = vim.api.nvim_list_bufs()
		local loaded = vim.tbl_filter(function(b)
			return vim.api.nvim_buf_is_loaded(b)
		end, bufs)
		assert.is_true(#loaded == 1)
		local name = vim.api.nvim_buf_get_name(loaded[1])
		assert.is_true(name == "")
	end)
end)
