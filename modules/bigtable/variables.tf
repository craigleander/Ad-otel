variable "project_id" {
  description = "The project ID"
  type        = string
}

variable "name" {
  description = "The name of the Bigtable instance"
  type        = string
}

variable "zones" {
  description = "The zones/clusters configuration"
  type        = map(any)
  default     = {}
}

variable "tables" {
  description = "The tables configuration"
  type        = map(any)
  default     = {}
}

variable "deletion_protection" {
  description = "Whether to enable deletion protection"
  type        = bool
  default     = false
}
