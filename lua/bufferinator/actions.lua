--- Bufferinator buffer actions
-- @module bufferinator.actions

local M = {}

--- Close all hidden buffers except the current one.
function M.close_hidden_buffers()
  local current_buf = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current_buf and vim.api.nvim_buf_is_loaded(buf) and vim.fn.bufwinnr(buf) == -1 then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
  vim.notify("Hidden buffers closed", vim.log.levels.INFO)
end

--- Close all buffers except the current one.
function M.close_other_buffers()
  local current_buf = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current_buf and vim.api.nvim_buf_is_loaded(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
  vim.notify("Other buffers closed", vim.log.levels.INFO)
end

--- Close all buffers, including the current one.
function M.close_all_buffers()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
  vim.notify("All buffers closed", vim.log.levels.INFO)
end

--- Close the current buffer.
function M.close_current_buffer()
  vim.cmd("bd")
  vim.notify("Current buffer closed", vim.log.levels.INFO)
end

return M
