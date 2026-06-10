#!/bin/bash
# Deploy AePDS uptime monitor on dilbert (Tailscale node)

set -e
CONFIG_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$CONFIG_DIR"

if [ ! -f config.yaml ]; then
    echo "ERROR: config.yaml not found"
    exit 1
fi

docker pull twinproduction/gatus:latest

if docker ps -a --format '{{.Names}}' | grep -q '^aepds-uptime$'; then
    docker stop aepds-uptime 2>/dev/null || true
    docker rm aepds-uptime 2>/dev/null || true
fi

docker volume inspect aepds-uptime-data &>/dev/null || docker volume create aepds-uptime-data

docker run -d \
    --name aepds-uptime \
    --restart unless-stopped \
    -p 8080:8080 \
    -v "$(pwd)/config.yaml:/config/config.yaml:ro" \
    -v aepds-uptime-data:/data \
    -e GATUS_CONFIG_PATH=/config/config.yaml \
    twinproduction/gatus:latest

echo "Dashboard: http://localhost:8080"
sleep 3
curl -so /dev/null -w "Status: %{http_code}\n" http://localhost:8080/health
