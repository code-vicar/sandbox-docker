#!/bin/bash
set -e

# if command starts with an option, prepend sandbox run
if [ "${1:0:1}" = '-' ]; then
  set -- ./sandbox run "$@"
fi

if [ "$1" = './sandbox' ]; then
  echo "Starting sandbox"
  exec /gosu sandbox "$@"
fi

echo "Passthrough command"
exec "$@"
