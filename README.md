# AePDS Uptime Monitor

[![AePDS Health Dashboard](https://img.shields.io/badge/dashboard-aepds--uptime.fly.dev-00b4d8)](https://aepds-uptime.fly.dev)

Uptime monitoring dashboard for Indian state AePDS (Aadhaar-enabled Public Distribution System) portals, state PDS portals, and central NIC food infrastructure websites. Powered by [Gatus](https://gatus.io/).

## Monitored Portals

### AePDS PoS Transaction Portals (23 states/UTs)

Andhra Pradesh, Andaman and Nicobar, Arunachal Pradesh, Assam, Bihar, Chandigarh, Daman and Diu, Delhi, Goa, Haryana, Jammu and Kashmir, Kerala, Ladakh, Lakshadweep, Madhya Pradesh, Maharashtra, Manipur, Meghalaya, Mizoram, Nagaland, Punjab, Sikkim, Tripura

### Other State PDS Portals (15 states/UTs)

Andaman DCSCA, Chhattisgarh, Gujarat, Himachal Pradesh, Jharkhand, Karnataka, Lakshadweep (Dhaanyapurti), Odisha, Puducherry, Rajasthan, Tamil Nadu, Telangana, Uttar Pradesh, Uttarakhand, West Bengal

### Central / NIC Portals

Annavitran Portal, NFSA Portal, ePDS NIC Landing

Total: **41 endpoints** checked every 5-10 minutes.

## Deployment

### Option 1: Docker (recommended for Indian hosts like dilbert)

```bash
docker compose up -d
```

Dashboard at `http://localhost:8080`.

### Option 2: Fly.io

```bash
flyctl launch --copy-config --no-deploy
flyctl deploy
```

Dashboard at `https://aepds-uptime.fly.dev`.

### Option 3: Docker on any host

```bash
docker run -d --name aepds-uptime \
  -p 8080:8080 \
  -v $(pwd)/config.yaml:/config/config.yaml:ro \
  -v gatus-data:/data \
  -e GATUS_CONFIG_PATH=/config/config.yaml \
  twinproduction/gatus:latest
```

## Customization

- **Edit portals**: modify `config.yaml` under `endpoints`
- **Alerting**: Gatus supports email, Slack, Discord, Telegram, PagerDuty, and more
- **Custom domain**: use a reverse proxy (nginx/caddy) or Fly.io custom domains

## Data

- Gatus stores check history in SQLite at `/data/gatus.db`
- This is ephemeral — persists only within the Docker volume

## License

MIT
