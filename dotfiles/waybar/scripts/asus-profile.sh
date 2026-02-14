#!/bin/bash
# ── asus-profile.sh ───────────────────────────────────────  
# Description: Display current ASUS power profile with color
# Usage: Called by Waybar `custom/asus-profile`
# Dependencies: asusctl, awk
# ──────────────────────────────────────────────────────────  

profile=$(asusctl profile -p | awk '/Active profile/ {print $NF}')

case "$profile" in
  Performance)
    text="RAZGON"
    fg="#FF5370"
    ;;
  Balanced)
    text="STABILIZATION"
    fg="#F78C6C"
    ;;
  Quiet)
    text="REACTOR SLEEP"
    fg="#25a2a6"
    ;;
  *)
    text="ASUS ??"
    fg="#eeffff"
    ;;
esac

echo "<span foreground='$fg'>$text</span>"

