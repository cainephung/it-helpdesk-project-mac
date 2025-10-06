# Help Desk Ticketing System with Automation (macOS + Docker)

This project sets up a **self-hosted osTicket** help desk on your Mac using Docker, and adds **automation scripts** and a **mini knowledge base** for a realistic Tier‑1/Tier‑2 support portfolio.

## What You Get
- Dockerized **osTicket v1.18.2** + **MariaDB 11**
- Ready-to-run `docker-compose.yml`
- macOS support scripts (reset Wi‑Fi, flush DNS, diagnostics)
- Sample Knowledge Base articles (`/kb`)
- Example SQL queries for reporting (`/sql`)
- Screenshot placeholders (`/.screenshots`)

---

## 1) Prereqs (macOS)
1. Install **Homebrew** (if you don't have it):
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
2. Install **Docker Desktop**:
   ```bash
   brew install --cask docker
   open -a Docker
   ```
   Wait for the little whale icon to stop animating (Docker running).

> **Apple Silicon note:** The official image usually works. If you hit a `no matching manifest` error, either uncomment the `platform: linux/amd64` line under the `osticket` service in `docker-compose.yml` **or** switch the image to `rinkp/osticket-dockerized` which supports `arm64`.

---

## 2) Start the stack
From this folder:
```bash
docker compose up -d
docker compose ps
```
- App will be at **http://localhost:8080/**
- Admin panel lives at **http://localhost:8080/scp**

To see logs:
```bash
docker compose logs -f osticket
```

To stop:
```bash
docker compose down
```

To wipe data and start over:
```bash
docker compose down -v
```

---

## 3) First-time web setup
Open **http://localhost:8080/** → follow the installer.
Use these DB settings when prompted:
- **MySQL Host:** `db`
- **Database Name:** `osticket`
- **MySQL Username:** `osticket`
- **MySQL Password:** `changeme`

Create your **Admin** account during setup.
When installation finishes, log in to **http://localhost:8080/scp**.

> The image persists config & data in Docker volumes (`db_data`, `osticket_site`).

---

## 4) Configure osTicket (recommended)
In **Admin Panel → Settings**:
- **Company Info:** Set your mock company (e.g., _Caine Support_).
- **Departments / Teams:** IT, Service Desk, Networking.
- **Agents:** Create a couple of agent accounts.
- **Help Topics:** Wi‑Fi Issues, VPN, Email/Outlook, Printer, Hardware.
- **SLA:** e.g., SEV‑1 4h, SEV‑2 1 business day.
- **Canned Responses:** Add 2–3.

---

## 5) Create practice tickets
Open **http://localhost:8080/** (user portal) → **Open a New Ticket**.
Suggested real-world samples:
1. **Wi‑Fi drops every 5 mins** (attach a screenshot if you want)
2. **VPN: “Auth failed” after password change**
3. **Printer not found on Wi‑Fi**

As an Agent, triage these in **/scp**:
- Set **priority**, **department**, **help topic**.
- Add **internal notes** describing your troubleshooting.
- Add **public replies** with instructions (link to KB pages in `/kb`).

Export CSV from Tickets if you want metrics: **Tickets → Export**.

---

## 6) macOS Support Scripts
Scripts are in `/scripts/mac` — don’t forget to make them executable:
```bash
chmod +x scripts/mac/*.sh
```

- `reset_wifi.sh` – Turn Wi‑Fi off/on and renew DHCP
- `flush_dns.sh` – Flush macOS DNS cache
- `collect_diagnostics.sh` – Gather system/network info into `/scripts/mac/logs`

You can reference these from KB pages and attach outputs to tickets.

---

## 7) Reporting (SQL)
Examples are under `/sql`. To run a query:
```bash
docker exec -it osticket-db mariadb -u root -p
# password: changeme-root
USE osticket;
SOURCE /sql/avg_resolution_time.sql;  -- or paste the query here
```

---

## 8) (Optional) Remote Support
For demos, install **RustDesk** on your Mac and another device to simulate remote access. (See vendor docs.)

---

## 9) Portfolio Tips
Add screenshots from:
- **Dashboard** and **Ticket view** (with your notes)
- **KB article**
- **Script output** (Terminal)
Keep them in `/.screenshots` and embed them into your GitHub README.

---

## Common Docker Commands
```bash
# Start / Stop / Reset
docker compose up -d
docker compose down
docker compose down -v   # remove volumes (data)

# Check container logs
docker compose logs -f osticket
docker compose logs -f db

# Shell into the osTicket container
docker exec -it osticket-app bash

# Shell into MariaDB
docker exec -it osticket-db mariadb -u root -p
```
