return {
  "wojciech-kulik/xcodebuild.nvim",
  -- dir = "/Users/terje/Development/xcodebuild.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("xcodebuild").setup({
      integrations = {
        xcodebuild_offline = {
          enabled = true,
        },
      },
      logs_formatter = "xcbeautify",
      code_coverage = {
        enabled = true,
      },
    })
    local codelldbPath = os.getenv("HOME") .. "/.local/lib/codelldb/extension/adapter/codelldb"
    require("xcodebuild.integrations.dap").setup(codelldbPath)
  end,
  keys = {
    {
      "<leader>Z",
      ":XcodebuildPicker<CR>",
      desc = "Xcodebuild Picker",
    },
    {
      "<leader>zr",
      ":XcodebuildBuildRun<CR>",
      desc = "Xcodebuild Run",
    },
    {
      "<leader>zb",
      "<cmd>XcodebuildBuild<cr>",
      desc = "Build Project",
    },
    {
      "<leader>zB",
      "<cmd>XcodebuildBuildForTesting<cr>",
      desc = "Build For Testing",
    },
    {
      "<leader>zr",
      "<cmd>XcodebuildBuildRun<cr>",
      desc = "Build & Run Project",
    },
    {
      "<leader>zT",
      "<cmd>XcodebuildTest<cr>",
      desc = "Test",
    },
    {
      "<leader>zt",
      "<cmd>XcodebuildTestNearest<cr>",
      desc = "Test (nearest)",
    },
    {
      "<leader>zD",
      "<cmd>XcodebuildSelectDevice<cr>",
      desc = "Select Device",
    },
    {
      "<leader>zx",
      "<cmd>XcodebuildCancel<cr>",
      desc = "Cancel Running Action",
    },
    {
      "<leader>zd",
      function()
        require("xcodebuild.integrations.dap").build_and_debug()
      end,
      desc = "Build & Debug",
    },
  },
}
