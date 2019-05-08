#!/bin/bash
set -euo pipefail
set -f # disable automatic globbing

npm install --quiet --production
# shellcheck disable=SC2068
/node_modules/.bin/jest $@
