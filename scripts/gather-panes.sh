#!/bin/sh

name=$1
[ -z "$name" ] && exit 0

matches=$(
  tmux list-panes -a -F "#{pane_id}|#{pane_tty}" |
  while IFS="|" read -r pane_id pane_tty; do
    [ -z "$pane_tty" ] && continue
    tty=${pane_tty#/dev/}
    if ps -t "$tty" -o command= 2>/dev/null | grep -Fqi -- "$name"; then
      printf "%s\n" "$pane_id"
    fi
  done
)

if [ -z "$matches" ]; then
  tmux display-message "No panes found for $name"
  exit 0
fi

target_window=$(tmux new-window -P -F "#{window_id}" -n "proc-$name")

first=1
printf "%s\n" "$matches" | while IFS= read -r pane_id; do
  [ -z "$pane_id" ] && continue
  if [ "$first" -eq 1 ]; then
    target_pane=$(tmux list-panes -t "$target_window" -F "#{pane_id}")
    tmux respawn-pane -t "$target_pane" -k "exec ~/.config/tmux/scripts/mirror-pane.sh \"$pane_id\""
    first=0
  else
    tmux split-window -t "$target_window" -d "exec ~/.config/tmux/scripts/mirror-pane.sh \"$pane_id\""
  fi
done

tmux select-layout -t "$target_window" tiled
