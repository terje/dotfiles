local M = {}

local map = function(tbl, func)
  local newtbl = {}
  for i, v in ipairs(tbl) do
    newtbl[i] = func(v)
  end
  return newtbl
end

--- Select app name in a monorepo from a list
-- Looks for all apps under ./apps directory
-- @param callback function to call with selected app slug
local selectApp = function(callback)
  local scan = require "plenary.scandir"
  local apps = scan.scan_dir("./apps", { hidden = false, depth = 1, only_dirs = true })
  local slugs = map(apps, function(v)
    return v:match "([^/]-)/?$"
  end)

  vim.ui.select(slugs, { prompt = "Select app" }, function(selected)
    callback(selected)
  end)
end

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

local function findAppByBundleIdentifier(apps, bundleIdentifier)
  for _, app in ipairs(apps) do
    if app.CFBundleIdentifier == bundleIdentifier then
      return app
    end
  end
  return nil -- Return nil if not found
end

M.reload = function()
  vim.cmd "VimuxRunCommand 'r'"
end

local hasBootedDevice = function(deviceList)
  for _, device in ipairs(deviceList) do
    if device.state == "Booted" then
      return true
    end
  end
  return false
end

local selectAppAndRun = function()
  local simctl = require("simctl.api")
  local aw = require("simctl.lib.async")

  aw.async(function()
    -- Quit expo go if it is running
    local success, apps = aw.await(function(cb)
      simctl.listapps({ deviceId = "booted" }, cb)
    end)
    if not success then
      vim.notify("Error listing apps", vim.log.levels.ERROR)
      return
    end
    if findAppByBundleIdentifier(apps, "host.exp.Exponent") then
      aw.await(function(cb)
        simctl.terminate({ deviceId = "booted", appId = "host.exp.Exponent" }, cb)
      end)
    end

    -- Select app from monorepo and run it using Vimux
    vim.schedule(function()
      selectApp(function(slug)
        vim.cmd("VimuxRunCommand 'yarn " .. slug .. ":start --ios'")
      end)
    end)
  end)
end

M.run = function()
  if vim.g.VimuxRunnerIndex then
    vim.cmd "VimuxInterruptRunner"
  end

  local simctl = require("simctl.api")
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

    selectAppAndRun()
  end)
end

return M
