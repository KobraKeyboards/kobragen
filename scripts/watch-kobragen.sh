#!/usr/bin/env sh

set -eu

while inotifywait example.yaml; do
  ./scripts/dev-kobragen.sh
done
