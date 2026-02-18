# My Dotfiles managed with [Chezmoi](https://www.chezmoi.io)

I'm ready to go on a new machine with one simple command.

## Features

- Monitor Management: [Kanshi](https://sr.ht/~emersion/kanshi/)
- Greeter: [Tuigreet](https://github.com/NotAShelf/tuigreet)
- UWSM Session Management

### Theming/Ricing

- Colorscheme: [Catppuccin](https://catppuccin.com/) Macchiato Mauve
- qt5ct
- GTK automated with nwg-look

### Desktop Experience

- Application Launcher: [Rofi](https://github.com/davatorium/rofi)
- Notifications: [Mako](https://github.com/emersion/mako)
- Bar: [Waybar](https://github.com/Alexays/Waybar)

#### Desktop Environments

- [Hyprland](https://hypr.land/) with my [config](https://github.com/quantumfate/hypr)

##### Planned

- [Niri](https://github.com/YaLTeR/niri)
- [MangoWC](https://github.com/DreamMaoMao/mangowc)
- [Sway](https://github.com/swaywm/sway)

### Development

- Terminal Emulator: [Kitty](https://sw.kovidgoyal.net/kitty/)
- Editor: [Neovim](https://github.com/neovim/neovim) with [my config](https://github.com/quantumfate/nvim)
- Tmux

### Sysadmin

- Bootstrap my environment with [Cockpit](https://cockpit-project.org/) and [libvrt](https://libvirt.org/), see [here](./.chezmoiscripts/run_after_07-install-cockpit-vm-kvm.sh.tmpl)

### Office

- Note Taking: [Obsidian](https://obsidian.md/) Zettelkasten method
- PDF Viewer: [Zathura](https://github.com/pwmt/zathura)

### Web

- [Firefox](https://github.com/mozilla-firefox/firefox) and [Zen](https://github.com/zen-browser/desktop)

#### Hardening

- [yokoffing/betterfox](https://github.com/yokoffing/BetterFox),
- [user.js](./user.js) injected with [this script](./.chezmoiscripts/run_after_05-install-userjs-for-browser.sh.tmpl)
- [uBlock Origin](https://ublockorigin.com/)
- [yokoffing/filterlits](https://github.com/yokoffing/filterlists)
- [Clear URLs](https://github.com/ClearURLs/Addon)
- Clicking external URLs are parsed through a script via Mime-Type associations that:

1. blocks websites unless they are whitelisted
2. routes whitelisted websites into isolated container

### Custom Dvorak layout

[My layout](./dot_local/share/xkb/symbols/dvorak-custom) is inspired by [ThePrimeagen/keyboards](https://github.com/ThePrimeagen/keyboards/tree/master)
and installed via [this script](./.chezmoiscripts/run_after_15-install-layout.sh).

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
