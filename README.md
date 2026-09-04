# omarchy-lumon-theme

> Part of **[Omarchy · Lumon Industries](https://github.com/KaiCryan/omarchy-lumon)** — a whole-system _Severance_ theme for Omarchy. This repo is one piece; the hub links the rest.

The connective tissue of the Lumon / *Severance* setup for
[Omarchy](https://omarchy.org) — the bits that aren't a screensaver, a
wallpaper or a greeting.

- **Colour theme** — installs [OldJobobo's `omarchy-lumon-theme`](https://github.com/OldJobobo/omarchy-lumon-theme)
  (bg `#1b2d40`, fg `#d6e2ee`, accent `#6fb8e3`) and sets it.
- **Hyprland look'n'feel** — bigger gaps, softly-rounded corners, heavier blur,
  a wide cyan drop shadow, near-white active borders. Appended to
  `~/.config/hypr/looknfeel.lua` between markers, so it survives theme switches
  and `omarchy update`.
- **Branding** — `fastfetch` recoloured green→cyan with the Lumon globe as its
  logo, and the same emblem for `omarchy about`.

## Install

```sh
git clone https://github.com/KaiCryan/omarchy-lumon-theme
cd omarchy-lumon-theme
./install.sh
```

Backs up your existing `fastfetch/config.jsonc` and `branding/about.txt` first
(`.bak.<timestamp>`).

## Uninstall

```sh
./uninstall.sh          # removes the look'n'feel block, restores the backups
omarchy theme set <x>   # switch away from the Lumon colours
```

## The rest of the set

| | |
|---|---|
| [omarchy-lumon-greeting](https://github.com/KaiCryan/omarchy-lumon-greeting) | animated terminal greeting |
| [omarchy-lumon-screensaver](https://github.com/KaiCryan/omarchy-lumon-screensaver) | idle-screen reels |
| [omarchy-lumon-wallpapers](https://github.com/KaiCryan/omarchy-lumon-wallpapers) | wallpapers + hourly cycle |
| [omarchy-lumon-lock](https://github.com/KaiCryan/omarchy-lumon-lock) | lock screen |
| [omarchy-lumon-boot](https://github.com/KaiCryan/omarchy-lumon-boot) | Plymouth splash |
| [omarchy-lumon-assets](https://github.com/KaiCryan/omarchy-lumon-assets) | shared ASCII art, fonts, tools |
