#!/bin/bash
# ── nordvpn-status.sh ──────────────────────────────────────
# Description: Checks if VPN interface is active via IP range
# Usage: Called by Waybar `custom/vpn` every 5s
# Dependencies: ip, curl (optional, for country lookup)
# Output: Pango markup → [ФАНТОМ]: Country or KAPUTT
# Example: <span foreground='#e78a4e'>[ФАНТОМ]: Japan</span>
#          <span foreground='#ea6962'>[ФАНТОМ]: KAPUTT</span>
# ───────────────────────────────────────────────────────────

#!/bin/bash

if sudo ipsec statusall 2>/dev/null | grep -q "ESTABLISHED"; then
  country=$(curl -s ifconfig.co/country 2>/dev/null)
  [[ -z "$country" ]] && country="UNKNOWN"
  echo "<span foreground='#e78a4e'>[ФАНТОМ]: $country</span>"
else
  echo "<span foreground='#ea6962'>[ФАНТОМ]: KAPUTT</span>"
fi

