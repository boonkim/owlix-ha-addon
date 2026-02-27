#!/bin/sh
set -e

# Read owlix_api_key (tunnel token) from Home Assistant options
# In HA add-on runtime: /data/options.json
# For local/docker-compose: use TUNNEL_TOKEN env or mount options.json
CONFIG_PATH="${CONFIG_PATH:-/data/options.json}"

if [ -f "$CONFIG_PATH" ]; then
  TOKEN="$(jq -r '.owlix_api_key // empty' "$CONFIG_PATH")"
fi

# Allow override from environment (e.g. docker-compose or future Backend)
if [ -z "$TOKEN" ] && [ -n "$TUNNEL_TOKEN" ]; then
  TOKEN="$TUNNEL_TOKEN"
fi

if [ -z "$TOKEN" ]; then
  echo "Error: No tunnel token. Set owlix_api_key in add-on Options or TUNNEL_TOKEN env."
  exit 1
fi

exec cloudflared tunnel --no-autoupdate run --token "$TOKEN"
