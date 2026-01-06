variable "project_id" {
  description = "The project ID"
  type        = string
}

variable "name" {
  description = "Name of the redis instance"
  type        = string
}

variable "region" {
  description = "The region of the redis instance"
  type        = string
}

variable "tier" {
  description = "The tier of the redis instance"
  type        = string
  default     = "BASIC"
}

variable "memory_size_gb" {
  description = "Redis memory size in GiB"
  type        = number
  default     = 1
}

variable "authorized_network" {
  description = "The full name of the Google Compute Engine network to which the instance is connected"
  type        = string
}

variable "redis_version" {
  description = "The version of Redis software"
  type        = string
  default     = "REDIS_6_X"
}
