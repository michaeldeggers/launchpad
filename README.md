## 🚀 Launchpad

**Launchpad** is a lightweight CLI tool that scaffolds fully deployable services using an opinionated golden path.

Run one command. Get a production-ready service with backend, optional frontend, IaC, CI/CD, health checks, and observability — all wired up and consistent.

```bash
launchpad init my-service
launchpad init my-service --frontend   # include React + Vite frontend
```

---

### Install

Requires [Go 1.21+](https://go.dev/dl/).

```bash
curl -fsSL https://raw.githubusercontent.com/michaeldeggers/launchpad/main/install.sh | bash
```

Or manually:

```bash
go install github.com/michaeldeggers/launchpad@latest
```

---

### What it generates

| Concern | Choice |
|---|---|
| Backend | Go + Chi |
| Frontend (opt-in) | React + Vite |
| Default (no frontend) | Static status page |
| IaC | OpenTofu (GCP) |
| Observability | Grafana Cloud |
| CI/CD | Preconfigured pipeline |

---

### Contributing

```bash
git clone https://github.com/michaeldeggers/launchpad.git
cd launchpad
bash scripts/bootstrap.sh
```

The bootstrap script installs all dev dependencies (Go modules, golangci-lint) and verifies the build.

```bash
go run . --help              # run the CLI
go build -o launchpad .      # build a local binary
golangci-lint run ./...      # lint
```

---