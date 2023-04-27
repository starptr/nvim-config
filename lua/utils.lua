local M = {}

function M.capture_stdout_from_shell(cmd)
  local handle = io.popen(cmd) -- os.execute crashes neovide; see https://github.com/neovide/neovide/issues/1376#issue-1289518816
  if handle == nil then
    error("Could not execute shell command")
  end
  local res = handle:read("*a")
  handle:close()
  return res
end

local function is_system_in_dark_mode()
  if vim.fn.has('macunix') == 1 then
    -- mac os
    local cmd = [[zsh -c 'defaults read -g AppleInterfaceStyle']]
    return M.capture_stdout_from_shell(cmd) == 'Dark\n'
  end

  error("Not implemented for current OS", 2)
end

-- This function usually retrieves a cached value which tells the caller whether
-- the system is in dark mode.
-- However, the first time it is called, the value calls the underlying functions
-- so that the correct value can be cached. Therefore, if the system theme
-- changes after this function is called for the first time, the value returned
-- will not match the system theme.
function M.is_dark_mode_cached()
  if vim.g.is_dark_mode_cached == nil then
    vim.g.is_dark_mode_cached = is_system_in_dark_mode()
  end
  return vim.g.is_dark_mode_cached
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


local valid_version_ids = {
  ['system@17.0.6-aarch64'] = true,
  ['system@11.0.18-aarch64'] = true,
  ['openjdk@1.11.0-2'] = true,
}
-- This function retrieves the path to a jdk version using jabba
function M.get_jdk_path_using_jabba(version_id)
  if vim.fn.has('macunix') ~= 1 then
    error("Not implemented for current OS", 2)
  end

  if valid_version_ids[version_id] == nil then
    error("Jdk version doesn't exist, or isn't explicitly listed in the table in nvim dotfiles' utils script.", 1)
  end

  local cmd = [[zsh -ic 'jabba which ]] .. version_id .. [[']]
  local res = M.capture_stdout_from_shell(cmd)
  local path_to_macos_wrapped_jdk = res:sub(1, -2) -- remove trailing newline
  return path_to_macos_wrapped_jdk .. [[/Contents/Home]]
end

return M
