-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.debug_key_events = true
config.enable_csi_u_key_encoding = true
config.enable_kitty_keyboard = false


-- or, changing the font size and color scheme.
config.font_size = 22
config.font = wezterm.font({
    family = "Iosevka Nerd Font Mono",
})

-- Finally, return the configuration to wezterm:

local function read_file(path)
    local f = io.open(path, "r")
    if not f then return nil end
    local s = f:read("*l")
    f:close()
    return s
end

local scheme = read_file(os.getenv("HOME") .. "/.local/share/tinted-theming/tinty/artifacts/current_scheme")

config.color_scheme = scheme

-- config.use_fancy_tab_bar = true
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.9
config.macos_window_background_blur = 20

local act = wezterm.action

config.keys = {
    { key = ")", mods = "SUPER|CTRL|ALT|SHIFT", action = act.SendString("\x1b[48;8u") },
    { key = "!", mods = "SUPER|CTRL|ALT|SHIFT", action = act.SendString("\x1b[49;8u") },
    { key = "@", mods = "SUPER|CTRL|ALT|SHIFT", action = act.SendString("\x1b[50;8u") },
    { key = "#", mods = "SUPER|CTRL|ALT|SHIFT", action = act.SendString("\x1b[51;8u") },
    { key = "$", mods = "SUPER|CTRL|ALT|SHIFT", action = act.SendString("\x1b[52;8u") },
    { key = "%", mods = "SUPER|CTRL|ALT|SHIFT", action = act.SendString("\x1b[53;8u") },
    { key = "^", mods = "SUPER|CTRL|ALT|SHIFT", action = act.SendString("\x1b[54;8u") },
    { key = "&", mods = "SUPER|CTRL|ALT|SHIFT", action = act.SendString("\x1b[55;8u") },
    { key = "*", mods = "SUPER|CTRL|ALT|SHIFT", action = act.SendString("\x1b[56;8u") },
    { key = "(", mods = "SUPER|CTRL|ALT|SHIFT", action = act.SendString("\x1b[57;8u") },
    { key = "m", mods = "SUPER|CTRL|ALT|SHIFT", action = act.SendString("\x1b[109;8u") },
    { key = "k", mods = "SUPER|CTRL|ALT|SHIFT", action = act.SendString("\x1b[107;8u") },
}

return config
