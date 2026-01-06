variable "project_id" {
  description = "The project ID to create the service accounts in"
  type        = string
}

variable "prefix" {
  description = "Prefix applied to service account names"
  type        = string
  default     = ""
}

variable "names" {
  description = "Names of the service accounts to create"
  type        = list(string)
  default     = []
}

variable "project_roles" {
  description = "List of project roles to apply to the created service accounts"
  type        = list(string)
  default     = []
}
