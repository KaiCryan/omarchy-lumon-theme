#!/usr/bin/env bash
# Lumon theme polish for Omarchy — sits on top of OldJobobo's colour theme.
set -euo pipefail
cd "$(dirname "$0")"

HYPR="$HOME/.config/hypr/looknfeel.lua"
FF="$HOME/.config/fastfetch/config.jsonc"
ABOUT="$HOME/.config/omarchy/branding/about.txt"
M1='-- >>> omarchy-lumon-theme looknfeel >>>'
M2='-- <<< omarchy-lumon-theme looknfeel <<<'

# 1. base colour theme (skip if already there)
if [[ ! -d "$HOME/.config/omarchy/themes/lumon" ]]; then
  echo ":: installing OldJobobo's Lumon colour theme"
  omarchy theme install https://github.com/OldJobobo/omarchy-lumon-theme
fi
omarchy theme set lumon 2>/dev/null || true

# 2. Hyprland look'n'feel — appended, marker-guarded, theme-independent
if [[ -f "$HYPR" ]] && ! grep -qF "$M1" "$HYPR"; then
  echo ":: adding the Lumon look'n'feel block to $HYPR"
  { echo; echo "$M1"; cat hypr/lumon-looknfeel.lua; echo "$M2"; } >> "$HYPR"
  hyprctl reload >/dev/null 2>&1 || true
else
  echo ":: $HYPR already has the block (or doesn't exist)"
fi

# 3. fastfetch + about branding (back up whatever's there)
mkdir -p "$(dirname "$FF")" "$(dirname "$ABOUT")"
[[ -f "$FF" ]]    && cp "$FF" "$FF.bak.$(date +%s)"
[[ -f "$ABOUT" ]] && cp "$ABOUT" "$ABOUT.bak.$(date +%s)"
cp fastfetch/config.jsonc "$FF"
cp branding/about.txt "$ABOUT"
echo ":: fastfetch + 'omarchy about' now Lumon-branded"

echo
echo "Done. Try:  fastfetch   /   omarchy about"
