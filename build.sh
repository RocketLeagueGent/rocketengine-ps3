#!/usr/bin/env bash
# [rocketengine] Build RocketEngine PS3 pkg. Requires setup.sh completed once.
set -e
export PS3DEV=/usr/local/ps3dev
export PSL1GHT=$PS3DEV
export PATH=$PATH:$PS3DEV/bin:$PS3DEV/ppu/bin:$PS3DEV/spu/bin

cd app
make -f Makefile pkg
cd ..

pkg="$(ls app/*.pkg | head -1)"
cp "$pkg" RocketEngine_v0.1.pkg
echo "== DONE: $(pwd)/RocketEngine_v0.1.pkg =="
ls -l RocketEngine_v0.1.pkg
