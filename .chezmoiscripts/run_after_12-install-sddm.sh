#!/bin/bash
# Sets up SDDM as the display manager (X11 greeter; lists Wayland sessions).
# Replaces the former greetd + dms-greeter setup and tears greetd down.

echo ""
echo "[INFO] Installing SDDM ..."

sudo -v
set -euo pipefail

SDDM_CONF_DIR="/etc/sddm.conf.d"
THEME_PKG="catppuccin-sddm-theme-macchiato"
KEYMAP_LAYOUT="dvorak-custom"

# --- Packages ---
for pkg in sddm "$THEME_PKG"; do
  if ! pacman -Qi "$pkg" &>/dev/null; then
    echo "  installing $pkg ..."
    yay -S --needed --noconfirm "$pkg"
  fi
done
echo "  ✓ sddm + theme present"

# --- Remove systemd autologin (greetd-era leftover) ---
AUTOLOGIN_OVERRIDE="/etc/systemd/system/getty@tty1.service.d/autologin.conf"
if [ -f "$AUTOLOGIN_OVERRIDE" ]; then
  sudo rm "$AUTOLOGIN_OVERRIDE"
  sudo systemctl daemon-reload
  sudo systemctl disable getty@tty1
  echo "  ✓ systemd autologin removed"
fi

# --- Tear down greetd / dms-greeter ---
if systemctl is-enabled greetd &>/dev/null; then
  sudo systemctl disable greetd || true
  echo "  ✓ greetd disabled"
fi
sudo rm -f /etc/systemd/system/greetd.service.d/sleep.conf
sudo rm -rf /etc/greetd /var/cache/dms-greeter
if id greeter &>/dev/null; then
  sudo userdel greeter 2>/dev/null || true
  sudo rm -rf /var/lib/greeter
  echo "  ✓ greeter user removed"
fi

# --- Disable any other display managers ---
for dm in gdm lightdm lxdm ly tuigreet; do
  if systemctl is-enabled "$dm" &>/dev/null; then
    sudo systemctl disable "$dm" || true
    echo "  ✓ $dm disabled"
  fi
done

# --- SDDM theme ---
THEME_LIST=$(pacman -Qlq "$THEME_PKG" 2>/dev/null) || THEME_LIST=""
THEME_NAME=$(printf '%s\n' "$THEME_LIST" |
  sed -n 's#^/usr/share/sddm/themes/\([^/]*\)/.*#\1#p' | sort -u)
sudo mkdir -p "$SDDM_CONF_DIR"
if [ -n "$THEME_NAME" ] && [ "$(printf '%s' "$THEME_NAME" | grep -c 'mauve')" -eq 1 ]; then
  sudo tee "$SDDM_CONF_DIR/theme.conf" >/dev/null <<EOF
[Theme]
Current=$(echo "$THEME_NAME" | grep "mauve")
EOF
  echo "  ✓ sddm theme set to $(echo "$THEME_NAME" | grep "mauve")"
else
  echo "  ! could not resolve theme dir from $THEME_PKG — leaving default theme"
fi

# --- X11 greeter keymap ---
# Xsetup runs as root on the greeter's X server before the login screen draws.
# Loads the custom layout installed by run_onchange_after_01-install-layout.sh.
XSETUP="/etc/sddm/Xsetup"
sudo mkdir -p /etc/sddm
sudo tee "$XSETUP" >/dev/null <<EOF
#!/bin/sh
# Managed by chezmoi (run_after_12-install-sddm.sh). Sets the SDDM greeter keymap.
setxkbmap $KEYMAP_LAYOUT
EOF
sudo chmod 755 "$XSETUP"
sudo tee "$SDDM_CONF_DIR/keyboard.conf" >/dev/null <<EOF
[X11]
DisplayCommand=$XSETUP
EOF
echo "  ✓ greeter keymap set to $KEYMAP_LAYOUT (Xsetup)"

# --- PAM keyring unlock ---
PAM_SDDM="/etc/pam.d/sddm"
if { [ -f /usr/lib/security/pam_gnome_keyring.so ] ||
  [ -f /usr/lib64/security/pam_gnome_keyring.so ]; } && [ -f "$PAM_SDDM" ]; then
  if ! grep -q pam_gnome_keyring "$PAM_SDDM"; then
    sudo tee -a "$PAM_SDDM" >/dev/null <<'EOF'

auth       optional     pam_gnome_keyring.so
password   optional     pam_gnome_keyring.so
session    optional     pam_gnome_keyring.so auto_start
EOF
    echo "  ✓ pam_gnome_keyring wired into sddm"
  else
    echo "  ✓ pam_gnome_keyring already present in sddm PAM"
  fi
else
  echo "  ! gnome-keyring PAM module missing — skipping keyring unlock"
fi

# --- Drop the DankMaterialShell user service ---
if systemctl --user show-environment >/dev/null 2>&1; then
  systemctl --user daemon-reload || true
  if systemctl --user is-enabled dms.service &>/dev/null; then
    systemctl --user disable dms.service || true
    echo "  ✓ dms.service disabled (user)"
  fi
fi

# --- Enable SDDM ---
sudo systemctl daemon-reload
sudo systemctl enable --force sddm.service
echo "  ✓ sddm enabled"

if [ ! -e /usr/share/wayland-sessions/hyprland.desktop ]; then
  echo "  ! no Hyprland session file in /usr/share/wayland-sessions/"
fi

echo "  → reboot to switch to SDDM"
