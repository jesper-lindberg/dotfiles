require("hs.ipc") -- lets the `hs` CLI talk to Hammerspoon

local function toggleGhostty()
    local appName = "Ghostty"
    local app = hs.appfinder.appFromName(appName)

    if app and app:isFrontmost() then
        app:hide()                            -- Hide it if it's the active app
    else
        hs.application.launchOrFocus(appName) -- Otherwise launch it or bring it to the front
    end
end

hs.hotkey.bind({}, "§", toggleGhostty)
hs.hotkey.bind({}, "<", toggleGhostty)
