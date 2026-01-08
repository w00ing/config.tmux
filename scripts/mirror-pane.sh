#!/bin/sh

pane_id=$1
[ -z "$pane_id" ] && exit 0

while true; do
  if ! tmux list-panes -a -F "#{pane_id}" | grep -qx "$pane_id"; then
    printf '\033[H\033[J'
    printf "Pane %s closed\n" "$pane_id"
    sleep 2
    continue
  fi

  height=$(tmux display-message -p -t "$pane_id" "#{pane_height}")
  if [ -n "$height" ]; then
    start=$((0 - height))
  else
    start=-200
  fi

  printf '\033[H\033[J'
  tmux capture-pane -pt "$pane_id" -S "$start"
  sleep 1
done
