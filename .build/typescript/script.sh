#!/bin/bash
set -euo pipefail
set -f # disable automatic globbing

npm install --quiet
# shellcheck disable=SC2068
/node_modules/.bin/tsc $@
