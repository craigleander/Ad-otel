variable "project_id" {
  description = "The project ID"
  type        = string
}

variable "secrets" {
  description = "List of secrets to create"
  type = list(object({
    name        = string
    secret_data = optional(string)
  }))
  default = []
}
