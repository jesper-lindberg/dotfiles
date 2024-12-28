hs.hotkey.bind({}, "§", function()
    local appName = "Ghostty"
    local app = hs.appfinder.appFromName(appName)

    if app then
        if app:isHidden() then
            hs.application.launchOrFocus(appName) -- Launch or focus the app if it's hidden
        else
            app:hide()                            -- Hide the app if it's not hidden
        end
    end
end)
