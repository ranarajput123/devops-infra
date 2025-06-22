variable "project" {
  description = "The ID of the project where the IAM roles will be applied"
  type        = string
}

variable "backend_devs" {
  description = "List of backend developer emails"
  type        = list(string)
  default     = []
}

variable "frontend_devs" {
  description = "List of frontend developer emails"
  type        = list(string)
  default     = []
}

variable "full_stack_devs" {
  description = "List of full stack developer emails"
  type        = list(string)
  default     = []
}