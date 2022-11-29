#!/usr/bin/env sh

set -eu

killall pcbnew || true
podman run --rm -v ${PWD}:/build ghcr.io/kobrakeyboards/kobragen:latest kobragen example.yaml example
pcbnew output/pcbs/example-routed.kicad_pcb 2> /dev/null &
