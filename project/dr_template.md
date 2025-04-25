# Infrastructure

## AWS Zones
* us-east-2
* us-west-1

## Servers and Clusters

### Table 1.1 Summary
| Asset      | Purpose           | Size                                                                   | Qty                                                             | DR                                                                                                           |
|--------------|-------------------|------------------------------------------------------------------------|-----------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------|
| ec2 instance | Serves the example api| t3.micro | 1 | yes this resource is also replicated in zone 2 |
| aws_rds_cluster | MySQL database | db.t3.medium | 1 | yes this resource is also present in zone 2 as rds-s(econdary) |

### Descriptions
More detailed descriptions of each asset identified above.

## DR Plan
### Pre-Steps:
List steps you would perform to setup the infrastructure in the other region. It doesn't have to be super detailed, but high-level should suffice.

## Steps:
You won't actually perform these steps, but write out what you would do to "fail-over" your application and database cluster to the other region. Think about all the pieces that were setup and how you would use those in the other region
