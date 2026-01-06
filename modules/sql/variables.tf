variable "project_id" {
  description = "The project ID"
  type        = string
}

variable "name" {
  description = "Name of the instance"
  type        = string
}

variable "database_version" {
  description = "PostgreSQL version"
  type        = string
  default     = "POSTGRES_15"
}

variable "region" {
  description = "Region for the instance"
  type        = string
}

variable "zone" {
  description = "Zone for the instance"
  type        = string
}

variable "tier" {
  description = "The machine type to use"
  type        = string
  default     = "db-custom-2-7680"
}

variable "network_self_link" {
  description = "The self link of the VPC network"
  type        = string
}

variable "deletion_protection" {
  description = "Whether to enable deletion protection"
  type        = bool
  default     = false
}
