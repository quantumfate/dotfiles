# Dotfiles & Scripts Refactor — TODO

**Goal:** one source of truth per thing. Kill copy / dual-maintenance. Right tool per scope.

---

## Current state (found on system)

- chezmoi source: `~/.local/share/chezmoi` (git repo) — manages `$HOME` dotfiles. Keep.
- `.chezmoiscripts/` — ~25 `run_*` scripts. Mix of **system-scope** and **user-scope**.
- `00-clone-repos.sh.tmpl` clones repos with an `:up` / `:down` convention:
  - `:up`   → `~/Projects/<host>/<owner>/<repo>`            (development clone)
  - `:down` → `~/.local/share/own-scripts/<host>/<owner>/<repo>` (runtime clone, script repos)
  - `:down` → `~/.config/...`                               (config repos: hypr, nvim — single clone, fine)
- **Dual-cloned repos (the pain):** `scripts`, `dofus-scripts`, `security-and-privacy` — each cloned twice. Edit in `:up`, push, `:down` pulls. Two working copies.
- `~/.local/bin` is on PATH — holds `wm` (chezmoi-managed) + venv shims. **Your script repos are NOT on PATH.**
- PATH exports live in `.zshrc` (interactive only) — **not `.zshenv`**. systemd user units / hypr `exec` don't see custom PATH.
- No `.chezmoiignore`.

---

## Phase 1 — Kill the dual-clone (biggest win)

Each owned script repo is cloned twice. Collapse to ONE.

- [ ] Pick single home per repo: `~/Projects/<host>/<owner>/<repo>`. That clone = dev **and** runtime.
- [ ] Affected repos: `scripts`, `dofus-scripts`, `security-and-privacy`.
- [ ] Edit `00-clone-repos.sh.tmpl`: drop the `:up`/`:down` split. One entry per repo, one target dir.
- [ ] Delete `~/.local/share/own-scripts/` once nothing references it.
- [ ] Result: edit → commit → push = done. No second clone, no `git pull` of a deployed copy.

---

## Phase 2 — Scripts on PATH (kill manual sourcing)

- [ ] In each script repo, put executables in a `bin/` subdir (keep README, `lib/`, tests OFF PATH).
- [ ] Split sourced libs (functions/aliases/env — must be `source`d) into a `shell/` dir.
- [ ] Move ALL `export PATH=` lines from `.zshrc` → `.zshenv`, so hypr `exec`, systemd user units, cron see them. Use array form:
  ```sh
  typeset -U path
  path=( "$HOME/Projects/github/quantumfate/scripts/bin" $path )
  ```
- [ ] Add each repo's `bin/` to PATH the same way.
- [ ] One source loop in `.zshrc` replaces all manual sourcing:
  ```sh
  for f in "$HOME/Projects/github/quantumfate/scripts/shell/"*.zsh(N); do source "$f"; done
  ```
- [ ] Confirm executable bit is committed (`chmod +x` before commit; fresh clone must stay executable).

---

## Phase 3 — Shadowing guard

PATH = first match wins. Prevent personal scripts shadowing system binaries (e.g. `nvim`).

- [ ] Prefix all personal executables with `,` (comma) — `,backup`, `,tag-photos`. No system binary starts with `,` → zero shadow risk + own Tab-completion namespace.
- [ ] Alternative/extra: append script `bin/` to PATH (system binary wins on collision).
- [ ] Optional: pre-commit hook in script repos that flags any script name already on PATH.

---

## Phase 4 — System scope → Ansible


System-scope `.chezmoiscripts` are out of chezmoi's scope. Move to an Ansible localhost playbook — modules give idempotency for free, deletes hand-rolled guards.

System-scope scripts to convert:
`00-install-sudoers`, `01-install-layout`, `01-install-ssh-keys`, `05-install-yay`,
`06-install-dev-env-packages`, `07-install-cockpit-vm-kvm`, `08-configure-tty`,
`09-change-login-shell`, `11-setup-docker`, `12-install-dms-greeter`,
`12-install-epp-performance`, `13-install-clight-geoclue`, `14-restart-clight`, `install-packages`

- [ ] New repo (or dir) `system/` with `playbook.yml`.
- [ ] Map each to real modules:
  - login shell → `ansible.builtin.user:` (`shell:`)
  - services / display manager → `ansible.builtin.systemd:` (`enabled`/`state`)
  - packages → `community.general.pacman:`
  - `/etc` files → `ansible.builtin.copy` / `template` / `lineinfile` / `blockinfile`
  - yay / AUR helper bootstrap → `ansible.builtin.git:` + build step
- [ ] Genuinely odd one-shots that don't map to a module → `ansible.builtin.script:` wrapping the existing script.
- [ ] Track packages: `pacman -Qqe > packages.txt`, restore via a `pacman:` task.
- [ ] Run: `ansible-pull -U <system-repo> playbook.yml --ask-become-pass`.

---

## Phase 5 — Audit remaining `.chezmoiscripts` (user-scope)

A script that just *writes/edits a config file* is a smell — let chezmoi **own the file** instead, then delete the script.

- [ ] Review: `02-xdg`, `03-install-user-units`, `04-install-desktop-entries`,
      `05-install-userjs-for-browser`, `05-prepare-nvim-deps`,
      `00-finalise-theme`, `20-do-additional-theming`.
- [ ] Each: writes a static file → make it a chezmoi-managed file. Genuine action → keep as `run_onchange_`.

---

## Phase 6 — Bootstrap chain (after the split)

Fresh machine:

1. `pacman -S ansible chezmoi git`
2. `ansible-pull -U <system-repo> playbook.yml --ask-become-pass`   → system / distro scope
3. `chezmoi init --apply <dotfiles-repo>`                            → `$HOME` scope (clones script repos once, onto PATH)

---

## End state

- **chezmoi** → `$HOME` dotfiles only.
- **Ansible** → system / distro scope.
- **Script repos** → single clone, `bin/` on PATH, `,`-prefixed, no manual sourcing.
- **Deleted:** `~/.local/share/own-scripts/`, `:up`/`:down` logic, hand-rolled idempotency guards, dual-maintenance.
