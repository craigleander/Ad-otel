variable "project_id" {
  description = "The project ID"
  type        = string
}

variable "names" {
  description = "Names of the buckets"
  type        = list(string)
}

variable "prefix" {
  description = "Prefix used to generate the bucket name"
  type        = string
  default     = ""
}

variable "location" {
  description = "Bucket location"
  type        = string
  default     = "US"
}

variable "versioning" {
  description = "Map of bucket names to versioning status"
  type        = map(bool)
  default     = {}
}
