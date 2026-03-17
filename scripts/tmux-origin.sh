#!/usr/bin/env bash
set -euo pipefail

pid="$(tmux display -p "#{pid}" 2>/dev/null || true)"
if [ -z "$pid" ]; then
  exit 0
fi

while [ "$pid" -gt 1 ]; do
  cmd="$(ps -o command= -p "$pid" 2>/dev/null || true)"
  if echo "$cmd" | grep -q ".app/Contents/MacOS"; then
    echo "$(basename "$cmd")"
    exit 0
  fi
  if echo "$cmd" | grep -q "sshd-keygen-wrapper"; then
    echo "sshd"
    exit 0
  fi
  if echo "$cmd" | grep -q "loginwindow"; then
    echo "loginwindow"
    exit 0
  fi
  pid="$(ps -o ppid= -p "$pid" 2>/dev/null | tr -d ' ' || true)"
  if [ -z "$pid" ]; then
    break
  fi
done

echo "unknown"
