# Launchpad – Copilot Instructions

## Project Purpose

Launchpad is a service bootstrap tool that generates fully deployable application scaffolds. Given inputs like service name and environment, it produces a ready-to-run repository with CI/CD pipelines, IaC wiring, deployment manifests, health checks, config/secrets patterns, and basic observability hooks.

The goal is a **golden path**: every generated service builds, deploys, and behaves the same way in production.

## Launchpad CLI Stack

- **Language:** Go
- **CLI framework:** [Cobra](https://github.com/spf13/cobra)
- **Primary command:** `launchpad init`

## Generated Service Stack

Launchpad scaffolds opinionated, consistent services using:

| Concern | Choice |
|---|---|
| Backend | Go + [Chi](https://github.com/go-chi/chi) |
| Frontend (optional) | React + Vite |
| Default (no frontend) | Static status page |
| IaC | [OpenTofu](https://opentofu.org/) |
| Cloud | GCP |
| Observability | Grafana Cloud |

### Key scaffold rules
- Every generated service defaults to a **static status page** unless a frontend is explicitly requested via `launchpad init`
- IaC always uses OpenTofu — never raw Terraform
- Observability wires to **Grafana Cloud** (not self-hosted); generated configs should include Prometheus-compatible metrics and an OTLP trace exporter endpoint placeholder

## Status

Early-stage MVP. Core CLI structure is being established.

## Philosophy

- **Start simple** — one stack, one path (avoid multi-stack abstractions)
- **Optimize for execution** — working service over perfect design
- **Dogfood everything** — Launchpad itself should be bootstrapped using Launchpad patterns
- **Evolve from friction** — changes are driven by real usage, not speculation

## Scope Boundaries

Launchpad is **not**:
- A full internal developer portal
- A multi-stack abstraction layer
- A replacement for infrastructure tooling

It is a **focused bootstrap layer** — resist scope creep toward the above.

## What Generated Scaffolds Must Include

Every scaffold Launchpad produces should wire up:
1. CI/CD pipeline configuration
2. Infrastructure-as-Code declarations
3. Deployment manifests
4. Health check endpoint(s)
5. Config and secrets handling pattern
6. Basic observability hooks (logging, metrics, or tracing entry points)
