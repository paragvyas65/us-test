# Current State Analysis: Observability

## Overview
Currently, Finastra's Grafana Cloud implementation relies on Pattern 005 (Per-Product Stacks), leading to over 100+ individual environments.

## Findings & Data Analysis (from Architecture Review)

### 1. Persona & Layered Observability
Our analysis identifies three distinct personas requiring different visibility layers:
- **Product Teams:** Need deep-dive visibility into specific application components.
- **BU Leadership:** Require consolidated uptime and performance metrics across multiple products.
- **SRE/Platform Teams:** Need cross-product infrastructure health and cost attribution.

**Layering Gap:** Currently, layer 1 (application metrics) is siloed. Personas cannot transition smoothly between infrastructure-level health and application-level traces because they reside in different stacks.

### 2. Naming Scheme & Metadata Gaps
A critical finding from the naming scheme audit is the **inconsistency in environmental labeling**.
- **Issue:** The `env` label is frequently missing or inconsistently applied (e.g., `dev`, `development`, `non-prod`).
- **Impact:** This makes it impossible to create global, automated dashboards that filter by environment across the entire Business Unit.
- **Fix:** Metadata governance must be enforced at the collector level to ensure every trace and metric includes the `bu`, `product`, and `env` labels.

## Pain Points
- **Cross-Tier Silos:** No cross-tier visibility (Dev/Stage/Prod) within a single view.
- **Cost Attribution:** Difficult to attribute costs at the BU level without manual tag consolidation.
- **Identity Sprawl:** Access management is fragmented across 100+ stacks.

