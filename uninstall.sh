#!/usr/bin/env bash
# Remove the Lumon theme polish (leaves the colour theme in place — switch away
# with `omarchy theme set <other>`).
set -euo pipefail

HYPR="$HOME/.config/hypr/looknfeel.lua"
M1='-- >>> omarchy-lumon-theme looknfeel >>>'
M2='-- <<< omarchy-lumon-theme looknfeel <<<'

if [[ -f "$HYPR" ]] && grep -qF "$M1" "$HYPR"; then
  echo ":: removing the look'n'feel block from $HYPR"
  sed -i "\#$M1#,\#$M2#d" "$HYPR"
  hyprctl reload >/dev/null 2>&1 || true
fi

echo ":: restoring fastfetch / about from the newest .bak, if present"
for f in "$HOME/.config/fastfetch/config.jsonc" "$HOME/.config/omarchy/branding/about.txt"; do
  bak=$(ls -1t "$f".bak.* 2>/dev/null | head -1 || true)
  [[ -n $bak ]] && { mv "$bak" "$f"; echo "   $f"; }
done
echo "Done."
