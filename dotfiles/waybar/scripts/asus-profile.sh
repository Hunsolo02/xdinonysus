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
    fg="#ea6962"
    ;;
  Balanced)
    text="STABILIZATION"
    fg="#e78a4e"
    ;;
  Quiet)
    text="REACTOR SLEEP"
    fg="#89b482"
    ;;
  *)
    text="ASUS ??"
    fg="#ddc7a1"
    ;;
esac

echo "<span foreground='$fg'>$text</span>"

