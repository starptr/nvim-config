local M = {}

function M.is_system_in_dark_mode()
  if vim.fn.has('macunix') == 1 then
    -- mac os
    local cmd = [[zsh -c 'defaults read -g AppleInterfaceStyle']]
    local handle = io.popen(cmd) -- os.execute crashes neovide; see https://github.com/neovide/neovide/issues/1376#issue-1289518816
    if handle == nil then
      error("Could not execute shell command", 2)
    end
    local res = handle:read("*a")
    handle:close()
    return res == 'Dark\n'
  end

  error("Not implemented for current OS", 2)
end

-- This function taken from LunarVim.
-- Strategy for choosing formatter:
-- 1. If null-ls is available, always choose that formatter
--   - This is because traditional formatters are usually very high quality
-- 2. Otherwise, allow any (all?) lsp servers that supports the lsp format method
-- @param client table a client attached to the buffer
-- @return boolean whether the client should format
function M.format_filter(client)
  local null_ls = require('null-ls')
  local null_ls_sources = require('null-ls.sources')
  local format_method = null_ls.methods.FORMATTING
  local avail_formatters = null_ls_sources.get_available(vim.bo.filetype, format_method)

  -- Use null-ls if available
  if #avail_formatters > 0 then
    return client.name == 'null-ls'
  end

  -- Use any / all lsp servers that support formatting
  return client.supports_method 'textDocument/formatting'
end

function M.format(opts)
  opts = opts or {}
  opts.filter = opts.filter or M.format_filter
  return vim.lsp.buf.format(opts)
end

return M
