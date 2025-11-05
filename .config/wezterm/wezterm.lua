local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "tokyonight"
config.font = wezterm.font("Hack Nerd Font")

config.automatically_reload_config = true
config.font_size = 16.0
config.use_ime = true
config.macos_forward_to_ime_modifier_mask = "SHIFT|CTRL"
config.window_background_opacity = 1.0
config.macos_window_background_blur = 0

----------------------------------------------------
-- tab
----------------------------------------------------
-- タイトルバーを非表示
config.window_decorations = "RESIZE"
-- タブバーの表示
config.show_tabs_in_tab_bar = true
-- タブが一つの時は非表示
config.hide_tab_bar_if_only_one_tab = false
-- falseにするとタブバーの透過が効かなくなる
-- config.use_fancy_tab_bar = false

-- タブバーの透過
config.window_frame = {
	inactive_titlebar_bg = "none",
	active_titlebar_bg = "none",
    font_size = 14.0,
}

-- タブバーを背景色に合わせる
config.window_background_gradient = {
	colors = { "#1a1b26" },
}

-- タブの追加ボタンを非表示
config.show_new_tab_button_in_tab_bar = false
-- nightlyのみ使用可能
-- タブの閉じるボタンを非表示
config.show_close_tab_button_in_tabs = false

-- タブ同士の境界線を非表示

config.colors = {
	tab_bar = {
		inactive_tab_edge = "none",
	},
	background = "#1a1b26",
}

--local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
--local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle
local SOLID_LEFT_ARROW = "" -- U+E0B6 (powerline left rounded)
local SOLID_RIGHT_ARROW = "" -- U+E0B4 (powerline right rounded)

--[[
  blue = "#7aa2f7",
  blue0 = "#3d59a1",
  blue1 = "#2ac3de",
  blue2 = "#0db9d7",
  blue5 = "#89ddff",
  blue6 = "#b4f9f8",
  blue7 = "#394b70",
]]
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local background = "#394b70"
	local foreground = "#FFFFFF"
	local edge_background = "none"
	if tab.is_active then
		background = "#7aa2f7"
		foreground = "#FFFFFF"
	end
	local edge_foreground = background
	local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "
	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

config.window_padding = {
	top = 1,
	bottom = 2,
}
-- set bar height
config.line_height = 1.0
config.cell_width = 1.0

----------------------------------------------------
-- keybinds
----------------------------------------------------
config.disable_default_key_bindings = true
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables
config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 2000 }

return config
