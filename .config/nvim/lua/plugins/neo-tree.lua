return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      width = 30,
    },
    filesystem = {
      follow_current_file = {
        enabled = false,
        leave_dirs_open = false,
      },
    },
  },
  keys = {
    {
      "<leader>+",
      ":Neotree reveal<CR>",
      desc = "Reveal in Neotree",
    },
  },
}
