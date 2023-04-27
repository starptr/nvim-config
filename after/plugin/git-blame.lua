vim.g.gitblame_highlight_group = "GitBlame"

vim.api.nvim_set_hl(0, 'GitBlame', { fg = "#888888", bg = "NONE" })

vim.g.gitblame_message_template = '<author> • <date> • <summary>'
vim.g.gitblame_date_format = '%x %H:%M'
