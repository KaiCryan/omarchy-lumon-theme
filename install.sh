#!/usr/bin/env bash
# Lumon theme polish for Omarchy — sits on top of OldJobobo's colour theme.
set -euo pipefail
cd "$(dirname "$0")"

HYPR="$HOME/.config/hypr/looknfeel.lua"
FF="$HOME/.config/fastfetch/config.jsonc"
ABOUT="$HOME/.config/omarchy/branding/about.txt"
CLIAMP_THEME="$HOME/.config/cliamp/themes/lumon.toml"
CLIAMP_CONF="$HOME/.config/cliamp/config.toml"
CLIAMP_PLUGINS="$HOME/.config/cliamp/plugins"
M1='-- >>> omarchy-lumon-theme looknfeel >>>'
M2='-- <<< omarchy-lumon-theme looknfeel <<<'

# 1. base colour theme (skip if already there)
if [[ ! -d "$HOME/.config/omarchy/themes/lumon" ]]; then
  echo ":: installing OldJobobo's Lumon colour theme"
  omarchy theme install https://github.com/OldJobobo/omarchy-lumon-theme
fi
omarchy theme set lumon 2>/dev/null || true

# 2. Hyprland look'n'feel — appended, marker-guarded, theme-independent
if [[ -f "$HYPR" ]] && ! grep -qF -- "$M1" "$HYPR"; then
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

# 4. cliamp (only if it's installed — this is opt-in, not everyone has it)
if command -v cliamp >/dev/null 2>&1; then
  mkdir -p "$(dirname "$CLIAMP_THEME")"
  cp cliamp/lumon.toml "$CLIAMP_THEME"

  mkdir -p "$CLIAMP_PLUGINS"
  cp cliamp/plugins/*.lua "$CLIAMP_PLUGINS/"
  for plug in lumon-mdr lumon-flavor; do
    cliamp plugins trust --yes "$plug" >/dev/null 2>&1 || true
  done

  mkdir -p "$(dirname "$CLIAMP_CONF")"
  if [[ -f "$CLIAMP_CONF" ]]; then
    cp "$CLIAMP_CONF" "$CLIAMP_CONF.bak.$(date +%s)"
  else
    : > "$CLIAMP_CONF"
  fi
  if grep -q '^theme *=' "$CLIAMP_CONF"; then
    sed -i 's/^theme *=.*/theme = "lumon"/' "$CLIAMP_CONF"
  else
    printf 'theme = "lumon"\n' >> "$CLIAMP_CONF"
  fi
  if grep -q '^visualizer *=' "$CLIAMP_CONF"; then
    sed -i 's/^visualizer *=.*/visualizer = "lumon-mdr"/' "$CLIAMP_CONF"
  else
    printf 'visualizer = "lumon-mdr"\n' >> "$CLIAMP_CONF"
  fi
  echo ":: cliamp themed lumon + macrodata-refinement visualizer + flavour messages"
  echo "   (trusts lumon-mdr/lumon-flavor automatically — they're ours; read cliamp/plugins/*.lua"
  echo "   first if you're installing this on someone else's machine)"
fi

echo
echo "Done. Try:  fastfetch   /   omarchy about"
