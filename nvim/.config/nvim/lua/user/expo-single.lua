local M = {}

--- Quit Expo Go on running iOS Simulators
-- @param callback function to call when command finishes
M.quit = function(callback)
  require("simctl.api").terminate({ deviceId = "booted", appId = "host.exp.Exponent" }, callback)
end

--- Uninstall Expo Go from running iOS Simulators
-- @param callback function to call when command finishes
M.uninstall = function(callback)
  require("simctl.api").uninstall({ deviceId = "booted", appId = "host.exp.Exponent" }, callback)
end

M.reload = function()
  vim.cmd("VimuxRunCommand 'r'")
end

local hasBootedDevice = function(deviceList)
  for _, device in ipairs(deviceList) do
    if device.state == "Booted" then
      return true
    end
  end
  return false
end

M.run = function()
  -- Stop the Expo Go process if it is running
  if vim.g.VimuxRunnerIndex then
    vim.cmd "VimuxInterruptRunner"
  end

  local simctl = require "simctl.api"
  local aw = require("simctl.lib.async")
  aw.async(function()
    -- Check if we have a booted device to run on, boot one if not
    local _, devices = aw.await(simctl.list)
    if not hasBootedDevice(devices) then
      local success = aw.await(function(cb)
        simctl.boot({}, cb)
      end)
      if not success then
        -- No device was selected, cancel
        return
      end
    end

    -- Run the app
    vim.schedule(function()
      vim.cmd("VimuxRunCommand 'yarn start --ios'")
    end)
  end)
end

return M
