#!/bin/bash
set -e

if [ "$1" = 'sandbox' ]; then
  echo "Starting sandbox"
  exec /gosu sandbox "$@"
fi

echo "Passthrough command"
exec "$@"
