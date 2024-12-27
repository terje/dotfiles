return {
  -- dir = "/Users/terje/Development/NeoVim/simctl.nvim",
  "terje/simctl.nvim",
  version = "*",
  keys = {
    {
      "<leader>ib",
      function()
        require("simctl.api").boot()
      end,
      desc = "Boot Simulator",
    },
    {
      "<leader>is",
      function()
        require("simctl.api").shutdown()
      end,
      desc = "Shut down Simulator",
    },
    {
      "<leader>il",
      function()
        require("simctl.api").launch({ deviceId = "booted" })
      end,
      desc = "Launch app",
    },
    {
      "<leader>it",
      function()
        require("simctl.api").terminate({ deviceId = "booted" })
      end,
      desc = "Terminate app",
    },
    {
      "<leader>io",
      function()
        vim.ui.input({ prompt = "URL: " }, function(url)
          require("simctl.api").openurl({ deviceId = "booted", url = url })
        end)
      end,
      desc = "Open URL",
    },
    {
      "<leader>iu",
      function()
        require("simctl.api").uninstall({ deviceId = "booted" })
      end,
      desc = "Uninstall app",
    },
    {
      "<leader>ia",
      function()
        require("simctl.api").ui.toggleAppearance({ deviceId = "booted" })
      end,
      desc = "󰔎 Toggle appearance",
    },
    { "<leader>ic", desc = " Content size" },
    {
      "<leader>icc",
      function()
        require("simctl.api").ui.setContentSize({ deviceId = "booted" })
      end,
      desc = "Set content size",
    },
    {
      "<leader>ic+",
      function()
        require("simctl.api").ui.increaseContentSize({ deviceId = "booted" })
      end,
      desc = "Increase content size",
    },
    {
      "<leader>ic-",
      function()
        require("simctl.api").ui.decreaseContentSize({ deviceId = "booted" })
      end,
      desc = "Decrease content size",
    },
    {
      "<leader>icr",
      function()
        local simctl = require("simctl.api")
        simctl.ui.setContentSize({
          deviceId = "booted",
          size = simctl.ui.ContentSize.LARGE,
        })
      end,
      desc = "Default content size",
    },
    {
      "<leader>icm",
      function()
        local simctl = require("simctl.api")
        simctl.ui.setContentSize({
          deviceId = "booted",
          size = simctl.ui.ContentSize.EXTRA_EXTRA_EXTRA_LARGE,
        })
      end,
      desc = "Max content size",
    },
    {
      "<leader>ica",
      function()
        local simctl = require("simctl.api")
        simctl.ui.setContentSize({
          deviceId = "booted",
          size = simctl.ui.ContentSize.ACCESSIBILITY_EXTRA_EXTRA_EXTRA_LARGE,
        })
      end,
      desc = "Max accessibility content size",
    },
    { "<leader>im", desc = "󰱻 Biometry" },
    {
      "<leader>ime",
      function()
        local simctl = require("simctl.api")
        simctl.biometry.toggleEnrollment({ deviceId = "booted" }, function(success, isEnrolled)
          if success then
            vim.notify("Biometry is now " .. (isEnrolled and "enrolled" or "disenrolled"))
          end
        end)
      end,
      desc = "Toggle Biometry Enrollment",
    },
    {
      "<leader>ima",
      function()
        local simctl = require("simctl.api")
        simctl.biometry.authenticate({ deviceId = "booted", match = true })
      end,
      desc = "Authenticate (matching)",
    },
    {
      "<leader>imb",
      function()
        local simctl = require("simctl.api")
        simctl.biometry.authenticate({ deviceId = "booted", match = false })
      end,
      desc = "Authenticate (non-matching)",
    },
  },
}
