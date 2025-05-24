locals {
  pre_fix = var.vpc_name

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

variable "project_name" {
  type        = string
  description = "The name of the project this infrastructure is associated with. Used for naming and tagging resources."
}

variable "environment" {
  type        = string
  description = "The deployment environment (e.g., dev, staging, prod). Helps differentiate resources across environments."
}

variable "vpc_name" {
  type        = string
  description = "The name assigned to the Virtual Private Cloud (VPC). Used in resource naming and tagging."
}

variable "cidr_block" {
  type        = string
  description = "The CIDR block for the VPC (e.g., 10.0.0.0/16). Defines the IP address range for the VPC."
}

variable "public_subnets" {
  type        = list(string)
  description = "A list of CIDR blocks for public subnets. These subnets are intended for resources that must be accessible from the internet."
  default     = []
}

variable "private_subnets" {
  type        = list(string)
  description = "A list of CIDR blocks for private subnets. These subnets are for internal resources that do not require direct access from the internet."
  default     = []
}

variable "enable_nat_gateway" {
  type        = bool
  default     = false
  description = "Boolean flag to enable or disable the creation of a NAT Gateway. Requires at least one public subnet if set to true."

  validation {
    condition     = !(var.enable_nat_gateway == true && length(var.public_subnets) == 0)
    error_message = "At least one public subnet is required when NAT Gateway is enabled."
  }
}

variable "availability_zones" {
  type        = list(string)
  description = "A list of availability zones to distribute the subnets across. Enhances availability and fault tolerance."
}