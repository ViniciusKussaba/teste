#!/bin/bash

set -e

echo "=== BUNDLING ==="
bundle check || bundle install --jobs 20 --retry 5 --binstubs="$BUNDLE_BIN"

COMMAND="$1"

case "$COMMAND" in
  server)
    echo "=== RUNNING SERVER ON PORT 3000 ==="
    rm -f /web/tmp/pids/server.pid
    rails s -b '0.0.0.0'
    ;;
  *)
    echo "=== RUNNING COMAND -> $* ==="
    sh -c "$*"
    ;;
esac
