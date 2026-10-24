#!/bin/sh
# Verifies the Docker daemon is up and every Command 360 service is running and healthy.
# Exit code 0 = all good, 1 = daemon down, 2 = at least one service not healthy.
cd "$(dirname "$0")/.." || exit 1

if ! docker info >/dev/null 2>&1; then
	echo "FAIL: Docker daemon is not reachable. Start Docker Desktop (or: systemctl start docker)."
	exit 1
fi

docker compose up -d --remove-orphans >/dev/null

bad=$(docker compose ps --format '{{.Service}} {{.State}} {{.Health}}' | awk '$2 != "running" || ($3 != "" && $3 != "healthy") {print}')
docker compose ps

if [ -n "$bad" ]; then
	echo "FAIL: not healthy:"
	echo "$bad"
	exit 2
fi
echo "OK: all services running and healthy."
