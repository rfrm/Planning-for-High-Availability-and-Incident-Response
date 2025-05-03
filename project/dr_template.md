# Infrastructure

## AWS Zones
* us-east-2
* us-west-1

## Servers and Clusters

### Table 1.1 Summary
| Asset      | Purpose           | Size                                                                   | Qty                                                             | DR                                                                                                           |
|--------------|-------------------|------------------------------------------------------------------------|-----------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------|
| ec2 instance | Serves the example api| t3.micro | 3 | yes this resource is also replicated in zone 2 |
| aws_rds_cluster | MySQL database | db.t3.medium | 3 | yes this resource is also present in zone 2 as rds-s(econdary) |
| eks cluster | Kubernetes Cluster | t3.medium | 2 | yes also replicated in zone 2
| vpc | Virtual private cloud | 1 | Its replicated in diferent availability zones
| alb | Application load balancer | 1 | Yes there's a load balancer in both zone1 and zone2


### Descriptions
ec2 instances: Run the events API
RDS cluster is a managed MySQL database
EKS cluster is used to host the monitoring tools grafana and prometheus in this setup
VPC is used to isolate aws resources, to allow communication between the EKS and the ec2 instances.
ALB is used to send traffic to ec2 instances in zone1 and zone2

## DR Plan
### Pre-Steps:
We would have to run `terraform apply` inside the `zone2` directory.
I have set up an RDS global cluster, with a primary in zone1 and a follower in zone2

## Steps:
To perform the failover, we would have to:

1. Detach the secondary from the global cluster.
2. Promote the secondary to standalone and enable writes.
3. Update the applications database URL to the new primary.

