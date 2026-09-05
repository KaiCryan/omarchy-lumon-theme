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
| [omarchy-lumon-wallpapers](https://github.com/KaiCryan/omarchy-lumon-wallpapers) | real severed-floor stills, opening-titles frames + 4K brand set, hourly cycler |
| [omarchy-lumon-screensaver](https://github.com/KaiCryan/omarchy-lumon-screensaver) | capped-fps `ttfx` effects + an ambient scene reel |
| **omarchy-lumon-theme** | colour scheme, Hyprland look’n’feel, `fastfetch` + about branding &nbsp;·&nbsp; ← you are here |
| [omarchy-desktop-quote](https://github.com/KaiCryan/omarchy-desktop-quote) | a rotating quote placard over the wallpaper, auto-picks the emptiest side |
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
- **cliamp** — a Lumon UI theme for the [cliamp](https://github.com/bjarneo/cliamp)
  terminal music player, if it's installed, plus two Lua plugins:
  - `lumon-mdr` — a custom **visualizer**. Instead of an equaliser, the floor
    is a dense, perfectly aligned grid of numbers — every cell always full,
    like a wall of refined data rather than a bar chart. The music changes
    how fast each column refines its value (idle: barely moves; loud: cycles
    briskly), plus one bracketed cluster of "flagged" numbers drifting across
    a row at a slow, deliberate pace. Boxed in a hairline CRT-panel frame
    with a coarse scanline tint on alternating rows and a footer line
    (`MDR-7 STATUS: NOMINAL ... REC 04:12`) with a timer that burns in for
    the length of the session. Set as the default visualizer.
  - `lumon-flavor` — the rest of the terminal, in two voices. A cold machine
    voice runs the boot sequence on start (`SELF-TEST...` /
    `CALIBRATING WAVEFORM SENSORS...` / `MODULE READY.`) and answers **F9**
    with a one-line diagnostics readout that cycles on repeat presses
    (`CORE TEMP: 41C -- NOMINAL`, `OUTIE STATUS: UNVERIFIABLE`, …). A
    corporate-human voice handles the welcome line, an occasional remark on
    track change ("This selection has been approved by the board.",
    sometimes rendered through a bit of static — `Th▓s selection...` — like a
    dying CRT), and a farewell notification on quit.

  Both plugins are trusted automatically by `install.sh` — they're ours, and
  you can read them at `cliamp/plugins/*.lua` before it does. If you're
  installing this on someone else's machine, read them first; `cliamp plugins
  trust` shows the same SHA-256 + permissions prompt either way.

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
