#!/usr/bin/env bash
# git-helper.sh
# Simple wrapper to run git via AppleScript do shell script.
osascript -e "do shell script \"cd /Users/pjk/code/ai-context-tree && git $*\""
