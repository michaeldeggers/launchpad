#!/usr/bin/env bash
# install.sh — install the launchpad CLI for end users
set -euo pipefail

REPO="github.com/michaeldeggers/launchpad"
MIN_GO_VERSION="1.21"

# ── helpers ────────────────────────────────────────────────────────────────────
info()  { printf '\033[0;34m▶ %s\033[0m\n' "$*"; }
ok()    { printf '\033[0;32m✔ %s\033[0m\n' "$*"; }
die()   { printf '\033[0;31m✖ %s\033[0m\n' "$*" >&2; exit 1; }

version_gte() {
  printf '%s\n%s\n' "$2" "$1" | sort -C -V
}

# ── check Go ──────────────────────────────────────────────────────────────────
info "Checking for Go..."
if ! command -v go &>/dev/null; then
  die "Go is not installed. Install it from https://go.dev/dl/ (>= ${MIN_GO_VERSION}) and re-run this script."
fi

GO_VERSION=$(go version | awk '{print $3}' | sed 's/go//')
if ! version_gte "$GO_VERSION" "$MIN_GO_VERSION"; then
  die "Go ${MIN_GO_VERSION}+ is required (found ${GO_VERSION}). Upgrade at https://go.dev/dl/"
fi
ok "Go ${GO_VERSION} found"

# ── install ───────────────────────────────────────────────────────────────────
info "Installing launchpad..."
go install "${REPO}@latest"

INSTALL_PATH="$(go env GOPATH)/bin/launchpad"
if [[ ! -x "$INSTALL_PATH" ]]; then
  die "Installation failed — binary not found at ${INSTALL_PATH}"
fi
ok "launchpad installed to ${INSTALL_PATH}"

# ── PATH hint ─────────────────────────────────────────────────────────────────
if ! command -v launchpad &>/dev/null; then
  printf '\n\033[0;33m⚠ Add Go binaries to your PATH to use launchpad from anywhere:\033[0m\n'
  printf '  export PATH="$PATH:$(go env GOPATH)/bin"\n'
  printf 'Add that line to your ~/.bashrc, ~/.zshrc, or equivalent.\n\n'
else
  printf '\nRun: launchpad --help\n'
fi
