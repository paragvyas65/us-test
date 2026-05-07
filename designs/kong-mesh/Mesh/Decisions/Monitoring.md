# Monitoring

## Description

Observability is a core component of running a Service Mesh. The current FO-Monitoring architecture has a single Grafana Cloud scraper running on each Zone to collect different service and pod metrics. When Mesh would be enabled, that scraper would no longer have access to the sidecars to pull the metrics unless it was included as part of the mesh.

## Decision

**Remove mTLS Requirement**

In the Mesh CR (spec.metrics.backends.conf) there is a configuration item for skipMTLS. With that option set to true, the sidecars will allow any traffic to access the metrics endpoint without the need for mTLS auth. This allows for the existing FO-Monitoring architecture to scrape the pod metrics with a single instance.

## Comparisons

#### Scraper per Mesh

**Pros's**

- Scraping of metrics would secured by mTLS authentication

**Cons's**

- Additional scrapers would be deployed per Zone per Mesh to scrape metrics
- Helm charts would have to be re-done to meet the new deployment model

#### Remove mTLS requirement

**Pro's**

- Existing FO-Monitoring architecture would not change

**Con's**

- Metric collection would be unauthenticated
