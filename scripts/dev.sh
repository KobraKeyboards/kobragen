#!/usr/bin/env sh

set -eu

killall pcbnew || true
podman run --rm -v ${PWD}:/build kobragen:latest ergogen example.yaml
pcbnew output/pcbs/example.kicad_pcb 2> /dev/null &
