return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      sourcekit = {},
      gdscript = {
        cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
        root_dir = function(fname)
          return require("lspconfig.util").root_pattern("project.godot", ".git")(fname)
        end,
        single_file_support = false,
      },
    },
  },
}
