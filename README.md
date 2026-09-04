# omarchy-lumon-theme
<!-- lumon-voice:head -->
```
░▒▓█  L U M O N   I N D U S T R I E S  █▓▒░
```
> *Consistency is a form of kindness.*
<!-- /lumon-voice:head -->

<!-- lumon-set:start -->
> **Part of [Omarchy · Lumon Industries](https://github.com/KaiCryan/omarchy-lumon)** — a whole-system *Severance* theme for Omarchy.

<details><summary><strong>The full set</strong></summary>

| Repo | |
|---|---|
| [omarchy-lumon](https://github.com/KaiCryan/omarchy-lumon) | **the hub** — install everything, screenshots, the whole pitch |
| [omarchy-lumon-boot](https://github.com/KaiCryan/omarchy-lumon-boot) | Plymouth boot splash — Lumon globe, matching LUKS prompt |
| [omarchy-lumon-lock](https://github.com/KaiCryan/omarchy-lumon-lock) | lock screen — prompts *“Enter your access code”* |
| [omarchy-lumon-greeting](https://github.com/KaiCryan/omarchy-lumon-greeting) | terminal greeting — 19 animations, then `fastfetch` |
| [omarchy-lumon-wallpapers](https://github.com/KaiCryan/omarchy-lumon-wallpapers) | ASCII crew portraits + 4K brand set, hourly cycler |
| [omarchy-lumon-screensaver](https://github.com/KaiCryan/omarchy-lumon-screensaver) | capped-fps `ttfx` effects + an ambient scene reel |
| **omarchy-lumon-theme** | colour scheme, Hyprland look’n’feel, `fastfetch` + about branding &nbsp;·&nbsp; ← you are here |
| [omarchy-desktop-quote](https://github.com/KaiCryan/omarchy-desktop-quote) | a rotating quote placard over the wallpaper |
| [omarchy-lumon-assets](https://github.com/KaiCryan/omarchy-lumon-assets) | shared ASCII art, fonts and build tools |

</details>
<!-- lumon-set:end -->

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

---

<div align="center"><sub>

*The work is mysterious and important.*

Part of [Omarchy · Lumon Industries](https://github.com/KaiCryan/omarchy-lumon) · a personal, non-commercial *Severance* tribute · not affiliated with Apple TV+

</sub></div>
<!-- lumon-voice:footer -->
