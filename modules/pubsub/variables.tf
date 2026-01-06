variable "project_id" {
  description = "The project ID"
  type        = string
}

variable "topic" {
  description = "The topic name"
  type        = string
}

variable "pull_subscriptions" {
  description = "The list of pull subscriptions"
  type        = list(map(string))
  default     = []
}

variable "push_subscriptions" {
  description = "The list of push subscriptions"
  type        = list(map(string))
  default     = []
}
