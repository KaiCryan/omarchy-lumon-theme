#!/usr/bin/env bash
# Remove the Lumon theme polish (leaves the colour theme in place — switch away
# with `omarchy theme set <other>`).
set -euo pipefail

HYPR="$HOME/.config/hypr/looknfeel.lua"
M1='-- >>> omarchy-lumon-theme looknfeel >>>'
M2='-- <<< omarchy-lumon-theme looknfeel <<<'
CLIAMP_THEME="$HOME/.config/cliamp/themes/lumon.toml"
CLIAMP_CONF="$HOME/.config/cliamp/config.toml"

if [[ -f "$HYPR" ]] && grep -qF -- "$M1" "$HYPR"; then
  echo ":: removing the look'n'feel block from $HYPR"
  sed -i "\#$M1#,\#$M2#d" "$HYPR"
  hyprctl reload >/dev/null 2>&1 || true
fi

echo ":: restoring fastfetch / about from the newest .bak, if present"
for f in "$HOME/.config/fastfetch/config.jsonc" "$HOME/.config/omarchy/branding/about.txt"; do
  bak=$(ls -1t "$f".bak.* 2>/dev/null | head -1 || true)
  [[ -n $bak ]] && { mv "$bak" "$f"; echo "   $f"; }
done

if [[ -f "$CLIAMP_THEME" ]]; then
  rm -f "$CLIAMP_THEME"
  echo ":: removed $CLIAMP_THEME"

  if command -v cliamp >/dev/null 2>&1; then
    cliamp plugins remove lumon-mdr >/dev/null 2>&1 || true
    cliamp plugins remove lumon-flavor >/dev/null 2>&1 || true
  fi

  bak=$(ls -1t "$CLIAMP_CONF".bak.* 2>/dev/null | head -1 || true)
  if [[ -n $bak ]]; then
    mv "$bak" "$CLIAMP_CONF"
    echo "   $CLIAMP_CONF restored"
  elif [[ -f "$CLIAMP_CONF" ]]; then
    sed -i '/^theme = "lumon"$/d; /^visualizer = "lumon-mdr"$/d' "$CLIAMP_CONF"
  fi
fi

echo "Done."
