variable "region" {
  default = "us-east-1"
}

variable "project_name" {
  default = "vprofile"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_1_cidr" {
  default = "10.0.2.0/24"
}

variable "private_subnet_2_cidr" {
  default = "10.0.3.0/24"
}

variable "az_1" {
  default = "us-east-1a"
}

variable "az_2" {
  default = "us-east-1b"
}

variable "my_ip" {
  description = "Your IP address with CIDR (e.g., 1.2.3.4/32)"
  default     = "0.0.0.0/0"
}

variable "db_name" {
  default = "accounts"
}

variable "db_username" {
  default = "admin"
}

variable "db_password" {
  default = "admin123"
}

variable "mq_username" {
  default = "rabbit"
}

variable "mq_password" {
  default = "guest1234567"
}

variable "public_key" {
  description = "Public key material for EC2 key pair"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCNOk786l8H/M3zphIXcqZYbOp1sZ/bpLnuZqfUzfxZIrN64N4+jUL5Fq7SLnNqUcMk7UkmJ+X6VZc8xJ8GJi6/EDdLWK2PebN3drGp7UWwhJBux4capobJ1/X5Ff8V6Bfu0KzkAyAlqmVQnh9G4DKHGGDabZPXbxEGcT4gyBiaAKgSkfOyGTs8L/8wfRt4J5mhhuCXsX8dDza2/god/vhNZi+r/XgQB6AIP0gmugdXWhUc4n8ArpLGwFvYeqzPVQ4lpKHqTsxU4xHiQBrG7EhcKwRuFHlCea0qFlF8trNvesm/oELFJZ89VjSkbka59mf+wXeD7cY9JzEcYStuQyxvzKmDhlHEVfF3oA2hAyinAH6ENr52TdHjmqy2qJDZradpHkFoH/SCbY/2Ejg7wDinixzqaunPedSEF/S7Mu9M/3QWBzXn+ShLCaR3eYShVt6IF026cOr3zQ2Rpaj5YEtMc2NiPH8tthYPVj9kAbljIW6ea5EuuEmZYK0O7qzMaY0= mohamed@EXPERTBOOK" # Placeholder
}

variable "domain_name" {
  default = "vprofile.in"
}
