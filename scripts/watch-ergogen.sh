#!/usr/bin/env sh

set -eu

while inotifywait example.yaml; do
  ./scripts/dev-ergogen.sh
done
