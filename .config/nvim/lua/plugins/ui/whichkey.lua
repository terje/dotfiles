local M = {
  "folke/which-key.nvim",
}

function M.config()
  local icons = require "lib.icons"

  local mappings = {
    a = { name = icons.misc.Squirrel .. "AI Tools" },
    q = { "<cmd>confirm q<CR>", "Quit" },
    b = { desc = icons.kind.File .. "Buffers" },
    d = { name = icons.ui.Bug .. "Debug" },
    e = { name = icons.ui.EmptyFolderOpen .. "Neotree" },
    f = { name = icons.ui.Telescope .. "Find" },
    c = { name = icons.misc.Code .. " Code" },
    g = { name = icons.misc.Git .. "Git" },
    i = { name = icons.misc.MobilePhone .. "iOS Simulator" },
    -- l = { name = icons.misc.Package .. "Setup" },
    m = { name = icons.misc.Run .. "Compiler" },
    p = { name = icons.misc.Plugins .. "Plugins" },
    t = { name = icons.misc.Test .. "Test" },
    T = { name = "Treesitter" },
  }

  local wk = require "which-key"
  wk.setup {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
    icons = { group = vim.g.icons_enabled and "" or "", separator = "" },
    window = {
      border = "rounded",
      position = "bottom",
      padding = { 2, 2, 2, 2 },
    },
    ignore_missing = true,
    show_help = false,
    show_keys = false,
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },
  }

  -- General
  wk.register {
    ["<ESC>"] = {
      function()
        if vim.fn.hlexists "Search" then
          vim.cmd "nohlsearch"
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, true, true), "n", true)
        end
      end,
      "Format",
    },
    ["<leader><leader>"] = { "<cmd>Telescope find_files<cr>", icons.ui.FindFile .. " Find files" },
    ["<leader>."] = { "<cmd>Telescope live_grep<cr>", icons.ui.Search .. "Find Text" },
    ["<leader>w"] = { "<cmd>WhichKey<cr>", icons.diagnostics.Question .. " Which key" },
  }
  wk.register {
    ["<leader>/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment line" },
  }
  wk.register {
    ["<leader>/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment", mode = "v" },
  }

  -- a - AI and assistants
  wk.register {
    ["<leader>aa"] = {
      function()
        require("chatgpt").openChat()
      end,
      "Ask ChatGPT",
    },
    ["<leader>ae"] = {
      function()
        require("chatgpt").edit_with_instructions()
      end,
      "ChatGPT: Edit with instructions",
      mode = "v",
    },
    ["<leader>af"] = { ":CopilotChatFixDiagnostic<cr>", icons.git.Copilot .. " Fix diagnostic" },
    ["<leader>as"] = {
      function()
        require("chatgpt").summarize()
      end,
      "ChatGPT: Summarize",
      mode = "v",
    },
    ["<leader>at"] = { "<cmd>CopilotChatTests<cr>", icons.git.Copilot .. " Generate tests" },
    ["<leader>av"] = { ":CopilotChatVisual", icons.git.Copilot .. " Open in vertical split" },
    ["<leader>aC"] = { ":CopilotChatInPlace<cr>", icons.git.Copilot .. " Chat" },
  }

  -- b - Buffers
  wk.register {
    ["<leader>bb"] = { "<cmd>Telescope buffers previewer=false<cr>", "Find" },
    ["<leader>bp"] = { "<Cmd>BufferLineTogglePin<CR>", "Toggle pin" },
    ["<leader>bP"] = { "<Cmd>BufferLineGroupClose ungrouped<CR>", "Delete non-pinned buffers" },
    ["<leader>bo"] = { "<Cmd>BufferLineCloseOthers<CR>", "Delete other buffers" },
    ["<leader>br"] = { "<Cmd>BufferLineCloseRight<CR>", "Delete buffers to the right" },
    ["<leader>bl"] = { "<Cmd>BufferLineCloseLeft<CR>", "Delete buffers to the left" },
    ["<S-h>"] = { "<Cmd>BufferLineCyclePrev<CR>", "Prev buffer" },
    ["<S-l>"] = { "<Cmd>BufferLineCycleNext<CR>", "Next buffer" },
    ["[b"] = { "<cmd>BufferLineCyclePrev<cr>", "Prev buffer" },
    ["]b"] = { "<cmd>BufferLineCycleNext<cr>", "Next buffer" },
    ["<leader>bd"] = {
      function()
        require("mini.bufremove").delete(0)
      end,
      "Delete buffer",
    },
    ["<leader>bD"] = {
      function()
        require("mini.bufremove").delete(0, true)
      end,
      "Delete buffer (Force)",
    },
  }

  -- c - Code Actions
  wk.register {
    ["<leader>cf"] = {
      function()
        require("conform").format()
      end,
      "Format",
    },
    ["<leader>ct"] = { "<cmd>TroubleToggle<cr>", "Toggle Trouble" },
    ["<leader>ca"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    ["<leader>cp"] = {
      function()
        require("actions-preview").code_actions()
      end,
      "Code action preview",
    },
    ["<leader>cA"] = {
      function()
        vim.lsp.buf.code_action {
          context = {
            only = {
              "source",
            },
            diagnostics = {},
          },
        }
      end,
      "Source Action",
    },
    ["<leader>ci"] = { "<cmd>LspInfo<cr>", "Info" },
    ["<leader>ch"] = { "<cmd>lua require('user.lspconfig').toggle_inlay_hints()<cr>", "Hints" },
    ["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
    ["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },

    ["<leader>cl"] = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    ["<leader>cq"] = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
    ["<leader>cs"] = { "<cmd>lua require('treesj').toggle()<cr>", "Toggle Split/Join" }
  }
  vim.keymap.set("n", "<leader>cr", function()
    -- return ":IncRename " .. vim.fn.expand "<cword>"
    return ":IncRename "
  end, { expr = true })

  -- f - Find & Search
  wk.register {
    -- nnoremap gd :Neotree float reveal_file=<cfile> reveal_force_cwd<cr>
    ["<leader>fb"] = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    ["<leader>fc"] = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    ["<leader>fe"] = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
    ["<leader>ff"] = { "<cmd>Neotree reveal<cr>", "Show file in tree" },
    ["<leader>fp"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
    ["<leader>fh"] = { "<cmd>Telescope help_tags<cr>", "Help" },
    ["<leader>fl"] = { "<cmd>Telescope resume<cr>", "Last Search" },
    ["<leader>fn"] = { "<cmd>Telescope notify<cr>", "Notifications" },
    ["<leader>fr"] = { "<cmd>Telescope lsp_references<cr>", "References" },
    -- ["<leader>fr"] = {
    --   function()
    --     require("spectre").toggle { path = vim.fn.expand "%:t:p" }
    --   end,
    --   "Replace in buffer",
    -- },
    ["<leader>fR"] = {
      function()
        require("spectre").toggle()
      end,
      "Replace in project",
    },
  }

  -- g - Git
  wk.register {
    ["<leader>gg"] = { "<cmd>LazyGit<CR>", "LazyGit" },
    ["<leader>gj"] = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next Hunk" },
    ["<leader>gk"] = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "Prev Hunk" },
    ["<leader>gp"] = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    ["<leader>gr"] = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    ["<leader>gl"] = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    ["<leader>gR"] = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    ["<leader>gs"] = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    ["<leader>gu"] = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    ["<leader>gd"] = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Git Diff",
    },
  }

  local simctlArgs = { deviceId = "booted" }

  wk.register {
    ["<leader>ib"] = { require("simctl.api").boot, "Boot Simulator" },
    ["<leader>is"] = { require("simctl.api").shutdown, "Shut down Simulator" },
    ["<leader>il"] = {
      function()
        require("simctl.api").launch(simctlArgs)
      end,
      "Launch app",
    },
    ["<leader>it"] = {
      function()
        require("simctl.api").terminate(simctlArgs)
      end,
      "Terminate app",
    },
    ["<leader>io"] = {
      function()
        vim.ui.input({ prompt = "URL: " }, function(url)
          if not url then
            return
          end
          simctlArgs.url = url
          require("simctl.api").openurl(simctlArgs)
        end)
      end,
      "Open URL",
    },
    ["<leader>iu"] = {
      function()
        require("simctl.api").uninstall(simctlArgs)
      end,
      "Uninstall app",
    },
    ["<leader>ia"] = {
      function()
        require("simctl.api").ui.toggleAppearance(simctlArgs)
      end,
      "Toggle appearance",
    },
    ["<leader>ic"] = {
      function()
        require("simctl.api").ui.setContentSize(simctlArgs)
      end,
      "Set content size",
    },
    ["<leader>ic+"] = {
      function()
        require("simctl.api").ui.increaseContentSize(simctlArgs)
      end,
      "Increase content size",
    },
    ["<leader>ic-"] = {
      function()
        require("simctl.api").ui.decreaseContentSize(simctlArgs)
      end,
      "Decrease content size",
    },
    ["<leader>icr"] = {
      function()
        local simctl = require "simctl.api"
        simctlArgs.size = simctl.ui.ContentSize.LARGE
        simctl.ui.setContentSize(simctlArgs)
      end,
      "Default content size",
    },
    ["<leader>icm"] = {
      function()
        local simctl = require "simctl.api"
        simctlArgs.size = simctl.ui.ContentSize.EXTRA_EXTRA_EXTRA_LARGE
        simctl.ui.setContentSize(simctlArgs)
      end,
      "Max content size",
    },
    ["<leader>ica"] = {
      function()
        local simctl = require "simctl.api"
        simctlArgs.size = simctl.ui.ContentSize.ACCESSIBILITY_EXTRA_EXTRA_EXTRA_LARGE
        simctl.ui.setContentSize(simctlArgs)
      end,
      "Max accessibility content size",
    },
  }

  -- l - Setup
  wk.register {
    ["<leader>l"] = { "<cmd>Lazy<CR>", icons.misc.Package .. "Lazy" },
  }

  -- m - Compiler (build and run)
  wk.register {
    ["<leader>mq"] = {
      require("user.expo").quit,
      "Quit Expo Go",
    },
    ["<leader>me"] = {
      require("user.expo").run,
      "Expo Run",
    },
    ["<leader>mr"] = {
      require("user.expo").reload,
      "Expo Reload",
    },
    ["<leader>mu"] = {
      function()
        local expo = require "user.expo"
        expo.uninstall(function()
          vim.schedule(function()
            vim.fn.notify "Expo app uninstalled"
            expo.run()
          end)
        end)
      end,
      "Expo Uninstall & Run",
    },
    ["<leader>mx"] = { "<cmd>source %<cr>", "Execute file" },
  }

  -- t - Test
  wk.register {
    ["<leader>tt"] = { "<cmd>lua require'neotest'.run.run()<cr>", "Test Nearest" },
    ["<leader>tT"] = { "<cmd>lua require'neotest'.run.run(vim.loop.cwd())<cr>", "Test All" },
    ["<leader>ts"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Toggle Summary" },
    ["<leader>tf"] = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Test File" },
    ["<leader>td"] = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Debug Test" },
    ["<leader>tS"] = { "<cmd>lua require('neotest').run.stop()<cr>", "Test Stop" },
    ["<leader>ta"] = { "<cmd>lua require('neotest').run.attach()<cr>", "Attach Test" },
    ["<leader>to"] = {
      function()
        require("neotest").output_panel.toggle()
      end,
      "Toggle output panel",
    },
  }

  local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
  }

  -- local function mod_hl(hl_name, opts)
  --   local is_ok, hl_def = pcall(vim.api.nvim_get_hl_by_name, hl_name, true)
  --   if is_ok then
  --     for k, v in pairs(opts) do hl_def[k] = v end
  --     vim.api.nvim_set_hl(0, hl_name, hl_def)
  --   end
  -- end
  --
  -- vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
  --   group = vim.api.nvim_create_augroup('Color', {}),
  --   pattern = "*",
  --   callback = function()
  --     mod_hl("WhichKeyGroup", { italic = false })
  --   end
  -- })

  wk.register(mappings, opts)
end

return M
