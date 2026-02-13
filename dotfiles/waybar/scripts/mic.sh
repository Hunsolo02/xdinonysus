#!/bin/bash
# ── mic.sh ─────────────────────────────────────────────────
# Description: Shows microphone mute/unmute status with icon
# Usage: Called by Waybar `custom/microphone` module every 1s
# Dependencies: pactl (PulseAudio / PipeWire)
# ───────────────────────────────────────────────────────────


if pactl get-source-mute @DEFAULT_SOURCE@ | grep -q 'yes'; then
  # Muted → mic-off icon
  echo "<span foreground='#e78a4e'>[  ]</span>"
else
  # Active → mic-on icon
  echo "<span foreground='#89b482'>[  ]</span>"
fi

