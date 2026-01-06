variable "project_id" {
  description = "The project ID"
  type        = string
}

variable "database_id" {
  description = "The ID of the firestore database"
  type        = string
  default     = "(default)"
}

variable "location" {
  description = "The location of the firestore database"
  type        = string
}

variable "type" {
  description = "The type of the firestore database"
  type        = string
  default     = "FIRESTORE_NATIVE"
}

variable "deletion_policy" {
  description = "The deletion policy"
  type        = string
  default     = "DELETE"
}

variable "delete_protection_state" {
  description = "The delete protection state"
  type        = string
  default     = "DELETE_PROTECTION_DISABLED"
}
