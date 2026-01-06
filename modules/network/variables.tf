variable "project_id" {
  description = "The project ID to host the network in"
  type        = string
}

variable "network_name" {
  description = "The name of the VPC network"
  type        = string
  default     = "vpc-01"
}

variable "subnets" {
  description = "The list of subnets being created"
  type        = list(map(string))
  default     = []
}

variable "secondary_ranges" {
  description = "Secondary ranges that will be used in some of the subnets"
  type        = map(list(object({ range_name = string, ip_cidr_range = string })))
  default     = {}
}
