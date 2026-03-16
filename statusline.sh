#!/bin/bash
# Claude Code status line hook
input=$(cat)
model=$(echo "$input" | jq -r '.model.display_name // "?"' 2>/dev/null | awk '{print $1}')
pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0' 2>/dev/null)
pct=${pct%%.*}

# Write to temp file keyed by tmux session (for gt status-line to read)
if [ -n "$TMUX" ]; then
  session=$(tmux display-message -p '#{session_name}' 2>/dev/null)
  if [ -n "$session" ] && [ -n "$pct" ]; then
    printf '%s' "$pct" > "/tmp/gt-context-${session}.pct"
  fi
fi

# Output status line
printf '\033[38;5;147m%s\033[0m | 🧠 %s%%\n' "$model" "$pct"
