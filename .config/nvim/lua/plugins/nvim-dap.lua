return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "wojciech-kulik/xcodebuild.nvim",
  },
  -- config = function()
  --   local codelldbPath = os.getenv("HOME") .. "/.local/lib/codelldb-darwin-arm64/extension/adapter/codelldb"
  --   require("xcodebuild.integrations.dap").setup(codelldbPath)
  -- end,
}
