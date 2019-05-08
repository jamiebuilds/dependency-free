#!/bin/bash
set -euo pipefail
set -f # disable automatic globbing

cmd=${1:-"build"}
args="${*:1}"

npm install --quiet --production
if [ "$cmd" != "build" ]; then
  # shellcheck disable=SC2086
  /node_modules/.bin/parcel $cmd $args --port 8000 --hmr-port 8080
else
  # shellcheck disable=SC2086
  /node_modules/.bin/parcel build $args
fi
