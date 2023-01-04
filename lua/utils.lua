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

return M
