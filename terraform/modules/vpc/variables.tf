variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for subnets"
  type        = string
}

# Removed variables related to multiple public subnets
# variable "public_b" {
#   type = string
# }

# variable "public_a" {
#   type = string
# }

# Removed the variable for a list of public subnet IDs since we now have only one public subnet
# variable "public_subnet_ids" {
#   type = list(string)
# }