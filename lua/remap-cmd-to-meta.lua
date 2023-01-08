-- XXX: add the "TextChangedT" event to the list of events. Blocked by https://github.com/neovim/neovim/issues/21685
vim.api.nvim_create_autocmd("TextChangedI", {
  group = vim.api.nvim_create_augroup('NeovideCaptureSuperWorkaround', { clear = true }),
  callback = function()
    -- Get the last 5 or 7 characters
    local _, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()
    local maybe_super = line:sub(col-4, col) -- capture something like <D-a>
    local maybe_shifted_super = line:sub(col-6, col) -- captures something like <S-D-a>

    -- Check if the last 5 or 7 characters are super combos
    local super_pattern = "<D%-.>"
    local shifted_super_pattern = "<S%-D%-.>"
    if string.match(maybe_super, super_pattern) then
      -- Old attempts to construct the keycode input
      -- local seq = vim.api.nvim_eval([["\<M-]] .. maybe_super:sub(4,4) .. [[>"]]) -- works but uses nvim_eval
      -- local seq = [[<M-]] .. maybe_super:sub(4,4) .. [[>]] -- does not work

      -- Delete the existing text, and send meta keycode
      local seq = vim.api.nvim_replace_termcodes(string.rep("<BS>", 5) .. [[<M-]] .. maybe_super:sub(4,4) .. [[>]], true, false, true)
      -- from docs: 3rd arg should be false if using `nvim_replace_termcodes`
      vim.api.nvim_feedkeys(seq, 'm', false)
    elseif string.match(maybe_shifted_super, shifted_super_pattern) then
      -- branch = 2
      local seq = vim.api.nvim_replace_termcodes(string.rep("<BS>", 7) .. [[<S-M-]] .. maybe_shifted_super:sub(6,6) .. [[>]], true, false, true)
      vim.api.nvim_feedkeys(seq, 'm', false)
    end
    -- Debug info
    -- local char = line:sub(col, col)
    -- print(line .. ':::' .. char .. ':::' .. maybe_super .. ':::' .. maybe_shifted_super)
  end,
})

-- Shifted maps are untested
-- vim.api.nvim_set_keymap('', '<S-D-A>', '<S-M-A>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<S-D-B>', '<S-M-B>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<S-D-C>', '<S-M-C>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<S-D-D>', '<S-M-D>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<S-D-E>', '<S-M-E>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<S-D-F>', '<S-M-F>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<S-D-G>', '<S-M-G>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<S-D-H>', '<S-M-H>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<S-D-I>', '<S-M-I>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<S-D-J>', '<S-M-J>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<S-D-K>', '<S-M-K>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<S-D-L>', '<S-M-L>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<S-D-M>', '<S-M-M>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<S-D-N>', '<S-M-N>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<S-D-O>', '<S-M-O>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<S-D-P>', '<S-M-P>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<S-D-Q>', '<S-M-Q>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<S-D-R>', '<S-M-R>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<S-D-S>', '<S-M-S>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<S-D-T>', '<S-M-T>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<S-D-U>', '<S-M-U>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<S-D-V>', '<S-M-V>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<S-D-W>', '<S-M-W>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<S-D-X>', '<S-M-X>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<S-D-Y>', '<S-M-Y>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<S-D-Z>', '<S-M-Z>', { desc = "Remap cmd to alt" })
-- 
-- vim.api.nvim_set_keymap('', '<D-A>', '<M-A>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-B>', '<M-B>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-C>', '<M-C>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-D>', '<M-D>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-E>', '<M-E>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-F>', '<M-F>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-G>', '<M-G>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-H>', '<M-H>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-I>', '<M-I>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-J>', '<M-J>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-K>', '<M-K>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-L>', '<M-L>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-M>', '<M-M>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-N>', '<M-N>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-O>', '<M-O>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-P>', '<M-P>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-Q>', '<M-Q>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-R>', '<M-R>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-S>', '<M-S>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-T>', '<M-T>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-U>', '<M-U>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-V>', '<M-V>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-W>', '<M-W>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-X>', '<M-X>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-Y>', '<M-Y>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-Z>', '<M-Z>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-1>', '<M-1>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-2>', '<M-2>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-3>', '<M-3>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-4>', '<M-4>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-5>', '<M-5>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-6>', '<M-6>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-7>', '<M-7>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-8>', '<M-8>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-9>', '<M-9>', { desc = "Remap cmd to alt" })
-- vim.api.nvim_set_keymap('', '<D-0>', '<M-0>', { desc = "Remap cmd to alt" })


-- Space,     mods: Control,   chars: "\x00"                        } # Ctrl + Space
-- Grave,     mods: Alt,       chars: "\x1b`"                       } # Alt + `
-- Grave,     mods: Alt|Shift, chars: "\x1b~"                       } # Alt + ~
-- Period,    mods: Alt,       chars: "\x1b."                       } # Alt + .
-- Key8,      mods: Alt|Shift, chars: "\x1b*"                       } # Alt + *
-- Key3,      mods: Alt|Shift, chars: "\x1b#"                       } # Alt + #
-- Period,    mods: Alt|Shift, chars: "\x1b>"                       } # Alt + >
-- Comma,     mods: Alt|Shift, chars: "\x1b<"                       } # Alt + <
-- Minus,     mods: Alt|Shift, chars: "\x1b_"                       } # Alt + _
-- Key5,      mods: Alt|Shift, chars: "\x1b%"                       } # Alt + %
-- Key6,      mods: Alt|Shift, chars: "\x1b^"                       } # Alt + ^
-- Backslash, mods: Alt,       chars: "\x1b\\"                      } # Alt + \
-- Backslash, mods: Alt|Shift, chars: "\x1b|"                       } # Alt + |
