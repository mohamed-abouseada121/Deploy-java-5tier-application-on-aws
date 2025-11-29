variable "project_name" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "backend_sg_id" {
  type = string
}

variable "mq_username" {
  type = string
}

variable "mq_password" {
  type = string
}
