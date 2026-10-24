# Command 360 deployment

Start everything: `cp .env.example .env`, edit it, then `docker compose up -d`.
Verify: `./scripts/check.sh`

Restart behavior
- Every service uses `restart: unless-stopped`, so containers return after a crash or a Docker restart.
- The autoheal service restarts containers that are running but unhealthy.
- The Docker daemon itself must start at boot. On Linux: `systemctl enable docker`.
  On Docker Desktop (Windows/Mac): Settings > General > "Start Docker Desktop when you sign in",
  and keep the user session logged in or enable auto-login on the host.

Assumptions to adjust: API listens on 8080 with GET /healthz, web listens on 3000, images are set in .env.
