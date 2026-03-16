#!/bin/bash
# Claude Code status line hook
input=$(cat)
model=$(echo "$input" | jq -r '.model.display_name // "?"' 2>/dev/null | awk '{print $1}')
pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0' 2>/dev/null)
pct=${pct%%.*}

# Output status line
printf '\033[38;5;147m%s\033[0m | 🧠 %s%%\n' "$model" "$pct"
