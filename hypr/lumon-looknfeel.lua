-- ── OldJobobo's Lumon look'n'feel (from omarchy-lumon-theme/hyprland.conf) ──
-- Bigger gaps, softly-rounded corners, heavier blur, and a wide drop shadow.
-- Theme-independent: lives here so it survives theme switches. Remove this
-- block to go back to the Omarchy defaults.
local lumonActiveBorder   = "rgb(f2fcff)"
local lumonActiveShadow   = "rgb(6fb8e3)"
local lumonInactiveBorder = "rgba(30486099)"
local lumonInactiveShadow = "rgba(30486077)"

hl.config({
  general = {
    col = {
      active_border   = lumonActiveBorder,
      inactive_border = lumonInactiveBorder,
    },
    gaps_in  = 14,
    gaps_out = 28,
  },
  group = {
    col = {
      border_active   = lumonActiveBorder,
      border_inactive = lumonInactiveBorder,
    },
  },
  decoration = {
    rounding       = 6,
    rounding_power = 7,
    blur = {
      enabled = true,
      size    = 2,
      passes  = 3,
      noise   = 0.05,
    },
    shadow = {
      enabled        = true,
      range          = 16,
      render_power   = 4,
      color          = lumonActiveShadow,
      color_inactive = lumonInactiveShadow,
    },
  },
})
