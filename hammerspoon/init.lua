-- Hammerspoon Configuration
-- Hyper key app launcher

-- Hyper key definition: left cmd + left option + left shift + left control
local hyper = {"cmd", "alt", "shift", "ctrl"}

-- Function to launch or focus an application
local function launchOrFocus(appName)
    return function()
        hs.application.launchOrFocus(appName)
    end
end

-- App mappings with hyper key combinations
-- 개별 앱 설정:
-- space: superwhisper
-- 1: ChatGPT
-- 3: Claude (claude 는 특정 숫자키가 설정이 잘 안됨, 2 , 5 등)
local appMappings = {
    ["o"] = "Obsidian",
    ["c"] = "Google Chrome",
    ["w"] = "WORKS",
    ["t"] = "iterm",
    ["2"] = "notebookLM",
    ["i"] = "intelliJ IDEA Ultimate"
}

-- Bind hyper key combinations to launch apps
for key, appName in pairs(appMappings) do
    hs.hotkey.bind(hyper, key, launchOrFocus(appName))
end

-- Optional: Show notification when configuration is loaded
hs.notify.new({
    title = "Hammerspoon",
    informativeText = "Configuration loaded successfully"
}):send()

-- Optional: Reload configuration when this file changes
function reloadConfig(files)
    local doReload = false
    for _, file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")