vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

require('neo-tree').setup {
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
    },
  },
}
