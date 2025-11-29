# Terraform Infrastructure for VProfile

This directory contains the Terraform configuration to automate the provisioning of the VProfile multi-tier application architecture on AWS.

## Modular Structure

The project is organized into reusable modules to ensure maintainability and scalability:

| Module | Description | Resources Created |
|--------|-------------|-------------------|
| **`vpc`** | Networking Foundation | VPC, Public Subnet (IGW), 2 Private Subnets (Multi-AZ), Route Tables |
| **`security_groups`** | Network Security | Security Groups for ELB, App Server, and Backend Services with strict ingress/egress rules |
| **`rds`** | Database Layer | Amazon RDS (MySQL) instance in private subnets |
| **`elasticache`** | Caching Layer | Amazon ElastiCache (Memcached) cluster in private subnets |
| **`mq`** | Messaging Layer | Amazon MQ (RabbitMQ) broker in private subnets |
| **`ec2`** | Application Layer | EC2 Instance (Ubuntu 20.04) in public subnet with SSH key pair |
| **`route53`** | Service Discovery | Private Hosted Zone (`vprofile.in`) with CNAME records mapping friendly names to AWS endpoints |

## Usage

### 1. Initialize
Initialize the Terraform working directory and download providers/modules:
```bash
terraform init
```

### 2. Validate
Check the configuration for syntax errors:
```bash
terraform validate
```

### 3. Plan
Preview the changes that Terraform will make:
```bash
terraform plan
```

### 4. Apply
Provision the infrastructure:
```bash
terraform apply
```

## Configuration

Key variables can be configured in `variables.tf` or passed via a `terraform.tfvars` file:

- `region`: AWS Region (default: `us-east-1`)
- `project_name`: Prefix for resource names (default: `vprofile`)
- `my_ip`: Your IP address for SSH access (CIDR format)
- `public_key`: Public key material for the EC2 instance
- `db_username` / `db_password`: Database credentials
- `mq_username` / `mq_password`: RabbitMQ credentials

## Outputs

After application, Terraform will output:
- `ec2_public_ip`: Public IP of the application server
- `rds_endpoint`: Endpoint for the MySQL database
- `cache_endpoint`: Endpoint for the Memcached cluster
- `mq_endpoint`: Endpoint for the RabbitMQ broker
