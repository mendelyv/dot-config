local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local nf = wezterm.nerdfonts

-- launch bash
config.default_prog = { "C:\\Program Files\\Git\\bin\\bash.exe", "-i", "-l" }

-- render mode
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

-- font
config.font_size = 10
config.font = wezterm.font("Maple Mono NF CN", { weight = "DemiBold" })
config.harfbuzz_features = { "calt=0", "cv02=0", "cv31=0", "ss01=0", }

-- theme
config.color_scheme = 'One Dark (Gogh)'
config.colors = {
  foreground = "#DCDFE4",
  cursor_bg = "#C5B9B3",
}

-- window
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.92
config.adjust_window_size_when_changing_font_size = false
config.window_padding = { left = 3, right = 0, top = 3, bottom = 0 }

-- tab
config.tab_max_width = 20
local tab_title_min_width = config.tab_max_width - 6
config.use_fancy_tab_bar = false
config.enable_tab_bar = true
config.show_tab_index_in_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.colors.tab_bar = {
  background = '#232a2e', -- 深灰主背景
  active_tab = {
    bg_color = '#a7c080', -- Everforest 主绿
    fg_color = '#2b3339', -- 深灰文字，高对比
    intensity = 'Bold',
    underline = 'None',
    italic = false,
    strikethrough = false,
  },
  inactive_tab = {
    bg_color = '#3a4248', -- 比背景亮一些，灰蓝偏绿
    fg_color = '#9da9a0', -- 灰绿色文字
  },
  inactive_tab_hover = {
    bg_color = '#4b565c', -- hover 再亮一点
    fg_color = '#d3c6aa', -- 米白文字
    italic = true,
  },
  new_tab = {
    bg_color = '#3a4248',
    fg_color = '#9da9a0',
  },
  new_tab_hover = {
    bg_color = '#4b565c',
    fg_color = '#d3c6aa',
    italic = true,
  },
}
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local title = tab.active_pane.title
  title = wezterm.truncate_right(title, max_width)

  -- 计算填充长度（居中）
  local width = math.max(#title, tab_title_min_width)
  local pad_total = width - #title
  local pad_left = math.floor(pad_total / 2)
  local pad_right = pad_total - pad_left
  local centered_title = string.rep(" ", pad_left) .. title .. string.rep(" ", pad_right)

  -- 选颜色（区分 active / inactive / hover）
  local colors = config.colors.tab_bar
  local is_active = tab.is_active
  local bg_color, fg_color

  if is_active then
    bg_color = colors.active_tab.bg_color
    fg_color = colors.active_tab.fg_color
  elseif hover then
    bg_color = colors.inactive_tab_hover.bg_color
    fg_color = colors.inactive_tab_hover.fg_color
  else
    bg_color = colors.inactive_tab.bg_color
    fg_color = colors.inactive_tab.fg_color
  end

  return {
    { Background = { Color = colors.background } },
    { Foreground = { Color = bg_color } },
    { Text = nf.ple_left_half_circle_thick },

    { Background = { Color = bg_color } },
    { Foreground = { Color = fg_color } },
    { Text = centered_title },

    { Background = { Color = colors.background } },
    { Foreground = { Color = bg_color } },
    { Text = nf.ple_right_half_circle_thick },
  }
end)

return config
