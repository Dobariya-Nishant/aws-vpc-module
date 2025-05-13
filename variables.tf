locals {
  postfix_name = "${var.vpc_name}"

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

variable "project_name" {
  type        = string
  description = "project name"
}

variable "environment" {
  type        = string
  description = "project environment prod, dev, stag"
}

variable "vpc_name" {
  type        = string
  description = "VPC name"
}

variable "cidr_block" {
  type        = string
  description = "VPC cidr block"
}

variable "public_subnets" {
  type        = list(string)
  description = "list of public subnet cidr"
  default     = []
}

variable "private_subnets" {
  type        = list(string)
  description = "list of private subnet cidr"
  default     = []
}

variable "enable_nat_gateway" {
  type        = bool
  default     = false
  description = "enable NAT gateway"

  validation {
    condition     = !(var.enable_nat_gateway == true && length(var.public_subnets) == 0)
    error_message = "At least one public subnet is required when NAT Gateway is enabled."
  }
}

variable "availability_zones" {
  type        = list(string)
  description = "list of availability zones"
}