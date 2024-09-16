variable "usg_username" {
  type        = string
  default     = "admin"
  description = "Username used for connecting to the USG for management."
  sensitive   = true
}

variable "usg_password" {
  type        = string
  description = "Password used for the 'usg_username' used for connecting to the USG for management."
  sensitive   = true
}

variable "usg_api_url" {
  type        = string
  description = "URL used for making API requests against the USG for management."
  sensitive   = true
}

variable "action" {
  type        = string
  description = "The action to perform for authentication: 'login' ('logout' supported at a later date)."
  default     = "login"

  validation {
    condition     = contains(["login"], var.action)
    error_message = "The 'action' variable must be either 'login' ('logout' supported at a later date)."
  }
}
