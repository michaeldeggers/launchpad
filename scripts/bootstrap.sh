#!/usr/bin/env bash
# scripts/bootstrap.sh — set up a local development environment
set -euo pipefail

MIN_GO_VERSION="1.21"
GOLANGCI_VERSION="v1.57.2"

# ── helpers ────────────────────────────────────────────────────────────────────
info()  { printf '\033[0;34m▶ %s\033[0m\n' "$*"; }
ok()    { printf '\033[0;32m✔ %s\033[0m\n' "$*"; }
warn()  { printf '\033[0;33m⚠ %s\033[0m\n' "$*"; }
die()   { printf '\033[0;31m✖ %s\033[0m\n' "$*" >&2; exit 1; }

version_gte() {
  printf '%s\n%s\n' "$2" "$1" | sort -C -V
}

# ── Go ────────────────────────────────────────────────────────────────────────
info "Checking for Go..."
if ! command -v go &>/dev/null; then
  die "Go is not installed. Install it from https://go.dev/dl/ (>= ${MIN_GO_VERSION}) and re-run this script."
fi

GO_VERSION=$(go version | awk '{print $3}' | sed 's/go//')
if ! version_gte "$GO_VERSION" "$MIN_GO_VERSION"; then
  die "Go ${MIN_GO_VERSION}+ is required (found ${GO_VERSION}). Upgrade at https://go.dev/dl/"
fi
ok "Go ${GO_VERSION} found"

# ── module dependencies ───────────────────────────────────────────────────────
info "Downloading Go module dependencies..."
go mod download
ok "Dependencies ready"

# ── golangci-lint ─────────────────────────────────────────────────────────────
info "Checking for golangci-lint..."
if command -v golangci-lint &>/dev/null; then
  ok "golangci-lint already installed ($(golangci-lint --version | head -1))"
else
  info "Installing golangci-lint ${GOLANGCI_VERSION}..."
  curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh \
    | sh -s -- -b "$(go env GOPATH)/bin" "$GOLANGCI_VERSION"
  ok "golangci-lint installed"
  if ! command -v golangci-lint &>/dev/null; then
    warn "golangci-lint not in PATH — add \$(go env GOPATH)/bin to your PATH"
  fi
fi

# ── verify build ──────────────────────────────────────────────────────────────
info "Verifying build..."
go build ./...
ok "Build successful"

printf '\n\033[0;32mDev environment ready.\033[0m\n'
printf 'Run the CLI:  go run . --help\n'
printf 'Lint:         golangci-lint run ./...\n'
printf 'Build:        go build -o launchpad .\n\n'
