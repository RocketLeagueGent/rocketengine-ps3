#!/usr/bin/env bash
# [rocketengine] PS3 dev environment bootstrap for GitHub Codespaces (Ubuntu).
# Builds ps3toolchain into /usr/local/ps3dev, then PSL1GHT. Idempotent.
set -e

export PS3DEV=/usr/local/ps3dev
export PSL1GHT=$PS3DEV
export PATH=$PATH:$PS3DEV/bin:$PS3DEV/ppu/bin:$PS3DEV/spu/bin

echo "== apt deps =="
sudo apt-get update -qq
sudo apt-get install -y -qq autoconf automake bison flex gcc g++ libelf-dev make \
  texinfo libncurses-dev patch python-is-python3 subversion wget zlib1g-dev \
  libtool libtool-bin bzip2 libgmp3-dev pkg-config libssl-dev clang >/dev/null

if [ -x "$PS3DEV/ppu/bin/ppu-gcc" ]; then
  echo "== toolchain already built, skipping =="
else
  sudo mkdir -p "$PS3DEV"
  sudo chown -R "$(whoami)" "$PS3DEV"
  echo "== building ps3toolchain (1-2 h, unattended) =="
  rm -rf "$HOME/ps3toolchain"
  git clone --depth 1 https://github.com/ps3dev/ps3toolchain.git "$HOME/ps3toolchain"
  cd "$HOME/ps3toolchain"
  ./toolchain.sh
fi

if [ -d "$PSL1GHT/ppu_rules" ]; then
  echo "== PSL1GHT present, skipping =="
else
  echo "== installing PSL1GHT =="
  rm -rf "$HOME/PSL1GHT-src"
  git clone --depth 1 https://github.com/ps3dev/PSL1GHT.git "$HOME/PSL1GHT-src"
  cd "$HOME/PSL1GHT-src"
  make install-ctrl
  make -j"$(nproc)"
  make install
fi

echo "== DONE: PS3 toolchain ready at $PS3DEV =="
"$PS3DEV/ppu/bin/ppu-gcc" --version | head -1
