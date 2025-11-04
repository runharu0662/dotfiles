------------------------------------------------------------
-- Hammerspoon Window Control (No yabai)
-- Alt + h/j/k/l : Focus movement
-- Ctrl + o/p/s  : Toggle apps (WezTerm, Obsidian, Safari)
------------------------------------------------------------

------------------------------------------------------------
-- 🪟 Window Focus Movement
------------------------------------------------------------

-- Helper function to focus the next window or show an alert
local function focusOrAlert(winList, dir)
	if winList and winList[1] then
		winList[1]:focus()
	else
		hs.alert.show("No window " .. dir)
	end
end

-- Focus west (left)
hs.hotkey.bind({ "alt" }, "h", function()
	local win = hs.window.focusedWindow()
	if win then focusOrAlert(win:windowsToWest(), "←") end
end)

-- Focus east (right)
hs.hotkey.bind({ "alt" }, "l", function()
	local win = hs.window.focusedWindow()
	if win then focusOrAlert(win:windowsToEast(), "→") end
end)

-- Focus south (down)
hs.hotkey.bind({ "alt" }, "j", function()
	local win = hs.window.focusedWindow()
	if win then focusOrAlert(win:windowsToSouth(), "↓") end
end)

-- Focus north (up)
hs.hotkey.bind({ "alt" }, "k", function()
	local win = hs.window.focusedWindow()
	if win then focusOrAlert(win:windowsToNorth(), "↑") end
end)

------------------------------------------------------------
-- 🚀 App Toggle Function (Show / Hide / Focus)
------------------------------------------------------------

local function toggleApp(appName)
	local app = hs.application.get(appName)

	-- If app not running → launch it
	if app == nil then
		hs.application.launchOrFocus(appName)
		return
	end

	-- If app is frontmost → hide it
	if app:isFrontmost() then
		app:hide()
		return
	end

	-- If app is hidden → unhide it
	if app:isHidden() then
		app:unhide()
	end

	-- Try to focus the main or currently focused window
	local win = app:mainWindow() or app:focusedWindow()
	if win then
		win:raise()
		win:focus()
	else
		-- As a fallback, just launch/focus the app
		hs.application.launchOrFocus(appName)
	end
end

------------------------------------------------------------
-- ⌨️ Hotkey Bindings (Ctrl + key)
------------------------------------------------------------

local hotkeys = {
	{ key = "o", app = "WezTerm" },
	{ key = "p", app = "Obsidian" },
	{ key = "s", app = "Safari" },
}

for _, item in ipairs(hotkeys) do
	hs.hotkey.bind({ "ctrl" }, item.key, function()
		toggleApp(item.app)
	end)
end

------------------------------------------------------------
-- ✅ Notes:
-- • Make sure Hammerspoon has Accessibility permission
--   (System Settings → Privacy & Security → Accessibility)
-- • Avoid key conflicts with Rectangle
-- • You can add more apps to the hotkeys table if needed
------------------------------------------------------------
