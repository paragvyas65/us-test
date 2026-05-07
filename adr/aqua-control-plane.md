# Self-Managed vs SaaS TCO Comparison

> **Disclaimer**: This is an example, full-retail comparison between a self-managed Aqua control plane and Aqua's SaaS control plane to discover differences in units and scale of costs between the models.
>
> The comparison **does not** depict actual Finastra pricing.

| Category           |                  Self-Managed Cost                  |                                                                           SaaS Cost                                                                           |
| ------------------ | :-------------------------------------------------: | :-----------------------------------------------------------------------------------------------------------------------------------------------------------: |
|                    |                                                     |
| **Licensing**      | **$300,000**<br>(for 250 nodes, or $1,200 per node) | **$360,000**<br>(for 250 nodes, or $1,440 per node; a 20% increase for SaaS-bound nodes)<br>**+**<br>**$12,500**<br>(tenant management yearly licensing cost) |
|                    |                                                     |
| **Infrastructure** | **$74,500**<br>(Aqua control plane infrastructure)  |                                                         **$0**<br>(Aqua control plane infrastructure)                                                         |
|                    |                                                     |
| **Engineering**    |   **$80,640**<br>(Aqua control plane engineering)   |                 **$7,392**<br>(assuming 8 story points a year allocated to opening/managing tickets with Aqua related to SaaS control plane)                  |
|                    |                                                     |
| **Total:**         |                    **$455,140**                     |                                                                         **$379,892**                                                                          |

## Notes

- Aqua licensing is based on node units (nodes with installed enforcer). The licensing model and cost are the same whether we are self-managing or using SaaS. We are currently in negotiations around per node pricing.

- Additional license costs may be added per add-on (such as the SaaS tenant management add-on).

- SaaS licensing given above **excludes** Premium Support. Premium Support would add additional licensing cost.

- Full retail licensing costs (depicted above) provided by Hui and Ramesh.

- The infrastructure costs compared above are for Aqua control plane infrastructure only. Other Aqua infrastructure costs (such as infrastructure enforcers run on) are identical between self-managed and SaaS.

- Infrastructure costs obtained from Cloudability [AZR-C21-DV-400-01 Costs](https://app-eu.apptio.com/cloudability#/reports/report?category=Cost&custom=true&dimensions=enhanced_service_name&dimensions=usage_type&dimensions=usage_family&dimensions=resource_identifier&end_date=2022-11-28&filters=tag2%3D%40azr-c21-dv-400-01&id=6293350&metrics=total_amortized_cost&order=desc&owned_by_user=true&shared=false&shared_with_organization=false&sort_by=total_amortized_cost&star=false&start_date=2021-11-28&title=AZR-C21-DV-400-01+Costs) and [AZR-C21-PR-400-01 Costs](https://app-eu.apptio.com/cloudability#/reports/report?category=Cost&custom=true&dimensions=enhanced_service_name&dimensions=usage_type&dimensions=usage_family&dimensions=resource_identifier&end_date=2022-11-28&filters=tag2%3D%40azr-c21-pr-400-01&id=6293539&metrics=total_amortized_cost&order=desc&owned_by_user=true&shared=false&shared_with_organization=false&sort_by=total_amortized_cost&star=false&start_date=2021-11-28&title=AZR-C21-PR-400-01+Costs) reports.

- The engineering costs compared above are for Aqua control plane engineering only. Other Aqua engineering costs (such as engineering work around enforcer maintenance, etc.) are identical between self-managed and SaaS.

- Engineering costs were estimated based on historical and planned JIRA issues. The details of that analysis are captured in the spreadsheet associated with the [Gather engineering costs of self managed control plane](https://jira.finastra.com/browse/FOP-1497) task of the [Aqua SaaS: Compare TCO of Self-Managed vs SaaS Control Plane](https://jira.finastra.com/browse/FOP-1237) user story.
