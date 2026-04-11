# My Dotfiles managed with [Chezmoi](https://www.chezmoi.io)

I'm ready to go on a new machine with one simple command.

## Features

- Monitor Management: [Kanshi](https://sr.ht/~emersion/kanshi/)
- Greeter: [Tuigreet](https://github.com/NotAShelf/tuigreet)
- UWSM Session Management
- Systemd Autostart with compositor scopes

### Theming/Ricing

- Colorscheme: [Catppuccin](https://catppuccin.com/) Macchiato Mauve
- qt5ct
- GTK automated with nwg-look
- Grub/Limine + TTY with [this script](./.chezmoiscripts/run_after_09-configure-tty.sh.tmpl)

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
and installed via [this script](./.chezmoiscripts/run_after_15-install-layout.sh). Works in Wayland/X11 Sessions as well as TTY.

#### Base Layer

```ascii
            ┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────────┐
 AltGr+S    │  1  │  2  │  3  │  4  │  5  │  6  │  7  │  8  │  9  │  0  │     │     │     │         │
 AltGr      │  ¹  │  ²  │  ³  │  ⁴  │  ⁵  │  ⁶  │  ⁷  │  ⁸  │  ⁹  │  ⁰  │     │  ~̃  │     │         │
 Shift      │  %  │  9  │  7  │  5  │  3  │  1  │  0  │  2  │  4  │  6  │  8  │  #  │     │  Bksp   │
 base       │  +  │  [  │  {  │  (  │  &  │  =  │  )  │  }  │  ]  │  *  │  !  │  `  │     │         │
            ├─────┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬──────┤
 AltGr+S    │        │  ¨  │  ˇ  │  ·  │     │     │     │     │     │     │     │     │  ˘  │      │
 AltGr      │        │  ´  │  ¸  │  ˙  │     │     │     │     │     │     │     │     │  ^  │      │
 Shift      │  Tab   │  :  │  <  │  >  │  P  │  Y  │  F  │  G  │  C  │  R  │  L  │  ?  │  ^  │  |   │
 base       │        │  ;  │  ,  │  .  │  p  │  y  │  f  │  g  │  c  │  r  │  l  │  /  │  @  │  \   │
            ├────────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴┬────┴──────┤
 Shift      │         │  A  │  O  │  E  │  U  │  I  │  D  │  H  │  T  │  N  │  S  │  _  │           │
 base       │  Caps   │  a  │  o  │  e  │  u  │  i  │  d  │  h  │  t  │  n  │  s  │  -  │   Enter   │
            ├─────────┴───┬─┴───┬─┴───┬─┴───┬─┴───┬─┴───┬─┴───┬─┴───┬─┴───┬─┴───┬─┴───┬─┴───────────┤
 AltGr+S    │             │  ˝  │     │     │     │     │     │     │     │     │     │             │
 AltGr      │             │  ˛  │     │     │     │     │     │     │     │     │     │             │
 Shift      │   Shift     │  "  │  Q  │  J  │  K  │  X  │  B  │  M  │  W  │  V  │  Z  │   Shift     │
 base       │             │  '  │  q  │  j  │  k  │  x  │  b  │  m  │  w  │  v  │  z  │             │
            ├──────┬──────┼─────┴┬────┴─────┴─────┴─────┴─────┴─────┴─────┴┬────┴─────┼─────┬───────┤
            │ Ctrl │ Super│ Alt  │                  Space                  │   AltGr  │ Menu│ Ctrl  │
            └──────┴──────┴──────┴─────────────────────────────────────────┴──────────┴─────┴───────┘
```
