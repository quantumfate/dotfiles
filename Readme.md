# My Dotfiles managed with [Chezmoi](https://www.chezmoi.io)

This repository only serves me.

## Features

- Colorscheme: [Catppuccin](https://catppuccin.com/),
  - Flavour: Macchiato
  - accent: Mauve
- Terminal Emulator: [Kitty](https://sw.kovidgoyal.net/kitty/)
- Application Launcher: [Rofi](https://github.com/davatorium/rofi)
- Editor: [Neovim](https://github.com/neovim/neovim) with [my config](https://github.com/quantumfate/nvim)
- Monitor Management: [Kanshi](https://sr.ht/~emersion/kanshi/)
- Bar: [Waybar](https://github.com/Alexays/Waybar)
- PDF Viewer: [Zathura](https://github.com/pwmt/zathura)
- Notifications: [Mako](https://github.com/emersion/mako)

### Destop Environments

- [Hyprland](https://hypr.land/) with my [config](https://github.com/quantumfate/hypr)

#### Planned

- [Niri](https://github.com/YaLTeR/niri)
- [MangoWC](https://github.com/DreamMaoMao/mangowc)
- [Sway](https://github.com/swaywm/sway)

### Browser

- [Firefox](https://github.com/mozilla-firefox/firefox) and [Zen](https://github.com/zen-browser/desktop)

#### Hardening

- [yokoffing/betterfox](https://github.com/yokoffing/BetterFox),
  - [user.js](./user.js) injected with [this script](./.chezmoiscripts/run_after_05-install-userjs-for-browser.sh.tmpl)
- [uBlock Origin](https://ublockorigin.com/)
  - [yokoffing/filterlits](https://github.com/yokoffing/filterlists)
- [Clear URLs](https://github.com/ClearURLs/Addon)

### Custom Dvorak layout

[My layout](./dot_local/share/xkb/symbols/dvorak-custom) is inspired by [ThePrimeagen/keyboards](https://github.com/ThePrimeagen/keyboards/tree/master)
and installed vie [this script](./.chezmoiscripts/run_after_15-install-layout.sh).

- Legend: lower SHIFT (Programmer Dvorak-style number row: 9 7 5 3 1 0 2 4 6 8)
- AltGr = Level 3 (dead keys: ´ ¨ ¸ ˇ ˙ ^ ` ˜ ˛ ˝)

#### Base Layer

```ascii
┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬──────────┐
│  $  │  +  │  [  │  {  │  (  │  &  │  =  │  )  │  }  │  ]  │  *  │  !  │  `  │  Bksp    │
├─────┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬───────┤
│ Tab    │  ;  │  ,  │  .  │  p  │  y  │  f  │  g  │  c  │  r  │  l  │  /  │  @  │   \   │
├────────┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴───────┤
│ Caps     │  a  │  o  │  e  │  u  │  i  │  d  │  h  │  t  │  n  │  s  │  -  │   Enter   │
├──────────┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴───────────┤
│ Shift       │  '  │  q  │  j  │  k  │  x  │  b  │  m  │  w  │  v  │  z  │    Shift     │
├───────┬─────┴─┬───┴───┬─┴─────┴─────┴─────┴─────┴─────┴───┬─┴───┬─┴───┬─┴───┬──────────┤
│ Ctrl  │ Super │  Alt  │             Space                 │AltGr│Super│ Menu│   Ctrl   │
└───────┴───────┴───────┴───────────────────────────────────┴─────┴─────┴─────┴──────────┘
```

#### Shift Layer

```ascii
┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬──────────┐
│  ~  │  %  │  9  │  7  │  5  │  3  │  1  │  0  │  2  │  4  │  6  │  8  │  #  │  Bksp    │
├─────┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬───────┤
│ Tab    │  :  │  <  │  >  │  P  │  Y  │  F  │  G  │  C  │  R  │  L  │  ?  │  ^  │   |   │
├────────┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴─┬───┴───────┤
│ Caps     │  A  │  O  │  E  │  U  │  I  │  D  │  H  │  T  │  N  │  S  │  _  │   Enter   │
├──────────┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴───────────┤
│ Shift       │  "  │  Q  │  J  │  K  │  X  │  B  │  M  │  W  │  V  │  Z  │    Shift     │
├───────┬─────┴─┬───┴───┬─┴─────┴─────┴─────┴─────┴─────┴───┬─┴───┬─┴───┬─┴───┬──────────┤
│ Ctrl  │ Super │  Alt  │             Space                 │AltGr│Super│ Menu│   Ctrl   │
└───────┴───────┴───────┴───────────────────────────────────┴─────┴─────┴─────┴──────────┘
```
