local M = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "folke/neoconf.nvim",
  },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

function M.config()
  local servers = {
    "lua_ls",
    "cssls",
    "html",
    "tsserver",
    "pyright",
    "bashls",
    "jsonls",
    "eslint",
    "volar",
    "tailwindcss",
  }

  require("mason").setup {
    ui = {
      border = "rounded",
    },
  }

  require("mason-lspconfig").setup {
    ensure_installed = servers,
  }

  require("neodev").setup {}
  local lspconfig = require "lspconfig"
  require("mason-lspconfig").setup_handlers {
    function(server_name)
      local server_config = {
        capabilities = capabilities,
      }
      if require("neoconf").get(server_name .. ".disable") then
        return
      end
      -- if server_name == "volar" then
      --   server_config.filetypes = { "vue", "typescript", "javascript" }
      -- end
      lspconfig[server_name].setup(server_config)
    end,
  }
end

return M
