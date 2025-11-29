variable "project_name" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "backend_sg_id" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}
