# Deploy Java 5-Tier Application on AWS – Cloud Native Architecture

## Overview

This repository provides a fully automated deployment of a multi-tier Java web application on AWS using Terraform modules. The project migrates a local virtualization-based stack to a cloud-native architecture, leveraging AWS managed services for high availability, fault tolerance, and scalability.

The architecture includes:

* EC2 instances for Tomcat application servers
* RDS (MySQL) for relational database
* ElastiCache (Memcached) for caching
* Amazon MQ (RabbitMQ) for messaging
* Route 53 for DNS and private hosted zone
* VPC with public/private subnets
* Security Groups for network segmentation

## AWS Architecture

### Request Flow

1. User accesses the application via a domain name in Route 53.
2. Traffic is routed through an Application Load Balancer (optional, can be added in EC2 module).
3. EC2 instances host the Tomcat application server.
4. Backend services communicate securely via private subnets:

   * RDS MySQL (db01.<domain_name>)
   * ElastiCache (mc01.<domain_name>)
   * Amazon MQ (rmq01.<domain_name>)

## Terraform Modules Overview

| Module          | Resource Created                             | Purpose                               |
| --------------- | -------------------------------------------- | ------------------------------------- |
| vpc             | VPC, Public & Private Subnets                | Network isolation and AZ distribution |
| security_groups | ELB-SG, App-SG, Backend-SG                   | Network access control for tiers      |
| rds             | Amazon RDS (MySQL)                           | Relational database backend           |
| elasticache     | Amazon ElastiCache (Memcached)               | Caching layer                         |
| mq              | Amazon MQ (RabbitMQ)                         | Messaging layer                       |
| ec2             | EC2 instances for Tomcat                     | Application layer                     |
| route53         | Route 53 Private Hosted Zone + CNAME records | DNS mapping for backend services      |

## Prerequisites

* AWS account with IAM permissions for VPC, EC2, RDS, ElastiCache, MQ, and Route 53
* Terraform 1.x installed locally
* AWS CLI configured
* SSH Key Pair for EC2 access

## How to Deploy

Clone the repository:

```bash
git clone <repo_url>
cd Deploy-java-5tier-application-on-aws
```

Define Variables in `terraform.tfvars` (example):

```hcl
region               = "us-east-1"
project_name         = "vprofile"
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidr   = "10.0.1.0/24"
private_subnet_1_cidr= "10.0.2.0/24"
private_subnet_2_cidr= "10.0.3.0/24"
az_1                 = "us-east-1a"
az_2                 = "us-east-1b"
my_ip                = "<YOUR_PUBLIC_IP>"
db_name              = "accounts"
db_username          = "admin"
db_password          = "admin123"
mq_username          = "guest"
mq_password          = "guest"
domain_name          = "vprofile.in"
public_key           = "~/.ssh/id_rsa.pub"
```

Initialize Terraform:

```bash
terraform init
```

Preview the Deployment Plan:

```bash
terraform plan
```

Apply the Configuration:

```bash
terraform apply
```

Terraform will create all modules and output the endpoints for RDS, ElastiCache, MQ, and EC2 instances.

## Application Configuration

Update your Java application `src/main/resources/application.properties` to use the Route 53 CNAME records created by the Terraform route53 module:

```properties
# Database
jdbc.url=jdbc:mysql://db01.vprofile.in:3306/accounts
jdbc.username=admin
jdbc.password=admin123

# Cache
memcached.active.host=mc01.vprofile.in
memcached.active.port=11211

# Messaging
rabbitmq.address=rmq01.vprofile.in
rabbitmq.port=5672
rabbitmq.username=guest
rabbitmq.password=guest
```

## Verification

SSH into your EC2 instance:

```bash
ssh -i key.pem ubuntu@<EC2_PUBLIC_IP>
```

Deploy the WAR file to Tomcat:

```bash
sudo cp target/vprofile-v2.war /var/lib/tomcat9/webapps/ROOT.war
sudo systemctl restart tomcat9
```

Test connectivity:

```bash
mysql -h db01.vprofile.in -u admin -p
# memcached telnet mc01.vprofile.in 11211
# RabbitMQ test using broker endpoint
```

Access the application in browser:

```
http://<EC2_PUBLIC_DNS>:8080
```

## Project Structure

```
.
├── modules/
│   ├── vpc/
│   ├── security_groups/
│   ├── rds/
│   ├── elasticache/
│   ├── mq/
│   ├── ec2/
│   └── route53/
├── terraform.tfvars
├── variables.tf
├── outputs.tf
└── README.md
```

