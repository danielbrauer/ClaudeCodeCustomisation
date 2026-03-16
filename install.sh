#!/bin/bash
set -e

repo_dir="$(cd "$(dirname "$0")" && pwd)"

mkdir -p ~/.claude

for file in settings.json statusline.sh; do
  target="$HOME/.claude/$file"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "Backing up existing $target to ${target}.bak"
    mv "$target" "${target}.bak"
  fi
  ln -sf "$repo_dir/$file" "$target"
  echo "Linked $target -> $repo_dir/$file"
done
