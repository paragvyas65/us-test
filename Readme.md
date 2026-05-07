# Grafana Cloud Org Structure Redesign — Onboarding & Project Notes

> **Owner:** Usman Malik
> **Role:** Observability Pod (Q2-Q3) — Finastra
> **Start Date:** Day 1 onboarding (April 30, 2026)
> **Project:** SPS-1989 / SPS-2000 — Grafana Cloud Organization Management Design

---

## 📑 Table of Contents

1. [Project Overview](#project-overview)
2. [Stakeholders & Team](#stakeholders--team)
3. [Onboarding Context](#onboarding-context)
4. [The Core Problem](#the-core-problem)
5. [Jira Tasks Breakdown](#jira-tasks-breakdown)
6. [Existing Design (Pattern 005)](#existing-design-pattern-005)
7. [New Proposed Design (BU-Aligned)](#new-proposed-design-bu-aligned)
8. [Critical Conflict to Resolve](#critical-conflict-to-resolve)
9. [Action Plan & Timeline](#action-plan--timeline)
10. [Open Questions for Vladimir](#open-questions-for-vladimir)
11. [Key Resources & Links](#key-resources--links)
12. [Glossary](#glossary)

---

## Project Overview

### What is being built?
Ek **design document** jo define karega ki Finastra apne **Grafana Cloud stacks** ko kaise organize kare — 100+ disorganized stacks ko consolidated, manageable structure me convert karna.

### Why?
Currently Finastra ke paas **per-product Grafana stacks** hain (e.g., `finfoprod105`), jiske wajah se:
- 100+ stacks ka operational overhead
- Dashboard duplication
- Inconsistent alerting
- Complex RBAC management
- Cost visibility issues
- Cross-product reporting impossible

### Target outcome
**Business Unit (BU) aligned stack model** with:
- ~5-6 stacks (instead of 100+)
- Standardized labels
- Centralized governance
- Folder-based product segmentation within stacks

### Timeline
| Milestone | Date |
|-----------|------|
| Project start | April 29, 2026 |
| **First draft due** | **May 11, 2026** |
| Enterprise Monitoring alignment call | May 11, 2026 |
| **Final design** | **June 30, 2026** |

---

## Stakeholders & Team

### Observability Pod (Q2-Q3)
| Person | Role | What they do |
|--------|------|--------------|
| **Vladimir Babichev** | Senior Architect / Tech Lead | Owns design decisions, reviewer of design doc, has reference architecture |
| **Johann** | Automation Lead | Owns Backstage + Terraform automation strategy |
| **Julia Antonova** | Project Manager / Coordinator | Manages access, planning, Jira boards, timelines |
| **Liliana** | Support / Onboarding | Helps with access provisioning |
| **Usman Malik** | Designer (this role) | Drafting org structure design |

### Reporting & Communication
- **Day-to-day technical**: Vladimir
- **Process/blockers/access**: Julia
- **Automation deep-dive**: Johann

---

## Onboarding Context

### What happened on Day 1
1. Attended kickoff/discovery meeting with Vladimir, Johann
2. Discussion covered:
   - Grafana Cloud organization management
   - Stack design challenges
   - Automation & Backstage integration
   - Application observability strategy
   - Auto-instrumentation & POCs
3. **Usman proposed** consolidating to BU-level stacks (this is now the basis of the new design)
4. Julia followed up with Jira board, SharePoint, planning docs, vacation tracker
5. Started exploring actual Grafana Cloud (`finfoprod105.grafana.net`)
6. Found existing pattern 005 design document in GitHub

### Tools & Systems
- **Code**: GitHub (`finastra-platform/PlatformArchitecture-docs`)
- **PM**: Jira
- **Docs**: SharePoint + Confluence
- **Dev environment**: WSL on Windows
- **Communication**: Microsoft Teams
- **Infrastructure**: Azure (primarily), Grafana Cloud, Terraform Cloud

---

## The Core Problem

### Problem in plain language
Socho 200 alag-alag WhatsApp groups manage karne pad rahe hain — har product ka apna group. Same problem Finastra me Grafana ke saath hai.

### Visual representation
```
CURRENT STATE (Mess):              TARGET STATE (Clean):
─────────────────────              ──────────────────────
Product 1  → Stack 1               Stack 1: PAYMENTS
Product 2  → Stack 2                 ├── 📁 Product A
Product 3  → Stack 3                 ├── 📁 Product B
   ...                                └── 📁 Product C
Product 200 → Stack 200
                                   Stack 2: LENDING
~100+ stacks 😵                      └── 📁 Folders per product

                                   Stack 3: UNIVERSAL BANKING
                                   Stack 4: TCM
                                   Stack 5: CORNERSTONE & SES

                                   ~5-6 stacks 😎
```

### Evidence collected
- Live observation: `https://finfoprod105.grafana.net` exists
- The "105" suffix suggests at least 100+ similar production stacks
- Folder naming inside stacks is inconsistent (e.g., "Active Directory Infrastructure" vs "CCM" vs "CISO")

---

## Jira Tasks Breakdown

### SPS-1989 — Parent Ticket
**Title:** Grafana Cloud Org management design

**Scope:** Full Q2 deliverable covering all aspects:
- Org structure design
- Naming conventions
- Cost attribution & isolation
- Regulatory/data locality
- Automation & Backstage integration
- Application observability strategy
- Auto-instrumentation & POCs

**Timeline:** April 29, 2026 → June 30, 2026

### SPS-2000 — Active Sub-task (Current Focus)
**Title:** Design organizational structure

**Concrete deliverables:**
1. Review `005-grafana-cloud-management.md` (existing pattern)
2. Review `Grafana Org Clean-Up v1.2.pdf`
3. Review `004-grafana-logs.pdf`
4. Review `005-grafana-cloud-management.pdf`
5. Review Confluence page: Monitoring+2.0
6. **Design new organizational structure with pros & cons**
7. **Push to GitHub repo**
8. **Get review from Vladimir Babichev**

**Output format:** Markdown file in `PlatformArchitecture-docs` repository

---

## Existing Design (Pattern 005)

### Source
GitHub: `finastra-platform/PlatformArchitecture-docs/patterns/005-grafana-cloud-management.md`

### Key design decisions in v1
1. **Single Finastra Org** (consolidated 4 orgs: Finastra, DevQA, PreProd, Prod into one)
2. **Per-Product stacks** (not per-BU)
3. **Naming convention:**
   ```
   AZR - C03 - 0402 - CORE
   ↓     ↓     ↓      ↓
   Provider Region Product Index
   (Azure)  (Central US) (Fusion Operate) (Specific use)
   ```
4. **GitOps workflow** with `main` and `release` branches
5. **Terraform Cloud** for execution
6. **Azure Entra ID** for security groups
7. **Azure Key Vault** for secrets management
8. **CODEOWNERS** for approval governance
9. **LBAC** (Label-Based Access Control) for multi-tenancy
10. **Per-product cost showback**

### v1's reasoning for per-Product stacks (6 arguments)
| # | Argument | Rationale |
|---|----------|-----------|
| 1 | Customization | Different BUs use different principles/tech |
| 2 | Empowerment | Self-service for dev teams |
| 3 | Scalability | Limits on alerts/SLOs per stack |
| 4 | Isolation | DoS prevention between products |
| 5 | Privacy & Compliance | Per-product data separation |
| 6 | Cost Showback | Per-product cost transparency |

### Goals defined in v1
- ✅ Cost showback per Product
- ✅ Stack deployment to arbitrary geographies
- ✅ Standardized automated provisioning
- ✅ Self-service stack deployment

### Known artifacts in v1
- 4 architecture diagrams (org structure, naming, consumption, management flow)
- 3 user stories (new product onboarding, self-service, cost showback)
- Repository layout specification
- CODEOWNERS pattern
- YAML configuration schema

---

## New Proposed Design (BU-Aligned)

### Summary of change
**v1:** Per-Product stacks (100+ stacks)
**v2:** Per-BU stacks (5-6 stacks) with folders for product segmentation

### 5 Business Units (from existing org structure)
1. **Lending**
2. **Payment**
3. **Universal Banking**
4. **TCM**
5. **Cornerstone & SES**

(Plus shared services: IT CDM, Platform teams — Fusion Operate & FFDC)

### Proposed new structure
```
Finastra Org
│
├── Stack 1: AZR-C03-LEND-PROD (Lending BU)
│   ├── 📁 Folder: Product 1 (with team-based RBAC)
│   ├── 📁 Folder: Product 2
│   └── 📁 Folder: Product N
│
├── Stack 2: AZR-C03-PAYM-PROD (Payment BU)
├── Stack 3: AZR-C03-UBNK-PROD (Universal Banking)
├── Stack 4: AZR-C03-TCMG-PROD (TCM)
├── Stack 5: AZR-C03-CORN-PROD (Cornerstone & SES)
│
└── Exception Stacks (regulatory):
    └── AZR-C03-XXXX-DED (dedicated, isolated)
```

### Standardized labels (within stacks)
- `business_unit` (e.g., payments, lending)
- `product`
- `service`
- `owner`
- `environment` (dev/prod)
- `region`

### What's preserved from v1
- ✅ Single Finastra Org
- ✅ GitOps workflow
- ✅ Terraform Cloud
- ✅ Azure Entra ID + Key Vault integration
- ✅ CODEOWNERS pattern
- ✅ LBAC for access control
- ✅ Naming API integration

### What's new in v2
- 🆕 BU-level stack granularity
- 🆕 Folder-based product segmentation
- 🆕 Team-based RBAC at folder level
- 🆕 Label-based cost attribution
- 🆕 Regulatory exception handling
- 🆕 Reduced operational overhead

---

## Critical Conflict to Resolve

### The fundamental tension
| Aspect | v1 (Existing 005) | v2 (New Proposal) |
|--------|-------------------|-------------------|
| **Stack granularity** | Per-Product | Per-Business Unit |
| **Total stacks** | 100+ | 5-6 |
| **Segmentation method** | Stack-level | Folder + LBAC |
| **Philosophy** | Maximum isolation | Operational efficiency |

### Counter-arguments needed (v2 must address each v1 concern)
| v1 Argument | v2 Response Strategy |
|-------------|---------------------|
| Customization | Folders + folder-level permissions provide same flexibility |
| Empowerment | Folder-based RBAC enables self-service |
| Scalability | **Genuine concern** — define split criteria when limits hit |
| Isolation | LBAC + ingestion limits per BU |
| Privacy & Compliance | Regulatory exceptions get dedicated stacks |
| Cost Showback | Label-based cost attribution (verify Grafana Cloud support) |

### Strategic positioning
> "Pattern 005 established an excellent foundation for Grafana Cloud management — single Finastra org, GitOps workflow, Terraform automation, naming convention. This v2 evolves the **stack granularity model** based on operational learnings, while preserving ~90% of v1's architecture."

---

## Action Plan & Timeline

### Week 1: April 30 – May 4 (Discovery)
- [x] Day 1: Onboarding meeting attended
- [x] Day 1: Access setup (Jira, SharePoint, GitHub, Grafana)
- [x] Day 1: Located existing pattern 005 design document
- [ ] Send DH account to Vladimir (for Copilot license)
- [ ] Read Confluence: Monitoring+2.0 page
- [ ] Read Grafana Org Clean-Up v1.2.pdf
- [ ] Read 004-grafana-logs.pdf
- [ ] Read 005-grafana-cloud-management.pdf (full)
- [ ] Inventory current stacks (count, naming patterns)
- [ ] **Send clarification email to Vladimir** (see below)

### Week 2: May 5 – May 11 (Drafting + Alignment)
- [ ] Draft 1-page outline for v2 design
- [ ] Get outline approval from Vladimir
- [ ] Write full design document (Markdown + Mermaid diagrams)
- [ ] Open PR in `PlatformArchitecture-docs` repo
- [ ] Request review from Vladimir
- [ ] **Attend May 11 alignment call with Enterprise Monitoring Team**

### Weeks 3-8: May 12 – June 30 (Iteration + Finalization)
- [ ] Incorporate feedback from Vladimir
- [ ] Address comments from Enterprise Monitoring team
- [ ] Iterate on design based on stakeholder input
- [ ] Final design ready by June 30

### Recurring tasks
- [ ] 2-3 day cycle: send progress updates to Vladimir
- [ ] Weekly: sync with Julia on Jira board status
- [ ] Update vacation tracker if any planned leave

---

## Open Questions for Vladimir

### High priority (blocking)
1. **Should I update existing pattern 005 (as v2) or create a new pattern 006?**
2. **Has 005 been implemented in production?** Or is it still a proposal?
3. **The 100+ stacks I'm seeing (e.g., `finfoprod105`) — are these from 005 implementation or the OLD imperative pipeline?**
4. **Should I address each of v1's 6 arguments for per-Product as counter-arguments in v2?**

### Medium priority (design-related)
5. What's the current alert/SLO volume per BU? (helps validate scalability concerns)
6. Has Grafana Cloud released label-based cost attribution? (key for cost showback argument)
7. Are there any BUs that should keep per-Product stacks for regulatory reasons?
8. What level of detail is expected in the May 11 draft?

### Low priority (process)
9. Who from Enterprise Monitoring Team should I connect with before May 11?
10. Is there a template/format for design docs in this repo?

### For Julia
1. Is there an "Alignm on Q2 Observability Pod" tab in a separate planning file?
2. Owner column missing in planning sheet — am I sole owner of Bucket 1?
3. Timeline for buckets 2-4 (Automation, App Observability, Auto-Instrumentation)?

---

## Key Resources & Links

### Documentation
- **Pattern 005 (existing)**: `finastra-platform/PlatformArchitecture-docs/patterns/005-grafana-cloud-management.md`
- **Confluence Monitoring 2.0**: `https://confluence.finastra.com/spaces/ESM/pages/354558880/Monitoring+2.0`
- **Dev environment setup**: `Platform-docs/developer-docs/setting-up-wsl-on-finastra.md`

### Project tracking
- **Jira tickets**: SPS-1989 (parent), SPS-2000 (current)
- **SharePoint**: Aspirations Platform Engineering Initiative
- **Planning sheet**: Q1-Q3 Planning.xlsx → "Alignm on Q2 Observability Pod" tab
- **Vacation tracker**: Shared_Services_Teams_vacation_tracker.xlsx

### External references
- **Grafana Cloud regions**: `https://grafana.com/docs/grafana-cloud/account-management/regional-availability/`
- **Naming API docs**: `https://docs.providesops.cloud/docs/reference/naming/overview/`
- **LBAC docs**: `https://grafana.com/docs/grafana-cloud/account-management/authentication-and-permissions/access-policies/label-access-policies/`

### PDFs to review (received from Vladimir)
- `Grafana Org Clean-Up v1.2.pdf`
- `004-grafana-logs.pdf`
- `005-grafana-cloud-management.pdf`

---

## Glossary

| Term | Meaning |
|------|---------|
| **Stack** | A Grafana Cloud workspace (containing dashboards, alerts, logs, metrics) |
| **Folder** | Sub-organization within a stack |
| **BU** | Business Unit (Lending, Payment, Universal Banking, TCM, Cornerstone & SES) |
| **LBAC** | Label-Based Access Control — Grafana feature for fine-grained data access |
| **RBAC** | Role-Based Access Control |
| **OTEL** | OpenTelemetry — standard format for observability data |
| **GitOps** | Git as source of truth for infrastructure configuration |
| **CODEOWNERS** | GitHub file defining who can approve changes to specific paths |
| **CLM** | Centralised Log Management |
| **FO** | Fusion Operate (a Finastra product) |
| **LPro / LaserPro** | A Finastra product |
| **TCM** | (Business Unit at Finastra) |
| **POC** | Proof of Concept |
| **DH account** | Dedicated Host account (for Copilot license) |
| **Backstage** | Spotify's developer portal — used as dev-facing entry point |
| **Terraform Cloud** | Infrastructure-as-Code execution platform |
| **Entra ID** | Microsoft's identity service (formerly Azure AD) |
| **CTIO** | (Finastra organization unit) |
| **FFDC** | (Finastra platform — Fusion Foundation Data Centre / similar) |

---

## Day 1 Reflection — What went well

✅ Attended kickoff meeting and contributed proposal (BU-aligned model)
✅ Got access to Jira, SharePoint, GitHub, Grafana within Day 1
✅ Located existing pattern 005 — saved significant ramp-up time
✅ Started exploring actual Grafana stacks to understand current state
✅ Identified critical conflict between existing design and new proposal early

## Lessons / Reminders for Day 2+

🎯 **Always clarify before drafting** — sending Vladimir questions before writing
🎯 **Outline first, full draft later** — avoid rework
🎯 **Cite v1's good work** — political smart move when proposing changes
🎯 **Use real data/screenshots** — evidence-based design > theory-based
🎯 **2-3 day update cycle** — keep Vladimir informed without overwhelming
🎯 **Document as you go** — this README itself is an example

---

## Next Immediate Steps

1. ⚠️ **Send clarification email to Vladimir** (4 high-priority questions)
2. ⚠️ **Send DH account to Vladimir** (for Copilot license — quick task)
3. 📖 Read remaining PDFs in priority order:
   - Grafana Org Clean-Up v1.2.pdf (most important — past learnings)
   - 005-grafana-cloud-management.pdf (full version)
   - 004-grafana-logs.pdf
4. 📊 Inventory current stacks via Grafana Cloud Portal
5. ✏️ Draft 1-page outline once Vladimir responds

---

*This document is a living onboarding & planning reference. Update as project progresses.*

**Last updated:** April 30, 2026 (Day 1)
