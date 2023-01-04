local M = {}

function M.is_system_in_dark_mode()
  if vim.fn.has('macunix') == 1 then
    -- mac os
    local cmd = 'defaults read -g AppleInterfaceStyle'
    local exit_code = os.execute(cmd) -- will succeed on Dark mode
    return exit_code == 0
  else
    error("Not implemented for current OS", 2)
  end
end

return M
