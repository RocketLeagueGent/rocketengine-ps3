# RocketEngine PS3

PS3 build of RocketEngine (homebrew, installs on PS3HEN via "Install Package Files").
Built **entirely in GitHub Codespaces** — nothing is compiled locally.

## One-time setup (in a Codespace terminal, ~1–2 h, runs unattended)

```bash
./setup.sh
```

Installs apt deps, builds the PS3 toolchain (PPU gcc, signing tools) into `/usr/local/ps3dev`,
then PSL1GHT. Safe to re-run — skips finished steps.

## Build the PKG (seconds)

```bash
./build.sh
```

Produces `RocketEngine_v0.1.pkg` in the repo root. Download it from the Codespace
file explorer (right-click → Download), put it on a FAT32 USB, install on Pana's
HEN'd PS3 via XMB → Package Directory / Install Package Files.

## Layout

- `setup.sh` — environment bootstrap (apt + ps3toolchain + PSL1GHT)
- `build.sh` — env vars + `make pkg` wrapper
- `app/` — the PS3 application (`source/main.c`, Makefile adapted from PSL1GHT rsxtest)
