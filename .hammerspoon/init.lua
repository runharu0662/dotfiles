-- アプリをトグルする関数
local function toggleApp(appName)
	local app = hs.application.get(appName)

	if app == nil or app:isHidden() or not app:isFrontmost() then
		-- アプリを起動またはフォーカス
		hs.application.launchOrFocus(appName)

		-- 少し待ってから現在のスペースに移動
		hs.timer.doAfter(0.5, function()
			local windowQuery = "yabai -m query --windows --app '" .. appName .. "'"
			local success, output = hs.execute(windowQuery)

			if success and output then
				local windows = hs.json.decode(output)

				if #windows > 0 then
					-- 最初のウィンドウID取得
					local win_id = windows[1].id

					-- 現在のスペースID取得
					local spaceSuccess, currentSpaceJson = hs.execute("yabai -m query --spaces --space")
					local currentSpace = hs.json.decode(currentSpaceJson)
					local currentSpaceID = currentSpace.index

					-- ウィンドウを現在のスペースに移動
					hs.execute("yabai -m window " .. win_id .. " --space " .. currentSpaceID)
					hs.execute("yabai -m window --focus " .. win_id)
				end
			end
		end)
	else
		app:hide()
	end
end

-- ホットキー設定（Ctrl +  o） 追加可能
local hotkeys = {
	{ key = "p", app = "Obsidian" },
	{ key = "o", app = "WezTerm" },
	{ key = "s", app = "Safari" },
}

for _, item in ipairs(hotkeys) do
	hs.hotkey.bind({ "ctrl" }, item.key, function()
		toggleApp(item.app)
	end)
end

--[[
local open_wezterm = function()
	local appName = "WezTerm"
	local app = hs.application.get(appName)

	if app == nil or app:isHidden() or not (app:isFrontmost()) then
		hs.application.launchOrFocus(appName)
	else
		app:hide()
	end
end
hs.hotkey.bind({ "ctrl" }, "t", open_wezterm)

local open_wezterm = function()
	local appName = "Vivaldi"
	local app = hs.application.get(appName)

	if app == nil or app:isHidden() or not (app:isFrontmost()) then
		hs.application.launchOrFocus(appName)
	else
		app:hide()
	end
end
hs.hotkey.bind({ "ctrl" }, "b", open_wezterm)

local open_wezterm = function()
	local appName = "Obsidian"
	local app = hs.application.get(appName)

	if app == nil or app:isHidden() or not (app:isFrontmost()) then
		hs.application.launchOrFocus(appName)
	else
		app:hide()
	end
end
hs.hotkey.bind({ "ctrl" }, "o", open_wezterm)
]]
--
