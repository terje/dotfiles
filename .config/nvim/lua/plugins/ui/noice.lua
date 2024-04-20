local M = {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    -- "rcarriga/nvim-notify",
  },
}

function M.config()
  require("noice").setup {
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
      },
    },
    presets = {
      bottom_search = true,         -- use a classic bottom cmdline for search
      -- command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false,           -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false,       -- add a border to hover docs and signature help
    },
    popupmenu = {
      position = "50%",
      size = {
        width = 80,
        height = "60%",
      },
    },
    routes = {
      { -- filter write messages "xxxL, xxxB"
        filter = {
          event = "msg_show",
          find = "%dL",
        },
        opts = { skip = true },
      },
      { -- filter undo messages
        filter = {
          event = "msg_show",
          find = "; before #%d+",
        },
        opts = { skip = true },
      },
      { -- filter redo messages
        filter = {
          event = "msg_show",
          find = "; after #%d+",
        },
        opts = { skip = true },
      },
    },
  }
end

return M
